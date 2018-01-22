//=================================================================================================================
// Vera Olivia: Tutorial Ability
//=================================================================================================================

"vera_tutorial_ability"
{
	// Ability Technical Aspect
	// base script folder	: scripts/vscripts
	// base texture folder	: resource/flash3/images/spellicons
	//-------------------------------------------------------------------------------------------------------------
	"BaseClass"						"ability_lua"
	"ScriptFile"					"lua_abilities/vera_tutorial_ability/vera_tutorial_ability"
	"AbilityTextureName"			"vera_tutorial_ability"
	"FightRecapLevel"				"1"
	"MaxLevel"						"4"
	
	// Ability General
	//-------------------------------------------------------------------------------------------------------------
	"AbilityType"					"DOTA_ABILITY_TYPE_BASIC"
	"AbilityBehavior"				"DOTA_ABILITY_BEHAVIOR_UNIT_TARGET | DOTA_ABILITY_BEHAVIOR_AOE"
	"AbilityUnitTargetTeam"			"DOTA_UNIT_TARGET_TEAM_ENEMY"
	"AbilityUnitTargetType"			"DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC"
	"AbilityUnitTargetFlags"		"DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES"
	"AbilityUnitDamageType"			"DAMAGE_TYPE_MAGICAL"
	"SpellDispellableType"			"SPELL_DISPELLABLE_YES"
	"SpellImmunityType"				"SPELL_IMMUNITY_ENEMIES_NO"


	// Ability Casting
	//-------------------------------------------------------------------------------------------------------------
	"AbilityCastRange"				"600"
	"AbilityCastRangeBuffer"		"250"
	"AbilityCastPoint"				"0.3 0.3 0.3 0.3"
	"AbilityChannelTime"			"2.75 3.5 4.25 5.0"
	"AbilityDuration"				"0.0 0.0 0.0 0.0"

	// Ability Resource
	//-------------------------------------------------------------------------------------------------------------
	"AbilityCooldown"				"13.0"
	"AbilityManaCost"				"140"

	// Damage
	//-------------------------------------------------------------------------------------------------------------
	"AbilityDamage"					"100 175 250 325"

	// Special
	//-------------------------------------------------------------------------------------------------------------
	"AbilitySpecial"
	{
		"01"
		{
			"var_type"				"FIELD_INTEGER"
			"bolt_speed"			"1000"
		}
		"02"
		{
			"var_type"				"FIELD_FLOAT"
			"bolt_stun_duration"	"2.0"
		}
		"03"
		{
			"var_type"			"FIELD_INTEGER"
			"bolt_aoe"			"255"
		}
		"04"
		{
			"var_type"			"FIELD_INTEGER"
			"vision_radius"		"225"
		}
		"05"
		{
			"var_type"			"FIELD_INTEGER"
			"bolt_damage"		"100 175 250 325"
		}
	}
}

// Template Ability
"DOTA_Tooltip_ability_<ability_name>"
	"Name"

"DOTA_Tooltip_ability_<ability_name>_Description"
	"Description, with %stat_value%"

"DOTA_Tooltip_ability_<ability_name>_Lore"
	"Role"

"DOTA_Tooltip_ability_<ability_name>_Note<0-3>"
	"Note # (When Alt is pressed)"

"DOTA_Tooltip_ability_<ability_name>_<stats_value>"			"STAT NAME:"
"DOTA_Tooltip_ability_<ability_name>_<stats_pct>"			"%PERCENT STAT NAME:"

"DOTA_Tooltip_ability_<ability_name>_aghanim_description"
	"Aghanim Description"

"DOTA_Tooltip_ability_<ability_name>_<stats_scepter>"		"SCEPTER STAT NAME:"

"DOTA_Tooltip_<modifier_name>"		"Modifier Name"
"DOTA_Tooltip_<modifier_name>_Description"
	"Description, with %dMODIFIER_PROPERTY_XX% flat and %dMODIFIER_PROPERTY_XX%%% percent"
