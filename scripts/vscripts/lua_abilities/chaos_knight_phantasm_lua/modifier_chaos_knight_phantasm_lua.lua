modifier_chaos_knight_phantasm_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_chaos_knight_phantasm_lua:IsHidden()
	return false
end

function modifier_chaos_knight_phantasm_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_chaos_knight_phantasm_lua:OnCreated( kv )
	-- references
	self.image_count = self:GetAbility():GetSpecialValueFor( "images_count" )
	self.image_duration = self:GetAbility():GetSpecialValueFor( "illusion_duration" )
	self.extra_chance = self:GetAbility():GetSpecialValueFor( "extra_phantasm_chance_pct_tooltip" )
	self.extra_count = 1
	self.vision_duration = self:GetAbility():GetSpecialValueFor( "vision_duration" )

	if IsServer() then
		-- Generate data
		local caster = self:GetParent()
		local extra = false
		if self:RollChance( self.extra_chance ) then
			self.image_count = self.image_count + self.extra_count
			extra = true
		end
		self.illusions = {}

		-- Basic Dispel
		self:GetParent():Purge( false, true, false, false, false )

		-- Stop orders
		self:GetParent():Stop()

		-- Remove previous illusions
		for _,illusion in pairs(self:GetAbility().illusions) do
			if (not illusion:IsNull()) and illusion:IsAlive() then
				illusion:ForceKill( false )
			end
			illusion = nil
		end
		self:GetAbility().illusions = {}

		-- Determine Spawn Points
		local distance = 135 -- 162
		local spawn = {} -- center, right, left, back, front
		spawn[1] = caster:GetOrigin()
		spawn[2] = spawn[1] + caster:GetRightVector():Normalized() * distance
		spawn[3] = spawn[1] + caster:GetRightVector():Normalized() * -distance
		spawn[4] = spawn[1] + caster:GetForwardVector():Normalized() * -distance
		spawn[5] = spawn[1] + caster:GetForwardVector():Normalized() * distance

		-- Move real one to random position
		local realPos = RandomInt( 1, self.image_count+1 )
		self.spawnSelf = spawn[realPos]

		-- set other spawn's location
		self.spawnLoc = {}
		for i=1,self.image_count do
			local sp = i
			if sp==realPos then sp = self.image_count+1 end
			self.spawnLoc[i] = spawn[sp]
		end

		-- Optimization: spread over spawn creator
		-- self:StartIntervalThink( 0.1 )
		self.spawnedUnits = 0

		-- Play Effects
		self:PlayEffects( extra, spawn[1] )
	end
end

function modifier_chaos_knight_phantasm_lua:OnRefresh( kv )
	
end

function modifier_chaos_knight_phantasm_lua:OnDestroy( kv )
	if IsServer() then
		FindClearSpaceForUnit( self:GetParent(), self.spawnSelf, true )

		local loop = true
		while loop do
			-- create illusion
			local illusion = self:CreateIllusionAndAdd( self:GetParent(), self.spawnLoc[self.spawnedUnits + 1] )

			self.spawnedUnits = self.spawnedUnits + 1
			if self.spawnedUnits >= self.image_count then
				loop = false
			end
		end
	end
end

-- function modifier_chaos_knight_phantasm_lua:OnIntervalThink()
-- 	-- create illusion
-- 	local illusion = self:CreateIllusion( self:GetParent(), self.spawnLoc[self.spawnedUnits + 1] )

-- 	-- add to table

-- 	self.spawnedUnits = self.spawnedUnits + 1
-- 	if self.spawnedUnits >= self.image_count then
-- 		self:StartIntervalThink( -1 )
-- 	end
-- end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_chaos_knight_phantasm_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

function modifier_chaos_knight_phantasm_lua:PlayEffects( extra, location )
		local particle_cast = "particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf"
		self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
		ParticleManager:SetParticleControl( self.effect_cast, 0, location )

		self:AddParticle(
			self.effect_cast,
			false,
			false,
			-1,
			false,
			false
		)

		local sound_cast = "Hero_ChaosKnight.Phantasm"
		EmitSoundOn( sound_cast, self:GetParent() )
		
		if extra then 
			local sound_cast_2 = "Hero_ChaosKnight.Phantasm.Plus" 
			EmitSoundOn( sound_cast_2, self:GetParent() )
		end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_chaos_knight_phantasm_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end

function modifier_chaos_knight_phantasm_lua:CreateIllusionAndAdd( caster, location )
	-- optimization: use async unit creation
	local ability = self:GetAbility()
	local modifyIllusion = function ( illusion )
		-- set facing
		illusion:SetForwardVector( caster:GetForwardVector() )

		-- set level, abilities and items
		while illusion:GetLevel() < caster:GetLevel() do
			illusion:HeroLevelUp( false )
		end
		illusion:SetAbilityPoints( 0 )
		local abilityCount = caster:GetAbilityCount()
		for i=0,abilityCount-1 do
			local ability = caster:GetAbilityByIndex(i)
			if ability and illusion:GetAbilityByIndex(i) then
				illusion:GetAbilityByIndex(i):SetLevel( ability:GetLevel() )
			end
		end
		local eslot = nil
		for slot=0,5 do
			-- remove anything in current slot
			local iItem = illusion:GetItemInSlot(slot)
			if iItem then illusion:RemoveItem( illusion:GetItemInSlot(slot) ) end

			-- add item to slot
			local item = caster:GetItemInSlot(slot)
			if item then
				illusion:AddItemByName( item:GetName() )

				-- rearrange slot
				if eslot and eslot~=slot then
					illusion:SwapItems( eslot, slot )
				end
			elseif not eslot then
				eslot = slot
			end
		end

		-- make illusion
		illusion:MakeIllusion()
		illusion:SetControllableByPlayer( caster:GetPlayerID(), false ) -- (playerID, bSkipAdjustingPosition)
		illusion:SetOwner( caster )
		illusion:SetPlayerID( caster:GetPlayerID() )

		-- Add illusion modifier
		illusion:AddNewModifier(
			caster,
			self,
			"modifier_illusion",
			{
				duration = self.image_duration,
				outgoing_damage = 0,
				incoming_damage = 160,
			}
		)
		table.insert( ability.illusions, illusion )
	end

	-- Create unit
	local illusion = CreateUnitByNameAsync(
		caster:GetUnitName(), -- szUnitName
		location, -- vLocation,
		false, -- bFindClearSpace,
		caster, -- hNPCOwner,
		nil, -- hUnitOwner,
		caster:GetTeamNumber(), -- iTeamNumber
		modifyIllusion
	)

	return illusion
end