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
pangolier_swashbuckle_lua = class({})
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_pangolier_swashbuckle_lua", "lua_abilities/pangolier_swashbuckle_lua/modifier_pangolier_swashbuckle_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function pangolier_swashbuckle_lua:OnAbilityPhaseInterrupted()

end
function pangolier_swashbuckle_lua:OnAbilityPhaseStart()
	-- Vector targeting
	if not self:CheckVectorTargetPosition() then return false end
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function pangolier_swashbuckle_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local targets = self:GetVectorTargetPosition()

	-- load data
	local speed = self:GetSpecialValueFor( "dash_speed" )
	local direction = targets.direction

	local vector = (targets.init_pos-caster:GetOrigin())
	local dist = vector:Length2D()
	vector.z = 0
	vector = vector:Normalized()

	-- Facing
	caster:SetForwardVector( direction )

	-- Play effects
	local effects = self:PlayEffects()

	-- knockback
	local knockback = caster:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_knockback_lua", -- modifier name
		{
			direction_x = vector.x,
			direction_y = vector.y,
			distance = dist,
			duration = dist/speed,
			IsStun = true,
			IsFlail = false,
		} -- kv
	)
	local callback = function( bInterrupted )
		-- stop effects
		ParticleManager:DestroyParticle( effects, false )
		ParticleManager:ReleaseParticleIndex( effects )

		if bInterrupted then return end

		-- add modifier
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_pangolier_swashbuckle_lua", -- modifier name
			{
				dir_x = direction.x,
				dir_y = direction.y,
				duration = 3, -- max duration
			} -- kv
		)
		
	end
	knockback:SetEndCallback( callback )
end

--------------------------------------------------------------------------------
function pangolier_swashbuckle_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf"
	local sound_cast = "Hero_Pangolier.Swashbuckle.Cast"
	local sound_layer = "Hero_Pangolier.Swashbuckle.Layer"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_layer, self:GetCaster() )

	return effect_cast
end