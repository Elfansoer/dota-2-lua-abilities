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
modifier_hwei_crushing_maw = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_crushing_maw:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	-- references
	self.length = self:GetAbility():GetSpecialValueFor( "length" )
	self.width = self:GetAbility():GetSpecialValueFor( "width" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.stun = self:GetAbility():GetSpecialValueFor( "stun" )
	self.slow = self:GetAbility():GetSpecialValueFor( "duration" )

	if not IsServer() then return end
	self.damage_type = self.ability:GetAbilityDamageType()
	
	EmitSoundOnLocationWithCaster(self.parent:GetOrigin(), "Hero_Magnataur.ReversePolarity.Anim", self.caster ) 
end     

function modifier_hwei_crushing_maw:OnDestroy()
	if not IsServer() then return end

	local point = self.parent:GetOrigin()
	local zero = Vector(0,0,0)
	
	local angle_diff = AngleDiff( 
		VectorToAngles( self.parent:GetForwardVector() ).y,
		VectorToAngles( Vector( 0, 1, 0 ) ).y
	)
	local radius = math.sqrt( self.width*self.width + self.length*self.length )

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- precache damage
	local damageTable = {
		-- victim = self.parent,
		attacker = self.caster,
		damage = self.damage,
		damage_type = self.damage_type,
		ability = self.ability, --Optional.
	}

	for _,enemy in pairs(enemies) do
		local enemy_pos = enemy:GetOrigin()

		-- transform to local space
		local local_pos = enemy_pos - point
		local_pos = RotatePosition( zero, QAngle( 0, -angle_diff, 0 ), local_pos )

		-- check if its within the rectangle
		if
			math.abs( local_pos.x ) < self.length and
			math.abs( local_pos.y ) < self.width
		then
			-- move towards middle line
			local_pos.x = 0

			-- transform back to global space
			local target_pos = RotatePosition( zero, QAngle( 0, angle_diff, 0 ), local_pos )
			target_pos = target_pos + point
			FindClearSpaceForUnit( enemy, target_pos, true )

			-- ministun and slow
			enemy:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_stunned",
				{duration = self.stun}
			)

			enemy:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_hwei_crushing_maw_debuff",
				{duration = self.slow}
			)

			-- apply damage
			damageTable.victim = enemy
			ApplyDamage( damageTable )
		end
	end

	-- play effects
	EmitSoundOnLocationWithCaster(self.parent:GetOrigin(), "Hero_Magnataur.ReversePolarity.Cast", self.caster ) 

	UTIL_Remove( self.parent )
end