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
modifier_dark_willow_bramble_maze_lua_bramble = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_willow_bramble_maze_lua_bramble:IsHidden()
	return false
end

function modifier_dark_willow_bramble_maze_lua_bramble:IsDebuff()
	return false
end

function modifier_dark_willow_bramble_maze_lua_bramble:IsStunDebuff()
	return false
end

function modifier_dark_willow_bramble_maze_lua_bramble:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_willow_bramble_maze_lua_bramble:OnCreated( kv )
	if not IsServer() then return end
	-- references
	self.radius = kv.radius
	self.root = kv.root
	self.damage = kv.damage
	local delay = kv.delay

	-- start delay
	self:StartIntervalThink( delay )

	-- play effects
	self:PlayEffects()
end

function modifier_dark_willow_bramble_maze_lua_bramble:OnRefresh( kv )
	
end

function modifier_dark_willow_bramble_maze_lua_bramble:OnRemoved()
end

function modifier_dark_willow_bramble_maze_lua_bramble:OnDestroy()
	if not IsServer() then return end
	-- stop loop sound
	local sound_loop = "Hero_DarkWillow.BrambleLoop"
	StopSoundOn( sound_loop, self:GetParent() )

	-- play stopping sound
	local sound_stop = "Hero_DarkWillow.Bramble.Destroy"
	EmitSoundOn( sound_stop, self:GetParent() )

	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dark_willow_bramble_maze_lua_bramble:OnIntervalThink()
	if not self.delay then
		self.delay = true

		-- start search interval
		local interval = 0.03
		self:StartIntervalThink( interval )
		return
	end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local target = nil
	for _,enemy in pairs(enemies) do
		-- find the first occurence
		target = enemy
		break
	end
	if not target then return end

	-- root target
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_dark_willow_bramble_maze_lua_debuff", -- modifier name
		{
			duration = self.root,
			damage = self.damage,
		} -- kv
	)

	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_willow_bramble_maze_lua_bramble:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_bramble_wraith.vpcf"
	local sound_cast = "Hero_DarkWillow.Bramble.Spawn"
	local sound_loop = "Hero_DarkWillow.BrambleLoop"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, self.radius, self.radius ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
	EmitSoundOn( sound_loop, self:GetParent() )
end