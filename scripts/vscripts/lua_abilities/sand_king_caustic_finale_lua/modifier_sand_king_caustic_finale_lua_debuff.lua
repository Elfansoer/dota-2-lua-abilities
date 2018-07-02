modifier_sand_king_caustic_finale_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sand_king_caustic_finale_lua_debuff:IsHidden()
	return false
end

function modifier_sand_king_caustic_finale_lua_debuff:IsDebuff()
	return true
end

function modifier_sand_king_caustic_finale_lua_debuff:IsPurgable()
	return true
end

function modifier_sand_king_caustic_finale_lua_debuff:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sand_king_caustic_finale_lua_debuff:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "caustic_finale_radius" ) -- special value
	self.damage = self:GetAbility():GetSpecialValueFor( "caustic_finale_damage" ) -- special value
	self.damage_exp = self:GetAbility():GetSpecialValueFor( "caustic_finale_damage_expire" ) -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "caustic_finale_slow_duration" ) -- special value

	if IsServer() then
		-- Start interval
		self:StartIntervalThink( kv.duration )
	end
end

function modifier_sand_king_caustic_finale_lua_debuff:OnRefresh( kv )
	
end

function modifier_sand_king_caustic_finale_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sand_king_caustic_finale_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_sand_king_caustic_finale_lua_debuff:OnDeath( params )
	if IsServer() then
		if params.unit~=self:GetParent() then return end

		-- check if denied
		if params.unit:GetTeamNumber()==params.attacker:GetTeamNumber() then return end

		self:Explode( true )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sand_king_caustic_finale_lua_debuff:OnIntervalThink()
	self:Explode( false )
end

--------------------------------------------------------------------------------
-- Helper function
function modifier_sand_king_caustic_finale_lua_debuff:Explode( death )
	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- precache damage table
	local dmg = self.damage
	if death then dmg = self.damage_exp end
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = dmg,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}

	for _,enemy in pairs(enemies) do
		-- slow
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_sand_king_caustic_finale_lua_slow", -- modifier name
			{
				duration = self.slow_duration,
			} -- kv
		)

		-- damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end

	-- effects
	self:PlayEffects()

	-- destroy
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sand_king_caustic_finale_lua_debuff:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sand_king_caustic_finale_lua_debuff:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_sand_king_caustic_finale_lua_debuff:PlayEffects()
	-- Get Resources
	-- local particle_cast = "string"
	local sound_cast = "Ability.SandKing_CausticFinale"

	-- -- Get Data

	-- -- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	iControlPoint,
	-- 	hTarget,
	-- 	PATTACH_NAME,
	-- 	"attach_name",
	-- 	vOrigin, -- unknown
	-- 	bool -- unknown, true
	-- )
	-- ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	-- SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- -- buff particle
	-- self:AddParticle(
	-- 	nFXIndex,
	-- 	bDestroyImmediately,
	-- 	bStatusEffect,
	-- 	iPriority,
	-- 	bHeroEffect,
	-- 	bOverheadEffect
	-- )

	-- Create Sound
	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_cast, self:GetParent() )
end