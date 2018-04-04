modifier_sniper_shrapnel_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_shrapnel_lua_thinker:IsHidden()
	return true
end

function modifier_sniper_shrapnel_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Aura
function modifier_sniper_shrapnel_lua_thinker:IsAura()
	return self.start
end
function modifier_sniper_shrapnel_lua_thinker:GetModifierAura()
	return "modifier_sniper_shrapnel_lua"
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraDuration()
	return 0.5
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_sniper_shrapnel_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_shrapnel_lua_thinker:OnCreated( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "damage_delay" ) -- special value
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
	self.damage = self:GetAbility():GetSpecialValueFor( "shrapnel_damage" ) -- special value
	self.aura_stick = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value

	self.start = false

	if IsServer() then
		self.direction = (self:GetParent():GetOrigin()-self:GetCaster():GetOrigin()):Normalized()

		-- Start interval
		self:StartIntervalThink( self.delay )

		-- effects
		self.sound_cast = "Hero_Sniper.ShrapnelShatter"
		EmitSoundOn( self.sound_cast, self:GetParent() )		
	end
end

function modifier_sniper_shrapnel_lua_thinker:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sniper_shrapnel_lua_thinker:OnIntervalThink()
	if not self.start then
		self.start = true
		self:StartIntervalThink( self.duration )
		AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius, self.duration, false )

		-- effects
		self:PlayEffects()
	else
		self:StopEffects()
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sniper_shrapnel_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:SetParticleControlForward( self.effect_cast, 2, self.direction + Vector(0, 0, 0.1) )
end

function modifier_sniper_shrapnel_lua_thinker:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	StopSoundOn( self.sound_cast, self:GetParent() )
end