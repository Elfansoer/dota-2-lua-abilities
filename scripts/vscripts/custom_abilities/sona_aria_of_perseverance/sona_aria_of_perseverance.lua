sona_aria_of_perseverance = class({})

--------------------------------------------------------------------------------
-- Ability Start
function sona_aria_of_perseverance:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local targets = self:GetSpecialValueFor("targets")
	local heal = self:GetSpecialValueFor("heal")

	-- find allies
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- find lowest health
	local lowest = caster:GetHealth()
	local lowest_ally = caster
	for _,ally in pairs(allies) do
		-- check alive
		if ally:IsAlive() then
			if ally:GetHealth()<lowest then
				lowest = ally:GetHealth()
				lowest_ally = ally
			end
		end
	end

	-- heal both
	caster:Heal(heal,caster)
	lowest_ally:Heal(heal,caster)
end

--------------------------------------------------------------------------------
function sona_aria_of_perseverance:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end