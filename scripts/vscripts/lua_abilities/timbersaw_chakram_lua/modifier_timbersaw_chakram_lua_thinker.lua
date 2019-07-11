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
modifier_timbersaw_chakram_lua_thinker = class({})
local MODE_LAUNCH = 0
local MODE_STAY = 1
local MODE_RETURN = 2

--------------------------------------------------------------------------------
-- Classifications
function modifier_timbersaw_chakram_lua_thinker:IsHidden()
	return true
end

function modifier_timbersaw_chakram_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_timbersaw_chakram_lua_thinker:OnCreated( kv )
	if not IsServer() then return end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	-- references
	self.damage_pass = self:GetAbility():GetSpecialValueFor( "pass_damage" )
	self.damage_stay = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
	self.duration = self:GetAbility():GetSpecialValueFor( "pass_slow_duration" )
	self.manacost = self:GetAbility():GetSpecialValueFor( "mana_per_second" )
	self.max_range = self:GetAbility():GetSpecialValueFor( "break_distance" )
	self.interval = self:GetAbility():GetSpecialValueFor( "damage_interval" )

	-- kv references
	self.point = Vector( kv.target_x, kv.target_y, kv.target_z )
	self.scepter = kv.scepter==1

	-- init vars
	self.mode = MODE_LAUNCH
	self.move_interval = FrameTime()
	self.proximity = 50
	self.caught_enemies = {}
	self.damageTable = {
		-- victim = target,
		attacker = self.caster,
		-- damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- give vision to thinker
	self.parent:SetDayTimeVisionRange( 500 )
	self.parent:SetNightTimeVisionRange( 500 )

	-- add disarm to caster
	self.disarm = self.caster:AddNewModifier(
		self.caster, -- player source
		self:GetAbility(), -- ability source
		"modifier_timbersaw_chakram_lua_disarm", -- modifier name
		{} -- kv
	)

	-- Init mode
	self.damageTable.damage = self.damage_pass
	self:StartIntervalThink( self.move_interval )

	-- play effects
	self:PlayEffects1()
end

function modifier_timbersaw_chakram_lua_thinker:OnRemoved()
end

function modifier_timbersaw_chakram_lua_thinker:OnDestroy()
	if not IsServer() then return end

	-- remove disarm
	if not self.disarm:IsNull() then
		self.disarm:Destroy()
	end

	-- swap ability back, then remove sub
	local main = self:GetAbility()
	if (not main:IsNull()) and (not self.sub:IsNull()) then
		-- check if main is hidden (due to scepter)
		local active = main:IsActivated()

		self.caster:SwapAbilities(
			main:GetAbilityName(),
			self.sub:GetAbilityName(),
			active,
			false
		)
	end
	self.caster:RemoveAbilityByHandle( self.sub )

	-- stop sound
	local sound_cast = "Hero_Shredder.Chakram"
	StopSoundOn( sound_cast, self.parent )

	-- remove
	UTIL_Remove( self.parent )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_timbersaw_chakram_lua_thinker:OnIntervalThink()
	-- check mode
	if self.mode==MODE_LAUNCH then
		self:LaunchThink()
	elseif self.mode==MODE_STAY then
		self:StayThink()
	elseif self.mode==MODE_RETURN then
		self:ReturnThink()
	end
end

function modifier_timbersaw_chakram_lua_thinker:LaunchThink()
	local origin = self.parent:GetOrigin()

	-- pass logic
	self:PassLogic( origin )

	-- move logic
	local close = self:MoveLogic( origin )

	-- if close, switch to stay mode
	if close then
		self.mode = MODE_STAY
		self.damageTable.damage = self.damage_stay*self.interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()

		-- play effects
		self:PlayEffects2()
	end
end

function modifier_timbersaw_chakram_lua_thinker:StayThink()
	local origin = self.parent:GetOrigin()

	-- check if died, too far or not enough manacost
	local mana = self.caster:GetMana()
	if (self.caster:GetOrigin()-origin):Length2D()>self.max_range or mana<self.manacost*self.interval or (not self.caster:IsAlive()) then
		self:ReturnChakram()
		return
	end

	-- spend mana
	self.caster:SpendMana( self.manacost*self.interval, self:GetAbility() )

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		origin,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- -- add debuff
		-- enemy:AddNewModifier(
		-- 	self.caster, -- player source
		-- 	self:GetAbility(), -- ability source
		-- 	"modifier_timbersaw_chakram_lua", -- modifier name
		-- 	{ duration = self.duration } -- kv
		-- )
	end

	-- destroy trees
	local sound_tree = "Hero_Shredder.Chakram.Tree"
	local trees = GridNav:GetAllTreesAroundPoint( origin, self.radius, true )
	for _,tree in pairs(trees) do
		EmitSoundOnLocationWithCaster( tree:GetOrigin(), sound_tree, self.parent )
	end
	GridNav:DestroyTreesAroundPoint( origin, self.radius, true )
end

function modifier_timbersaw_chakram_lua_thinker:ReturnThink()
	local origin = self.parent:GetOrigin()

	-- pass logic
	self:PassLogic( origin )

	-- move logic
	self.point = self.caster:GetOrigin( )
	local close = self:MoveLogic( origin )

	-- if close, destroy
	if close then
		self:Destroy()
	end
end

function modifier_timbersaw_chakram_lua_thinker:PassLogic( origin )
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		origin,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- check if already hit
		if not self.caught_enemies[enemy] then
			self.caught_enemies[enemy] = true

			-- damage
			self.damageTable.victim = enemy
			ApplyDamage( self.damageTable )

			-- add debuff
			enemy:AddNewModifier(
				self.caster, -- player source
				self:GetAbility(), -- ability source
				"modifier_timbersaw_chakram_lua", -- modifier name
				{ duration = self.duration } -- kv
			)

			-- play effects
			local sound_target = "Hero_Shredder.Chakram.Target"
			EmitSoundOn( sound_target, enemy )
		end
	end

	-- destroy trees
	local sound_tree = "Hero_Shredder.Chakram.Tree"
	local trees = GridNav:GetAllTreesAroundPoint( origin, self.radius, true )
	for _,tree in pairs(trees) do
		EmitSoundOnLocationWithCaster( tree:GetOrigin(), sound_tree, self.parent )
	end
	GridNav:DestroyTreesAroundPoint( origin, self.radius, true )
end

function modifier_timbersaw_chakram_lua_thinker:MoveLogic( origin )
	-- move position
	local direction = (self.point-origin):Normalized()
	local target = origin + direction * self.speed * self.move_interval
	-- target.z = GetGroundHeight( target, self.parent ) + 50
	self.parent:SetOrigin( target )

	-- return true if close to target
	return (target-self.point):Length2D()<self.proximity
end

function modifier_timbersaw_chakram_lua_thinker:ReturnChakram()
	-- if already returning, do nothing
	if self.mode == MODE_RETURN then return end

	-- switch mode
	self.mode = MODE_RETURN
	self.caught_enemies = {}
	self.damageTable.damage = self.damage_pass
	self:StartIntervalThink( self.move_interval )

	-- play effects
	self:PlayEffects3()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_timbersaw_chakram_lua_thinker:IsAura()
	return self.mode==MODE_STAY
end

function modifier_timbersaw_chakram_lua_thinker:GetModifierAura()
	return "modifier_timbersaw_chakram_lua"
end

function modifier_timbersaw_chakram_lua_thinker:GetAuraRadius()
	return self.radius
end

function modifier_timbersaw_chakram_lua_thinker:GetAuraDuration()
	return 0.3
end

function modifier_timbersaw_chakram_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_timbersaw_chakram_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_timbersaw_chakram_lua_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_timbersaw_chakram_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_shredder/shredder_chakram.vpcf"
	local sound_cast = "Hero_Shredder.Chakram"

	-- get data
	local direction = self.point-self.parent:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, direction * self.speed )
	ParticleManager:SetParticleControl( self.effect_cast, 16, Vector( 0, 0, 0 ) )

	if self.scepter then
		-- set color to blue
		ParticleManager:SetParticleControl( self.effect_cast, 15, Vector( 0, 0, 255 ) )
		ParticleManager:SetParticleControl( self.effect_cast, 16, Vector( 1, 0, 0 ) )
	end

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_timbersaw_chakram_lua_thinker:PlayEffects2()
	-- destroy previous particle
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_shredder/shredder_chakram_stay.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 16, Vector( 0, 0, 0 ) )

	if self.scepter then
		-- set color to blue
		ParticleManager:SetParticleControl( self.effect_cast, 15, Vector( 0, 0, 255 ) )
		ParticleManager:SetParticleControl( self.effect_cast, 16, Vector( 1, 0, 0 ) )
	end
end

function modifier_timbersaw_chakram_lua_thinker:PlayEffects3()
	-- destroy previous particle
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_shredder/shredder_chakram_return.vpcf"
	local sound_cast = "Hero_Shredder.Chakram.Return"
	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		self.caster,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self.caster:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self.speed, 0, 0 ) )
	ParticleManager:SetParticleControl( self.effect_cast, 16, Vector( 0, 0, 0 ) )

	if self.scepter then
		-- set color to blue
		ParticleManager:SetParticleControl( self.effect_cast, 15, Vector( 0, 0, 255 ) )
		ParticleManager:SetParticleControl( self.effect_cast, 16, Vector( 1, 0, 0 ) )
	end

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_timbersaw_chakram_lua_thinker:StopEffects()
	-- destroy previous particle
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	-- stop sound
	local sound_cast = "Hero_Shredder.Chakram"
	StopSoundOn( sound_cast, self.parent )
end

-- function modifier_timbersaw_chakram_lua_thinker:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_shredder/shredder_chakram_spin.vpcf"
-- 	local sound_cast = "Hero_Shredder.Chakram"

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CENTER_FOLLOW, self.parent )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		3,
-- 		self.parent,
-- 		PATTACH_CENTER_FOLLOW,
-- 		nil,
-- 		Vector( 0,0,0 ), -- unknown
-- 		true -- unknown, true
-- 	)

-- 	if self.scepter then
-- 		-- set color to blue
-- 		ParticleManager:SetParticleControl( effect_cast, 15, Vector( 0, 0, 255 ) )
-- 		ParticleManager:SetParticleControl( effect_cast, 16, Vector( 1, 0, 0 ) )
-- 	end

-- 	-- buff particle
-- 	self:AddParticle(
-- 		effect_cast,
-- 		false, -- bDestroyImmediately
-- 		false, -- bStatusEffect
-- 		-1, -- iPriority
-- 		false, -- bHeroEffect
-- 		false -- bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOn( sound_cast, self.parent )
-- end
