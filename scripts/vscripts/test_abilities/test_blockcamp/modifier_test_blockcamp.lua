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
modifier_test_blockcamp = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_test_blockcamp:IsHidden()
	return false
end

function modifier_test_blockcamp:IsPurgable()
	return false
end

function modifier_test_blockcamp:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_test_blockcamp:OnCreated( kv )
	-- Start interval

	if not IsServer() then return end
	self:StartIntervalThink( 1 )

	self:GetParent():SetOriginalModel( "models/heroes/mars/mars_soldier.vmdl" )
	self:GetParent():StartGesture( ACT_DOTA_SPAWN )

end

function modifier_test_blockcamp:OnRefresh( kv )
	
end

function modifier_test_blockcamp:OnRemoved()
end

function modifier_test_blockcamp:OnDestroy()
	if not IsServer() then return end
	self:GetParent():ForceKill( false )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_test_blockcamp:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_test_blockcamp:OnIntervalThink()
	self:GetParent():StartGesture( ACT_DOTA_ATTACK )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_test_blockcamp:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_test_blockcamp:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end