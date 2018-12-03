modifier_generic_orb_effect_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_orb_effect_lua:IsHidden()
	return true
end

function modifier_generic_orb_effect_lua:IsDebuff()
	return false
end

function modifier_generic_orb_effect_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_orb_effect_lua:OnCreated( kv )
	-- generate data
	self.ability = self:GetAbility()
	self.cast = false
	self.records = {}
end

function modifier_generic_orb_effect_lua:OnRefresh( kv )
end

function modifier_generic_orb_effect_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_orb_effect_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,

		MODIFIER_EVENT_ON_ORDER,

		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}

	return funcs
end

function modifier_generic_orb_effect_lua:OnAttack( params )
	if params.attacker~=self:GetParent() then return end

	-- check autocast
	if self.ability:GetAutoCastState() then
		-- filter whether target is valid 
		local nResult = UnitFilter(
			params.target,
			self.ability:GetAbilityTargetTeam(),
			self.ability:GetAbilityTargetType(),
			self.ability:GetAbilityTargetFlags(),
			self:GetCaster():GetTeamNumber()
		)
		if nResult == UF_SUCCESS then
			self.cast = true
		end
	end

	-- register attack if being cast and fully castable
	if self.cast and self.ability:IsFullyCastable() then
		-- use mana and cd
		self.ability:UseResources( true, false, true )

		-- record the attack
		self.records[params.record] = true

		-- run OrbFire script if available
		if self.ability.OnOrbFire then self.ability:OnOrbFire( params ) end

		-- create custom projectile
		-- if self.ability.GetProjectileName then 
		-- 	local info = {
		-- 		Target = params.target,
		-- 		Source = self:GetParent(),
		-- 		Ability = self.ability,	
		-- 		EffectName = self.ability:GetProjectileName(),
		-- 		iMoveSpeed = self:GetParent():GetProjectileSpeed(),
		-- 	}
		-- 	ProjectileManager:CreateTrackingProjectile(info)
		-- end
	end

	self.cast = false
end
function modifier_generic_orb_effect_lua:GetModifierProcAttack_Feedback( params )
	if self.records[params.record] then
		-- apply the effect
		if self.ability.OnOrbImpact then self.ability:OnOrbImpact( params ) end
	end
end
function modifier_generic_orb_effect_lua:OnAttackFail( params )
	if self.records[params.record] then
		-- apply the fail effect
		if self.ability.OnOrbFail then self.ability:OnOrbFail( params ) end
	end
end
function modifier_generic_orb_effect_lua:OnAttackRecordDestroy( params )
	-- destroy attack record
	self.records[params.record] = nil
end

function modifier_generic_orb_effect_lua:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	if params.ability then
		-- if this ability, cast
		if params.ability==self:GetAbility() then
			self.cast = true
			return
		end

		-- if casting other ability that cancel channel while casting this ability, turn off
		local pass = false
		local behavior = params.ability:GetBehavior()
		if self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_CHANNEL ) or 
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT ) or
			self:FlagExist( behavior, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL )
		then
			local pass = true -- do nothing
		end

		if self.cast and (not pass) then
			self.cast = false
		end
	else
		-- if ordering something which cancel channel, turn off
		if self.cast then
			if self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_POSITION ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_MOVE_TO_TARGET )	or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_MOVE ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_ATTACK_TARGET ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_STOP ) or
				self:FlagExist( params.order_type, DOTA_UNIT_ORDER_HOLD_POSITION )
			then
				self.cast = false
			end
		end
	end
end

function modifier_generic_orb_effect_lua:GetModifierProjectileName( params )
	if self.ability.GetProjectileName then
		if self.cast or (self.ability:GetAutoCastState() and self.ability:IsFullyCastable()) then
			return self.ability:GetProjectileName()
		end
	end
end

--------------------------------------------------------------------------------
-- Helper: Flags
function modifier_generic_orb_effect_lua:FlagExist(a,b)--Bitwise Exist
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