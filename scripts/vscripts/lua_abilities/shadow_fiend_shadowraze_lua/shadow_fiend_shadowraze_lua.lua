LinkLuaModifier( "modifier_shadow_fiend_shadowraze_lua", "lua_abilities/shadow_fiend_shadowraze_lua/modifier_shadow_fiend_shadowraze_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
shadow_fiend_shadowraze_a_lua = class({})
shadow_fiend_shadowraze_b_lua = class({})
shadow_fiend_shadowraze_c_lua = class({})

function shadow_fiend_shadowraze_a_lua:OnSpellStart()
	shadowraze.OnSpellStart( self )
end
function shadow_fiend_shadowraze_b_lua:OnSpellStart()
	shadowraze.OnSpellStart( self )
end
function shadow_fiend_shadowraze_c_lua:OnSpellStart()
	shadowraze.OnSpellStart( self )
end

--------------------------------------------------------------------------------

if shadowraze==nil then
	shadowraze = {}
end

function shadowraze.OnSpellStart( this )
	-- get references
	local distance = this:GetSpecialValueFor("shadowraze_range")
	local front = this:GetCaster():GetForwardVector():Normalized()
	local target_pos = this:GetCaster():GetOrigin() + front * distance
	local target_radius = this:GetSpecialValueFor("shadowraze_radius")
	local base_damage = this:GetSpecialValueFor("shadowraze_damage")
	local stack_damage = this:GetSpecialValueFor("stack_bonus_damage")
	local stack_duration = this:GetSpecialValueFor("duration")

	-- get affected enemies
	local enemies = FindUnitsInRadius(
		this:GetCaster():GetTeamNumber(),
		target_pos,
		nil,
		target_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	-- for each affected enemies
	for _,enemy in pairs(enemies) do
		-- Get Stack
		local modifier = enemy:FindModifierByNameAndCaster("modifier_shadow_fiend_shadowraze_lua", this:GetCaster())
		local stack = 0
		if modifier~=nil then
			stack = modifier:GetStackCount()
		end

		-- Apply damage
		local damageTable = {
			victim = enemy,
			attacker = this:GetCaster(),
			damage = base_damage + stack*stack_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = this,
		}
		ApplyDamage( damageTable )

		-- Add stack
		if modifier==nil then
			enemy:AddNewModifier(
				this:GetCaster(),
				this,
				"modifier_shadow_fiend_shadowraze_lua",
				{duration = stack_duration}
			)
		else
			modifier:IncrementStackCount()
			modifier:ForceRefresh()
		end
	end

	-- Effects
	shadowraze.PlayEffects( this, target_pos, target_radius )
end

function shadowraze.PlayEffects( this, position, radius )
	local particle_blast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local sound_blast = "Hero_Nevermore.Shadowraze"

	local nFXIndex = ParticleManager:CreateParticle( particle_blast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, position )
	ParticleManager:SetParticleControl( nFXIndex, 1, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )
	EmitSoundOnLocationWithCaster( position, sound_blast, this:GetCaster() )
end