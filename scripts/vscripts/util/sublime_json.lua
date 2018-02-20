json = require "util/json"
string_doc = require "util/script_help2"
dotadoc = {}

function dotadoc.PrintTableRecursive( key, value, tab )
	-- abort deep recursive
	if tab>10 then
		print("quit")
		return
	end

	local tabText = ""
	for i=0,tab do
		tabText = tabText .. "    "
	end

	print(tabText,key,value, type(value))
	if (type(value)=='table') then
		for k,v in pairs(value) do
			dotadoc.PrintTableRecursive( k, v, tab + 1)
		end
	end
end

local function readDescription( line )
	local _, start = string.find(line,'---[[ ',1,true)
	local finish, _ = string.find(line,' ])',1,true)

	if finish then
		return string.sub(line,start+1,finish-1)
	else
		return string.sub(line,start+1,-1)
	end
end

local function readParams( line )
	local _,start = string.find(line,'-- @',1,true)
	return string.sub(line,start+1)
end

local function readFunction( line )
	local _,start = string.find(line,'function ',1,true)
	local finish,_ = string.find(line,')',1,true)

	return string.sub(line,start+1,finish)
end

local function readEnumName( line )
	local _,start = string.find(line, '--- Enum ',1,true)

	return string.sub(line,start+1,-1)
end

local function readEnumValue( line )
	local finish,_ = string.find(line,' = ',1,true)

	return string.sub(line,1,finish-1)
end

local function arrageTable( context )
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
			item["contents"] = value .. " " .. contents
			table.insert(jsonTable["completions"],item)
		end
	end

	return jsonTable
end



local function parseLine( line, context )
	-- if empty line, pass
	if string.len( line )==0 then
		return
	end

	-- if reading mode
	-- check line type
	local desc = string.find( line, '---[[', 1, true )
	local params = string.find( line, '-- @', 1, true )
	local funcs = string.find( line, 'function', 1, true )
	local ename = string.find( line, '--- Enum', 1, true )
	local evalue = string.find( line, ' = ', 1, true )

	-- Function mode
	if desc and desc==1 then
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
	elseif params and params==1 then
		-- read line
		table.insert(context.read.params, readParams( line ))
	elseif funcs and funcs==1 then
		-- read line
		context.read.func = readFunction( line )
		
		-- finish reading
		table.insert(context.funcs,context.read)
		context.read = nil
		context.mode = "none"
	elseif ename and ename==1 then
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
		context.read.values = {}

		-- read line
		context.read.name = readEnumName( line )
	elseif evalue then
		-- read line
		context.mode = "enumvalue"
		table.insert(context.read.values,readEnumValue( line ))
	end
end


function dotadoc.mainFunction()
	-- create context
	local context = {}
	context.mode = ""
	context.funcs = {}
	context.enums = {}

	-- prepare strings
	local doc_lines = {}
	for line in (string_doc):gmatch("([^\n]*)\n")  do 
	    table.insert(doc_lines, line) 
	end

	-- parse Lines
	for i,line in ipairs(doc_lines) do
		parseLine( line, context )
	end

	-- end parse Lines
	if context.mode=="enumvalue" then
		-- finish reading
		table.insert(context.enums,context.read)
		context.read = nil
		context.mode = "none"
	end

	-- Rearrange tables
	local jsonTable = arrageTable( context )

	-- Write JSON
	local JSON_string = json.encode(jsonTable)
	-- print(JSON_string)
	
	-- Print JSON String
	print("length",string.len(JSON_string))
	local remaining = string.len(JSON_string)
	local current_pos = 1
	local json_split = {}

	while remaining >=100 do
		table.insert( json_split, string.sub( JSON_string, current_pos, current_pos+99 ) )
		current_pos = current_pos + 100
		remaining = remaining - 100
	end
	table.insert( json_split, string.sub( JSON_string, current_pos, -1 ) )

	for k,v in pairs(json_split) do
		print(v)
	end

end

return dotadoc