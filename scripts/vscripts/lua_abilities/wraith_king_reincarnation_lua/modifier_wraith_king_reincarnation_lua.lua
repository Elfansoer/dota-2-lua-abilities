modifier_wraith_king_reincarnation_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_reincarnation_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Aura
-- function modifier_wraith_king_reincarnation_lua:IsAura()
-- 	return true
-- end

-- function modifier_wraith_king_reincarnation_lua:GetModifierAura()
-- 	return "modifier_wraith_king_reincarnation_lua_effect"
-- end

-- function modifier_wraith_king_reincarnation_lua:GetAuraRadius()
-- 	return float
-- end

-- function modifier_wraith_king_reincarnation_lua:GetAuraSearchTeam()
-- 	return DOTA_UNIT_TARGET_TEAM_XX
-- end

-- function modifier_wraith_king_reincarnation_lua:GetAuraSearchType()
-- 	return DOTA_UNIT_TARGET_XX + DOTA_UNIT_TARGET_YY + ...
-- end

-- function modifier_wraith_king_reincarnation_lua:GetAuraEntityReject( hEntity )
-- 	if IsServer() then
		
-- 	end

-- 	return false
-- end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_reincarnation_lua:OnCreated( kv )
	-- references
	self.reincarnate_time = self:GetAbility():GetSpecialValueFor( "reincarnate_time" ) -- special value
	self.slow_radius = self:GetAbility():GetSpecialValueFor( "slow_radius" ) -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value

	self.aura_radius = self:GetAbility():GetSpecialValueFor( "aura_radius" ) -- special value
end

function modifier_wraith_king_reincarnation_lua:OnRefresh( kv )
	-- references
	self.reincarnate_time = self:GetAbility():GetSpecialValueFor( "reincarnate_time" ) -- special value
	self.slow_radius = self:GetAbility():GetSpecialValueFor( "slow_radius" ) -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
	
	self.aura_radius = self:GetAbility():GetSpecialValueFor( "aura_radius" ) -- special value
end

function modifier_wraith_king_reincarnation_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wraith_king_reincarnation_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_REINCARNATION,
		-- MODIFIER_EVENT_ON_DEATH,
	}
	return funcs
end

function modifier_wraith_king_reincarnation_lua:ReincarnateTime()
	-- if IsServer() then
	-- 	if self.reincarnate then
	-- 		return self.reincarnate_time
	-- 	end
	-- end
	return 3
end

function modifier_wraith_king_reincarnation_lua:OnDeath( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			self.reincarnate = false
			-- check if ability is ready
			if self:GetAbility():IsFullyCastable() then
				self:Reincarnate()
			end
		end
	end
end
--------------------------------------------------------------------------------
-- Helper Function
function modifier_wraith_king_reincarnation_lua:Reincarnate()
	-- set reincarnate flag to true
	self.reincarnate = true

	-- find affected enemies
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.slow_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- apply slow
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_wraith_king_reincarnation_lua_slow",
			{ duration = self.slow_duration }
		)
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wraith_king_reincarnation_lua:PlayEffects()
	-- get resources
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf"
	local sound_cast = ""

	-- play particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- play sound
	-- EmitSoundOn( sound_cast, self:GetParent() )
end