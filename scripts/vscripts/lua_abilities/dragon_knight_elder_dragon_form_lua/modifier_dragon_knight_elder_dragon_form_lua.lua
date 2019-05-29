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
modifier_dragon_knight_elder_dragon_form_lua = class({})

-- effect references
local level1 = {
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_corrosive.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot1.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_green.vpcf",
	["scale"] = 0,
}
local level2 = {
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot2.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_red.vpcf",
	["scale"] = 10,
}
local level3 = {
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot3.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf",
	["scale"] = 20,
}
local level4 = {
	["projectile"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_frost.vpcf",
	["attack_sound"] = "Hero_DragonKnight.ElderDragonShoot3.Attack",
	["transform"] = "particles/units/heroes/hero_dragon_knight/dragon_knight_transform_blue.vpcf",
	["scale"] = 50,
}
modifier_dragon_knight_elder_dragon_form_lua.effect_data = {
	[1] = level1,
	[2] = level2,
	[3] = level3,
	[4] = level4,
}

--------------------------------------------------------------------------------
-- Classifications
function modifier_dragon_knight_elder_dragon_form_lua:IsHidden()
	return false
end

function modifier_dragon_knight_elder_dragon_form_lua:IsDebuff()
	return false
end

function modifier_dragon_knight_elder_dragon_form_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dragon_knight_elder_dragon_form_lua:OnCreated( kv )
	-- references
	self.parent = self:GetParent()

	self.level = self:GetAbility():GetLevel()
	if self.parent:HasScepter() then
		self.level = self.level + 1
	end
	self.bonus_ms = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_attack_damage" )
	self.bonus_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
	self.magic_resist = 0

	self.corrosive_duration = self:GetAbility():GetSpecialValueFor( "corrosive_breath_duration" )
	
	self.splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" )
	self.splash_pct = self:GetAbility():GetSpecialValueFor( "splash_damage_percent" )/100
	
	self.frost_radius = self:GetAbility():GetSpecialValueFor( "frost_aoe" )
	self.frost_duration = self:GetAbility():GetSpecialValueFor( "frost_duration" )

	if self.level==4 then
		-- direct value == bad practice, but it's whatever written on original abilities kv
		self.bonus_range = self.bonus_range + 100
		self.splash_pct = self.splash_pct * 1.5
		self.magic_resist = 30
	end

	if not IsServer() then return end
	-- set attack capability
	-- TODO: Consider stacking other attack cap changing abilities
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_RANGED_ATTACK )

	-- set model change
	self:StartIntervalThink( 0.03 ) -- set skin can only affect model after this frame
	self.projectile = self.effect_data[self.level].projectile
	self.attack_sound = self.effect_data[self.level].attack_sound
	self.scale = self.effect_data[self.level].scale

	-- play effects
	self:PlayEffects()
	local sound_cast = "Hero_DragonKnight.ElderDragonForm"
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_dragon_knight_elder_dragon_form_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dragon_knight_elder_dragon_form_lua:OnRemoved()
end

function modifier_dragon_knight_elder_dragon_form_lua:OnDestroy()
	if not IsServer() then return end

	-- revert unit cap
	-- TODO: Consider stacking other attack cap changing abilities
	self.parent:SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )

	-- Play effects
	self:PlayEffects()
	local sound_cast = "Hero_DragonKnight.ElderDragonForm.Revert"
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_dragon_knight_elder_dragon_form_lua:OnIntervalThink()
	self.parent:SetSkin( self.level-1 )
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dragon_knight_elder_dragon_form_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,

		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,

		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_dragon_knight_elder_dragon_form_lua:GetModifierBaseAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_dragon_knight_elder_dragon_form_lua:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end

function modifier_dragon_knight_elder_dragon_form_lua:GetModifierAttackRangeBonus()
	return self.bonus_range
end

function modifier_dragon_knight_elder_dragon_form_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end

--------------------------------------------------------------------------------
function modifier_dragon_knight_elder_dragon_form_lua:GetModifierModelChange()
	return "models/heroes/dragon_knight/dragon_knight_dragon.vmdl"
end

function modifier_dragon_knight_elder_dragon_form_lua:GetModifierModelScale()
	return self.scale
end

function modifier_dragon_knight_elder_dragon_form_lua:GetAttackSound()
	return self.attack_sound
end

function modifier_dragon_knight_elder_dragon_form_lua:GetModifierProjectileName()
	return self.projectile
end

function modifier_dragon_knight_elder_dragon_form_lua:GetModifierProjectileSpeedBonus()
	return 900
end

--------------------------------------------------------------------------------
function modifier_dragon_knight_elder_dragon_form_lua:GetModifierProcAttack_Feedback( params )
	if params.target:GetTeamNumber()==self.parent:GetTeamNumber() then return end

	-- add attack modifiers based on level
	if self.level==1 then
		self:Corrosive( params.target )
	elseif self.level==2 then
		self:Corrosive( params.target )
		self:Splash( params.target, params.damage )
	elseif self.level==3 then
		self:Corrosive( params.target )
		self:Splash( params.target, params.damage )
		self:Frost( params.target )
	else
		self:Corrosive( params.target )
		self:Splash( params.target, params.damage )
		self:Frost( params.target )
	end

	-- play effects
	local sound_cast = "Hero_DragonKnight.ProjectileImpact"
	EmitSoundOn( sound_cast, params.target )
end

--------------------------------------------------------------------------------
-- Helper
function modifier_dragon_knight_elder_dragon_form_lua:Corrosive( target )
	-- add modifier
	target:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_dragon_knight_elder_dragon_form_lua_corrosive", -- modifier name
		{ duration = self.corrosive_duration } -- kv
	)
end

function modifier_dragon_knight_elder_dragon_form_lua:Splash( target, damage )
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.splash_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		if enemy~=target then
			-- -- perform attack
			-- self.parent:PerformAttack(
			-- 	enemy, -- hTarget,
			-- 	false, -- bUseCastAttackOrb,
			-- 	false, -- bProcessProcs,
			-- 	true, -- bSkipCooldown,
			-- 	true, -- bIgnoreInvis,
			-- 	false, -- bUseProjectile,
			-- 	false, -- bFakeAttack,
			-- 	true -- bNeverMiss
			-- )

			-- apply damage
			local damageTable = {
				victim = enemy,
				attacker = self.parent,
				damage = damage * self.splash_pct,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = self:GetAbility(), --Optional.
				-- damage_category = DOTA_DAMAGE_CATEGORY_ATTACK, --Optional.
			}
			ApplyDamage(damageTable)

			-- corrosive
			self:Corrosive( enemy )
		end
	end
end

function modifier_dragon_knight_elder_dragon_form_lua:Frost( target )
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.frost_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- add frost
		enemy:AddNewModifier(
			self.parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_dragon_knight_elder_dragon_form_lua_frost", -- modifier name
			{ duration = self.frost_duration } -- kv
		)
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dragon_knight_elder_dragon_form_lua:PlayEffects()
	-- Get Resources
	local particle_cast = self.effect_data[self.level].transform

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end