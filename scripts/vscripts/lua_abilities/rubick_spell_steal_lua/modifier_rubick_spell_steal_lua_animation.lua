modifier_rubick_spell_steal_lua_animation = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_rubick_spell_steal_lua_animation:IsHidden()
    return false
end

function modifier_rubick_spell_steal_lua_animation:IsDebuff()
    return false
end

function modifier_rubick_spell_steal_lua_animation:IsPurgable()
    return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_rubick_spell_steal_lua_animation:OnCreated( kv )
    if IsServer() then
        -- Get SpellName
        self.spellName = kv.spellName

        -- Set stack to current reference
        self:SetStackCount( self:GetAbility().animations:GetCurrentReference() )
    end
    if not IsServer() then
        -- Retrieve current reference
        self:GetAbility().animations:SetCurrentReferenceIndex( self:GetStackCount() )
    end
end

function modifier_rubick_spell_steal_lua_animation:OnRefresh( kv )
  
end

function modifier_rubick_spell_steal_lua_animation:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Declared functions
function modifier_rubick_spell_steal_lua_animation:DeclareFunctions() 
  local funcs = {
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
    -- MODIFIER_PROPERTY_OVERRIDE_ANIMATION_WEIGHT,
    MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    MODIFIER_EVENT_ON_ORDER,
  }
 
  return funcs
end

function modifier_rubick_spell_steal_lua_animation:GetOverrideAnimation()
    return self:GetAbility().animations:GetActivity()
end

function modifier_rubick_spell_steal_lua_animation:GetOverrideAnimationRate()
    return self:GetAbility().animations:GetPlaybackRate()
end

-- function modifier_rubick_spell_steal_lua_animation:GetOverrideAnimationWeight()

-- end

function modifier_rubick_spell_steal_lua_animation:GetActivityTranslationModifiers()
    return self:GetAbility().animations:GetTranslate()
end

function modifier_rubick_spell_steal_lua_animation:OnOrder( params )
    if IsServer() then
        if params.unit==self:GetParent() then
            self:Destroy()
        end
    end
end
--------------------------------------------------------------------------------
-- Interval Effects
-- function modifier_rubick_spell_steal_lua_animation:OnIntervalThink()
--     self:Destroy()
-- end
