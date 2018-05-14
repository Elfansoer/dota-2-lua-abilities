riven_broken_wings = class({})
LinkLuaModifier( "modifier_riven_broken_wings", "custom_abilities/riven_broken_wings/modifier_riven_broken_wings", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function riven_broken_wings:CastFilterResult()
	if IsServer() then
		if self:IsInAbilityPhase() then
		else
			self.aggro = self:GetCaster():GetAggroTarget()
		end
	end

	return UF_SUCCESS
end

function riven_broken_wings:OnAbilityPhaseStart()
	if IsServer() then
		if self.aggro then
			self:GetCaster():FaceTowards(self.aggro:GetOrigin())
		end
	end

	return true
end

function riven_broken_wings:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local range = self:GetSpecialValueFor("range")
	local width = self:GetSpecialValueFor("width")
	local damage = self:GetSpecialValueFor("bonus_damage")
	local recast_timer = self:GetSpecialValueFor("recast_timer")
	local recast_number = self:GetSpecialValueFor("recast_number")

	-- generate data
	local origin = caster:GetOrigin()
	local direction = caster:GetForwardVector()

	if self.aggro then 
		direction = self.aggro:GetOrigin()-origin
		direction.z = 0
		direction = direction:Normalized()
	end

	local point = caster:GetOrigin() + direction*range

	-- find units in line
	local enemies = FindUnitsInLine( 
		caster:GetTeamNumber(),
		origin,
		point,
		nil,
		width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0
	)

	local damageTable = {
		-- victim = enemy,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self,
	}
	
	-- attack
	for _,enemy in pairs(enemies) do
		caster:PerformAttack( enemy, true, true, true, true, false, false, true)
		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end

	-- move
	FindClearSpaceForUnit( caster, point, true )

	-- set attack
	if self.aggro then
		caster:SetForwardVector( -direction )
		caster:SetAggroTarget( self.aggro )
		caster:MoveToTargetToAttack( self.aggro )
	end

	-- triple cast
	local modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_riven_broken_wings", -- modifier name
		{
			duration = recast_timer,
			number = recast_number-1,
		} -- kv
	)
	if modifier:GetStackCount()>0 then
		self:EndCooldown()
	else
		modifier:Destroy()
	end

	-- effects

end

--------------------------------------------------------------------------------
function riven_broken_wings:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end