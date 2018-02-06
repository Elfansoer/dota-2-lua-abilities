modifier_wraith_king_hellfire_blast_lua_slow = class({})

--------------------------------------------------------------------------------

function modifier_wraith_king_hellfire_blast_lua_slow:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_wraith_king_hellfire_blast_lua_slow:OnCreated( kv )
	self.dot_damage = kv.damage
	self.dot_slow = kv.slow
	self.tick = 0
	self.interval = self:GetRemainingTime()/kv.duration -- in case of status resistance

	self:StartIntervalThink( self.interval )
end

function modifier_wraith_king_hellfire_blast_lua_slow:OnRefresh( kv )
	self.dot_damage = kv.damage
	self.tick = 0
	self.interval = self:GetRemainingTime()/kv.duration

	self:StartIntervalThink( self.interval )
end

function modifier_wraith_king_hellfire_blast_lua_slow:OnDestroy( kv )
	-- make sure last tick must happened
	if self.tick < kv.duration then
		self:OnIntervalThink()
	end
end

--------------------------------------------------------------------------------

function modifier_wraith_king_hellfire_blast_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_wraith_king_hellfire_blast_lua_slow:GetModifierMoveSpeedBonus_Percentage( params )
	return self.dot_slow
end

--------------------------------------------------------------------------------

function modifier_wraith_king_hellfire_blast_lua_slow:OnIntervalThink()
	if IsServer() then
		-- Apply DoT
		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.dot_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility()
		}
		ApplyDamage( damage )
	end

	-- add tick
	self.tick = self.tick + 1
end