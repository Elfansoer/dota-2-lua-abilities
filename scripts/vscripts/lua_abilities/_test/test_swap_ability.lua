test_lua = class({})
LinkLuaModifier( "modifier_test", "lua_abilities/_test/modifier_test", LUA_MODIFIER_MOTION_NONE )

annex = {}

--------------------------------------------------------------------------------
function test_lua:OnSpellStart()
	local caster = self:GetCaster()
	self.annex:Print()
	-- caster:SwapAbilities(
	-- 	"shaco_haunting_presence",
	-- 	"shaco_deceive",
	-- 	true,
	-- 	true
	-- )
	local name = self.ability_list[self.current]
	caster:AddAbility( name )
	caster:SwapAbilities( name, self:GetAbilityName(), true, true )
	self.current = self.current + 1

	print("ability number: ",n)
	local n = caster:GetAbilityCount()
	for i=0,n-1 do
		local ability = caster:GetAbilityByIndex(i)
		if ability then print(i,ability:GetAbilityName()) end
	end
end

function test_lua:OnUpgrade()
	print("upgrade")
	self.annex = annex
end

test_lua.current = 1
test_lua.ability_list = {
	"bloodseeker_bloodrage_lua",
	"bloodseeker_blood_rite_lua",
	"centaur_warrunner_hoof_stomp_lua",
	"centaur_warrunner_double_edge_lua",
	"centaur_warrunner_return_lua",
	"centaur_warrunner_stampede_lua",
	"dazzle_shallow_grave_lua",
	"dazzle_shadow_wave_lua",
	"dazzle_weave_lua",
	"earthshaker_fissure_lua",
	"earthshaker_enchant_totem_lua",
	"earthshaker_aftershock_lua",
	"earthshaker_echo_slam_lua",
	"juggernaut_blade_fury_lua",
	"juggernaut_blade_dance_lua",
	"lion_hex_lua",
	"lion_finger_of_death_lua",
	"mirana_sacred_arrow_lua",
	"mirana_leap_lua",
	"puck_waning_rift_lua",
	"puck_phase_shift_lua",
	"puck_dream_coil_lua",
	"shadow_fiend_necromastery_lua",
	"shadow_fiend_presence_of_the_dark_lord_lua",
	"shadow_fiend_requiem_of_souls_lua",
}

annex.val = 5
function annex:GetVal()
	return self.val
end
function annex:Print()
	print("annex_print", self.val, self:GetVal())
end