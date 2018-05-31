modifier_invoker_emp_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_emp_lua_thinker:IsHidden()
	return true
end

function modifier_invoker_emp_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_emp_lua_thinker:OnCreated( kv )
	if IsServer() then
		self.burn = self:GetAbility():GetOrbSpecialValueFor("mana_burned","w")
		self.radius = self:GetAbility():GetSpecialValueFor("area_of_effect")
		self.damage_pct = self:GetAbility():GetSpecialValueFor("damage_per_mana_pct")/100
		self.restore_pct = self:GetAbility():GetSpecialValueFor("restore_per_mana_pct")/100

		-- play effects
		self:PlayEffects1()
	end
end

function modifier_invoker_emp_lua_thinker:OnDestroy( kv )
	if IsServer() then
		-- find caught units
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			self:GetParent():GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_MANA_ONLY,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- precache damage
		local damageTable = {
			-- victim = target,
			attacker = self:GetCaster(),
			-- damage = 500,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
		}

		local burned = 0
		for _,enemy in pairs(enemies) do
			-- burn mana
			local mana_burn = math.min( enemy:GetMana(), self.burn )
			enemy:ReduceMana( mana_burn )

			-- damage based on mana burned
			damageTable.victim = enemy
			damageTable.damage = mana_burn * self.damage_pct
			ApplyDamage(damageTable)

			-- sum mana burned
			burned = burned + mana_burn
		end

		-- give mana to caster
		self:GetCaster():GiveMana( burned * self.restore_pct )

		-- play effects
		self:PlayEffects2()

		-- remove thinker
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_invoker_emp_lua_thinker:PlayEffects1()
	-- Get Resources
	-- local particle_cast = "string"
	local sound_cast = "Hero_Invoker.EMP.Charge"

	-- Get Data

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	iControlPoint,
	-- 	hTarget,
	-- 	PATTACH_NAME,
	-- 	"attach_name",
	-- 	vOrigin, -- unknown
	-- 	bool -- unknown, true
	-- )
	-- ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	-- SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end

function modifier_invoker_emp_lua_thinker:PlayEffects2()
	-- Get Resources
	-- local particle_cast = "string"
	local sound_cast = "Hero_Invoker.EMP.Discharge"

	-- Get Data

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	iControlPoint,
	-- 	hTarget,
	-- 	PATTACH_NAME,
	-- 	"attach_name",
	-- 	vOrigin, -- unknown
	-- 	bool -- unknown, true
	-- )
	-- ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	-- SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end