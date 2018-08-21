modifier_invoker_chaos_meteor_lua_burn = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_chaos_meteor_lua_burn:IsHidden()
	return false
end

function modifier_invoker_chaos_meteor_lua_burn:IsDebuff()
	return true
end

function modifier_invoker_chaos_meteor_lua_burn:IsStunDebuff()
	return false
end

function modifier_invoker_chaos_meteor_lua_burn:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_invoker_chaos_meteor_lua_burn:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_chaos_meteor_lua_burn:OnCreated( kv )
	if IsServer() then
		-- references
		local damage = self:GetAbility():GetOrbSpecialValueFor( "burn_dps", "e" )
		local delay = 1
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		-- Start interval
		self:StartIntervalThink( delay )
	end
end

function modifier_invoker_chaos_meteor_lua_burn:OnRefresh( kv )
	
end

function modifier_invoker_chaos_meteor_lua_burn:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_invoker_chaos_meteor_lua_burn:OnIntervalThink()
	-- damage
	ApplyDamage( self.damageTable )

	-- play effects
	local sound_tick = "Hero_Invoker.ChaosMeteor.Damage"
	EmitSoundOn( sound_tick, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_chaos_meteor_lua_burn:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_chaos_meteor_burn_debuff.vpcf"
end

function modifier_invoker_chaos_meteor_lua_burn:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- function modifier_invoker_chaos_meteor_lua_burn:PlayEffects()
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