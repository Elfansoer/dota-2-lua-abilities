modifier_invoker_ghost_walk_lua = class({})
local intPack = require( "util/intPack" )
--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_ghost_walk_lua:IsHidden()
	return false
end

function modifier_invoker_ghost_walk_lua:IsDebuff()
	return false
end

function modifier_invoker_ghost_walk_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_invoker_ghost_walk_lua:IsAura()
	return true
end

function modifier_invoker_ghost_walk_lua:GetModifierAura()
	return "modifier_invoker_ghost_walk_lua_debuff"
end

function modifier_invoker_ghost_walk_lua:GetAuraRadius()
	return self.radius
end

function modifier_invoker_ghost_walk_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_invoker_ghost_walk_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_invoker_ghost_walk_lua:GetAuraDuration()
	return self.aura_duration
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_ghost_walk_lua:OnCreated( kv )
	if IsServer() then
		-- references
		self.radius = self:GetAbility():GetSpecialValueFor( "area_of_effect" )
		self.aura_duration = self:GetAbility():GetSpecialValueFor( "aura_fade_time" )
		self.self_slow = self:GetAbility():GetOrbSpecialValueFor( "self_slow", "w" )
		self.enemy_slow = self:GetAbility():GetOrbSpecialValueFor( "enemy_slow", "q" )

		-- send to client
		local sign = 0
		if self.self_slow<0 then sign = 2 end
		local tbl = {
			sign,
			math.abs(self.self_slow),
		}
		self:SetStackCount( intPack.Pack( tbl, 60 ) )
	else
		-- receive from server
		local tbl = intPack.Unpack( self:GetStackCount(), 2, 60 )
		self.self_slow = (1-tbl[1])*tbl[2]
		self:SetStackCount( 0 )
	end
end

function modifier_invoker_ghost_walk_lua:OnRefresh( kv )
	if IsServer() then
		-- references
		self.radius = self:GetAbility():GetSpecialValueFor( "area_of_effect" )
		self.aura_duration = self:GetAbility():GetSpecialValueFor( "aura_fade_time" )
		self.self_slow = self:GetAbility():GetOrbSpecialValueFor( "self_slow", "w" )
		self.enemy_slow = self:GetAbility():GetOrbSpecialValueFor( "enemy_slow", "q" )

		-- send to client
		local sign = 0
		if self.self_slow<0 then sign = 2 end
		local tbl = {
			sign,
			math.abs(self.self_slow),
		}
		self:SetStackCount( intPack.Pack( tbl, 60 ) )
	else
		-- receive from server
		local tbl = intPack.Unpack( self:GetStackCount(), 2, 60 )
		self.self_slow = (1-tbl[1])*tbl[2]
		self:SetStackCount( 0 )
	end
end

function modifier_invoker_ghost_walk_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_ghost_walk_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,

		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_EVENT_ON_ATTACK,
	}

	return funcs
end

function modifier_invoker_ghost_walk_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.self_slow
end

function modifier_invoker_ghost_walk_lua:GetModifierInvisibilityLevel()
	return 1
end

function modifier_invoker_ghost_walk_lua:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end

		self:Destroy()
	end
end

function modifier_invoker_ghost_walk_lua:OnAttack( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end

		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_invoker_ghost_walk_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_invoker_ghost_walk_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_invoker_ghost_walk_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_invoker_ghost_walk_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
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
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end