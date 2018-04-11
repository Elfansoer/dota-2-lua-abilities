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
		-- MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_AVOID_DAMAGE,
	}

	return funcs
end
function modifier_sandra_undeniable_torture:GetModifierAvoidDamage( params )
	if IsServer() then
		if params.attacker==self:GetParent() or params.attacker:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
			return 0
		end
		if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL ) then
			return 0
		end

		-- heal
		local heal = math.min( self:GetParent():GetHealth(), params.damage )
		params.attacker:Heal( heal, self:GetAbility() )
		self:PlayEffects( params.attacker )

		-- deal damage with non-lethal
		local damageTable = {
			victim = self:GetParent(),
			attacker = params.attacker,
			damage = params.original_damage,
			damage_type = params.damage_type,
			ability = self:GetAbility(), --Optional.
			damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, --Optional.
		}
		ApplyDamage(damageTable)

		-- block the damage
		return 1
	end
end

-- function modifier_sandra_undeniable_torture:GetModifierTotal_ConstantBlock( params )
-- 	if IsServer() then
-- 		if params.attacker==self:GetParent() or params.attacker:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
-- 			return 0
-- 		end

-- 		if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL ) then
-- 			return 0
-- 		end

-- 		local damage = params.damage
-- 		local block = 0

-- 		-- check lethality
-- 		if params.damage>self:GetParent():GetHealth() then
-- 			damage = self:GetParent():GetHealth()
-- 			block = params.damage-self:GetParent():GetHealth()+1
-- 			print("health", self:GetParent():GetHealth(), "damage", params.damage, "block", block)
-- 			print("health-(damage-block):",self:GetParent():GetHealth()-(params.damage-block))
-- 		end

-- 		params.attacker:Heal( damage, self:GetAbility() )
-- 		self:PlayEffects( params.attacker )

-- 		return block
-- 	end
-- end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sandra_undeniable_torture:CheckState()
	local state = {
		[MODIFIER_STATE_SPECIALLY_DENIABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Helper: Flag operations
function modifier_sandra_undeniable_torture:FlagExist(a,b)--Bitwise Exist
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
function modifier_sandra_undeniable_torture:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/generic_gameplay/generic_lifesteal.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end