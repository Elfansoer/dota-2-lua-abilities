test_lua = class({})
LinkLuaModifier( "modifier_test", "lua_abilities/test/modifier_test", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function test_lua:GetIntrinsicModifierName()
	return "modifier_test"
end

--[[
Invoking results:
[none]
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC
	MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE

[loop]
	MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS

[normal attack]
	[animation started] ---------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_START
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	MODIFIER_PROPERTY_PRE_ATTACK
	
	[projectile launched] -------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK
	
	[animation finished] --------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_FINISHED
	
	[projectile arrived] --------------------------------------------------------------------
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
	MODIFIER_EVENT_ON_ATTACK_LANDED
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	MODIFIER_EVENT_ON_ATTACKED
	MODIFIER_EVENT_ON_TAKEDAMAGE

[cancelled attack]
	[animation started] ---------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_START
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	MODIFIER_PROPERTY_PRE_ATTACK

	[animation finished] --------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_FINISHED

[missed attack]
	[animation started] ---------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_START
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	MODIFIER_PROPERTY_PRE_ATTACK

	[projectile launched] -------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK

	[animation finished] --------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_FINISHED

	[projectile arrived] --------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_FAIL

[being attacked]
	[projectile arrived] --------------------------------------------------------------------
	MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK
	MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT
	MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	MODIFIER_PROPERTY_AVOID_DAMAGE
	MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK

[two-script attack]
	[animation started] ---------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_START
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT
	MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
	MODIFIER_PROPERTY_PRE_ATTACK

	[projectile launched] -------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK

	[animation finished] --------------------------------------------------------------------
	MODIFIER_EVENT_ON_ATTACK_FINISHED

	[projectile arrived] --------------------------------------------------------------------
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL
	MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE
	MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
	MODIFIER_EVENT_ON_ATTACK_LANDED

		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK
		MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
		MODIFIER_PROPERTY_AVOID_DAMAGE
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	MODIFIER_EVENT_ON_ATTACKED
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK
	MODIFIER_EVENT_ON_TAKEDAMAGE


[ability damage]
	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	MODIFIER_EVENT_ON_TAKEDAMAGE

[attack with: 100 base, 100 bonus-damage-physical]
[VScript] MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
[VScript] MODIFIER_EVENT_ON_ATTACK_LANDED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x001bd008
[VScript] damage	100
[VScript] original_damage	100
[VScript] damage_type	1
[VScript] MODIFIER_EVENT_ON_ATTACKED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x001bd008
[VScript] damage	200
[VScript] original_damage	200
[VScript] damage_type	1
[VScript] MODIFIER_EVENT_ON_TAKEDAMAGE
[VScript] attacker	table: 0x00177690
[VScript] unit	table: 0x001bd008
[VScript] target	nil
[VScript] damage	200
[VScript] original_damage	200
[VScript] damage_type	1

[attack with: 100 base, 200%-crit, 100 bonus-damage-physical]
[VScript] MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE
[VScript] MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
[VScript] MODIFIER_EVENT_ON_ATTACK_LANDED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x00163d58
[VScript] damage	300
[VScript] original_damage	300
[VScript] damage_type	1
[VScript] MODIFIER_EVENT_ON_ATTACKED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x00163d58
[VScript] damage	400
[VScript] original_damage	400
[VScript] damage_type	1
[VScript] MODIFIER_EVENT_ON_TAKEDAMAGE
[VScript] attacker	table: 0x00177690
[VScript] unit	table: 0x00163d58
[VScript] target	nil
[VScript] damage	400
[VScript] original_damage	400
[VScript] damage_type	1

[attack with: 100 base, 100 bonus-damage-magical]
[VScript] MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL
[VScript] MODIFIER_EVENT_ON_ATTACK_LANDED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x001a0568
[VScript] damage	100
[VScript] original_damage	100
[VScript] damage_type	1
[VScript] MODIFIER_EVENT_ON_ATTACKED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x001a0568
[VScript] damage	163.75
[VScript] original_damage	200
[VScript] damage_type	1
[VScript] MODIFIER_EVENT_ON_TAKEDAMAGE
[VScript] attacker	table: 0x00177690
[VScript] unit	table: 0x001a0568
[VScript] target	nil
[VScript] damage	163.75
[VScript] original_damage	200
[VScript] damage_type	1

[attack with: 100 base damage, 100% total-outgoing]
[VScript] MODIFIER_EVENT_ON_ATTACK_LANDED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x0019ec58
[VScript] damage	100
[VScript] original_damage	100
[VScript] damage_type	1
[VScript] MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
[VScript] MODIFIER_EVENT_ON_ATTACKED
[VScript] attacker	table: 0x00177690
[VScript] unit	nil
[VScript] target	table: 0x0019ec58
[VScript] damage	200
[VScript] original_damage	100
[VScript] damage_type	1
[VScript] MODIFIER_EVENT_ON_TAKEDAMAGE
[VScript] attacker	table: 0x00177690
[VScript] unit	table: 0x0019ec58
[VScript] target	nil
[VScript] damage	200
[VScript] original_damage	100
[VScript] damage_type	1
]]
