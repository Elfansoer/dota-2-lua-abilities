modifier_earthshaker_fissure_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earthshaker_fissure_lua_thinker:IsHidden()
	return true
end

function modifier_earthshaker_fissure_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earthshaker_fissure_lua_thinker:OnCreated( kv )
	
end

function modifier_earthshaker_fissure_lua_thinker:OnRefresh( kv )
	
end

function modifier_earthshaker_fissure_lua_thinker:OnDestroy( kv )
	if IsServer() then
		-- Effects
		local sound_cast = "Hero_EarthShaker.FissureDestroy"
		EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
		UTIL_Remove(self:GetParent())
	end
end