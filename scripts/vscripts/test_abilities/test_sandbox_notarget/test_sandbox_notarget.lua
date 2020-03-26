-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
test_sandbox_notarget = class({})
LinkLuaModifier( "modifier_test_sandbox_notarget", "test_abilities/test_sandbox_notarget/test_sandbox_notarget", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function test_sandbox_notarget:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		1000,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		print("found enemy",enemy:GetUnitName())
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_test_sandbox_notarget", -- modifier name
			{
				duration = 5,
				target = enemy:entindex(),
			} -- kv
		)
		break
	end
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_test_sandbox_notarget", -- modifier name
		{
			duration = 5,
			target = caster:entindex(),
		} -- kv
	)
end

--------------------------------------------------------------------------------
function test_sandbox_notarget:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 100, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_test_sandbox_notarget = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_test_sandbox_notarget:IsHidden()
	return false
end
function modifier_test_sandbox_notarget:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_test_sandbox_notarget:OnCreated( kv )
	-- references
	-- self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" )
	if IsServer() then
		self:SetStackCount( kv.target )
		self.target = EntIndexToHScript( kv.target )
	else
		local stack = self:GetStackCount()
		self.target = EntIndexToHScript( stack )
	end
	print("created")

	-- if IsServer() then
	-- 	-- Start interval
	-- 	self:StartIntervalThink( self.interval )
	-- 	self:OnIntervalThink()
	-- end
end

function modifier_test_sandbox_notarget:OnRemoved()
	if not IsServer() then return end
	print("removed")
end
function modifier_test_sandbox_notarget:OnDestroy()
	if not IsServer() then return end
	print("destroyed")
end

--------------------------------------------------------------------------------
-- Aura Effects
-- function modifier_test_sandbox_notarget:IsAura()
-- 	-- return self:GetParent()==self:GetCaster()
-- 	return false
-- end

-- function modifier_test_sandbox_notarget:GetModifierAura()
-- 	return "modifier_test_sandbox_notarget"
-- end

-- function modifier_test_sandbox_notarget:GetAuraRadius()
-- 	return FIND_UNITS_EVERYWHERE
-- end

-- function modifier_test_sandbox_notarget:GetAuraDuration()
-- 	return 0.5
-- end

-- function modifier_test_sandbox_notarget:GetAuraSearchTeam()
-- 	return DOTA_UNIT_TARGET_TEAM_ENEMY
-- end

-- function modifier_test_sandbox_notarget:GetAuraSearchType()
-- 	return DOTA_UNIT_TARGET_ALL
-- end

-- function modifier_test_sandbox_notarget:GetAuraSearchFlags()
-- 	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
-- end

-- function modifier_test_sandbox_notarget:GetAuraEntityReject( hEntity )
-- 	if IsServer() then
		
-- 	end

-- 	return false
-- end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test_sandbox_notarget:DeclareFunctions()
	local funcs = {
		-- MODIFIER_PROPERTY_IGNORE_PHYSICAL_ARMOR,
		MODIFIER_EVENT_ON_MODEL_CHANGED,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
	}

	return funcs
end

-- function modifier_test_sandbox_notarget:OnModifierAdded( params )
-- 	if not IsServer() then return end
-- 	if params.unit~=self:GetParent() then return end
-- 	print("OnModifierAdded",self:GetParent():GetUnitName(),params.unit:GetUnitName())
-- 	-- for k,v in pairs(params) do
-- 	-- 	print(k,v)
-- 	-- end
-- end

function modifier_test_sandbox_notarget:OnModelChanged( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end
	print( params.attacker:GetModelName() )
end
function modifier_test_sandbox_notarget:GetModifierModelChange( params )
	if not IsServer() then return end
	return self:GetCaster():GetModelName()
end

function modifier_test_sandbox_notarget:GetModifierIgnorePhysicalArmor( params )
	if not IsServer() then return end
	print(self:GetParent():GetUnitName(),"GetModifierIgnorePhysicalArmor")
	for k,v in pairs(params) do
		print(k,v)
	end
end

function modifier_test_sandbox_notarget:GetEffectName()
	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
end

function modifier_test_sandbox_notarget:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end