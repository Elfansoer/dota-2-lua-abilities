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
modifier_aqua_gods_blessing_delay = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_gods_blessing_delay:IsHidden()
	return false
end

function modifier_aqua_gods_blessing_delay:IsDebuff()
	return false
end

function modifier_aqua_gods_blessing_delay:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_aqua_gods_blessing_delay:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "delay" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if IsServer() then
		-- send init data from server to client
		self:SetHasCustomTransmitterData( true )
		
		-- set random value on server, then send to client with transmitter
		self.random = RandomInt(0, 5)

		self:StartIntervalThink( self.delay )
	end

	-- store the value in the thinker, since modifier handle isn't accessible in client
	self.parent.random = self.random
end

function modifier_aqua_gods_blessing_delay:OnRefresh( kv )
end

function modifier_aqua_gods_blessing_delay:OnRemoved()
end

function modifier_aqua_gods_blessing_delay:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self.parent )
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_aqua_gods_blessing_delay:AddCustomTransmitterData()
	-- on server
	local data = {
		random = self.random
	}

	return data
end

function modifier_aqua_gods_blessing_delay:HandleCustomTransmitterData( data )
	-- on client
	self.random = data.random
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_aqua_gods_blessing_delay:OnIntervalThink()
	self:StartIntervalThink(-1)
	-- create modifier on actual target, but using thinker as its caster, not the actual caster
	local unit = self.parent.unit
	unit:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_aqua_gods_blessing",
		{duration = self.duration}
	)
end