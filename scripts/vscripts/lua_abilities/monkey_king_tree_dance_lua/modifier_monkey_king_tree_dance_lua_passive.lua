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
modifier_monkey_king_tree_dance_lua_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_monkey_king_tree_dance_lua_passive:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_monkey_king_tree_dance_lua_passive:OnCreated( kv )
	-- references
	self.cooldown = self:GetAbility():GetSpecialValueFor( "jump_damage_cooldown" )

	if not IsServer() then return end
end

function modifier_monkey_king_tree_dance_lua_passive:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_monkey_king_tree_dance_lua_passive:OnRemoved()
end

function modifier_monkey_king_tree_dance_lua_passive:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_monkey_king_tree_dance_lua_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_monkey_king_tree_dance_lua_passive:OnTakeDamage( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end

	-- not if perched
	if params.unit:HasModifier( "modifier_monkey_king_tree_dance_lua" ) then return end

	-- not if jumping
	local mod = false
	local modifiers = params.unit:FindAllModifiersByName( 'modifier_generic_arc_lua' )
	for _,modifier in pairs(modifiers) do
		if modifier:GetAbility()==self:GetAbility() then
			mod = true
			break
		end
	end
	if mod then return end

	-- only roshan/player-based damage
	if not params.attacker:IsControllableByAnyPlayer() and params.attacker:GetUnitName()~="npc_dota_roshan" then return end

	-- add cooldown
	self:GetAbility():StartCooldown( self.cooldown )
end