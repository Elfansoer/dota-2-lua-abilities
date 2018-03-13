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

        -- Set stack to predefined name
        self:SetStackCount( self:FindStackTable( self.spellName ) )
    end
    if not IsServer() then
        -- Retrieve stack tables
        self.spellName = self.stackTable[self:GetStackCount()]
    end
    -- self:Destroy()
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
  }
 
  return funcs
end

function modifier_rubick_spell_steal_lua_animation:GetOverrideAnimation()
    print("activity", self.gestures[self.spellName][1])
    return self.gestures[self.spellName][1]
end

function modifier_rubick_spell_steal_lua_animation:GetOverrideAnimationRate()
    return self.gestures[self.spellName][3] or 1
end

-- function modifier_rubick_spell_steal_lua_animation:GetOverrideAnimationWeight()

-- end

function modifier_rubick_spell_steal_lua_animation:GetActivityTranslationModifiers()
    print("translate",  self.gestures[self.spellName][2])
    return self.gestures[self.spellName][2]
end

--------------------------------------------------------------------------------
-- Interval Effects
-- function modifier_rubick_spell_steal_lua_animation:OnIntervalThink()
--     self:Destroy()
-- end
--------------------------------------------------------------------------------
-- Ability Gesture Table
modifier_rubick_spell_steal_lua_animation.gestures = {
    ["antimage_blink_lua"] = {ACT_DOTA_CAST_ABILITY_5, "am_blink"},
    ["antimage_mana_void_lua"] = {ACT_DOTA_CAST_ABILITY_5,"mana_void"},
    ["ursa_earthshock_lua"] = {ACT_DOTA_CAST_ABILITY_5, "earthshock", 1.5},
    ["ursa_overpower_lua"] = {ACT_DOTA_OVERRIDE_ABILITY_3, "overpower"},
    ["ursa_enrage_lua"] = {ACT_DOTA_OVERRIDE_ABILITY_4, "enrage"},
}

modifier_rubick_spell_steal_lua_animation.stackTable = {
    "antimage_blink_lua",
    "antimage_mana_void_lua",
    "ursa_earthshock_lua",
    "ursa_overpower_lua",
    "ursa_enrage_lua",
}
function modifier_rubick_spell_steal_lua_animation:FindStackTable( name )
    for k,v in pairs(self.stackTable) do
        if v==name then
            return ks
        end
    end
    return 0
end

-- modifier_rubick_spell_steal_lua_animation.animations = {
--     {"antimage_blink_lua", ACT_DOTA_CAST_ABILITY_5, "am_blink"},
--     {"antimage_mana_void_lua", ACT_DOTA_CAST_ABILITY_5,"mana_void"},
--     {"ursa_earthshock_lua", ACT_DOTA_CAST_ABILITY_5, "earthshock", 1.5},
--     {"ursa_overpower_lua", ACT_DOTA_OVERRIDE_ABILITY_3, "overpower"},
--     {"ursa_enrage_lua", ACT_DOTA_OVERRIDE_ABILITY_4, "enrage"},
-- }
-- function modifier_rubick_spell_steal_lua_animation:FindAnimation( name )
--     for k,v in pairs(self.animations) do
--         if v[1]==name then
--             return k
--         end
--     end
--     return 0
-- end