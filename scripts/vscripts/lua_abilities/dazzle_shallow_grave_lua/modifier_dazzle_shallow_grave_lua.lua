modifier_dazzle_shallow_grave_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dazzle_shallow_grave_lua:IsHidden()
	return false
end

function modifier_dazzle_shallow_grave_lua:IsDebuff()
	return false
end

function modifier_dazzle_shallow_grave_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dazzle_shallow_grave_lua:OnCreated( kv )
	if IsServer() then
		-- Play effects
		local sound_cast = "Hero_Dazzle.Shallow_Grave"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dazzle_shallow_grave_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}

	return funcs
end
function modifier_dazzle_shallow_grave_lua:GetMinHealth()
	return 1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dazzle_shallow_grave_lua:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_shallow_grave.vpcf"
end

function modifier_dazzle_shallow_grave_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end