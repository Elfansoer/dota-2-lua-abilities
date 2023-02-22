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
modifier_maple_hydra = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_hydra:IsHidden()
	return true
end

function modifier_maple_hydra:IsDebuff()
	return false
end

function modifier_maple_hydra:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_hydra:OnCreated( kv )
	if not IsServer() then return end
	self.hydras = {}
	self.last_tick = GameRules:GetGameTime()
	self.ticking = false
	self.count = 0
end

function modifier_maple_hydra:OnRefresh( kv )
end

function modifier_maple_hydra:OnRemoved()
end

function modifier_maple_hydra:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_maple_hydra:OnIntervalThink()
	local current_tick = GameRules:GetGameTime()
	local dt = current_tick - self.last_tick
	self.last_tick = current_tick

	for hydra, end_time in pairs(self.hydras) do
		if end_time < current_tick then
			self:RemoveHydra( hydra )
		else
			hydra:IntervalThink( dt )
		end
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_maple_hydra:AddHydra( hydra, duration )
	self.hydras[ hydra ] = GameRules:GetGameTime() + duration
	self.count = self.count + 1
	if not self.ticking then
		self.last_tick = GameRules:GetGameTime()
		self:StartIntervalThink(0)
	end
end

function modifier_maple_hydra:RemoveHydra( hydra )
	hydra:Destroy()
	self.hydras[ hydra ] = nil
	self.count = self.count - 1
	if self.count < 1 then
		self:StartIntervalThink(-1)
		self.ticking = false
		self:Destroy()
	end
end
