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
modifier_bane_nightmare_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bane_nightmare_lua:IsHidden()
	return false
end

function modifier_bane_nightmare_lua:IsDebuff()
	return true
end

function modifier_bane_nightmare_lua:IsStunDebuff()
	return false
end

function modifier_bane_nightmare_lua:IsPurgable()
	return true
end

function modifier_bane_nightmare_lua:CanParentBeAutoAttacked()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bane_nightmare_lua:OnCreated( kv )
	-- references
	local inv_time = self:GetAbility():GetSpecialValueFor( "nightmare_invuln_time" )
	self.anim_rate = self:GetAbility():GetSpecialValueFor( "animation_rate" )

	if IsServer() then
		self.invulnerable = true
		self:StartIntervalThink( inv_time )

		-- play sound
		local sound_cast = "Hero_Bane.Nightmare"
		local sound_loop = "Hero_Bane.Nightmare.Loop"
		EmitSoundOn( sound_cast, self:GetParent() )
		EmitSoundOn( sound_loop, self:GetParent() )
	end
end

function modifier_bane_nightmare_lua:OnRefresh( kv )
	
end

function modifier_bane_nightmare_lua:OnRemoved()
end

function modifier_bane_nightmare_lua:OnDestroy()
	if not IsServer() then return end
	-- stop sound
	local sound_loop = "Hero_Bane.Nightmare.Loop"
	StopSoundOn( sound_loop, self:GetParent() )

	if not self.transfer then
		-- play end sound
		local sound_stop = "Hero_Bane.Nightmare.End"
		EmitSoundOn( sound_stop, self:GetParent() )
		
		-- end
		self:GetAbility():EndNightmare( false )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bane_nightmare_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,

		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_bane_nightmare_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
function modifier_bane_nightmare_lua:GetOverrideAnimationRate()
	return self.anim_rate
end

function modifier_bane_nightmare_lua:OnAttackStart( params )
	if not IsServer() then return end
	if params.target~=self:GetParent() then return end
	if not params.attacker:IsMagicImmune() then
		-- transfer
		local modifier = params.attacker:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_bane_nightmare_lua", -- modifier name
			{ duration = self:GetDuration() } -- kv
		)

		self:GetAbility().modifier = modifier
		self.transfer = true
	end
	self:Destroy()
end
function modifier_bane_nightmare_lua:OnTakeDamage( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if params.damage_category==DOTA_DAMAGE_CATEGORY_SPELL then
		self:Destroy()
	end
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_bane_nightmare_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = self.invulnerable,
		[MODIFIER_STATE_NIGHTMARED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_bane_nightmare_lua:OnIntervalThink()
	self.invulnerable = false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bane_nightmare_lua:GetEffectName()
	return "particles/units/heroes/hero_bane/bane_nightmare.vpcf"
end

function modifier_bane_nightmare_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- function modifier_bane_nightmare_lua:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_bane_nightmare_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		effect_cast,
-- 		false, -- bDestroyImmediately
-- 		false, -- bStatusEffect
-- 		-1, -- iPriority
-- 		false, -- bHeroEffect
-- 		false -- bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end