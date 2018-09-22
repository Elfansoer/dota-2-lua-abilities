modifier_sandra_sacrifice_master = class({})
local tempTable = require("util/tempTable")

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_sacrifice_master:IsHidden()
	return false
end

function modifier_sandra_sacrifice_master:IsDebuff()
	return false
end

function modifier_sandra_sacrifice_master:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_sacrifice_master:OnCreated( kv )
	if IsServer() then
		self.slave = tempTable:RetATValue( kv.modifier )
		self:PlayEffects()
	end
end

function modifier_sandra_sacrifice_master:OnRefresh( kv )
	
end

function modifier_sandra_sacrifice_master:OnDestroy( kv )
	if IsServer() then
		if not self.slave:IsNull() then
			self.slave:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_sacrifice_master:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}

	return funcs
end

function modifier_sandra_sacrifice_master:GetMinHealth()
	if IsServer() then
		self.currentHealth = self:GetParent():GetHealth()
	end
end

function modifier_sandra_sacrifice_master:OnTakeDamage( params )
	if IsServer() then
		if params.unit~=self:GetParent() then
			return
		end

		-- cover up damage
		self:GetParent():SetHealth( self.currentHealth )

		local flags = params.damage_flags
		flags = self:FlagAdd( flags, DOTA_DAMAGE_FLAG_BYPASSES_BLOCK ) 
		flags = self:FlagAdd( flags, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS ) 
		flags = self:FlagAdd( flags, DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION ) 
		flags = self:FlagAdd( flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL ) 
		flags = self:FlagAdd( flags, DOTA_DAMAGE_FLAG_REFLECTION )

		-- damage slave
		local damageTable = {
			victim = self.slave:GetParent(),
			attacker = params.attacker,
			damage = params.damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self:GetAbility(), --Optional.
			damage_flags = flags, --Optional.
		}
		ApplyDamage(damageTable)

		-- effects
		self:PlayEffects1()
	end
end

function modifier_sandra_sacrifice_master:OnAbilityExecuted( params )
	if IsServer() then
		if (not params.target) or params.target~=self:GetParent() or params.unit:GetTeamNumber()==self:GetParent():GetTeamNumber() then
			return
		end

		-- redirect
		params.unit:SetCursorCastTarget( self.slave:GetParent() )

		-- effects
		self:PlayEffects1()
		self:PlayEffects2()
	end
end

--------------------------------------------------------------------------------
-- Helper: Flag operations
function modifier_sandra_sacrifice_master:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function modifier_sandra_sacrifice_master:FlagAdd(a,b)--Bitwise and
	if self:FlagExist(a,b) then
		return a
	else
		return a+b
	end
end

function modifier_sandra_sacrifice_master:FlagMin(a,b)--Bitwise and
	if self:FlagExist(a,b) then
		return a-b
	else
		return a
	end
end

function modifier_sandra_sacrifice_master:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_sandra/sandra_sacrifice_sphere.vpcf"

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, Vector(0,255,0) )
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		false
	)
end

function modifier_sandra_sacrifice_master:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_rope.vpcf"
	local sound_cast = "DOTA_Item.BladeMail.Damage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self.slave:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.slave:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- sound
	EmitSoundOnClient( sound_cast, self.slave:GetParent():GetPlayerOwner() )
end

function modifier_sandra_sacrifice_master:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/items4_fx/combo_breaker_spell_burst.vpcf"
	local sound_cast = "Item.LotusOrb.Target"

	-- Get data
	local effect_constant = 100
	local direction = (self.slave:GetParent():GetOrigin()-self:GetParent():GetOrigin()):Normalized() * effect_constant

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() + Vector( 0, 0, 90 ) - direction*1 )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() + Vector( 0, 0, 90 ) + direction*0 )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetParent() )
end