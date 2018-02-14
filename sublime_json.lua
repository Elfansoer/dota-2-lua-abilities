{
	"scope": "text.html - source - meta.tag, punctuation.definition.tag.begin",

	"completions":
	[
		{ "trigger": "a", "contents": "<a href=\"$1\">$2</a>" },
		{ "trigger": "abbr", "contents": "<abbr>$1</abbr>" },
		{ "trigger": "acronym", "contents": "<acronym>$1</acronym>" },
		{ "trigger": "address", "contents": "<address>$1</address>" }
	]
}

---[[ AngleDiff  Returns the number of degrees difference between two yaw angles ]]
-- @return float
-- @param float_1 float
-- @param float_2 float
function AngleDiff( float_1, float_2 ) end

---[[ AppendToLogFile  Appends a string to a log file on the server ]]
-- @return void
-- @param string_1 string
-- @param string_2 string
function AppendToLogFile( string_1, string_2 ) end

---[[ AxisAngleToQuaternion  (vector,float) constructs a quaternion representing a rotation by angle around the specified vector axis ]]
-- @return Quaternion
-- @param Vector_1 Vector
-- @param float_2 float
function AxisAngleToQuaternion( Vector_1, float_2 ) end

--- Enum AbilityLearnResult_t
ABILITY_CANNOT_BE_UPGRADED_AT_MAX = 2
ABILITY_CANNOT_BE_UPGRADED_NOT_UPGRADABLE = 1
ABILITY_CANNOT_BE_UPGRADED_REQUIRES_LEVEL = 3
ABILITY_CAN_BE_UPGRADED = 0
ABILITY_NOT_LEARNABLE = 4

function mainFunction()
	local context = {}
	context.mode = ""
	context.funcs = {}
	context.enums = {}

	-- parse Lines
	while not eof do
		parseLine( line, context )
	end

	-- Rearrange tables
	local jsonTable = arrageTable( context )

	-- Write JSON
	local JSON_string = json.encode(jsonTable)
end

function parseLine( line, context )
	-- if empty line, pass
	if string.len( line )==0 then
		return
	end

	-- if reading mode
	-- check line type
	local desc = string.find( line, '---[[')
	local params = string.find( line, '---[[')
	local funcs = string.find( line, '---[[')
	local ename = string.find( line, '---[[')
	local evalue = string.find( line, '---[[')

	-- Function mode
	if desc then
		-- if in enum mode
		if context.mode=="enumvalue" then
			-- finish reading
			table.insert(context.enums,context.read)
			context.read = nil
			context.mode = "none"
		end

		-- prepare reading
		context.mode = "function"
		context.read = {}
		context.read.params = {}

		-- read line
		context.read.desc = readDescription( line )
	end
	if params then
		-- read line
		table.insert(context.read.params, readParams( line ))
	end
	if funcs then
		-- read line
		context.read.func = readFunction( line )
		
		-- finish reading
		table.insert(context.funcs,context.read)
		context.read = nil
		context.mode = "none"
	end


	-- Enum mode
	if ename then
		-- if in enum mode
		if context.mode=="enumvalue" then
			-- finish reading
			table.insert(context.enums,context.read)
			context.read = nil
			context.mode = "none"
		end

		-- prepare reading
		context.mode = "enumname"
		context.read = {}
		context.read.enums = {}

		-- read line
		read.name = readEnumName( line )
	end
	if evalue then
		-- read line
		context.mode = "enumvalue"
		table.insert(context.read.values,readEnumValue( line ))
	end
end

function readDescription( line )
	local _, start = string.find(line,'---[[ ')
	local finish,_ = string.find(line,' ]]')

	return string.sub(line,start+1,finish-1)
end

function readParams( line )
	local _,start = string.find(line,'-- @')

	return string.sub(line,start+1)
end

function readFunction( line )
	local _,start = string.find(line,'function ')
	local finish,_ = string.find(line,')')

	return string.sub(line,start+1,finish)
end

function readEnumName( line )
	local _,start = string.find(line, '--- Enum ')
end

function readEnumValue( line )
	local finish,_ string.find(line,' = ')

	return string.sub(line,1,finish)
end

function arrageTable( context )
	--[[
	context.funcs[]
	context.funcs[].func = "string"
	context.funcs[].params = array
	context.funcs[].desc = "string"

	context.enums
	context.enums[].name = "string"
	context.enums[].values = array
	]]

	-- preparing tables
	local jsonTable = {}
	jsonTable["scope"] = "text.html - source - meta.tag, punctuation.definition.tag.begin"
	jsonTable["completions"] = {}

	-- inserting functions
	for _,funcs in pairs(context.funcs) do
		-- build up contents
		local contents = ""
		contents = contents .. funcs.func .. "\n"
		contents = contents .. "--[[" .. "\n"
		contents = contents .. funcs.desc .. "\n"
		for _,param in pairs(funcs.params) do
			contents = contents .. param .. "\n"
		end
		contents = contents .. "]]" .. "\n"

		-- creating completion item
		local item = {}
		item["trigger"] = funcs.func
		item["contents"] = contents
		table.insert(jsonTable["completions"],item)
	end

	-- inserting enums
	for _,enums in pairs(context.enums) do
		local enum_name = enums.name
		for _,value in pairs(enums.values) do
			-- build up contents
			local contents = "--[[" .. enums.name .. "]]"

			-- create completion item
			local item = {}
			item["trigger"] = value
			item["contents"] = contents
			table.insert(jsonTable["completions"],item)
		end
	end

	return jsonTable
end