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
modifier_viper_nethertoxin_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_viper_nethertoxin_lua:IsHidden()
	return false
end

function modifier_viper_nethertoxin_lua:IsDebuff()
	return true
end

function modifier_viper_nethertoxin_lua:IsStunDebuff()
	return false
end

function modifier_viper_nethertoxin_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_viper_nethertoxin_lua:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "magic_resistance" )

	self.owner = kv.isProvidedByAura~=1

	if not IsServer() then return end

	if not self.owner then
		-- precache damage
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}
		-- ApplyDamage(damageTable)

		-- Start interval
		self:StartIntervalThink( 1 )
	else
		self:PlayEffects()
	end

end

function modifier_viper_nethertoxin_lua:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.magic_resist = self:GetAbility():GetSpecialValueFor( "magic_resistance" )
end

function modifier_viper_nethertoxin_lua:OnRemoved()
end

function modifier_viper_nethertoxin_lua:OnDestroy()
	if not IsServer() then return end
	if not self.owner then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_viper_nethertoxin_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}

	return funcs
end

function modifier_viper_nethertoxin_lua:GetModifierMagicalResistanceBonus()
	return self.magic_resist
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_viper_nethertoxin_lua:CheckState()
	local state = {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_viper_nethertoxin_lua:OnIntervalThink()
	-- Apply damage
	ApplyDamage( self.damageTable )

	-- Play effects
	local sound_cast = "Hero_Viper.NetherToxin.Damage"
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_viper_nethertoxin_lua:IsAura()
	return self.owner
end

function modifier_viper_nethertoxin_lua:GetModifierAura()
	return "modifier_viper_nethertoxin_lua"
end

function modifier_viper_nethertoxin_lua:GetAuraRadius()
	return self.radius
end

function modifier_viper_nethertoxin_lua:GetAuraDuration()
	return 0.5
end

function modifier_viper_nethertoxin_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_viper_nethertoxin_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_viper_nethertoxin_lua:GetEffectName()
	if not self.owner then
		return "particles/units/heroes/hero_viper/viper_nethertoxin_debuff.vpcf"
	end
end

function modifier_viper_nethertoxin_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_viper_nethertoxin_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf"
	local sound_cast = "Hero_Viper.NetherToxin"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end