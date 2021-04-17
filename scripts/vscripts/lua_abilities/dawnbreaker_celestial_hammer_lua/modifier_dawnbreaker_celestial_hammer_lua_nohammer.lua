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
modifier_dawnbreaker_celestial_hammer_lua_nohammer = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_celestial_hammer_lua_nohammer:IsHidden()
	return true
end

function modifier_dawnbreaker_celestial_hammer_lua_nohammer:IsDebuff()
	return false
end

function modifier_dawnbreaker_celestial_hammer_lua_nohammer:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_celestial_hammer_lua_nohammer:OnCreated( kv )
	if not IsServer() then return end
	self:IncrementStackCount()
end

function modifier_dawnbreaker_celestial_hammer_lua_nohammer:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dawnbreaker_celestial_hammer_lua_nohammer:OnRemoved()
end

function modifier_dawnbreaker_celestial_hammer_lua_nohammer:OnDestroy()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Other
function modifier_dawnbreaker_celestial_hammer_lua_nohammer:Decrement()
	self:DecrementStackCount()
	if self:GetStackCount()<1 then
		self:Destroy()
	end
end
