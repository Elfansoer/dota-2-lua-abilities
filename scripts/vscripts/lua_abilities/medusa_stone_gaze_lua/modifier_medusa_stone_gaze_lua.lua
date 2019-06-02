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
modifier_medusa_stone_gaze_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_medusa_stone_gaze_lua:IsHidden()
	return false
end

function modifier_medusa_stone_gaze_lua:IsDebuff()
	return false
end

function modifier_medusa_stone_gaze_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_medusa_stone_gaze_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	self.parent = self:GetParent()
	self.modifiers = {}

	if not IsServer() then return end
	-- Start interval
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()

	-- play effects
	self:PlayEffects()
end

function modifier_medusa_stone_gaze_lua:OnRefresh( kv )
	
end

function modifier_medusa_stone_gaze_lua:OnRemoved()
end

function modifier_medusa_stone_gaze_lua:OnDestroy()
	if not IsServer() then return end

	-- destroy existing debuff modifier
	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			modifier:Destroy()
		end
	end

	-- stop sound
	local sound_cast = "Hero_Medusa.StoneGaze.Cast"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_medusa_stone_gaze_lua:OnIntervalThink()
	-- find units in area
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do

		-- check modifiers
		local modifier1 = enemy:FindModifierByNameAndCaster( "modifier_medusa_stone_gaze_lua_debuff", self.parent )
		local modifier2 = enemy:FindModifierByNameAndCaster( "modifier_medusa_stone_gaze_lua_petrified", self.parent )

		-- only affects those who doesn't already have the modifier
		if (not modifier1) and (not modifier2) then
			local modifier = enemy:AddNewModifier(
				self.parent, -- player source
				self:GetAbility(), -- ability source
				"modifier_medusa_stone_gaze_lua_debuff", -- modifier name
				{
					center_unit = self.parent:entindex(),
				} -- kv
			)

			-- register modifier
			self.modifiers[modifier] = true
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_medusa_stone_gaze_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_stone_gaze_active.vpcf"
	local sound_cast = "Hero_Medusa.StoneGaze.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_head",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Play sound
	EmitSoundOn( sound_cast, self:GetParent() )
end