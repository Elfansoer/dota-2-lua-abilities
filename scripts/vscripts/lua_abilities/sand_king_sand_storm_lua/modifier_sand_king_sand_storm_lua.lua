modifier_sand_king_sand_storm_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sand_king_sand_storm_lua:IsHidden()
	return false
end

function modifier_sand_king_sand_storm_lua:IsDebuff()
	return false
end

function modifier_sand_king_sand_storm_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sand_king_sand_storm_lua:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "sand_storm_damage" ) -- special value
	self.radius = self:GetAbility():GetSpecialValueFor( "sand_storm_radius" ) -- special value
	self.interval = 0.5

	if IsServer() then
		-- initialize
		self.active = true
		self.damageTable = {
			-- victim = target,
			attacker = self:GetParent(),
			damage = self.damage * self.interval,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- Start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
	end
end

function modifier_sand_king_sand_storm_lua:OnRefresh( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "sand_storm_damage" ) -- special value
	self.radius = self:GetAbility():GetSpecialValueFor( "sand_storm_radius" ) -- special value

	if IsServer() then
		-- initialize
		self.damageTable.damage = self.damage * self.interval
		self.active = kv.start
		self:SetDuration( kv.duration, true )
	end
end

function modifier_sand_king_sand_storm_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sand_king_sand_storm_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}

	return funcs
end

function modifier_sand_king_sand_storm_lua:GetModifierInvisibilityLevel()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sand_king_sand_storm_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sand_king_sand_storm_lua:OnIntervalThink()
	if self.active==0 then return end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- damage enemies
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sand_king_sand_storm_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sand_king_sand_storm_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sand_king_sand_storm_lua:PlayEffects()
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