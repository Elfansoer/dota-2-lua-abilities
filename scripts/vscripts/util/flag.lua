--------------------------------------------------------------------------------
-- Helper: flag Calculations
if not flag then
	flag = {}
end

-- Returns true if flag b is within state a
function flag:Exist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

-- Adds flag b to state a, if not exist
function flag:Add(a,b)
	if flag:Exist(a,b) then
		return a
	else
		return a+b
	end
end

-- Removes flag b to state a, if exist
function flag:Min(a,b)
	if flag:Exist(a,b) then
		return a-b
	else
		return a
	end
end
