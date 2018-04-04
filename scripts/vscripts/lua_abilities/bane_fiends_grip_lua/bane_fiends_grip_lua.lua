bane_fiends_grip_lua = class({})
LinkLuaModifier( "modifier_bane_fiends_grip_lua", "lua_abilities/bane_fiends_grip_lua/modifier_bane_fiends_grip_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function bane_fiends_grip_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local maxDuration = self:GetSpecialValueFor("fiend_grip_duration")

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- add modifier
	self.modifier = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bane_fiends_grip_lua", -- modifier name
		{ duration = maxDuration } -- kv
	)

	self:PlayEffects( target )
end

function bane_fiends_grip_lua:StopSpell()
	if self.modifier then
		self.modifier:Destroy()
		
		if self:IsChanneling() then
			self:GetParent():Stop()
		end

		-- stop effects
		StopSoundOn( self.sound_cast, self:GetCaster() )
		StopSoundOn( self.sound_target, self.target )
		self.target = nil
	end
end

--------------------------------------------------------------------------------
-- Ability Channeling
function bane_fiends_grip_lua:OnChannelFinish( bInterrupted )
	self:StopSpell()
end

--------------------------------------------------------------------------------
function bane_fiends_grip_lua:PlayEffects( target )
	-- Get Resources
	self.sound_cast = "Hero_Bane.FiendsGrip.Cast"
	self.sound_target = "Hero_Bane.FiendsGrip"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( self.sound_target, target )
	self.target = target
end