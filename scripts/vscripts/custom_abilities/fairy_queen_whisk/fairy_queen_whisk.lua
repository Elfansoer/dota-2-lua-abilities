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
fairy_queen_whisk = class({})
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_custom_indicator", "lua_abilities/generic/modifier_generic_custom_indicator", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_fairy_queen_whisk", "custom_abilities/fairy_queen_whisk/modifier_fairy_queen_whisk", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_whisk_debuff", "custom_abilities/fairy_queen_whisk/modifier_fairy_queen_whisk_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_whisk_visual", "custom_abilities/fairy_queen_whisk/modifier_fairy_queen_whisk_visual", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function fairy_queen_whisk:GetIntrinsicModifierName()
	-- Using custom indicator
	return "modifier_generic_custom_indicator"
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function fairy_queen_whisk:CastFilterResultLocation( vLoc )
	-- Custom indicator block start
	if IsClient() then
		-- check custom indicator
		if self.custom_indicator then
			-- register cursor position
			self.custom_indicator:Register( vLoc )
		end
	end
	-- Custom indicator block end

	if not self:CheckFairies() then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function fairy_queen_whisk:GetCustomCastErrorLocation( vLoc )
	if not self:CheckFairies() then
		return "#dota_hud_error_no_fairies"
	end

	return ""
end

function fairy_queen_whisk:CheckFairies()
	if self:GetCaster():HasModifier( "modifier_fairy_queen_fairies" ) and self:GetCaster():HasModifier( "modifier_fairy_queen_fairies_counter" ) then
		local used = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies_counter", self:GetCaster() )
		local fairies = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies", self:GetCaster() )
		if used<=fairies then
			return true
		end
	end

	return false
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator
function fairy_queen_whisk:CreateCustomIndicator()
	-- get data
	local ally_radius = self:GetSpecialValueFor( "ally_radius" )
	local enemy_radius = self:GetSpecialValueFor( "enemy_radius" )

	-- create particle
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_rift_ring_aoe.vpcf"

	self.effect_cast = {}
	self.effect_cast[1] = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl( self.effect_cast[1], 1, Vector(ally_radius,0,0) )
	
	self.effect_cast[2] = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl( self.effect_cast[2], 1, Vector(enemy_radius,0,0) )
end

function fairy_queen_whisk:UpdateCustomIndicator( loc )
	-- get data
	local origin = self:GetCaster():GetAbsOrigin()
	local fairies = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies_counter", self:GetCaster() )
	local max_range = 0
	if fairies==1 then
		max_range = self:GetSpecialValueFor("range_1")
	elseif fairies==2 then
		max_range = self:GetSpecialValueFor("range_2")
	elseif fairies==3 then
		max_range = self:GetSpecialValueFor("range_3")
	end

	-- determine target position
	local direction = (loc - origin)
	direction.z = 0
	if direction:Length2D() > max_range then
		direction = direction:Normalized() * max_range
	end

	-- particles are hidden (by moving them out of game) unless more fairies is used
	local loc1 = Vector(0,0,-200)
	local loc2 = loc1
	if fairies>=2 then
		loc1 = self:GetCaster():GetAbsOrigin()
	end
	if fairies==3 then
		loc2 = origin + direction
		loc2.z = loc.z
	end

	-- update particle
	ParticleManager:SetParticleControl( self.effect_cast[1],20,loc1 )
	ParticleManager:SetParticleControl( self.effect_cast[2],20,loc2 )
end

function fairy_queen_whisk:DestroyCustomIndicator()
	-- destroy
	for i=1,2 do
		ParticleManager:DestroyParticle( self.effect_cast[i], false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast[i] )
		self.effect_cast[i] = nil
	end
end

--------------------------------------------------------------------------------
-- Ability Start
function fairy_queen_whisk:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- consume fairies
	local fairy_modifier = caster:FindModifierByNameAndCaster( "modifier_fairy_queen_fairies", caster )
	local fairies,fairy_visual = fairy_modifier:GetFairies()

	-- load data
	local max_range = 0
	if fairies==1 then
		max_range = self:GetSpecialValueFor("range_1")
	elseif fairies==2 then
		max_range = self:GetSpecialValueFor("range_2")
	elseif fairies==3 then
		max_range = self:GetSpecialValueFor("range_3")
	end
	local ally_radius = self:GetSpecialValueFor( "ally_radius" )
	local enemy_radius = self:GetSpecialValueFor( "enemy_radius" )
	local buff_duration = self:GetSpecialValueFor( "buff_duration" )
	local debuff_duration = self:GetSpecialValueFor( "debuff_duration" )
	local knockback_duration = 0.2

	-- determine target position
	local direction = (point - origin)
	direction.z = 0
	if direction:Length2D() > max_range then
		direction = direction:Normalized() * max_range
	end

	-- teleport
	FindClearSpaceForUnit( caster, origin + direction, true )
	ProjectileManager:ProjectileDodge( caster )
	self:PlayEffects( origin )
	self:PlayEffects2( caster )

	-- teleport allies
	if fairies>=2 then
		-- destroy trees
		GridNav:DestroyTreesAroundPoint( origin+direction, ally_radius, false )

		-- add modifier
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_fairy_queen_whisk", -- modifier name
			{ duration = buff_duration } -- kv
		)

		-- find allies (hero+summoned)
		local allies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			origin,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			ally_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		for _,ally in pairs(allies) do
			if ally~=caster then
				local ally_origin = ally:GetOrigin()

				-- get delta position
				local delta = ally_origin-origin

				-- teleport along with caster
				FindClearSpaceForUnit( ally, origin + direction + delta, true )
				ProjectileManager:ProjectileDodge( ally )

				-- add modifier
				ally:AddNewModifier(
					caster, -- player source
					self, -- ability source
					"modifier_fairy_queen_whisk", -- modifier name
					{ duration = buff_duration } -- kv
				)

				-- effects
				self:PlayEffects( ally_origin )
				self:PlayEffects2( ally )
			end
		end
	end

	-- knockback enemies
	if fairies>=3 then
		-- find enemies
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			origin + direction,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			enemy_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		for _,enemy in pairs(enemies) do
			-- get delta
			local delta = enemy:GetOrigin()-(origin+direction)

			-- add knockback
			enemy:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_generic_knockback_lua", -- modifier name
				{
					distance = enemy_radius-delta:Length2D(),
					duration = knockback_duration,
					height = 100,
					direction_x = delta.x,
					direction_y = delta.y,
					IsStun = true,
				} -- kv
			)

			-- add debuff
			enemy:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_fairy_queen_whisk_debuff", -- modifier name
				{ duration = debuff_duration } -- kv
			)
		end
	end

	-- create visual
	for _,fairy in pairs(fairy_visual) do
		fairy:DestroyFairy()
	end
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_fairy_queen_whisk_visual", -- modifier name
		{
			duration = 0.5,
			fairies = fairies,
			direction_x = direction.x,
			direction_y = direction.y,
			direction_z = direction.z,
		}, -- kv
		origin,
		caster:GetTeamNumber(),
		false
	)

	-- Play sound
	local sound_cast = "Hero_SkywrathMage.MysticFlare.Target"
	EmitSoundOnLocationWithCaster( origin, sound_cast, caster )
	EmitSoundOnLocationWithCaster( origin+direction, sound_cast, caster )
end

-- --------------------------------------------------------------------------------
function fairy_queen_whisk:PlayEffects( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_illusory_orb_blink_out.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point + Vector(0,0,50) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function fairy_queen_whisk:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_failure.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end