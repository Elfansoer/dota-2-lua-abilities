sona_song_of_celerity = class({})
LinkLuaModifier( "modifier_sona_song_of_celerity", "custom_abilities/sona_song_of_celerity/modifier_sona_song_of_celerity", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sona_song_of_celerity:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	-- find allies
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,ally in pairs(allies) do
		ally:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_sona_song_of_celerity", -- modifier name
			{ duration = duration } -- kv
		)
	end

end