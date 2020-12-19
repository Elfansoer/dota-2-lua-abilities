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
modifier_hoodwink_scurry_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hoodwink_scurry_lua:IsHidden()
	return self:GetStackCount()~=0
end

function modifier_hoodwink_scurry_lua:IsDebuff()
	return false
end

function modifier_hoodwink_scurry_lua:IsStunDebuff()
	return false
end

function modifier_hoodwink_scurry_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hoodwink_scurry_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.evasion = self:GetAbility():GetSpecialValueFor( "evasion" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.interval = 0.5

	if not IsServer() then return end

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_hoodwink_scurry_lua:OnRefresh( kv )
	-- references
	self.evasion = self:GetAbility():GetSpecialValueFor( "evasion" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_hoodwink_scurry_lua:OnRemoved()
end

function modifier_hoodwink_scurry_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hoodwink_scurry_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}

	return funcs
end

function modifier_hoodwink_scurry_lua:GetModifierEvasion_Constant()
	if self:GetStackCount()==1 then return 0 end

	return self.evasion
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hoodwink_scurry_lua:OnIntervalThink()
	-- check trees
	local trees = GridNav:GetAllTreesAroundPoint( self.parent:GetOrigin(), self.radius, false )
	local stack = 1
	if #trees>0 then stack = 0 end

	-- stack: 0 is active, 1 is inactive (no tree) 
	if self:GetStackCount()~=stack then
		self:SetStackCount( stack )

		-- set effects
		if stack==0 then
			self:PlayEffects()
		else
			self:StopEffects()
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hoodwink_scurry_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_scurry_passive.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, 0, 0 ) )

	self.effect_cast = effect_cast
end

function modifier_hoodwink_scurry_lua:StopEffects()
	if not self.effect_cast then return end

	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end