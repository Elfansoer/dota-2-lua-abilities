-- Created by Elfansoer

if FilterManager then return FilterManager end

FilterManager = {}

-- create names
FilterManager.filternames = {
	'AbilityTuningValue',
	'BountyRunePickup',
	'Damage',
	'ExecuteOrder',
	'Healing',
	'ItemAddedToInventory',
	'ModifierGained',
	'ModifyExperience',
	'ModifyGold',
	'RuneSpawn',
	'TrackingProjectile',	
}

FilterManager.filters = {}

function FilterManager:Init()
	-- init filter tables
	for k,v in pairs(self.filternames) do
		self.filters[k] = {}
	end

	-- set filters
	local entity = GameRules:GetGameModeEntity()
	entity:SetAbilityTuningValueFilter( self.MainAbilityTuningValueFilter, self )
	entity:SetBountyRunePickupFilter( self.MainBountyRunePickupFilter, self )
	entity:SetDamageFilter( self.MainDamageFilter, self )
	entity:SetExecuteOrderFilter( self.MainExecuteOrderFilter, self )
	entity:SetHealingFilter( self.MainHealingFilter, self )
	entity:SetItemAddedToInventoryFilter( self.MainItemAddedToInventoryFilter, self )
	entity:SetModifierGainedFilter( self.MainModifierGainedFilter, self )
	entity:SetModifyExperienceFilter( self.MainModifyExperienceFilter, self )
	entity:SetModifyGoldFilter( self.MainModifyGoldFilter, self )
	entity:SetRuneSpawnFilter( self.MainRuneSpawnFilter, self )
	entity:SetTrackingProjectileFilter( self.MainTrackingProjectileFilter, self )
end

-- Add Filters
function FilterManager:AddAbilityTuningValueFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[1][key] = {func = func, context = context}
	return key
end
function FilterManager:AddBountyRunePickupFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[2][key] = {func = func, context = context}
	return key
end
function FilterManager:AddDamageFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[3][key] = {func = func, context = context}
	return key
end
function FilterManager:AddExecuteOrderFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[4][key] = {func = func, context = context}
	return key
end
function FilterManager:AddHealingFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[5][key] = {func = func, context = context}
	return key
end
function FilterManager:AddItemAddedToInventoryFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[6][key] = {func = func, context = context}
	return key
end
function FilterManager:AddModifierGainedFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[7][key] = {func = func, context = context}
	return key
end
function FilterManager:AddModifyExperienceFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[8][key] = {func = func, context = context}
	return key
end
function FilterManager:AddModifyGoldFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[9][key] = {func = func, context = context}
	return key
end
function FilterManager:AddRuneSpawnFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[10][key] = {func = func, context = context}
	return key
end
function FilterManager:AddTrackingProjectileFilter( func, context )
	local key = DoUniqueString( 'filtermanager' )
	self.filters[11][key] = {func = func, context = context}
	return key
end

-- function FilterManager:AddAbilityTuningValueFilter( func, context )
-- 	self.filters[1][func] = context;
-- end
-- function FilterManager:AddBountyRunePickupFilter( func, context )
-- 	self.filters[2][func] = context
-- end
-- function FilterManager:AddDamageFilter( func, context )
-- 	self.filters[3][func] = context
-- end
-- function FilterManager:AddExecuteOrderFilter( func, context )
-- 	self.filters[4][func] = context
-- end
-- function FilterManager:AddHealingFilter( func, context )
-- 	self.filters[5][func] = context
-- end
-- function FilterManager:AddItemAddedToInventoryFilter( func, context )
-- 	self.filters[6][func] = context
-- end
-- function FilterManager:AddModifierGainedFilter( func, context )
-- 	self.filters[7][func] = context
-- end
-- function FilterManager:AddModifyExperienceFilter( func, context )
-- 	self.filters[8][func] = context
-- end
-- function FilterManager:AddModifyGoldFilter( func, context )
-- 	self.filters[9][func] = context
-- end
-- function FilterManager:AddRuneSpawnFilter( func, context )
-- 	self.filters[10][func] = context
-- end
-- function FilterManager:AddTrackingProjectileFilter( func, context )
-- 	self.filters[11][func] = context
-- end

-- Remove Filters
function FilterManager:RemoveAbilityTuningValueFilter( key )
	self.filters[1][key] = nil
end
function FilterManager:RemoveBountyRunePickupFilter( key )
	self.filters[2][key] = nil
end
function FilterManager:RemoveDamageFilter( key )
	self.filters[3][key] = nil
end
function FilterManager:RemoveExecuteOrderFilter( key )
	self.filters[4][key] = nil
end
function FilterManager:RemoveHealingFilter( key )
	self.filters[5][key] = nil
end
function FilterManager:RemoveItemAddedToInventoryFilter( key )
	self.filters[6][key] = nil
end
function FilterManager:RemoveModifierGainedFilter( key )
	self.filters[7][key] = nil
end
function FilterManager:RemoveModifyExperienceFilter( key )
	self.filters[8][key] = nil
end
function FilterManager:RemoveModifyGoldFilter( key )
	self.filters[9][key] = nil
end
function FilterManager:RemoveRuneSpawnFilter( key )
	self.filters[10][key] = nil
end
function FilterManager:RemoveTrackingProjectileFilter( key )
	self.filters[11][key] = nil
end

-- function FilterManager:RemoveAbilityTuningValueFilter( func )
-- 	self.filters[1][func] = nil
-- end
-- function FilterManager:RemoveBountyRunePickupFilter( func )
-- 	self.filters[2][func] = nil
-- end
-- function FilterManager:RemoveDamageFilter( func )
-- 	self.filters[3][func] = nil
-- end
-- function FilterManager:RemoveExecuteOrderFilter( func )
-- 	self.filters[4][func] = nil
-- end
-- function FilterManager:RemoveHealingFilter( func )
-- 	self.filters[5][func] = nil
-- end
-- function FilterManager:RemoveItemAddedToInventoryFilter( func )
-- 	self.filters[6][func] = nil
-- end
-- function FilterManager:RemoveModifierGainedFilter( func )
-- 	self.filters[7][func] = nil
-- end
-- function FilterManager:RemoveModifyExperienceFilter( func )
-- 	self.filters[8][func] = nil
-- end
-- function FilterManager:RemoveModifyGoldFilter( func )
-- 	self.filters[9][func] = nil
-- end
-- function FilterManager:RemoveRuneSpawnFilter( func )
-- 	self.filters[10][func] = nil
-- end
-- function FilterManager:RemoveTrackingProjectileFilter( func )
-- 	self.filters[11][func] = nil
-- end


-- Main Filters
function FilterManager:MainAbilityTuningValueFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[1]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainBountyRunePickupFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[2]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainDamageFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[3]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainExecuteOrderFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[4]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainHealingFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[5]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainItemAddedToInventoryFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[6]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainModifierGainedFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[7]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainModifyExperienceFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[8]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainModifyGoldFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[9]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainRuneSpawnFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[10]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

function FilterManager:MainTrackingProjectileFilter( handle )
	local result = true
	-- iterate over filters
	for _,data in pairs(self.filters[11]) do
		-- hand over filters
		local res = data.func( data.context, handle )

		-- if there is a filter that return false, the main filter will return false
		result = result and res
	end

	return result
end

-- function FilterManager:MainAbilityTuningValueFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[1]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainBountyRunePickupFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[2]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainDamageFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[3]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainExecuteOrderFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[4]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainHealingFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[5]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainItemAddedToInventoryFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[6]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainModifierGainedFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[7]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainModifyExperienceFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[8]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainModifyGoldFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[9]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainRuneSpawnFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[10]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

-- function FilterManager:MainTrackingProjectileFilter( handle )
-- 	local result = true
-- 	-- iterate over filters
-- 	for func,context in pairs(self.filters[11]) do
-- 		-- hand over filters
-- 		local res = func( context, handle )

-- 		-- if there is a filter that return false, the main filter will return false
-- 		result = result and res
-- 	end

-- 	return result
-- end

return FilterManager