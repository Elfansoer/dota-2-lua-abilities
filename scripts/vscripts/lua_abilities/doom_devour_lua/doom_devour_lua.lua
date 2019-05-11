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
doom_devour_lua = class({})
doom_devour_lua_slot1 = class({})
doom_devour_lua_slot2 = class({})

LinkLuaModifier( "modifier_doom_devour_lua", "lua_abilities/doom_devour_lua/modifier_doom_devour_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Cast Filter
function doom_devour_lua:CastFilterResultTarget( hTarget )
	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Start
function doom_devour_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor( "devour_time" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_doom_devour_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- check if target has abilities
	local avaiable = false
	for i=0,5 do -- for generality, should check to 23
		if target:GetAbilityByIndex( i ) then
			avaiable = true
			break
		end
	end

	-- absorb abilities if autocast is on and target has abilities
	if self:GetAutoCastState() and avaiable and (not self:IsStolen()) then
		-- obtain target's skills per slot available
		for i,_ in pairs(self.ability_manager.default_ability_list) do
			-- get ability (could be nil)
			local ability = target:GetAbilityByIndex( i-1 ) -- zero-based

			-- add ability using ability manager
			self.ability_manager:SetAbility( ability, i )
		end
	end


	-- Play effects and no draw
	self:PlayEffects( target )
	target:SetOrigin( target:GetOrigin() + Vector( 0, 0, -200 ) )

	-- kill target
	target:Kill( self, caster )
end

--------------------------------------------------------------------------------
-- Ability Events
function doom_devour_lua:OnUpgrade()
	-- first time upgrade
	if self:GetLevel()==1 then
		-- turn on autocast by default
		if not self:GetAutoCastState() then
			self:ToggleAutoCast()
		end

	end

	-- init ability manager (no need if it's stolen)
	if (not self.ability_manager) and not (self:IsStolen()) then
		self.ability_manager = ability_manager:CreateInstance()
		self.ability_manager:Init( self )
	end
end

--------------------------------------------------------------------------------
function doom_devour_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_bringer_devour.vpcf"
	local sound_cast = "Hero_DoomBringer.Devour"
	local sound_target = "Hero_DoomBringer.DevourCast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end

--------------------------------------------------------------------------------
-- Helper class
ability_manager = {}

-- just in case if modified to allow devouring more than 2 abilities, use this for default list
ability_manager.default_ability_list = {
	[1] = "doom_devour_lua_slot1",
	[2] = "doom_devour_lua_slot2",
	-- [3] = "doom_devour_lua_slot3",
}

ability_manager.current_abilities = {}
ability_manager.default_abilities = {}
ability_manager.default_index = {}

function ability_manager:CreateInstance()
	local ret = {}

	-- initialize fields
	ret.abilities = {}
	ret.ability_slot = {}
	ret.MAX_ABILITY = 2

	-- initialize methods and constants
	for k,v in pairs(self) do
		ret[k] = v
	end
	return ret
end

-- init ability manager
function ability_manager:Init( ability )
	-- store this ability (devour)
	self.ability = ability

	for k,v in pairs(self.default_ability_list) do
		-- get handles
		self.default_abilities[k] = ability:GetCaster():FindAbilityByName( v )
		self.current_abilities[k] = self.default_abilities[k]

		-- store ability indices
		self.default_index[k] = self.default_abilities[k]:GetAbilityIndex()
	end
end

-- pass 'ability' as nil to reset to default ability
function ability_manager:SetAbility( ability, slot )
	local caster = self.ability:GetCaster()

	-- if nil, reset instead
	if not ability then
		self:ResetAbility( slot )
		return
	end

	-- check if ability already exist
	local existing = nil
	for _,current in pairs(self.current_abilities) do
		if current:GetAbilityName()==ability:GetAbilityName() then
			existing = current
			break
		end
	end
	
	-- same ability already exist, only minor process
	if existing then
		-- if within the same position, just return
		if existing:GetAbilityIndex()==self.default_index[slot] then
			return
		end

		-- if it is on different slot, swap with current one
		caster:SwapAbilities( 
			existing:GetAbilityName(),
			self.current_abilities[slot]:GetAbilityName(),
			true,
			true
		)
		return
	end

	-- duplicate new ability
	ability_new = caster:AddAbility( ability:GetAbilityName() )
	ability_new:SetLevel( ability:GetLevel() )
	ability_new:SetStolen( true )

	-- swap abilities
	caster:SwapAbilities( 
		ability_new:GetAbilityName(),
		self.current_abilities[slot]:GetAbilityName(),
		true,
		false
	)

	-- remove old ability if it is not default abilities
	if self.current_abilities[slot]~=self.default_abilities[slot] then
		caster:RemoveAbility( self.current_abilities[slot]:GetAbilityName() )
	end

	-- register new ability
	self.current_abilities[slot] = ability_new
end

function ability_manager:ResetAbility( slot )
	local caster = self.ability:GetCaster()

	-- check if already reset
	if self.current_abilities[slot]==self.default_abilities[slot] then return end

	-- swap abilities
	caster:SwapAbilities( 
		self.default_abilities[slot]:GetAbilityName(),
		self.current_abilities[slot]:GetAbilityName(),
		true,
		false
	)

	-- remove old ability
	caster:RemoveAbility( self.current_abilities[slot]:GetAbilityName() )

	-- register default as new ability	
	self.current_abilities[slot] = self.default_abilities[slot]
end