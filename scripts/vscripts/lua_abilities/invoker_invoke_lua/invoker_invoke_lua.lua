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
	self.orb_manager = orb_manager

	-- add ability manager
	self.ability_manager = ability_manager
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

--------------------------------------------------------------------------------
-- Orb management
orb_manager.MAX_ORB = 3
orb_manager.modifiers = {}
orb_manager.names = {}
function orb_manager:Add( modifier )
	-- add new orb
	table.insert(self.modifiers,modifier)
	table.insert(self.names,self.modifier_list[modifier:GetName()])

	-- remove last orb
	if #self.modifiers>self.MAX_ORB then
		self.modifiers[1]:Destroy()
		table.remove(self.modifiers,1)
		table.remove(self.names,1)
	end
end

function orb_manager:GetInvokedAbility()
	return self.invoke_list[ self.names[1] .. self.names[2] .. self.names[3] ]
end

--------------------------------------------------------------------------------
-- Ability Management
ability_manager.abilities = {}
ability_manager.ability_slot = {}
ability_manager.MAX_ABILITY = 2

function ability_manager:Invoke( ability_name )
	local ability = self:GetAbilityHandle( ability_name )

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
-- Invoke List
orb_manager.invoke_list = {
	-- ["qqq"] = "invoker_cold_snap_lua",

	-- ["qqw"] = "invoker_ghost_walk_lua",
	-- ["qwq"] = "invoker_ghost_walk_lua",
	-- ["wqq"] = "invoker_ghost_walk_lua",

	-- ["qqe"] = "invoker_ice_wall_lua",
	-- ["qeq"] = "invoker_ice_wall_lua",
	-- ["eqq"] = "invoker_ice_wall_lua",

	-- ["www"] = "invoker_emp_lua",

	-- ["wwq"] = "invoker_tornado_lua",
	-- ["wqw"] = "invoker_tornado_lua",
	-- ["qww"] = "invoker_tornado_lua",

	-- ["wwe"] = "invoker_alacrity_lua",
	-- ["wew"] = "invoker_alacrity_lua",
	-- ["eww"] = "invoker_alacrity_lua",

	-- ["eee"] = "invoker_sun_strike_lua",

	-- ["eeq"] = "invoker_forge_spirit_lua",
	-- ["eqe"] = "invoker_forge_spirit_lua",
	-- ["qee"] = "invoker_forge_spirit_lua",

	-- ["eew"] = "invoker_chaos_meteor_lua",
	-- ["ewe"] = "invoker_chaos_meteor_lua",
	-- ["wee"] = "invoker_chaos_meteor_lua",

	-- ["qwe"] = "invoker_deafening_blast_lua",
	-- ["qew"] = "invoker_deafening_blast_lua",
	-- ["wqe"] = "invoker_deafening_blast_lua",
	-- ["weq"] = "invoker_deafening_blast_lua",
	-- ["eqw"] = "invoker_deafening_blast_lua",
	-- ["ewq"] = "invoker_deafening_blast_lua",


	["qqq"] = "bloodseeker_bloodrage_lua",

	["qqw"] = "bloodseeker_blood_rite_lua",
	["qwq"] = "bloodseeker_blood_rite_lua",
	["wqq"] = "bloodseeker_blood_rite_lua",

	["qqe"] = "shadow_fiend_necromastery_lua",
	["qeq"] = "shadow_fiend_necromastery_lua",
	["eqq"] = "shadow_fiend_necromastery_lua",

	["www"] = "shadow_fiend_presence_of_the_dark_lord_lua",

	["wwq"] = "dazzle_shallow_grave_lua",
	["wqw"] = "dazzle_shallow_grave_lua",
	["qww"] = "dazzle_shallow_grave_lua",

	["wwe"] = "dazzle_shadow_wave_lua",
	["wew"] = "dazzle_shadow_wave_lua",
	["eww"] = "dazzle_shadow_wave_lua",

	["eee"] = "dazzle_weave_lua",

	["eeq"] = "earthshaker_fissure_lua",
	["eqe"] = "earthshaker_fissure_lua",
	["qee"] = "earthshaker_fissure_lua",

	["eew"] = "earthshaker_enchant_totem_lua",
	["ewe"] = "earthshaker_enchant_totem_lua",
	["wee"] = "earthshaker_enchant_totem_lua",

	["qwe"] = "lion_finger_of_death_lua",
	["qew"] = "lion_finger_of_death_lua",
	["wqe"] = "lion_finger_of_death_lua",
	["weq"] = "lion_finger_of_death_lua",
	["eqw"] = "lion_finger_of_death_lua",
	["ewq"] = "lion_finger_of_death_lua",
}

orb_manager.modifier_list = {
	["q"] = "modifier_invoker_quas_lua",
	["w"] = "modifier_invoker_wex_lua",
	["e"] = "modifier_invoker_exort_lua",

	["modifier_invoker_quas_lua"] = "q",
	["modifier_invoker_wex_lua"] = "w",
	["modifier_invoker_exort_lua"] = "e",
}
