modifier_invoker_alacrity_lua = class({})
local intPack = require("util/intPack")
--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_alacrity_lua:IsHidden()
	return false
end

function modifier_invoker_alacrity_lua:IsDebuff()
	return false
end

function modifier_invoker_alacrity_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_alacrity_lua:OnCreated( kv )
	if IsServer() then
		-- get references
		self.damage = self:GetAbility():GetOrbSpecialValueFor( "bonus_damage", "e" )
		self.as_bonus = self:GetAbility():GetOrbSpecialValueFor( "bonus_attack_speed", "w" )

		-- send to client
		local pack = { self.damage, self.as_bonus }
		self:SetStackCount( intPack.Pack( pack, 120 ) )

		-- Effects
		self:PlayEffects()
	else
		-- get data from server
		local unPack = intPack.Unpack( self:GetStackCount(), 2, 120 )
		self.damage = unPack[1]
		self.as_bonus = unPack[2]
		self:SetStackCount(0)
	end
end

function modifier_invoker_alacrity_lua:OnRefresh( kv )
	if IsServer() then
		-- get references
		self.damage = self:GetAbility():GetOrbSpecialValueFor( "bonus_damage", "e" )
		self.as_bonus = self:GetAbility():GetOrbSpecialValueFor( "bonus_attack_speed", "w" )

		-- send to client
		local pack = { self.damage, self.as_bonus }
		self:SetStackCount( intPack.Pack( pack, 120 ) )

		-- Effects
		self:PlayEffects()
	else
		-- get data from server
		local unPack = intPack.Unpack( self:GetStackCount(), 2, 120 )
		self.damage = unPack[1]
		self.as_bonus = unPack[2]
		self:SetStackCount(0)
	end
end

function modifier_invoker_alacrity_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_alacrity_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function modifier_invoker_alacrity_lua:GetModifierPreAttack_BonusDamage()
	return self.damage
end
function modifier_invoker_alacrity_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_invoker_alacrity_lua:GetEffectName()
	return "particles/units/heroes/hero_invoker/invoker_alacrity_buff.vpcf"
end

function modifier_invoker_alacrity_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
function modifier_invoker_alacrity_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_invoker/invoker_alacrity.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)

	-- Emit Sounds
	local sound_cast = "Hero_Invoker.Alacrity"
	EmitSoundOn( sound_cast, self:GetParent() )
end