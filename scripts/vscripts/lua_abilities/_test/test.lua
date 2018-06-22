test_lua = class({})
LinkLuaModifier( "modifier_test", "lua_abilities/_test/modifier_test", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
function test_lua:OnSpellStart()
	local caster = self:GetCaster()
	-- caster:AddNewModifier(
	-- 	caster, -- player source
	-- 	self, -- ability source
	-- 	"modifier_test", -- modifier name
	-- 	{ 
	-- 		duration = 10,
	-- 	} -- kv
	-- )

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		2000,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	if #enemies<1 then return end
	local target = enemies[1]

	-- instant attack
	caster:PerformAttack(
		target,-- hTarget,
		false,-- bUseCastAttackOrb,
		false,-- bProcessProcs,
		true,-- bSkipCooldown,
		true,-- bIgnoreInvis,
		true,-- bUseProjectile,
		true,-- bFakeAttack,
		true-- bNeverMiss
	)

end