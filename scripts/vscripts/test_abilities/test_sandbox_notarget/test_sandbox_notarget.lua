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
--------------------------------------------------------------------------------
test_sandbox_notarget = class({})
LinkLuaModifier( "modifier_template", "test_abilities/test_sandbox_notarget/modifier_template", LUA_MODIFIER_MOTION_BOTH )

-- function test_sandbox_notarget:GetBehavior()
-- 	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
-- end

--------------------------------------------------------------------------------
-- Ability Start
function test_sandbox_notarget:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	print(target:GetOrigin())
	print(target.IsStanding, target.CutDown, target:entindex())

	local speed = 700

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_template", -- modifier name
		{
			speed = speed,
			tree = target:entindex(),
		} -- kv
	)
end

--------------------------------------------------------------------------------
function test_sandbox_notarget:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 100, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end