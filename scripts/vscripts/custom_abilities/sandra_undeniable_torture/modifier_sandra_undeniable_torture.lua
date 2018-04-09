modifier_sandra_undeniable_torture = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_undeniable_torture:IsHidden()
	return true
end

function modifier_sandra_undeniable_torture:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_undeniable_torture:OnCreated( kv )
	-- references
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal" ) -- special value
end

function modifier_sandra_undeniable_torture:OnRefresh( kv )
	-- references
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal" ) -- special value
end

function modifier_sandra_undeniable_torture:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_undeniable_torture:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
	}

	return funcs
end

function modifier_sandra_undeniable_torture:GetModifierTotal_ConstantBlock( params )
	if IsServer() then
		if params.attacker==self:GetParent() or params.attacker:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
			return 0
		end

		local damage = params.damage
		local block = 0

		-- check lethality
		if params.damage>self:GetParent():GetHealth() then
			damage = self:GetParent():GetHealth()
			block = params.damage-self:GetParent():GetHealth()+1
		end

		params.attacker:Heal( damage, self:GetAbility() )
		self:PlayEffects( params.attacker )

		return block
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sandra_undeniable_torture:CheckState()
	local state = {
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sandra_undeniable_torture:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end