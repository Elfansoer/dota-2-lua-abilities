modifier_axe_battle_hunger_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_battle_hunger_lua:IsHidden()
	return false
end

function modifier_axe_battle_hunger_lua:IsDebuff()
	return false
end

function modifier_axe_battle_hunger_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_battle_hunger_lua:OnCreated( kv )
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )

	if IsServer() then
		self:SetStackCount( 1 )	
	end
end

function modifier_axe_battle_hunger_lua:OnRefresh( kv )
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )

	if IsServer() then
		-- increase stack
		self:IncrementStackCount()
	end		
end

function modifier_axe_battle_hunger_lua:OnDestroy( kv )

end

function modifier_axe_battle_hunger_lua:OnStackCountChanged( old )
	if IsServer() then
		if self:GetStackCount()<1 then
			self:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_battle_hunger_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_axe_battle_hunger_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus * self:GetStackCount()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_axe_battle_hunger_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_axe_battle_hunger_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_axe_battle_hunger_lua:PlayEffects()
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
-- end***