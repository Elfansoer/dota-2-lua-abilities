modifier_earth_spirit_stone_remnant_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_stone_remnant_lua_effect:IsHidden()
	return true
end

function modifier_earth_spirit_stone_remnant_lua_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_stone_remnant_lua_effect:OnCreated( kv )
	if IsServer() then
		-- play effects
		self:PlayEffects()
	end
end

function modifier_earth_spirit_stone_remnant_lua_effect:OnDestroy( kv )
	if IsServer() then
		-- play effects
		local sound_cast = "Hero_EarthSpirit.StoneRemnant.Destroy"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_earth_spirit_stone_remnant_lua_effect:PlayEffects()
	-- Get Resources
	-- local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_stoneremnant.vpcf"
	local particle_cast = "particles/econ/items/earth_spirit/earth_spirit_vanquishingdemons_summons/espirit_stoneremnant_vanquishingdemons.vpcf"
	local sound_cast = "Hero_EarthSpirit.StoneRemnant.Impact"

	-- Get Data
	local caster_origin = self:GetCaster():GetOrigin()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end