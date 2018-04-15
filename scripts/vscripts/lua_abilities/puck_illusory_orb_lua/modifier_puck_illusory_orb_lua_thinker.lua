modifier_puck_illusory_orb_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_puck_illusory_orb_lua_thinker:IsHidden()
	return true
end

function modifier_puck_illusory_orb_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_puck_illusory_orb_lua_thinker:OnCreated( kv )
	if IsServer() then
		-- effects
		local sound_cast = "Hero_Puck.Illusory_Orb"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function modifier_puck_illusory_orb_lua_thinker:OnRefresh( kv )
	
end

function modifier_puck_illusory_orb_lua_thinker:OnDestroy( kv )
	if IsServer() then
		-- effects
		local sound_cast = "Hero_Puck.Illusory_Orb"
		StopSoundOn( sound_cast, self:GetParent() )
		UTIL_Remove( self:GetParent() )
	end
end