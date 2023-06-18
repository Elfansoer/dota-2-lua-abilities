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
modifier_megumin_explosion = class({})

local modifier_colors = {
	["modifier_megumin_crimson_core"] = Vector( 255,0,0 ),
	["modifier_megumin_emerald_core"] = Vector( 0,255,0 ),
	["modifier_megumin_azure_core"] = Vector( 0,0,255 ),
	["modifier_megumin_golden_core"] = Vector( 255,215,0 ),
}

local ring_shapes = { 6/7, 4/5, 2/3, 1/2 }

--------------------------------------------------------------------------------
-- Classifications
function modifier_megumin_explosion:IsHidden()
	return true
end

function modifier_megumin_explosion:IsDebuff()
	return false
end

function modifier_megumin_explosion:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_megumin_explosion:OnCreated( kv )
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then return end

	self.cores = {}
	self.current_slot = 0
	self.prev_max_slot = self.ability:GetSpecialValueFor( "yellow_max_cores" )

	self.effects = {}
end

function modifier_megumin_explosion:OnRefresh( kv )
end

function modifier_megumin_explosion:Update( core_modifier )
	local max_slot = self.ability:GetSpecialValueFor( "yellow_max_cores" )

	-- check max slot changes
	if max_slot>self.prev_max_slot then
		-- add scepter
		local new_cores = {}
		for i=0,self.prev_max_slot-1 do
			new_cores[i] = self.cores[self.current_slot]
			self.current_slot = (self.current_slot + 1) % self.prev_max_slot
		end

		self.current_slot = max_slot - 1
		self.cores = new_cores
		self.prev_max_slot = max_slot

	elseif max_slot<self.prev_max_slot then
		-- remove scepter
		local new_cores = {}
		local diff = self.prev_max_slot - max_slot
		self.current_slot = (self.current_slot + diff) % max_slot

		for i=1,diff do
			if self.cores[self.current_slot] then
				self.cores[self.current_slot]:Destroy()
			end
			self.current_slot = (self.current_slot + 1) % self.prev_max_slot
		end

		for i=0,max_slot-1 do
			new_cores[i] = self.cores[self.current_slot]
			self.current_slot = (self.current_slot + 1) % self.prev_max_slot
		end

		self.current_slot = max_slot - 1
		self.cores = new_cores
		self.prev_max_slot = max_slot
	end

	-- destroy old one
	if self.cores[self.current_slot] then
		self.cores[self.current_slot]:Destroy()
	end

	-- add new one
	self.cores[self.current_slot] = core_modifier

	self.current_slot = (self.current_slot + 1) % max_slot

	for i=0,max_slot-1 do
		local modifier = self.cores[i]
		if modifier then
			modifier:Update()
		end
		self:SetRing( i, modifier )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_megumin_explosion:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}

	return funcs
end

function modifier_megumin_explosion:GetModifierOverrideAbilitySpecial( params )
	if params.ability~=self.ability then return 0 end
	local specialname = params.ability_special_value

	if specialname == "red_damage_tooltip" then
		return 1
	elseif specialname == "green_stun_tooltip" then
		return 1
	end

	return 0
end

function modifier_megumin_explosion:GetModifierOverrideAbilitySpecialValue( params )
	local specialname = params.ability_special_value

	local manacost_damage = params.ability:GetSpecialValueFor( "red_damage_pct" )
	local damage = self.ability:GetManaCost(-1) * manacost_damage/100

	if specialname == "red_damage_tooltip" then
		return damage

	elseif specialname == "green_stun_tooltip" then
		local stun_base = params.ability:GetSpecialValueFor( "green_stun_base" )
		local stun_pct = params.ability:GetSpecialValueFor( "green_stun_pct" )
		local damage_stun = params.ability:GetSpecialValueFor( "green_damage_stun" )

		return stun_base + (stun_pct/100 * damage) / damage_stun
	end
	
	return 0
end

function modifier_megumin_explosion:SetRing( index, modifier )
	if not self.effects[index] then
		self.effects[index] = self:InitRing( index )
	end

	local color = Vector(0,0,0)
	if modifier then
		color = modifier_colors[ modifier:GetName() ]
	end

	ParticleManager:SetParticleControl( self.effects[index], 60, color )
end

function modifier_megumin_explosion:InitRing( index )
	local particle_cast = "particles/units/heroes/hero_megumin/epitrochoid.vpcf"
	local base_color = Vector(0,0,0)
	local base_radius = 150 - index * 20
	local base_ring_size = 7
	local base_shape = ring_shapes[ index+1 ] * 1000 + RandomInt( 0, 4 ) - 2
	local base_height = 20

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( base_shape, 0, base_height * index ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( base_radius, 0, base_ring_size ) )
	ParticleManager:SetParticleControl( effect_cast, 60, base_color )
	ParticleManager:SetParticleControl( effect_cast, 61, Vector( 1, 0, 0 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	return effect_cast
end

function modifier_megumin_explosion:SetRingColor( ring, color )
	ParticleManager:SetParticleControl( self.effects[ring], 60, color )
	print("setringcolor",ring,color)
end
