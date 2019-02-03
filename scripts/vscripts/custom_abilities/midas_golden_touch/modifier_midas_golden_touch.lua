-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_midas_golden_touch = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_touch:IsHidden()
	return false
end

function modifier_midas_golden_touch:IsDebuff()
	return self.enemy
end

function modifier_midas_golden_touch:IsStunDebuff()
	return self.enemy
end

function modifier_midas_golden_touch:IsPurgable()
	return false
end

function modifier_midas_golden_touch:DestroyOnExpire()
	return self.temporary
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_touch:OnCreated( kv )
	-- references
	self.damage_per_gold = self:GetAbility():GetSpecialValueFor( "damage_per_gold" )
	self.enemy = self:GetCaster():GetTeamNumber()~=self:GetParent():GetTeamNumber()
	self.creep = self:GetParent():IsCreep() and (not self:GetParent():IsAncient())
	self.temporary = not (self.creep and self.enemy)

	if IsServer() then
		if not self.temporary then
			self:SetDuration(0,true)
		end

		-- for allies, don't stop channeling but stop moving
		if (not self.enemy) and (not self:GetParent():IsChanneling() ) then
			self:GetParent():Stop()
		end

		-- purge
		if self.enemy then
			self:GetParent():Purge( true, false, false, false, false )
		else
			self:GetParent():Purge( false, true, false, true, true )
		end
	end
end

function modifier_midas_golden_touch:OnRefresh( kv )
	-- references
	self.damage_per_gold = self:GetAbility():GetSpecialValueFor( "damage_per_gold" )
	
end

function modifier_midas_golden_touch:OnRemoved()
end

function modifier_midas_golden_touch:OnDestroy()
	if IsServer() then
		if not self:GetParent():IsAlive() and (not self.temporary) then
			-- set origin below ground, then play effects
			self:GetParent():AddNoDraw()
		end

		self:PlayEffects2()
		-- play sound
		local sound_cast = "Hero_VengefulSpirit.MagicMissileImpact"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_midas_golden_touch:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED,

		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_DISABLE_HEALING,

		-- MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end
function modifier_midas_golden_touch:GetDisableHealing()
	if self.temporary then return 0 end
	return 1
end
function modifier_midas_golden_touch:GetAbsoluteNoDamageMagical()
	return 1
end
function modifier_midas_golden_touch:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_midas_golden_touch:OnAttacked( params )
	if IsServer() then
		if params.target~=self:GetParent() then return end

		-- only for allied attacker
		if params.attacker:GetTeamNumber()~=self:GetCaster():GetTeamNumber() then return end

		-- only for player controlled
		if not params.attacker:IsOwnedByAnyPlayer() then return end

		local gold = self.damage_per_gold * params.damage / 100
		gold = math.floor( gold + 0.5 )
		
		PlayerResource:ModifyGold( params.attacker:GetPlayerOwnerID(), gold, false, DOTA_ModifyGold_Unspecified )

		self:PlayEffects( params.attacker, gold )
	end
end

 -- function modifier_midas_golden_touch:OnDeath( params )
-- 	if params.unit~=self:GetParent() then return end
-- 	print("here")
-- 	self:PlayEffects2()
-- 	self:GetParent():SetOrigin( self:GetParent():GetOrigin() - Vector( 0,0,1000 ) )
-- end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_midas_golden_touch:CheckState()
	local state = {
		[MODIFIER_STATE_FROZEN] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_STUNNED] = self.enemy or self.creep,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = not self.enemy,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_midas_golden_touch:GetStatusEffectName()
	return "particles/midas_golden_touch.vpcf"
end

function modifier_midas_golden_touch:StatusEffectPriority()
	return 100
end

function modifier_midas_golden_touch:PlayEffects( attacker, gold )
	-- Get Resources
	local particle_cast = "particles/msg_fx/msg_goldbounty.vpcf"
	local sound_cast = "General.Coins"

	-- do nothing if no gold
	if gold<=0 then return end

	-- load data
	local digit = 0
		if gold<10 then digit = 1
	elseif gold<100 then digit = 2
	elseif gold<1000 then digit = 3
	elseif gold<10000 then digit = 4
	else digit = 5 end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, attacker )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 0, gold, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, digit+1, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( 255, 255, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, attacker )
end

function modifier_midas_golden_touch:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/midas_golden_touch_explode.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end