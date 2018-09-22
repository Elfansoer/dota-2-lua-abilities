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
	self.lifeshare_exception = "sandra_sacrifice"
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
		if params.unit~=self:GetCaster()  then
			return
		end

		if params.inflictor==self:GetAbility() then
			return
		end

		if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then
			if (not params.inflictor) or params.inflictor:GetAbilityName()~=self.lifeshare_exception then 
				return
			end
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
			damage = params.original_damage * (self.lifeshare/100),
			damage_type = params.damage_type,
			ability = self:GetAbility(), --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_REFLECTION, --Optional.
		}
		ApplyDamage(damageTable)

		-- effects
		self:PlayEffects()
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

function modifier_sandra_undeniable_torture_debuff:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_sandra/sandra_undeniable_torture.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 3, Vector(0,255,0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end