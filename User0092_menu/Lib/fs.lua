
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

local fileModes = {
	{"write","w"},
	{"append","a"},
	{"new","w+"}
}
function write_file(file,mode,text)
	for id, name in ipairs(fileModes) do 
		if name[1] == mode 
		or name[2] == mode then
			mode = name[2]
		break end 
	end 
	local file = io.open(file,mode)
	if text == "" then 
		file:write(text)
	else
		file:write(text.."\n")
	end 

---@diagnostic disable-next-line: redundant-parameter
	file:close(file)
end
return {
	file_exists = file_exists,
	lines_from = lines_from,
	write_file = write_file
}