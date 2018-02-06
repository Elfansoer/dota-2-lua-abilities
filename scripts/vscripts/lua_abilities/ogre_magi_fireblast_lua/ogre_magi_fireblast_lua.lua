ogre_magi_fireblast_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua" , "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ogre_magi_fireblast_lua:OnSpellStart()
	-- get references
	local target = self:GetCursorTarget()
	local damage = self:GetSpecialValueFor("fireblast_damage")
	local duration = self:GetSpecialValueFor("stun_duration")

	-- Apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damageTable )

	-- Apply Stun Modifier
	target:AddNewModifier(
		self:GetCaster(),
		self, 
		"modifier_generic_stunned_lua", 
		{duration = duration}
	)

	self:PlayEffects()
end

function ogre_magi_fireblast_lua:PlayEffects()
	-- get references
	local target = self:GetCursorTarget()
	local particle_target = "particles/units/heroes/hero_ogre_magi/ogre_magi_fireblast.vpcf"
	local sound_target = "Hero_OgreMagi.Fireblast.Cast"

	-- play particles
	local nFXIndex = ParticleManager:CreateParticle( particle_target, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, target:GetOrigin() )
	ParticleManager:SetParticleControl( nFXIndex, 1, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	-- play sound
	EmitSoundOn( sound_target, target )
end
