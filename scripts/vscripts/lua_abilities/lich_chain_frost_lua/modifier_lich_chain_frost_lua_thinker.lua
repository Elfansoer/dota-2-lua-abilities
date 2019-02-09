modifier_lich_chain_frost_lua_thinker = class({})
local tempTable = require( "util/tempTable" )

--------------------------------------------------------------------------------
-- Classifications
function modifier_lich_chain_frost_lua_thinker:IsHidden()
	return false
end

function modifier_lich_chain_frost_lua_thinker:IsPurgable()
	return false
end

function modifier_lich_chain_frost_lua_thinker:RemoveOnDeath()
	return false
end

function modifier_lich_chain_frost_lua_thinker:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lich_chain_frost_lua_thinker:OnCreated( kv )
	if IsServer() then
		self.key = kv.key
	end
end

function modifier_lich_chain_frost_lua_thinker:OnRefresh( kv )
	
end

function modifier_lich_chain_frost_lua_thinker:OnDestroy( kv )
	if IsServer() then
		local castTable = tempTable:GetATValue( self.key )

		-- update values
		if not castTable.scepter then
			castTable.jump = castTable.jump + 1
		end

		if castTable.jump>castTable.jumps then
			-- stop bouncing
			castTable = tempTable:RetATValue( self.key )
			return
		end

		-- add temporary FOV
		AddFOWViewer( castTable.projectile.iVisionTeamNumber, self:GetParent():GetOrigin(), castTable.projectile.iVisionRadius, 0.3, false)

		-- find enemies
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			self:GetParent():GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			castTable.jump_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- get random enemy
		local target = nil
		for _,enemy in pairs(enemies) do
			if enemy~=self:GetParent() then
				target = enemy
				break
			end
		end

		if not target then
			-- stop bouncing
			castTable = tempTable:RetATValue( self.key )
			return
		end

		-- bounce to enemy
		castTable.projectile.Target = target
		castTable.projectile.Source = self:GetParent()
		castTable.projectile.EffectName = "particles/econ/items/lich/lich_ti8_immortal_arms/lich_ti8_chain_frost.vpcf"
		
		castTable.projectile = self:PlayProjectile( castTable.projectile )
		ProjectileManager:CreateTrackingProjectile( castTable.projectile )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Effects
function modifier_lich_chain_frost_lua_thinker:PlayProjectile( info )
	local tracker = info.Target:AddNewModifier(
		info.Source, -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_tracking_projectile", -- modifier name
		{ duration = 4 } -- kv
	)
	local effect_cast = tracker:PlayTrackingProjectile( info )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		info.Source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	info.EffectName = nil
	if not info.ExtraData then info.ExtraData = {} end
	info.ExtraData.tracker = tempTable:AddATValue( tracker )

	return info
end
