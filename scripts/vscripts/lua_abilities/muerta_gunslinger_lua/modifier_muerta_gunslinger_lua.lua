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
Notes:
- CBaseAnimatingActivity setter functions are not working so far
	- getters are shown properly
	- setters DO change animation states, but no effect in actual model animation
	- StartGesture or OVERRIDE_ANIMATION isn't affected by SetPoseParameter
]]

--------------------------------------------------------------------------------
modifier_muerta_gunslinger_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_muerta_gunslinger_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_muerta_gunslinger_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "double_shot_chance" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "target_search_bonus_range" )
	
	if not IsServer() then return end

	self.main_target = nil
	self.proc_target = nil
	self.double_shot = false
end

function modifier_muerta_gunslinger_lua:OnRefresh( kv )
	self.chance = self:GetAbility():GetSpecialValueFor( "double_shot_chance" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "target_search_bonus_range" )
end

function modifier_muerta_gunslinger_lua:OnRemoved()
end

function modifier_muerta_gunslinger_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_muerta_gunslinger_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,

		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}

	return funcs
end

-- NOTE: OnAttackStart has no attack record (value is -1)
function modifier_muerta_gunslinger_lua:OnAttackStart( params )
	if params.attacker~=self.parent then return end

	-- not proc for attacking allies
	if params.target:GetTeamNumber()==params.attacker:GetTeamNumber() then return end

	-- not proc if break
	if self.parent:PassivesDisabled() then return end

	-- roll
	if not RollPseudoRandomPercentage(self.chance, self.parent:entindex(), self.parent) then return end

	self.main_target = params.target
	self.proc_target = params.target

	-- find other target units
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.parent:Script_GetAttackRange() + self.bonus_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- prioritize other target first
	for _,enemy in pairs(enemies) do
		if enemy~=self.main_target then
			self.proc_target = enemy
			break
		end
	end

	self:PlayEffects()
end

function modifier_muerta_gunslinger_lua:OnAttack( params )
	if params.attacker~=self.parent then return end
	if params.target~=self.main_target then return end

	-- not proc for instant attacks
	if params.no_attack_cooldown then return end

	local target = self.proc_target
	self.proc_target = nil
	self.main_target = nil

	-- attack secondary target
	self.double_shot = true
	self.parent:PerformAttack(target, true, true, true, false, true, false, false)
	self.double_shot = false

	EmitSoundOn( "Hero_Muerta.Attack.DoubleShot", self.parent )
end

function modifier_muerta_gunslinger_lua:GetModifierProjectileName()
	if not IsServer() then return end

	if not self.parent:HasModifier( "modifier_muerta_pierce_the_veil_lua" ) then return end
	if not self.double_shot then
		return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf"
	else
		return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf"
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_muerta_gunslinger_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end