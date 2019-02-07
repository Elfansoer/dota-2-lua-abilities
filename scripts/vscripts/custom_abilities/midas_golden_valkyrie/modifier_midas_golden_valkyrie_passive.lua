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
modifier_midas_golden_valkyrie_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_valkyrie_passive:IsHidden()
	return true
end

function modifier_midas_golden_valkyrie_passive:IsPurgable()
	return false
end

function modifier_midas_golden_valkyrie_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_valkyrie_passive:OnCreated( kv )
end

function modifier_midas_golden_valkyrie_passive:AddBit( bit )
	self:SetStackCount( flag:Add( self:GetStackCount(), bit ) )
end

function modifier_midas_golden_valkyrie_passive:HasBit( bit )
	return flag:Exist( self:GetStackCount(), bit )
end

--------------------------------------------------------------------------------
-- Helper: flag Calculations
if not flag then
	flag = {}
end

-- Returns true if flag b is within state a
function flag:Exist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

-- Adds flag b to state a, if not exist
function flag:Add(a,b)
	if flag:Exist(a,b) then
		return a
	else
		return a+b
	end
end

-- Removes flag b to state a, if exist
function flag:Min(a,b)
	if flag:Exist(a,b) then
		return a-b
	else
		return a
	end
end
