modifier_lich_frost_armor_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lich_frost_armor_lua_buff:IsHidden()
	return false
end

function modifier_lich_frost_armor_lua_buff:IsDebuff()
	return false
end

function modifier_lich_frost_armor_lua_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_INVULNERABLE 
end

function modifier_lich_frost_armor_lua_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lich_frost_armor_lua_buff:OnCreated( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor_bonus" )
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" )
end

function modifier_lich_frost_armor_lua_buff:OnRefresh( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor_bonus" )
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" )
	
end

function modifier_lich_frost_armor_lua_buff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_frost_armor_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end

function modifier_lich_frost_armor_lua_buff:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_lich_frost_armor_lua_buff:OnAttacked( params )
	if IsServer() then
		-- filter
		if params.target~=self:GetParent() then return end
		local filter = UnitFilter(
			params.attacker,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
			0,
			self:GetParent():GetTeamNumber()
		)
		if filter ~= UF_SUCCESS then return	end

		-- add modifier
		params.attacker:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_lich_frost_armor_lua_debuff", -- modifier name
			{
				duration = self.duration,
				as_slow = self.as_slow,
				ms_slow = self.ms_slow,
			} -- kv
		)

		-- play effects
		local sound_cast = "Hero_Lich.FrostArmorDamage"
		EmitSoundOn( sound_cast, params.attacker )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lich_frost_armor_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_lich/lich_frost_armor.vpcf"
end

function modifier_lich_frost_armor_lua_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-- function modifier_lich_frost_armor_lua_buff:PlayEffects()
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