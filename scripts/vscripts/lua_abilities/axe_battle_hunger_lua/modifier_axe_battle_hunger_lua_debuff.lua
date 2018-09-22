modifier_axe_battle_hunger_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_battle_hunger_lua_debuff:IsHidden()
	return false
end

function modifier_axe_battle_hunger_lua_debuff:IsDebuff()
	return true
end

function modifier_axe_battle_hunger_lua_debuff:IsStunDebuff()
	return false
end

function modifier_axe_battle_hunger_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_battle_hunger_lua_debuff:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	local interval = 1

	if IsServer() then
		-- precache damage
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
		}

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()
	end
end

function modifier_axe_battle_hunger_lua_debuff:OnRefresh( kv )
	-- update value
	self.slow = self:GetAbility():GetSpecialValueFor( "slow" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	
	if IsServer() then
		self.damageTable.damage = damage
	end
end

function modifier_axe_battle_hunger_lua_debuff:OnDestroy( kv )
	if IsServer() then
		-- decrement buff stack
		local modifier = self:GetCaster():FindModifierByName( "modifier_axe_battle_hunger_lua" )
		if modifier then
			modifier:DecrementStackCount()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_battle_hunger_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_axe_battle_hunger_lua_debuff:OnDeath( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end
		self:Destroy()
	end
end

function modifier_axe_battle_hunger_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_axe_battle_hunger_lua_debuff:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_battle_hunger_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_battle_hunger.vpcf"
end

function modifier_axe_battle_hunger_lua_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-- function modifier_axe_battle_hunger_lua_debuff:PlayEffects()
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