modifier_earth_spirit_magnetize_lua_expire = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_magnetize_lua_expire:IsHidden()
	return true
end

function modifier_earth_spirit_magnetize_lua_expire:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_magnetize_lua_expire:OnCreated( kv )

end

function modifier_earth_spirit_magnetize_lua_expire:OnRefresh( kv )
	
end

function modifier_earth_spirit_magnetize_lua_expire:OnRemoved( kv )
	if IsServer() then
		-- remove remnant modifier
		local modifier = self:GetParent():FindModifierByName( "modifier_earth_spirit_stone_remnant_lua" )
		if modifier then
			modifier:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_earth_spirit_magnetize_lua_expire:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_earth_spirit_magnetize_lua_expire:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_earth_spirit_magnetize_lua_expire:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_earth_spirit_magnetize_lua_expire:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end