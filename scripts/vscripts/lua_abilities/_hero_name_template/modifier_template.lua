modifier_template_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_template_lua:IsHidden()
	return false
end

function modifier_template_lua:IsDebuff()
	return false
end

function modifier_template_lua:IsStunDebuff()
	return false
end

function modifier_template_lua:GetAttributes()
	return MODIFIER_ATRRIBUTE_XX + MODIFIER_ATRRIBUTE_YY 
end

function modifier_template_lua:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Aura
function modifier_template_lua:IsAura()
	return true
end

function modifier_template_lua:GetModifierAura()
	return "modifier_template_effect_lua"
end

function modifier_template_lua:GetAuraRadius()
	return float
end

function modifier_template_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_XX
end

function modifier_template_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_XX + DOTA_UNIT_TARGET_YY + ...
end

function modifier_template_lua:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_template_lua:OnCreated( kv )
	-- references
	self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_template_lua:OnRefresh( kv )
	
end

function modifier_template_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_template_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_XX,
		MODIFIER_EVENT_YY,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_template_lua:CheckState()
	local state = {
	[MODIFIER_STATE_XX] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_template_lua:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_template_lua:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_template_lua:GetEffectAttachType()
	return PATTACH_XX
end

--------------------------------------------------------------------------------
-- Declared Functions
function modifier_template_lua:OnAttackLanded( params )

	-- target	table: 0x02126f70
	-- attacker	table: 0x0210a5e8
	-- damage_type	1
	-- damage_flags	0
	-- damage	65
	-- original_damage	65
	
	-- ranged_attack	false
	-- no_attack_cooldown	false
	-- reincarnate	false
	-- order_type	0
	-- damage_category	1
	
	-- new_pos	Vector 0000000002138938 [0.000000 0.000000 0.000000]
	-- process_procs	true
	-- issuer_player_index	1234320
	-- ignore_invis	false
	-- record	0
	-- activity	-1
	-- do_not_consume	false
	-- heart_regen_applied	false
	-- diffusal_applied	false
	-- mkb_tested	false
	-- distance	0
	-- cost	0
	-- gain	0
	-- basher_tested	false
	-- fail_type	0
end

function modifier_template_lua:OnTakeDamage( params )

	-- attacker	table: 0x0210e1d0
	-- unit	table: 0x02125680
	-- inflictor table: 0x02125680
	-- damage	52.34899520874
	-- original_damage	65
	-- damage_flags	0
	-- damage_type	1

	-- ranged_attack	false
	-- no_attack_cooldown	false
	-- reincarnate	false
	-- order_type	0
	-- damage_category	1
	
	-- new_pos	Vector 000000000210A488 [0.000000 1.000000 0.000000]
	-- process_procs	false
	-- issuer_player_index	0
	-- fail_type	0
	-- ignore_invis	false
	-- record	0
	-- do_not_consume	false
	-- activity	-1
	-- heart_regen_applied	false
	-- diffusal_applied	false
	-- mkb_tested	false
	-- gain	0
	-- cost	0
	-- basher_tested	false
	-- distance	0
end

-- Learned:
	-- damage always equal to original_damage in OnAttackLanded
	-- OnTakeDamage happens after OnAttackLanded
		-- So, SetHealth behaves differently (AFTER DAMAGE, if on OnTakeDamage)
