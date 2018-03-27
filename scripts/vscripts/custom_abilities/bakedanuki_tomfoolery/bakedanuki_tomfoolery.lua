bakedanuki_tomfoolery_blink = class({})
bakedanuki_tomfoolery_summon = class({})
LinkLuaModifier( "modifier_bakedanuki_tomfoolery", "custom_abilities/bakedanuki_tomfoolery/modifier_bakedanuki_tomfoolery", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Actual ability class
if tomfoolery==nil then
	tomfoolery = {}
end

tomfoolery.onTrick = false
bakedanuki_tomfoolery_blink.tomfoolery = tomfoolery
bakedanuki_tomfoolery_summon.tomfoolery = tomfoolery

function bakedanuki_tomfoolery_blink:OnSpellStart()
	self.tomfoolery:OnSpellStart( self, true )

	-- shared cooldown
	self:GetCaster():FindAbilityByName( self:GetSharedCooldownName() ):UseResources( false, false, true )
end
function bakedanuki_tomfoolery_summon:OnSpellStart()
	self.tomfoolery:OnSpellStart( self, false )

	-- shared cooldown
	self:GetCaster():FindAbilityByName( self:GetSharedCooldownName() ):UseResources( false, false, true )
end

function bakedanuki_tomfoolery_blink:StopTrick()
	self.tomfoolery:StopTrick( self )
end
function bakedanuki_tomfoolery_summon:StopTrick()
	self.tomfoolery:StopTrick( self )
end

--------------------------------------------------------------------------------
-- Ability Start
function tomfoolery:OnSpellStart( this, bBlink )
	-- destroy previous cast
	if self.onTrick then
		self:StopTrick( this )
	end

	-- Unit identifier
	local caster = this:GetCaster()
	local point = this:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- load data
	local max_range = this:GetSpecialValueFor("illusion_range")
	local illusion_outgoing = this:GetSpecialValueFor("illusion_outgoing")
	local illusion_incoming = this:GetSpecialValueFor("illusion_incoming")
	local illusion_duration = this:GetSpecialValueFor("illusion_duration")

	-- determine positions
	local direction = (point - origin)
	if direction:Length2D() > max_range then
		direction = direction:Normalized() * max_range
	end
	local loc1 = origin
	local loc2 = origin + direction
	if bBlink then
		local temp = loc1
		loc1 = loc2
		loc2 = temp
	end

	-- set real hero position, add fooling modifier
	FindClearSpaceForUnit( caster, loc1, true )
	local modifier = caster:AddNewModifier(
		caster,
		this,
		"modifier_bakedanuki_tomfoolery",
		{ duration = illusion_duration }
	)

	-- Create illusion at position
	local illusion = self:CreateIllusion( this, caster, loc2, illusion_incoming, illusion_outgoing, illusion_duration )

	-- set gesture
	caster:StartGesture( ACT_DOTA_IDLE )
	illusion:StartGesture( ACT_DOTA_IDLE )

	-- dodge projectile
	ProjectileManager:ProjectileDodge( caster )

	-- Set shared data
	self.onTrick = true
	self.modifier = modifier
	self.illusion = illusion
	self.currentHealth = caster:GetHealth()

	-- Play effects
	-- self:PlayEffects( origin, direction )
end

function tomfoolery:CreateIllusion( this, caster, location, incoming, outgoing, duration )
	local illusion = CreateUnitByName(
		caster:GetUnitName(), -- szUnitName
		location, -- vLocation,
		false, -- bFindClearSpace,
		caster, -- hNPCOwner,
		nil, -- hUnitOwner,
		caster:GetTeamNumber() -- iTeamNumber
	)

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

	-- copy health state
	illusion:SetHealth( caster:GetHealth() )

	-- make illusion
	illusion:MakeIllusion()
	illusion:SetControllableByPlayer( caster:GetPlayerID(), false ) -- (playerID, bSkipAdjustingPosition)
	illusion:SetOwner( caster )
	illusion:SetPlayerID( caster:GetPlayerID() )

	-- Add illusion modifier
	illusion:AddNewModifier(
		caster,
		this,
		"modifier_illusion",
		{
			duration = duration,
			outgoing_damage = outgoing-100,
			incoming_damage = incoming-100,
		}
	)

	return illusion
end

function tomfoolery:StopTrick( this )
	if not self.onTrick then
		return
	end

	self.onTrick = false
	self.modifier:Destroy()
	if self.illusion:IsAlive() then
		self.illusion:ForceKill( false )
	end
	this:GetCaster():SetHealth( self.currentHealth )
	this:GetCaster():Purge( false, true, false, true, true )
end

