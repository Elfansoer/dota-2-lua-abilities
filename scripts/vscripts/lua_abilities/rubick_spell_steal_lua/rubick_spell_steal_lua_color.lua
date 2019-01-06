--[[ Use this to import:
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)
]]
-- init
if not arcanaColor then
	arcanaColor = {}
	arcanaColor.TargetHSV = 120 -- Target Hue value [0..255] (color wheel); 0=red, 120=green, 240=blue
	arcanaColor.TargetRGB = Vector(0,255,0) -- Target RGB color
	
	arcanaColor.AbilityBaseHSV = {
		["faceless_void_chronosphere_lua"] = Vector(268,169,90),
	}

	-- set colors
	function arcanaColor:SetTargetHSV255( color )
		self.TargetHSV = color
	end
	function arcanaColor:SetTargetHSV360( color )
		self.TargetHSV = color/360*255
	end
	function arcanaColor:SetTargetRGB( r,g,b )
		self.TargetRGB = Vector(r,g,b)
	end

	-- conversion methods
	function arcanaColor:RgbToHsv( r, g, b )
		r, g, b = r/255, g/255, b/255
		local max, min = math.max(r, g, b), math.min(r, g, b)
		local h, s, v
		local d = max-min

		-- set v
		v = max

		-- set s
		if max==0 then
			s = 0
		else
			s = d/max
		end
		
		-- set h
		if max==min then
			h = 0
		elseif max==r then
			h = 60*( 0+(g-b)/d ) 
		elseif max==g then
			h = 60*( 2+(b-r)/d )
		else
			h = 60*( 4+(r-g)/d )
		end

		h = (h%360)/360

		h, s, v = h*255, s*255, v*255
		return math.floor(h+0.5), math.floor(s+0.5), math.floor(v+0.5)
	end
	function arcanaColor:HsvToRgb( h, s, v )
		h, s, v = h/255, s/255, v/255
		-- h = math.floor(h*6)
		h = h*6
		local c = v*s
		local x = c*(1-math.abs((h%2)-1))
		local m = v-c

		local r, g, b
			if h<=1 then r,g,b = c,x,0
		elseif h<=2 then r,g,b = x,c,0
		elseif h<=3 then r,g,b = 0,c,x
		elseif h<=4 then r,g,b = 0,x,c
		elseif h<=5 then r,g,b = x,0,c
		elseif h<=6 then r,g,b = c,0,x
		end

		r, g, b = r+m, g+m, b+m
		r, g, b = r*255, g*255, b*255
		return math.floor(r+0.5), math.floor(g+0.5), math.floor(b+0.5)
	end

	-- get colors
	function arcanaColor:GetHSVColor( ability )
		-- load original color HSV, convert hue to target value
		local colorHSV = self.AbilityBaseHSV[ability:GetAbilityName()]
		if not colorHSV then
			colorHSV = Vector(0,255,255)
		end

		-- convert hue to target
		colorHSV.x = self.TargetHSV

		-- change into RGB
		local colorRGB = Vector(0,0,0)
		colorRGB.x, colorRGB.y, colorRGB.z = self:HsvToRgb( colorHSV.x, colorHSV.y, colorHSV.z )
		return colorRGB
	end

	function arcanaColor:SetParticleColor( ability, effect, bRGB )
		if bRGB then
			ParticleManager:SetParticleControl( effect, 60, self.TargetRGB )
		else
			ParticleManager:SetParticleControl( effect, 60, self:GetHSVColor( ability ) )
		end
		ParticleManager:SetParticleControl( effect, 61, Vector( 1, 0, 0 ) )
	end
end

-- logic
local self, effect_name = ...
if self.GetAbility then
	self = self:GetAbility()
end

-- arcanaColor:SetTargetHSV360( 270 )
arcanaColor:SetTargetHSV255( RandomInt(0,255) )
arcanaColor:SetParticleColor( self, effect_name, false )