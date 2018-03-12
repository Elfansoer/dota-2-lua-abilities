modifier_rubick_spell_steal_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_rubick_spell_steal_lua:IsHidden()
	return false
end

function modifier_rubick_spell_steal_lua:IsDebuff()
	return false
end

function modifier_rubick_spell_steal_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_rubick_spell_steal_lua:OnCreated( kv )
end

function modifier_rubick_spell_steal_lua:OnRefresh( kv )
end

function modifier_rubick_spell_steal_lua:OnDestroy( kv )
	self:GetAbility():ForgetSpell()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_rubick_spell_steal_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_EVENT_ON_ABILITY_START,
	}

	return funcs
end

function modifier_rubick_spell_steal_lua:GetActivityTranslationModifiers()
	local translate = self.gestures[self:GetAbility().currentSpell:GetAbilityName()]
	if translate then
		print("translate:",translate)
		return translate
	end
end
function modifier_rubick_spell_steal_lua:OnAbilityStart( params )
	if IsServer() then
		if params.unit==self:GetParent() and params.ability==self:GetAbility().currentSpell then
			self:GetParent():StartGesture(59)
		end
	end
end

--------------------------------------------------------------------------------
-- Ability Gesture Table
modifier_rubick_spell_steal_lua.gestures = {}
modifier_rubick_spell_steal_lua.gestures["antimage_blink_lua"] = "am_blink"
