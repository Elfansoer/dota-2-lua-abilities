enchantress_impetus_lua = class({})
LinkLuaModifier( "modifier_generic_orb_effect_lua", "lua_abilities/generic/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function enchantress_impetus_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function enchantress_impetus_lua:OnSpellStart()
end

function enchantress_impetus_lua:GetProjectileName()
	return "particles/units/heroes/hero_enchantress/enchantress_impetus.vpcf.vpcf"
end

--------------------------------------------------------------------------------
-- Orb Effects
function enchantress_impetus_lua:OnOrbFire( params )
	-- play effects
	local sound_cast = "Hero_Enchantress.Impetus"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function enchantress_impetus_lua:OnOrbImpact( params )
	-- unit identifier
	local caster = self:GetCaster()
	local target = params.target

	-- load data
	local distance_cap = self:GetSpecialValueFor("distance_cap")
	local distance_dmg = self:GetSpecialValueFor("distance_damage_pct")
	
	-- calculate distance & damage
	local distance = math.min( (caster:GetOrigin()-target:GetOrigin()):Length2D(), distance_cap )
	local damage = distance_dmg/100 * distance

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- play effects
	local sound_cast = "Hero_Enchantress.ImpetusDamage"
	EmitSoundOn( sound_cast, target )
end