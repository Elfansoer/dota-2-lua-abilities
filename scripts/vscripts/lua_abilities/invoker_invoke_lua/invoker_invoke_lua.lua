invoker_invoke_lua = class({})
orb_manager = {}
ability_manager = {}

--------------------------------------------------------------------------------
-- Ability Start
function invoker_invoke_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- get invoked ability name
	local ability_name = self.orb_manager:GetInvokedAbility()

	-- invoke
	self.ability_manager:Invoke( ability_name )
end

--------------------------------------------------------------------------------
-- Hero Events
-- Initializations (OnOwnerSpawned does not work)
function invoker_invoke_lua:OnUpgrade()
	-- add orb manager
	self.orb_manager = orb_manager:init()

	-- add ability manager
	self.ability_manager = ability_manager:init()
	self.ability_manager.caster = self:GetCaster()
	self.ability_manager.ability = self

	-- add empty ability
	local empty1 = self:GetCaster():FindAbilityByName( "invoker_empty_1_lua" )
	local empty2 = self:GetCaster():FindAbilityByName( "invoker_empty_2_lua" )
	table.insert(self.ability_manager.ability_slot,empty1)
	table.insert(self.ability_manager.ability_slot,empty2)
end

--------------------------------------------------------------------------------
-- Helper functions
function invoker_invoke_lua:AddOrb( modifier )
	self.orb_manager:Add( modifier )
end

function invoker_invoke_lua:UpdateOrb( modifer_name )
	updates = self.orb_manager:UpdateOrb( modifer_name )
	self.ability_manager:UpgradeAbilities()
end

function invoker_invoke_lua:GetOrbLevel( orb_name )
	if not self.orb_manager.status[orb_name] then return 0 end
	return self.orb_manager.status[orb_name].level
end

function invoker_invoke_lua:GetOrbInstances( orb_name )
	if not self.orb_manager.status[orb_name] then return 0 end
	return self.orb_manager.status[orb_name].instances
end

function invoker_invoke_lua:GetOrbs()
	local ret = {}
	for k,v in pairs(self.orb_manager.status) do
		ret[k] = v.level
	end
	return ret
end

--------------------------------------------------------------------------------
-- Orb management
function orb_manager:init()
	local ret = {}

	-- initialize fields
	ret.MAX_ORB = 3
	ret.status = {}
	ret.modifiers = {}
	ret.names = {}

	-- initialize methods and constants
	for k,v in pairs(self) do
		ret[k] = v
	end
	return ret
end

function orb_manager:Add( modifier )
	-- register new orb type if not exist
	local orb_name = self.modifier_list[modifier:GetName()]
	if not self.status[orb_name] then
		self.status[orb_name] = {
			["instances"] = 0,
			["level"] = modifier:GetAbility():GetLevel(),
		}
	end

	-- add new orb instance
	table.insert(self.modifiers,modifier)
	table.insert(self.names,orb_name)
	self.status[orb_name].instances = self.status[orb_name].instances + 1

	-- remove last orb
	if #self.modifiers>self.MAX_ORB then
		self.status[self.names[1]].instances = self.status[self.names[1]].instances - 1
		self.modifiers[1]:Destroy()

		table.remove(self.modifiers,1)
		table.remove(self.names,1)
	end
end

function orb_manager:GetInvokedAbility()
	-- check instances
	local key = ""
	for i=1,string.len(self.orb_order) do
		k = string.sub(self.orb_order,i,i)

		if self.status[k] then 
			for i=1,self.status[k].instances do
				key = key .. k
			end
		end
	end
	return self.invoke_list[key]

	-- if allows permutation
	-- return self.invoke_list[ self.names[1] .. self.names[2] .. self.names[3] ]
end

function orb_manager:UpdateOrb( modifer_name )
	-- refresh orb instances
	for _,modifier in pairs(self.modifiers) do
		if modifier:GetName()==modifer_name then
			modifier:ForceRefresh()
		end
	end

	-- update its level
	local orb_name = self.modifier_list[modifer_name]
	self.status[orb_name].level = self.status[orb_name].level + 1
end

--------------------------------------------------------------------------------
-- Ability Management
function ability_manager:init()
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

function ability_manager:Invoke( ability_name )
	if not ability_name then return end

	local ability = self:GetAbilityHandle( ability_name )
	ability.orbs = self.ability:GetOrbs()

	-- nothing to invoke
	if self.ability_slot[1] and self.ability_slot[1]==ability then
		self.ability:RefundManaCost()
		self.ability:EndCooldown()
		return
	end

	-- swap already existing
	local exist = 0
	for i=1,#self.ability_slot do
		if self.ability_slot[i]==ability then
			exist = i
		end
	end
	if exist>0 then
		self:InvokeExist( exist )
		self.ability:RefundManaCost()
		self.ability:EndCooldown()
		return
	end

	-- summon new ability
	self:InvokeNew( ability )
end

function ability_manager:InvokeExist( slot )
	for i=slot,2,-1 do
		-- swap abilities
		self.caster:SwapAbilities( 
			self.ability_slot[slot-1]:GetAbilityName(),
			self.ability_slot[slot]:GetAbilityName(),
			true,
			true
		)

		-- sync slot
		self.ability_slot[slot], self.ability_slot[slot-1] = self.ability_slot[slot-1], self.ability_slot[slot]
	end
end

function ability_manager:InvokeNew( ability )
	if #self.ability_slot<self.MAX_ABILITY then
		-- add ability at tail
		table.insert(self.ability_slot,ability)
	else
		-- swap the last ability with the summoned
		self.caster:SwapAbilities( 
			ability:GetAbilityName(),
			self.ability_slot[#self.ability_slot]:GetAbilityName(),
			true,
			false
		)

		-- sync slot
		self.ability_slot[#self.ability_slot] = ability
	end

	-- move to the front
	self:InvokeExist( #self.ability_slot )
end

function ability_manager:GetAbilityHandle( ability_name )
	-- get ability handle
	local ability = self.abilities[ability_name]

	-- if handle not exist, get one existing
	if not ability then
		ability = self.caster:FindAbilityByName( ability_name )
		self.abilities[ability_name] = ability
	end

	-- if not exist, create one
	if not ability then
		ability = self.caster:AddAbility( ability_name )
		self.abilities[ability_name] = ability
		ability:SetLevel(1)
	end

	return ability
end

function ability_manager:UpgradeAbilities()
	for _,ability in pairs(self.abilities) do
		ability.orbs = self.ability:GetOrbs()
	end
end

--------------------------------------------------------------------------------
-- Effects
function invoker_invoke_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end

--------------------------------------------------------------------------------
-- Invoke List and Constants
orb_manager.invoke_list = {
	["qqq"] = "invoker_cold_snap_lua",
	["qqw"] = "bloodseeker_blood_rite_lua",
	["qqe"] = "shadow_fiend_necromastery_lua",
	["www"] = "shadow_fiend_presence_of_the_dark_lord_lua",
	["qww"] = "dazzle_shallow_grave_lua",
	["wwe"] = "dazzle_shadow_wave_lua",
	["eee"] = "dazzle_weave_lua",
	["qee"] = "earthshaker_fissure_lua",
	["wee"] = "earthshaker_enchant_totem_lua",
	["qwe"] = "lion_finger_of_death_lua",
}
orb_manager.orb_order = "qwe"
orb_manager.modifier_list = {
	["q"] = "modifier_invoker_quas_lua",
	["w"] = "modifier_invoker_wex_lua",
	["e"] = "modifier_invoker_exort_lua",

	["modifier_invoker_quas_lua"] = "q",
	["modifier_invoker_wex_lua"] = "w",
	["modifier_invoker_exort_lua"] = "e",
}
