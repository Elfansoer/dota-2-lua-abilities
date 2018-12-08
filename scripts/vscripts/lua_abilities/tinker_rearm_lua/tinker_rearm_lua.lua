tinker_rearm_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function tinker_rearm_lua:OnSpellStart()
	-- effects
	local sound_cast = "Hero_Tinker.Rearm"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Ability Channeling
function tinker_rearm_lua:OnChannelFinish( bInterrupted )
	local caster = self:GetCaster()

	-- stop effects
	local sound_cast = "Hero_Tinker.Rearm"
	StopSoundOn( sound_cast, self:GetCaster() )

	if bInterrupted then return end

	-- find all refreshable abilities
	for i=0,caster:GetAbilityCount()-1 do
		local ability = caster:GetAbilityByIndex( i )
		if ability and ability:GetAbilityType()~=DOTA_ABILITY_TYPE_ATTRIBUTES then
			ability:RefreshCharges()
			ability:EndCooldown()
		end
	end

	-- find all refreshable items
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item then
			local pass = false
			if item:GetPurchaser()==caster and not self:IsItemException( item ) then
				pass = true
			end

			if pass then
				item:EndCooldown()
			end
		end
	end

	-- effects
	self:PlayEffects()
end

--------------------------------------------------------------------------------
-- Helper
function tinker_rearm_lua:IsItemException( item )
	return self.ItemException[item:GetName()]
end
tinker_rearm_lua.ItemException = {
	["item_aeon_disk"] = true,
	["item_arcane_boots"] = true,
	["item_black_king_bar"] = true,
	["item_hand_of_midas"] = true,
	["item_helm_of_the_dominator"] = true,
	["item_meteor_hammer"] = true,
	["item_necronomicon"] = true,
	["item_necronomicon_2"] = true,
	["item_necronomicon_3"] = true,
	["item_refresher"] = true,
	["item_refresher_shard"] = true,
	["item_pipe"] = true,
	["item_sphere"] = true,
}

--------------------------------------------------------------------------------
-- Effects
function tinker_rearm_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_rearm.vpcf"
	local sound_cast = "Hero_Tinker.RearmStart"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end