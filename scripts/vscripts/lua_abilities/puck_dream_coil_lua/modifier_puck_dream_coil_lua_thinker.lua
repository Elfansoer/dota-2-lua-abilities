modifier_puck_dream_coil_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_puck_dream_coil_lua_thinker:IsHidden()
	return false
end

function modifier_puck_dream_coil_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_puck_dream_coil_lua_thinker:OnCreated( kv )
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_puck_dream_coil_lua_thinker:OnRefresh( kv )
	
end

function modifier_puck_dream_coil_lua_thinker:OnDestroy( kv )
	if IsServer() then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_puck_dream_coil_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_dreamcoil.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
end