modifier_enchantress_natures_attendants_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enchantress_natures_attendants_lua:IsHidden()
	return false
end

function modifier_enchantress_natures_attendants_lua:IsDebuff()
	return false
end

function modifier_enchantress_natures_attendants_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enchantress_natures_attendants_lua:OnCreated( kv )
	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "wisp_count" ) -- special value
	self.heal = self:GetAbility():GetSpecialValueFor( "heal" ) -- special value
	self.interval = self:GetAbility():GetSpecialValueFor( "heal_interval" ) -- special value
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value

	if IsServer() then
		self:SetDuration(kv.duration+0.1)

		-- Start interval
		self:StartIntervalThink( self.interval )
	end
end

function modifier_enchantress_natures_attendants_lua:OnRefresh( kv )
	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "wisp_count" ) -- special value
	self.heal = self:GetAbility():GetSpecialValueFor( "heal" ) -- special value
	self.interval = self:GetAbility():GetSpecialValueFor( "heal_interval" ) -- special value
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value

	if IsServer() then
		self:SetDuration(kv.duration+0.1)
		
		-- Start interval
		self:StartIntervalThink( self.interval )
	end	
end

function modifier_enchantress_natures_attendants_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_enchantress_natures_attendants_lua:OnIntervalThink()
	-- find allies
	local allies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ALLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- filter full health alliees
	local targets = {}
	for i,ally in pairs(allies) do
		if ally:GetHealthPercent()<100 then
			table.insert( targets, i )
		end
	end
	if #targets<1 then return end
	local n = #targets

	-- heal random target
	for i=1,self.count do
		targets[RandomInt(1,n)]:Heal( self.heal, self:GetAbility() )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_enchantress_natures_attendants_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_enchantress_natures_attendants_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_enchantress_natures_attendants_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end