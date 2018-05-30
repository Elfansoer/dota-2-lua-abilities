int_package = {}
function int_package.Pack( table, max_size )
	if #table<1 then return 0 end

	-- set max size (default 100)
	local max = max_size or 100

	-- pack integers
	local res = table[1]
	for i=2,#table do
		res = res * max_size
		res = res + table[i]
	end

	return res
end

function int_package.Unpack( integer, table_size, max_size )
	local res = {}
	for i=table_size,1,-1 do
		res[i] = integer%max_size
		integer = math.floor(integer/max_size)
	end
	return res
end

return int_package