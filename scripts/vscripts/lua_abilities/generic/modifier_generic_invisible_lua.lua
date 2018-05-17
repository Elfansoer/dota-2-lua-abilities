modifier_generic_invisible_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_invisible_lua:IsHidden()
	return false
end

function modifier_generic_invisible_lua:IsDebuff()
	return false
end

function modifier_generic_invisible_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_invisible_lua:OnCreated( kv )
	-- references
	self.delay = kv.delay or 0
	self.attack_reveal = kv.attack_reveal or true
	self.ability_reveal = kv.ability_reveal or true

	self.hidden = false

	if IsServer() then
		-- Start interval
		self:StartIntervalThink( self.delay )
	end
end

function modifier_generic_invisible_lua:OnRefresh( kv )
	-- references
	self.delay = kv.delay or 0
	self.attack_reveal = kv.attack_reveal or true
	self.ability_reveal = kv.ability_reveal or true

	self.hidden = false

	if IsServer() then
		-- Start interval
		self:StartIntervalThink( self.delay )
	end
end

function modifier_generic_invisible_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_invisible_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
	}

	return funcs
end

function modifier_generic_invisible_lua:GetModifierInvisibilityLevel()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_invisible_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = self.hidden,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_invisible_lua:OnIntervalThink()
	self.hidden = true
end