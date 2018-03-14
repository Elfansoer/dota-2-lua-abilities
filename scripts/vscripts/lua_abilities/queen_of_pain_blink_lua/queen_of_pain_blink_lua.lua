queen_of_pain_blink_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function queen_of_pain_blink_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()

	-- load data
	local max_range = self:GetSpecialValueFor("blink_range")

	-- determine target position
	local direction = (point - origin)
	if direction:Length2D() > max_range then
		direction = direction:Normalized() * max_range
	end

	-- teleport
	-- caster:SetOrigin( origin + direction )
	FindClearSpaceForUnit( caster, origin + direction, true )

	-- Play effects
	self:PlayEffects( origin, direction )
end

--------------------------------------------------------------------------------
function queen_of_pain_blink_lua:PlayEffects( origin, direction )
	-- Get Resources
	local particle_cast_a = "particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf"
	local sound_cast_a = "Hero_QueenOfPain.Blink_out"

	local particle_cast_b = "particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf"
	local sound_cast_b = "Hero_QueenOfPain.Blink_in"

	-- At original position
	local effect_cast_a = ParticleManager:CreateParticle( particle_cast_a, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_a, 0, origin )
	ParticleManager:SetParticleControlForward( effect_cast_a, 0, direction:Normalized() )
	ParticleManager:SetParticleControl( effect_cast_a, 1, origin + direction )
	ParticleManager:ReleaseParticleIndex( effect_cast_a )
	EmitSoundOnLocationWithCaster( origin, sound_cast_a, self:GetCaster() )

	-- At original position
	local effect_cast_b = ParticleManager:CreateParticle( particle_cast_b, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast_b, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast_b, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast_b )
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), sound_cast_b, self:GetCaster() )
end