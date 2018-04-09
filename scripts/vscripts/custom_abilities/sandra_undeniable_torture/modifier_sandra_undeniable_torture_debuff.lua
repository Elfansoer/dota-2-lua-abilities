modifier_sandra_undeniable_torture_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_undeniable_torture_debuff:IsHidden()
	return false
end

function modifier_sandra_undeniable_torture_debuff:IsDebuff()
	return true
end

function modifier_sandra_undeniable_torture_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_undeniable_torture_debuff:OnCreated( kv )
	-- references
	self.lifeshare = self:GetAbility():GetSpecialValueFor( "lifeshare" ) -- special value
end

function modifier_sandra_undeniable_torture_debuff:OnRefresh( kv )
	-- references
	self.lifeshare = self:GetAbility():GetSpecialValueFor( "lifeshare" ) -- special value
end

function modifier_sandra_undeniable_torture_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_undeniable_torture_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end
function modifier_sandra_undeniable_torture_debuff:OnTakeDamage( params )
	if IsServer() then
		if params.unit~=self:GetCaster() or self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then
			return
		end

		-- set attacker
		local source = self:GetCaster()
		if params.attacker:GetTeamNumber()==self:GetCaster():GetTeamNumber() then
			source = params.attacker
		end

		-- reflect damage
		local damageTable = {
			victim = self:GetParent(),
			attacker = source,
			damage = params.damage,
			damage_type = params.damage_type,
			ability = self, --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION, --Optional.
		}
		ApplyDamage(damageTable)
	end
end

--------------------------------------------------------------------------------
-- Helper: Flag operations
function modifier_sandra_undeniable_torture_debuff:FlagExist(a,b)--Bitwise Exist
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
function modifier_sandra_undeniable_torture_debuff:GetEffectName()
	return "particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon.vpcf"
end

function modifier_sandra_undeniable_torture_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end