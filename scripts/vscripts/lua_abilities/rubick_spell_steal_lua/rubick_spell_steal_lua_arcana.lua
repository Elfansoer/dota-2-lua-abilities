--[[ Use this to import:
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_WORLDORIGIN, caster )
]]
local reference = require("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana_effect_reference")
-- logic
local self, particle_name, iAttach, hUnit, iTeam = ...
if self.GetAbility then
	self = self:GetAbility()
end

-- check if stolen
local spell_steal = self:GetCaster():FindAbilityByName("rubick_spell_steal_lua")
local stolen = (self:IsStolen() and spell_steal)

-- check if available alternate (if nothing then the reference didn't changed)
local particle_alternate = reference[particle_name] or particle_name

-- not stolen
if (not stolen) then
	return ParticleManager:CreateParticle( particle_name, iAttach, hUnit )
end

-- otherwise
local effect_cast = nil
if iTeam then
	effect_cast = ParticleManager:CreateParticleForTeam( particle_alternate, iAttach, hUnit, iTeam )
else
	effect_cast = ParticleManager:CreateParticle( particle_alternate, iAttach, hUnit )
end

-- set color based on level
local color = Vector(0,0,0)
local level = spell_steal:GetLevel()
	if (level==1) then color.x = 255 
elseif (level==2) then color.y = 255
elseif (level==3) then color.z = 255
end

ParticleManager:SetParticleControl( effect_cast, 60, color )
ParticleManager:SetParticleControl( effect_cast, 61, Vector( 1, 0, 0 ) )

return effect_cast