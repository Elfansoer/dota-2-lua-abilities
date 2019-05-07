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
fairy_queen_royal_decree = class({})
-- LinkLuaModifier( "modifier_fairy_queen_royal_decree", "custom_abilities/fairy_queen_royal_decree/modifier_fairy_queen_royal_decree", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- Manacost
function fairy_queen_royal_decree:GetManaCost( level )
	local manacost_pct = self:GetSpecialValueFor( "manacost_pct" )
	local fairy_pct = self:GetSpecialValueFor( "refund_pct" )
	
	local fairies = self:GetFairies()
	local cost = manacost_pct/100 * self:GetCaster():GetMaxMana() * (100-fairy_pct*fairies)/100

	return cost
end

-- Cooldown
function fairy_queen_royal_decree:GetCooldown( level )
	local cooldown = self.BaseClass.GetCooldown( self, level )
	local fairy_pct = self:GetSpecialValueFor( "refund_pct" )
	
	local fairies = self:GetFairies()
	local cost = cooldown * (100-fairy_pct*fairies)/100

	return cost
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function fairy_queen_royal_decree:CastFilterResult()
	local max_fairies = self:GetSpecialValueFor( "max_fairies" )
	if self:GetFairies() == max_fairies then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function fairy_queen_royal_decree:GetCustomCastError()
	local max_fairies = self:GetSpecialValueFor( "max_fairies" )
	if self:GetFairies() == max_fairies then
		return "#dota_hud_error_full_fairies"
	end

	return ""
end

function fairy_queen_royal_decree:GetFairies()
	if self:GetCaster():HasModifier( "modifier_fairy_queen_fairies" ) then
		local fairies = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies", self:GetCaster() )
		return fairies
	end
	return 0
end

--------------------------------------------------------------------------------
-- Ability Start
function fairy_queen_royal_decree:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- find modifier
	local modifier = caster:FindModifierByNameAndCaster( "modifier_fairy_queen_fairies", caster )

	-- refresh
	if modifier then
		modifier:Refresh()
	end

	-- effects
	self:PlayEffects()
end

--------------------------------------------------------------------------------
function fairy_queen_royal_decree:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot_cast.vpcf"
	local sound_cast = "Hero_SkywrathMage.ConcussiveShot.Target"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() + Vector(0,0,100) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end