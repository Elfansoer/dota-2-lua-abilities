modifier_lion_finger_of_death_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lion_finger_of_death_lua:IsHidden()
	return true
end

function modifier_lion_finger_of_death_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_lion_finger_of_death_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lion_finger_of_death_lua:OnCreated( kv )
	-- references
	if self:GetCaster():HasScepter() then
		self.damage = self:GetAbility():GetSpecialValueFor( "damage_scepter" ) -- special value
	else
		self.damage = self:GetAbility():GetSpecialValueFor( "damage" ) -- special value
	end
end

function modifier_lion_finger_of_death_lua:OnDestroy( kv )
	if IsServer() then
		-- check if it's still valid target
		if not self:GetParent():IsAlive() then return end
		local nResult = UnitFilter(
			self:GetParent(),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
			0,
			self:GetCaster():GetTeamNumber()
		)
		if nResult ~= UF_SUCCESS then
			return
		end

		-- damage
		local damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}
		ApplyDamage(damageTable)
	end
end