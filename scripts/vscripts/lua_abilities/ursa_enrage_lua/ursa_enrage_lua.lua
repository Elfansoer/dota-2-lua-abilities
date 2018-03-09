ursa_enrage_lua = class({})
LinkLuaModifier( "modifier_ursa_enrage_lua", "lua_abilities/ursa_enrage_lua/modifier_ursa_enrage_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function ursa_enrage_luaGetBehavior()
	local behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
 	if self:GetCaster():HasScepter() then
 		behavior = behavior + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
 	end
 	return behavior
end

function ursa_enrage_lua:GetCooldown( level )
	local cooldown = 0
	if self:GetCaster():HasScepter() then
		cooldown = self:GetLevelSpecialValueFor( "cooldown_scepter", level )
	else
		cooldown = self:GetLevelSpecialValueFor( "cooldown_normal", level )
	end
	return cooldown
end

function ursa_enrage_lua:OnSpellStart()
	-- get references
	local bonus_duration = self:GetSpecialValueFor("duration")

	-- Add buff modifier
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_ursa_enrage_lua",
		{ duration = bonus_duration }
	)

	-- play effects
	self:PlayEffects()
end

function ursa_enrage_lua:PlayEffects()
	-- get resources
	local sound_cast = "Hero_Ursa.Enrage"

	-- play sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end