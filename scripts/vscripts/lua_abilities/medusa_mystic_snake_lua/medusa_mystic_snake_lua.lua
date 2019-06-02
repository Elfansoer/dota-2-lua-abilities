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
medusa_mystic_snake_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function medusa_mystic_snake_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local mana_steal = self:GetSpecialValueFor( "snake_mana_steal" )/100
	local jumps = self:GetSpecialValueFor( "snake_jumps" )
	local radius = self:GetSpecialValueFor( "radius" )
	local base_damage = self:GetSpecialValueFor( "snake_damage" )
	local mult_damage = self:GetSpecialValueFor( "snake_scale" )/100

	local base_stun = 0
	local mult_stun = 0
	if caster:HasScepter() then
		-- check if Stone Gaze has been learned, except it's stolen
		local ability = caster:FindAbilityByName( "medusa_stone_gaze_lua" )
		if self:IsStolen() or (ability and ability:GetLevel()>0) then
			base_stun = self:GetSpecialValueFor( "stone_form_scepter_base" )
			mult_stun = self:GetSpecialValueFor( "stone_form_scepter_increment" )
		end
	end

	local projectile_name = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "initial_speed" )
	local projectile_vision = 100

	-- get unique identifier
	local index = self:GetUniqueInt()

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = false,                           -- Optional
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
	
		bDrawsOnMinimap = false,                          -- Optional
		bVisibleToEnemies = true,                         -- Optional
		bProvidesVision = true,                           -- Optional
		iVisionRadius = projectile_vision,                              -- Optional
		iVisionTeamNumber = caster:GetTeamNumber(),        -- Optional

		ExtraData = {
			index = index,
		}
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- register projectile
	local data = {}
	data.jump = 0
	data.mana_stolen = 0
	data.isReturning = false
	data.hit_units = {}

	data.jumps = jumps
	data.radius = radius
	data.base_damage = base_damage
	data.mult_damage = mult_damage
	data.base_stun = base_stun
	data.mult_stun = mult_stun
	data.mana_steal = mana_steal
	data.projectile_info = info

	self.projectiles[index] = data

	-- play effects
	local sound_cast = "Hero_Medusa.MysticSnake.Cast"
	EmitSoundOn( sound_cast, caster )
end
--------------------------------------------------------------------------------
-- Projectile
medusa_mystic_snake_lua.projectiles = {}
function medusa_mystic_snake_lua:OnProjectileHit_ExtraData( target, location, ExtraData )
	-- load data
	local data = self.projectiles[ ExtraData.index ]

	-- if returning, returns mana
	if data.isReturning then
		self:Returned( data )
		return
	end

	-- if target turns magic immune or invulnerable or somehow there is no target even though it is undisjointable, skip
	if target and (not target:IsMagicImmune()) and (not target:IsInvulnerable()) then
		-- mark as hit
		data.hit_units[target] = true

		-- stun if scepter
		if data.base_stun>0 then
			target:AddNewModifier(
				self:GetCaster(), -- player source
				self, -- ability source
				"modifier_medusa_stone_gaze_lua_petrified", -- modifier name
				{
					duration = data.base_stun + data.mult_stun * data.jump,
					physical_bonus = 50, -- hard coded because caster may not have Stone Gaze
					center_unit = self:GetCaster():entindex()
				} -- kv
			)
		end

		-- damage
		local damage_type = self:GetAbilityDamageType()
		if target:HasModifier( "modifier_medusa_stone_gaze_lua_petrified" ) then
			damage_type = DAMAGE_TYPE_PURE
		end

		local damage = data.base_damage + data.base_damage * data.mult_damage * data.jump
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = damage_type,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)

		-- take mana
		local mana_taken = math.min( target:GetMaxMana()*data.mana_steal, target:GetMana() )
		target:ReduceMana( mana_taken )
		data.mana_stolen = data.mana_stolen + mana_taken

		-- play effects
		local sound_cast = "Hero_Medusa.MysticSnake.Target"
		EmitSoundOn( sound_cast, target )

		-- counter
		data.jump = data.jump + 1
		if data.jump>=data.jumps then
			-- return projectile with target
			self:Returning( data, target )
			return
		end
	end

	-- jump to nearby target
	local pos = location
	if target then
		pos = target:GetOrigin()
	end

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		pos,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		data.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- pick next target
	local next_target = nil
	for _,enemy in pairs(enemies) do

		-- check if it is already hit
		local found = false
		for unit,_ in pairs(data.hit_units) do
			if enemy==unit then
				found = true
				break
			end
		end

		if not found then
			next_target = enemy
			break
		end
	end

	-- not found
	if not next_target then
		-- return projectile without target
		self:Returning( data, target )
		return
	end

	-- create bounce projectile
	data.projectile_info.Target = next_target
	data.projectile_info.Source = target
	ProjectileManager:CreateTrackingProjectile( data.projectile_info )
end

function medusa_mystic_snake_lua:Returning( data, target )
	if not target then
		self:Returned( data )
		return
	end

	-- set returning
	data.isReturning = true

	-- create projectile
	local projectile_name = "particles/units/heroes/hero_medusa/medusa_mystic_snake_projectile_return.vpcf"
	data.projectile_info.Target = self:GetCaster()
	data.projectile_info.Source = target
	data.projectile_info.EffectName = projectile_name
	ProjectileManager:CreateTrackingProjectile( data.projectile_info )
end

function medusa_mystic_snake_lua:Returned( data )
	-- unregister projectile
	local index = data.projectile_info.ExtraData.index
	self.projectiles[ index ] = nil
	self:DelUniqueInt( index )

	-- only do things if alive
	if not self:GetCaster():IsAlive() then return end

	-- give mana
	self:GetCaster():GiveMana( data.mana_stolen )

	-- play effects
	local sound_cast = "Hero_Medusa.MysticSnake.Return"
	EmitSoundOn( sound_cast, self:GetCaster() )
	SendOverheadEventMessage(
		nil, -- DOTAPlayer sendToPlayer,
		OVERHEAD_ALERT_MANA_ADD, --int iMessageType,
		self:GetCaster(),-- Entity targetEntity,
		data.mana_stolen,-- int iValue,
		self:GetCaster():GetPlayerOwner() -- DOTAPlayer sourcePlayer
	) -- - sendToPlayer and sourcePlayer can be nil - iMessageType is one of OVERHEAD_ALERT_* ])
end

--------------------------------------------------------------------------------
-- Helper

-- Obtain unique integer for projectile identifier
medusa_mystic_snake_lua.unique = {}
medusa_mystic_snake_lua.i = 0
medusa_mystic_snake_lua.max = 65536
function medusa_mystic_snake_lua:GetUniqueInt()
	while self.unique[ self.i ] do
		self.i = self.i + 1
		if self.i==self.max then self.i = 0 end
	end

	self.unique[ self.i ] = true
	return self.i
end
function medusa_mystic_snake_lua:DelUniqueInt( i )
	self.unique[ i ] = nil
end