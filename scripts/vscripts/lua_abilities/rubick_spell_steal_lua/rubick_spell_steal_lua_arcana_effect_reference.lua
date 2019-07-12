local reference = {
	["particles/units/heroes/hero_antimage/antimage_manavoid.vpcf"] = "particles/rubick_manavoid.vpcf",

	["particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf"] = "particles/rubick_freezing_field_explosion.vpcf",
	["particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf"] = "particles/rubick_freezing_field_snow.vpcf",

	["particles/units/heroes/hero_dark_willow/dark_willow_wisp_aoe.vpcf"] = "particles/rubick_wisp_aoe_proj.vpcf",
	["particles/units/heroes/hero_dark_willow/dark_willow_wisp_aoe_cast.vpcf"] = "particles/rubick_wisp_aoe_cast.vpcf",
	["particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_channel.vpcf"] = "particles/rubick_wisp_spell_channel.vpcf",
	["particles/units/heroes/hero_dark_willow/dark_willow_willowisp_base_attack.vpcf"] = "particles/rubick_willowisp_base_attack.vpcf",
	["particles/units/heroes/hero_dark_willow/dark_willow_willowisp_ambient.vpcf"] = "particles/rubick_willowisp_ambient.vpcf",
	["particles/units/heroes/hero_dark_willow/dark_willow_willowisp_base_attack.vpcf"] = "particles/rubick_willowisp_base_attack.vpcf",

	["particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf"] = "particles/rubick_fissure.vpcf",

	["particles/units/heroes/hero_enigma/enigma_blackhole.vpcf"] = "particles/rubick_blackhole.vpcf",

	["particles/units/heroes/hero_faceless_void/faceless_void_chronosphere.vpcf"] = "particles/rubick_chronosphere.vpcf",

	["particles/units/heroes/hero_invoker/invoker_chaos_meteor.vpcf"] = "particles/rubick_chaos_meteor.vpcf",
	["particles/units/heroes/hero_invoker/invoker_chaos_meteor_fly.vpcf"] = "particles/rubick_chaos_meteor_fly.vpcf",

	["particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf"] = "particles/rubick_chain_frost.vpcf",

	["particles/units/heroes/hero_shredder/shredder_chakram.vpcf"] = "particles/rubick_chakram.vpcf",
	["particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf"] = "particles/rubick_chakram_stay.vpcf",
	["particles/units/heroes/hero_shredder/shredder_chakram_return.vpcf"] = "particles/rubick_chakram_return.vpcf",

	["particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf"] = "particles/rubick_guardian_angel_ally.vpcf",
	["particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf"] = "particles/rubick_guardian_angel_rubick.vpcf",
}

return reference

--[[
//////
not changing the reference:
- bane
- bristleback
- ck
- dazzle
- doom
- lion
- luna
- puck
- qop
- sandking
- sf
- slardar
- ursa

////////
problem:
- shadow wave (turn yellow)
- epicenter (still white)
- dream coil (turn yellow)

/////////////
not/partial implemented:
complex:
- magnetize
- stampede
- nature's attendants
- soulbind
- mystic flare

tracking proj:
- chaos bolt
- chain frost
- stifling dagger
- wraithfire blast

lazy:
- sacred arrow
- dark pact
- rearm
]]