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
		ProjectileManager:CreateTrackingProjectile( castTable.projectile )
	end
end