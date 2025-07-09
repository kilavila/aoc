local lfs = require("lfs")

---@class FileModule
local FileModule = {}
FileModule.__index = FileModule

function FileModule:new()
	local instance = setmetatable({}, FileModule)
	return instance
end

function FileModule:get_content(file_path)
	if file_path then
		local blob = io.open(file_path, "r")

		if blob then
			local content = blob:read("*a")
			blob:close()

			return content
		else
			print("[Error] Could not open file: " .. file_path)
		end
	else
		print("[Error] No file path provided!")
	end
end

function FileModule:new_event(year, day)
	local path = "events"
	if not lfs.symlinkattributes(path, "mode") then
		lfs.mkdir(path)
		print("Created directory: " .. path)
	end

	path = path .. "/" .. year
	if not lfs.symlinkattributes(path, "mode") then
		lfs.mkdir(path)
		print("Created directory: " .. path)
	end

	path = path .. "/" .. day
	if not lfs.symlinkattributes(path, "mode") then
		lfs.mkdir(path)
		print("Created directory: " .. path)
	end

	path = path .. "/"
	local file_path = path .. "input.txt"
	local file = io.open(file_path, "w")
	if file then
		file:write("Paste puzzle input here")
		file:close()
		print("Created file: " .. file_path)
	end

	file_path = path .. "input.test.txt"
	file = io.open(file_path, "w")
	if file then
		file:write("Paste puzzle test input here")
		file:close()
		print("Created file: " .. file_path)
	end

	file_path = path .. "puzzle.lua"
	file = io.open(file_path, "w")
	if file then
		local puzzle_module = [[---@class Puzzle
local M = {}
M.__index = M

function M:new()
	local instance = setmetatable({}, M)
	return instance
end

function M:part_1(input)
	-- solution to the puzzle

	return { "Solution to part 1" }
end

function M:part_2(input)
	-- solution to the puzzle

	return { "Solution to part 2" }
end

return M]]
		file:write(puzzle_module)
		file:close()
		print("Created file: " .. file_path)
	end
end

return FileModule
