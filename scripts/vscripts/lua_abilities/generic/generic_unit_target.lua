generic_unit_target = {}

generic_unit_target.data = {
	spell = nil,
	caster = nil,
	target = nil,
	projectile = nil,
}

function generic_unit_target:Init( spell )
	self.data.spell = spell,
	self.data.caster = spell:GetCaster(),
	self.data.target = spell:GetCursorTarget(),
end



function generic_unit_target:SetProjectile( name, speed, dodgeable )
	self.data.projectile = {
		name = name,
		speed = speed,
		dodgeable = dodgeable,
	}
end