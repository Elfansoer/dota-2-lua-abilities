modifier_earth_spirit_magnetize_lua_expire = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_magnetize_lua_expire:IsHidden()
	return true
end

function modifier_earth_spirit_magnetize_lua_expire:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_magnetize_lua_expire:OnCreated( kv )
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_earth_spirit_magnetize_lua_expire:OnRefresh( kv )
	
end

function modifier_earth_spirit_magnetize_lua_expire:OnRemoved( kv )
	if IsServer() then
		-- remove remnant modifier
		local modifier = self:GetParent():FindModifierByName( "modifier_earth_spirit_stone_remnant_lua" )
		if modifier then
			modifier:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_earth_spirit_magnetize_lua_expire:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_earth_spirit_magnetize_lua_expire:GetEffectName()
-- 	return "particles/units/heroes/hero_earth_spirit/espirit_stoneismagnetized_xpld.vpcf"
-- end

-- function modifier_earth_spirit_magnetize_lua_expire:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_earth_spirit_magnetize_lua_expire:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_stoneismagnetized_xpld.vpcf"

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
end