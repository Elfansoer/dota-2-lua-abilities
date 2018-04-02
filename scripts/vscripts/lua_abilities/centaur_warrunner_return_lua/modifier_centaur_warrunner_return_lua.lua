modifier_centaur_warrunner_return_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_centaur_warrunner_return_lua:IsHidden()
	return true
end

function modifier_centaur_warrunner_return_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_centaur_warrunner_return_lua:OnCreated( kv )
	-- references
	self.base_damage = self:GetAbility():GetSpecialValueFor( "return_damage" ) -- special value
	self.strength_pct = self:GetAbility():GetSpecialValueFor( "strength_pct" ) -- special value
end

function modifier_centaur_warrunner_return_lua:OnRefresh( kv )
	-- references
	self.base_damage = self:GetAbility():GetSpecialValueFor( "return_damage" ) -- special value
	self.strength_pct = self:GetAbility():GetSpecialValueFor( "strength_pct" ) -- special value
end

function modifier_centaur_warrunner_return_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_centaur_warrunner_return_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end
function modifier_centaur_warrunner_return_lua:OnAttacked( params )
	if IsServer() then
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return
		end
		if params.unit~=self:GetParent() or self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then
			return
		end

		-- get damage
		local damage = self.base_damage + self:GetParent():GetStrength()*self.strength_pct

		-- Apply Damage
		local damageTable = {
			victim = params.attacker,
			attacker = self:GetParent(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
			ability = self:GetAbility(), --Optional.
		}
		ApplyDamage(damageTable)

		-- Play effects
	end
end

-- Helper: Flag operations
function modifier_centaur_warrunner_return_lua:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_centaur_warrunner_return_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_centaur_warrunner_return_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end