modifier_rubick_spell_steal_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_rubick_spell_steal_lua:IsHidden()
	return false
end

function modifier_rubick_spell_steal_lua:IsDebuff()
	return false
end

function modifier_rubick_spell_steal_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_rubick_spell_steal_lua:OnCreated( kv )
end

function modifier_rubick_spell_steal_lua:OnRefresh( kv )
end

function modifier_rubick_spell_steal_lua:OnDestroy( kv )
	self:GetAbility():ForgetSpell()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_rubick_spell_steal_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_START,
	}

	return funcs
end

function modifier_rubick_spell_steal_lua:OnAbilityStart( params )
	if IsServer() then
		if params.unit==self:GetParent() and params.ability==self:GetAbility().currentSpell then
			-- Destroy previous animation
			local modifier = self:GetParent():FindModifierByNameAndCaster( "modifier_rubick_spell_steal_lua_animation", self:GetParent() )
			if modifier then
				modifier:Destroy()
			end

			-- Animate
			local anim_duration = math.max( 1.5, params.ability:GetCastPoint() )
			if params.ability:GetChannelTime()>0 then
				anim_duration = params.ability:GetChannelTime()
			end
			local animate = self:GetParent():AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_rubick_spell_steal_lua_animation",
				{
					duration = anim_duration,
					spellName = params.ability:GetAbilityName(),
				}
			)
		end
	end
end

