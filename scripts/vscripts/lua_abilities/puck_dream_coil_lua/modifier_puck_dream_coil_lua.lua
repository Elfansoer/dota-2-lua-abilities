modifier_puck_dream_coil_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_puck_dream_coil_lua:IsHidden()
	return false
end

function modifier_puck_dream_coil_lua:IsDebuff()
	return true
end

function modifier_puck_dream_coil_lua:IsStunDebuff()
	return false
end

function modifier_puck_dream_coil_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_puck_dream_coil_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_puck_dream_coil_lua:OnCreated( kv )
	-- references
	self.center = Vector( kv.coil_x, kv.coil_y, kv.coil_z )
	if self:GetCaster():HasScepter() then
		self.break_radius = self:GetAbility():GetSpecialValueFor( "coil_break_radius" ) -- special value
		self.break_stun = self:GetAbility():GetSpecialValueFor( "coil_stun_duration_scepter" ) -- special value
		self.break_damage = self:GetAbility():GetSpecialValueFor( "coil_break_damage_scepter" ) -- special value
		self.scepter = true
	else
		self.break_radius = self:GetAbility():GetSpecialValueFor( "coil_break_radius" ) -- special value
		self.break_stun = self:GetAbility():GetSpecialValueFor( "coil_stun_duration" ) -- special value
		self.break_damage = self:GetAbility():GetSpecialValueFor( "coil_break_damage" ) -- special value
	end

	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_puck_dream_coil_lua:OnRefresh( kv )
	
end

function modifier_puck_dream_coil_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_puck_dream_coil_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_UNIT_MOVED,
	}

	return funcs
end

function modifier_puck_dream_coil_lua:OnUnitMoved( params )
	if IsServer() then
		if params.unit~=self:GetParent() then
			return
		end

		-- if too far
		if (params.new_pos-self.center):Length2D()>self.break_radius then
			-- damage
			local damageTable = {
				victim = self:GetParent(),
				attacker = self:GetCaster(),
				damage = self.break_damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self:GetAbility(), --Optional.
			}
			ApplyDamage(damageTable)

			-- stun
			if not self:GetParent():IsMagicImmune() or self.scepter then
				self:GetParent():AddNewModifier(
					self:GetCaster(), -- player source
					self, -- ability source
					"modifier_generic_stunned_lua", -- modifier name
					{ duration = self.break_stun } -- kv
				)

			end

			-- effects
			local sound_cast = "Hero_Puck.Dream_Coil_Snap"
			EmitSoundOn( sound_cast, self:GetParent() )

			-- destroy
			self:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_puck_dream_coil_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_dreamcoil_tether.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.center )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end