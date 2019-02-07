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
midas_golden_burst = class({})
LinkLuaModifier( "modifier_midas_golden_burst_debuff", "custom_abilities/midas_golden_burst/modifier_midas_golden_burst_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function midas_golden_burst:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local gold_return = self:GetSpecialValueFor("gold_return")

	-- find units in radius
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- add modifier
	for _,hero in pairs(heroes) do
		hero:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_midas_golden_burst_debuff", -- modifier name
			{ duration = duration } -- kv
		)
	end

	-- play effects
	self:PlayEffects( caster:GetOrigin(), radius )

	-- kill dropped items and
	local items = Entities:FindAllByClassnameWithin( "dota_item_drop", caster:GetOrigin(), radius )
	for _,item_physical in pairs(items) do
		local item = item_physical:GetContainedItem()

		-- kill items and give the gold back
		if item:GetShareability()==ITEM_NOT_SHAREABLE and item:IsSellable() and item:IsKillable() then
			local purchaser = item:GetPurchaser()

			-- check if it is allied, and not disable help
			local filter = UnitFilter(
				purchaser,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP,
				caster:GetTeamNumber()
			)

			if filter==UF_SUCCESS then
				-- kill the item and give gold
				local position = item_physical:GetOrigin()
				local gold = item:GetCost() * gold_return/100
				item_physical:Kill()
				item:Kill()

				PlayerResource:ModifyGold( purchaser:GetPlayerOwnerID(), gold, false, DOTA_ModifyGold_Unspecified )
				self:PlayEffects2( purchaser, gold )
			end
		end
	end
end

--------------------------------------------------------------------------------
function midas_golden_burst:PlayEffects( origin, radius )
	-- Get Resources
	local particle_cast = "particles/midas_golden_burst.vpcf"
	local sound_cast = "Hero_FacelessVoid.TimeDilation.Cast"

	-- data
	radius = radius + 1000

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:SetParticleControl( effect_cast, 60, Vector( 255, 255, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function midas_golden_burst:PlayEffects2( unit, gold )
	-- Get Resources
	local particle_cast = "particles/msg_fx/msg_goldbounty.vpcf"
	local sound_cast = "General.Coins"

	-- do nothing if no gold
	if gold<=0 then return end

	-- load data
	local digit = 0
		if gold<10 then digit = 1
	elseif gold<100 then digit = 2
	elseif gold<1000 then digit = 3
	elseif gold<10000 then digit = 4
	else digit = 5 end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, unit )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 0, gold, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, digit+1, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( 255, 255, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
end