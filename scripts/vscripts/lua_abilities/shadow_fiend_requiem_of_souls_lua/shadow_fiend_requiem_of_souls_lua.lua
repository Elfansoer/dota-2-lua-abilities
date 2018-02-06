shadow_fiend_requiem_of_souls_lua = class({})
LinkLuaModifier( "modifier_shadow_fiend_requiem_of_souls_lua", "lua_abilities/shadow_fiend_requiem_of_souls_lua/modifier_shadow_fiend_requiem_of_souls_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function shadow_fiend_requiem_of_souls_lua:OnSpellStart()
	-- get references
	local soul_per_line = self:GetSpecialValueFor("requiem_soul_conversion")

	-- get number of souls
	local lines = 0
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_shadow_fiend_necromastery_lua", self:GetCaster() )
	if modifier~=nil then
		lines = math.floor(modifier:GetStackCount() / soul_per_line) 
	end

	-- explode
	self:Explode( lines )
end

function shadow_fiend_requiem_of_souls_lua:OnOwnerDied()
	-- get references
	local soul_per_line = self:GetSpecialValueFor("requiem_soul_conversion")

	-- get number of souls
	local lines = 0
	local modifier = self:GetCaster():FindModifierByNameAndCaster( "modifier_shadow_fiend_necromastery_lua", self:GetCaster() )
	if modifier~=nil then
		lines = math.floor(modifier:GetStackCount() / soul_per_line) 
	end

	-- explode
	self:Explode( lines/2 )
end

function shadow_fiend_requiem_of_souls_lua:Explode( lines )
	-- get references
	self.damage =  self:GetAbilityDamage()
	self.duration = self:GetSpecialValueFor("requiem_slow_duration")
	self.reduction_ms_pct = self:GetSpecialValueFor("requiem_reduction_ms")
	self.reduction_damage_pct = self:GetSpecialValueFor("requiem_reduction_damage")

	local particle_line = "particles/units/heroes/hero_nevermore/nevermore_requiemofsouls_line.vpcf"
	local line_length = self:GetSpecialValueFor("requiem_radius")
	local width_start = self:GetSpecialValueFor("requiem_line_width_start")
	local width_end = self:GetSpecialValueFor("requiem_line_width_end")
	local line_speed = self:GetSpecialValueFor("requiem_line_speed")

	-- create linear projectile
	self.lines = {}
	local forward = self:GetCaster():GetForwardVector():Normalized() * line_length
	local dif_degree = 360/lines;
	local rotate = 0

	for i=1,lines do
		-- todo: get rotation
		local rotation = 
		local velocity = RotatePosition( self:GetCaster():GetOrigin(), rotation, forward )
		local info = {
			Ability = self,
			EffectName = particle_line,
			vSpawnOrigin = self:GetCaster():GetOrigin(),
			fDistance = line_length,
			fStartRadius = width_start,
			fEndRadius = width_end,
			Source = self:GetCaster(),
			bHasFrontalCone = false,
			bReplaceExisting = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_SPELL_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			fExpireTime = GameRules:GetGameTime() + 1 + line_length/line_speed,
			bDeleteOnHit = false,
			vVelocity = velocity,
			bProvidesVision = false,
		}
		projectile = ProjectileManager:CreateLinearProjectile( info )
	end

end

function shadow_fiend_requiem_of_souls_lua:OnProjectileHit( hTarget, vLocation )
	if hTarget ~= nil then
		-- damage target
		local damage = {
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = this,
		}
		ApplyDamage( damage )

		-- apply modifier
		hTarget:AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_shadow_fiend_requiem_of_souls_lua",
			{
				duration = self.duration,
				reduction_ms_pct = self.reduction_ms_pct,
				reduction_damage_pct = self.reduction_damage_pct
			}
		)
	end

	return false
end