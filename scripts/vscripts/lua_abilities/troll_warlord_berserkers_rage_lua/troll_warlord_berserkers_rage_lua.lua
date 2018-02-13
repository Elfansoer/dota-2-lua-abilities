troll_warlord_berserkers_rage_lua = class({})
LinkLuaModifier( "modifier_troll_warlord_berserkers_rage_lua", "lua_abilities/troll_warlord_berserkers_rage_lua/modifier_troll_warlord_berserkers_rage_lua", LUA_MODIFIER_MOTION_NONE )

function troll_warlord_berserkers_rage_lua:ProcsMagicStick()
	return false
end

--------------------------------------------------------------------------------
-- Ability Toggle
function troll_warlord_berserkers_rage_lua:OnToggle()
	if self:GetToggleState() then
		self.modifier = self:GetCaster():AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_troll_warlord_berserkers_rage_lua",
			{}
		)
	else
		if self.modifier then
			self.modifier:Destroy()
			self.modifier = nil
		end
	end

	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Ability Events
function troll_warlord_berserkers_rage_lua:OnUpgrade()
	if self.modifier then
		self.modifier:ForceRefresh()
	end
end

--------------------------------------------------------------------------------
-- Ability Effects
function troll_warlord_berserkers_rage_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_TrollWarlord.BerserkersRage.Toggle"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end