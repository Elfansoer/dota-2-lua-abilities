reference = {}

reference.animations = {
-- AbilityName, bNormalWhenStolen, nActivity, nTranslate, fPlaybackRate
    {"default", nil, nil, nil},

    {"antimage_blink_lua", nil, nil, "am_blink"},
    {"antimage_mana_void_lua", false, ACT_DOTA_CAST_ABILITY_5, "mana_void"},

    {"bristleback_viscous_nasal_goo_lua", false, ACT_DOTA_ATTACK,"",2.0},

    {"chaos_knight_chaos_bolt_lua", false, ACT_DOTA_ATTACK,"", 2.0},

    {"furion_sprout_lua", false, ACT_DOTA_CAST_ABILITY_5, "sprout"},
    {"furion_teleportation_lua", true, ACT_DOTA_CAST_ABILITY_5, "teleport"},
    {"furion_force_of_nature_lua", false, ACT_DOTA_CAST_ABILITY_5, "summon"},
    {"furion_wrath_of_nature_lua", false, ACT_DOTA_CAST_ABILITY_5, "wrath"},

    {"lina_dragon_slave_lua", false, nil, "wave"},
    {"lina_light_strike_array_lua", false, nil, "lsa"},
    {"lina_laguna_blade_lua", false, nil, "laguna"},

    {"ogre_magi_fireblast_lua", false, nil, "frostbite"},

    {"phantom_assassin_stifling_dagger_lua", false, ACT_DOTA_ATTACK,"", 2.0},
    {"phantom_assassin_shadow_strike_lua", false, nil, "qop_blink"},

    {"queen_of_pain_shadow_strike_lua", false, nil, "shadow_strike"},
    {"queen_of_pain_blink_lua", false, nil, "qop_blink"},
    {"queen_of_pain_scream_of_pain_lua", false, nil, "scream"},
    {"queen_of_pain_sonic_wave_lua", false, nil, "sonic_wave"},

    {"shadow_fiend_shadowraze_a_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadowraze", 2.0},
    {"shadow_fiend_shadowraze_b_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadowraze", 2.0},
    {"shadow_fiend_shadowraze_c_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadowraze", 2.0},
    {"shadow_fiend_requiem_of_souls_lua", true, ACT_DOTA_CAST_ABILITY_5, "requiem"},

    {"sven_warcry_lua", nil, ACT_DOTA_OVERRIDE_ABILITY_3, "strength"},
    {"sven_gods_strength_lua", nil, ACT_DOTA_OVERRIDE_ABILITY_4, "strength"},

    {"slardar_slithereen_crush_lua", false, ACT_DOTA_MK_SPRING_END, nil},

    {"ursa_earthshock_lua", true, ACT_DOTA_CAST_ABILITY_5, "earthshock", 1.7},
    {"ursa_overpower_lua", true, ACT_DOTA_OVERRIDE_ABILITY_3, "overpower"},
    {"ursa_enrage_lua", true, ACT_DOTA_OVERRIDE_ABILITY_4, "enrage"},

    {"vengefulspirit_wave_of_terror_lua", nil, nil, "roar"},
    {"vengefulspirit_nether_swap_lua", nil, nil, "qop_blink"},
}
--[[ 
Advanced:
- pudge_meat_hook_lua
- pudge_dismember
- slardar_guardian_sprint_lua

Default:
- bristleback_quill_spray_lua
- sven_storm_bolt_lua
- slardar_corrosive_haze_lua
- vengefulspirit_magic_missile_lua
- wraith_king_wraithfire_blast_lua

]]


reference.current = 1
function reference:SetCurrentReference( spellName )
	self.current = self:FindReference( spellName )
end
function reference:SetCurrentReferenceIndex( index )
	reference.current = index
end
function reference:GetCurrentReference()
	return self.current
end

function reference:FindReference( spellName )
	for k,v in pairs(self.animations) do
		if v[1]==spellName then
			return k
		end
	end
	return 1
end
function reference:IsNormal()
	return self.animations[self.current][2] or false
end
function reference:GetActivity()
	return self.animations[self.current][3] or ACT_DOTA_CAST_ABILITY_5
end
function reference:GetTranslate()
	return self.animations[self.current][4] or ""
end
function reference:GetPlaybackRate()
	return self.animations[self.current][5] or 1
end

return reference