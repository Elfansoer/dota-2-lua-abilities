reference = {}

reference.animations = {
-- AbilityName, bNormalWhenStolen, nActivity, nTranslate, fPlaybackRate
    {"default", nil, ACT_DOTA_CAST_ABILITY_5, "bolt"},

    {"abaddon_mist_coil_lua", false, ACT_DOTA_CAST_ABILITY_3, "", 1.4},

    {"antimage_blink_lua", nil, nil, "am_blink"},
    {"antimage_mana_void_lua", false, ACT_DOTA_CAST_ABILITY_5, "mana_void"},

    {"axe_battle_hunger_lua", false, ACT_DOTA_CAST_ABILITY_6, ""},
    {"axe_culling_blade_lua", false, ACT_DOTA_CAST_ABILITY_5, "culling_blade"},

    {"bane_brain_sap_lua", false, ACT_DOTA_CAST_ABILITY_5,"brain_sap"},
    {"bane_fiends_grip_lua", false, ACT_DOTA_CHANNEL_ABILITY_5,"fiends_grip"},

    {"bristleback_viscous_nasal_goo_lua", false, ACT_DOTA_ATTACK,"",2.0},
    -- bristleback_quill_spray_lua

    {"centaur_warrunner_hoof_stomp_lua", false, ACT_DOTA_CAST_ABILITY_5, "slam", 2.0},
    {"centaur_warrunner_double_edge_lua", false, ACT_DOTA_ATTACK, "", 2.0},
    {"centaur_warrunner_stampede_lua", false, ACT_DOTA_OVERRIDE_ABILITY_4, "strength"},

    {"chaos_knight_chaos_bolt_lua", false, ACT_DOTA_ATTACK,"", 2.0},
    {"chaos_knight_reality_rift_lua", true, ACT_DOTA_CAST_ABILITY_5, "strike", 2.0},
    {"chaos_knight_phantasm_lua", true, ACT_DOTA_CAST_ABILITY_5, "remnant"},

    {"crystal_maiden_crystal_nova_lua", false, ACT_DOTA_CAST_ABILITY_5, "crystal_nova"},
    {"crystal_maiden_frostbite_lua", false, ACT_DOTA_CAST_ABILITY_5, "frostbite"},
    {"crystal_maiden_freezing_field_lua", false, ACT_DOTA_CHANNEL_ABILITY_5, "freezing_field"},

    {"dazzle_shallow_grave_lua", false, ACT_DOTA_CAST_ABILITY_5, "repel"},
    {"dazzle_shadow_wave_lua", false, ACT_DOTA_CAST_ABILITY_3, ""},
    {"dazzle_weave_lua", false, ACT_DOTA_CAST_ABILITY_5, "crystal_nova"},

    {"earth_spirit_boulder_smash_lua", false, ACT_DOTA_CAST_ABILITY_5, "impale"},
    {"earth_spirit_rolling_boulder_lua", false, ACT_DOTA_CAST_ABILITY_5, "gyroshell"},
    {"earth_spirit_magnetize_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadowraze"},

    {"earthshaker_fissure_lua", false, ACT_DOTA_CAST_ABILITY_5, "fissure"},
    {"earthshaker_enchant_totem_lua", false, ACT_DOTA_CAST_ABILITY_5, "totem"},
    {"earthshaker_echo_slam_lua", false, ACT_DOTA_CAST_ABILITY_5, "slam", 3.0},

    {"enigma_black_hole_lua", false, ACT_DOTA_CHANNEL_ABILITY_5, "black_hole"},

    {"faceless_void_chronosphere_lua", false, ACT_DOTA_CAST_ABILITY_5, "wall"},

    {"furion_sprout_lua", false, ACT_DOTA_CAST_ABILITY_5, "sprout"},
    {"furion_teleportation_lua", true, ACT_DOTA_CAST_ABILITY_5, "teleport"},
    {"furion_force_of_nature_lua", false, ACT_DOTA_CAST_ABILITY_5, "summon"},
    {"furion_wrath_of_nature_lua", false, ACT_DOTA_CAST_ABILITY_5, "wrath"},

    {"invoker_cold_snap_lua", false, ACT_DOTA_CAST_ABILITY_5, "bolt"},
    {"invoker_ghost_walk_lua", false, ACT_DOTA_CAST_ABILITY_5, "am_blink", 2.0},
    {"invoker_emp_lua", false, ACT_DOTA_CAST_ABILITY_5, "crystal_nova"},
    {"invoker_sun_strike_lua", false, ACT_DOTA_CAST_ABILITY_5, "wave"},
    {"invoker_chaos_meteor_lua", false, ACT_DOTA_CAST_ABILITY_5, "wave"},

    {"lich_chain_frost_lua", true, ACT_DOTA_ATTACK,"", 1.3},

    {"lina_dragon_slave_lua", false, nil, "wave"},
    {"lina_light_strike_array_lua", false, nil, "lsa"},
    {"lina_laguna_blade_lua", false, nil, "laguna"},

    {"lion_earth_spike_lua", false, ACT_DOTA_CAST_ABILITY_5, "impale"},
    {"lion_hex_lua", false, ACT_DOTA_CAST_ABILITY_3, ""},
    {"lion_finger_of_death_lua", false, ACT_DOTA_CAST_ABILITY_5, "finger"},

    {"luna_lucent_beam_lua", false, ACT_DOTA_CAST_ABILITY_5, "bramble_maze"},

    -- mirana_sacred_arrow_lua
    {"mirana_leap_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadow_realm", 1.5},

    {"ogre_magi_fireblast_lua", false, nil, "frostbite"},

    {"omniknight_purification_lua", true, nil, "purification", 1.4},
    {"omniknight_repel_lua", false, nil, "repel"},
    {"omniknight_guardian_angel_lua", true, nil, "guardian_angel", 1.3},

    {"phantom_assassin_stifling_dagger_lua", false, ACT_DOTA_ATTACK,"", 2.0},
    {"phantom_assassin_shadow_strike_lua", false, nil, "qop_blink"},

    {"puck_illusory_orb_lua", false, ACT_DOTA_CAST_ABILITY_5, "wave"},
    {"puck_waning_rift_lua", false, ACT_DOTA_CAST_ABILITY_5, "am_blink", 1.0},
    {"puck_dream_coil_lua", false, ACT_DOTA_CAST_ABILITY_5, "bramble_maze"},

    {"queen_of_pain_shadow_strike_lua", false, nil, "shadow_strike"},
    {"queen_of_pain_blink_lua", false, nil, "qop_blink"},
    {"queen_of_pain_scream_of_pain_lua", false, nil, "scream"},
    {"queen_of_pain_sonic_wave_lua", false, nil, "sonic_wave"},

    {"shadow_fiend_shadowraze_a_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadowraze", 2.0},
    {"shadow_fiend_shadowraze_b_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadowraze", 2.0},
    {"shadow_fiend_shadowraze_c_lua", false, ACT_DOTA_CAST_ABILITY_5, "shadowraze", 2.0},
    {"shadow_fiend_requiem_of_souls_lua", true, ACT_DOTA_CAST_ABILITY_5, "requiem"},
    
    {"sniper_assassinate_lua", true, ACT_DOTA_CAST_ABILITY_5, "snipe"},

    -- sven_storm_bolt_lua
    {"sven_warcry_lua", nil, ACT_DOTA_OVERRIDE_ABILITY_3, "strength"},
    {"sven_gods_strength_lua", nil, ACT_DOTA_OVERRIDE_ABILITY_4, "strength"},

    {"tinker_laser_lua", nil, ACT_DOTA_CAST_ABILITY_5, ""},

    {"slardar_slithereen_crush_lua", false, ACT_DOTA_MK_SPRING_END, nil},
    -- slardar_corrosive_haze_lua

    {"ursa_earthshock_lua", true, ACT_DOTA_CAST_ABILITY_5, "earthshock", 1.7},
    {"ursa_overpower_lua", true, ACT_DOTA_OVERRIDE_ABILITY_3, "overpower"},
    {"ursa_enrage_lua", true, ACT_DOTA_OVERRIDE_ABILITY_4, "enrage"},

    -- vengefulspirit_magic_missile_lua
    {"vengefulspirit_wave_of_terror_lua", nil, nil, "roar"},
    {"vengefulspirit_nether_swap_lua", nil, nil, "qop_blink"},
    
    -- wraith_king_wraithfire_blast_lua
}
--[[ 
Advanced:
- pudge_meat_hook_lua
- pudge_dismember_lua
- sand_king_burrowstrike_lua
- slardar_guardian_sprint_lua

Default:

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