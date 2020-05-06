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
modifier_terrorblade_reflection_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_terrorblade_reflection_lua:IsHidden()
	return false
end

function modifier_terrorblade_reflection_lua:IsDebuff()
	return true
end

function modifier_terrorblade_reflection_lua:IsStunDebuff()
	return false
end

function modifier_terrorblade_reflection_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_terrorblade_reflection_lua:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "move_slow" )

	if not IsServer() then return end

	local distance = 72

	-- create illusion
	local illusions = CreateIllusions(
		-- self:GetParent(), -- hOwner
		self:GetCaster(), -- hOwner
		self:GetParent(), -- hHeroToCopy
		{
			outgoing_damage = self.outgoing,
			duration = self:GetDuration(),
		}, -- hModiiferKeys
		1, -- nNumIllusions
		distance, -- nPadding
		false, -- bScramblePosition
		true -- bFindClearSpace
	)
	local illusion = illusions[1]
	-- illusion:SetControllableByPlayer( self:GetCaster():GetPlayerID(), false )
	-- illusion:SetOwner( self:GetCaster() )
	-- illusion:SetPlayerID( self:GetCaster():GetPlayerID() )

	-- add illusion buff
	illusion:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_terrorblade_reflection_lua_illusion", -- modifier name
		{ duration = self:GetDuration() } -- kv
	)

	-- command to attack target
	local order = {
		UnitIndex = illusion:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		TargetIndex = self:GetParent():entindex(),
	}
	ExecuteOrderFromTable( order )

	-- add to illusion table
	self.illusions = self.illusions or {}
	self.illusions[ illusion ] = true
end

function modifier_terrorblade_reflection_lua:OnRefresh( kv )
	self:OnCreated( kv )	
end

function modifier_terrorblade_reflection_lua:OnRemoved()
end

function modifier_terrorblade_reflection_lua:OnDestroy()
	if not IsServer() then return end

	-- destroy all illusions
	for illusion,_ in pairs( self.illusions ) do
		if not illusion:IsNull() then
			illusion:ForceKill( false )
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_terrorblade_reflection_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_terrorblade_reflection_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_terrorblade_reflection_lua:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end

function modifier_terrorblade_reflection_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- function modifier_terrorblade_reflection_lua:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_terrorblade_reflection_lua:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_terrorblade_reflection_lua:PlayEffects()
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