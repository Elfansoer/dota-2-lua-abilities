-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]

--[[
Hwei the Painter Mage, based on one of the League of Legends champion

Disclaimer:
- Hero concept, design, and abilities are based from League of Legends. All credits goes to them.
- This is a public implementation for educational programming purposes. Please use it responsibly. 

Todo:
- make precache (especially sounds) work for abilities from CreateAbility
]]

LinkLuaModifier( "modifier_hwei_common", "custom_abilities/hwei_common/modifier_hwei_common", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Hwei Base Selector
hwei_common = class({})
hwei_common.swapped_abilities = {}
hwei_common.original_abilities = {}

function hwei_common:Init( swapped_abilities )
	self.original_abilities = {
		"hwei_disaster",
		"hwei_serenity",
		"hwei_torment",
		"hwei_spiraling_despair",	
	}

	self.swapped_abilities = swapped_abilities
end

function hwei_common:IsStealable()
	return false
end

function hwei_common:ProcsMagicStick()
	return false
end

function hwei_common:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	caster:AddNewModifier(
		caster,
		self,
		"modifier_hwei_common",
		{}
	):Init( self.original_abilities, self.swapped_abilities )
end

--------------------------------------------------------------------------------
-- Hwei Disaster
hwei_disaster = class(hwei_common)
hwei_disaster:Init({
	"hwei_devastating_fire",
	"hwei_severing_bolt",
	"hwei_molten_fissure",
	"hwei_return",
})

--------------------------------------------------------------------------------
-- Hwei Serenity
hwei_serenity = class(hwei_common)
hwei_serenity:Init({
	"hwei_fleeting_current",
	"hwei_pool_of_reflection",
	"hwei_stirring_lights",
	"hwei_return",
})

--------------------------------------------------------------------------------
-- Hwei Torment
hwei_torment = class(hwei_common)
hwei_torment:Init({
	"hwei_grim_visage",
	"hwei_gaze_of_the_abyss",
	"hwei_crushing_maw",
	"hwei_return",
})

--------------------------------------------------------------------------------
-- Hwei Return
hwei_return = class({})

function hwei_return:IsStealable()
	return false
end

function hwei_common:ProcsMagicStick()
	return false
end

function hwei_return:OnSpellStart()
	-- do nothing
end