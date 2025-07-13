---@class Puzzle
local M = {
	title = "Day 6: Guard Gallivant",
}
M.__index = M

function M:new()
	local instance = setmetatable({}, M)
	return instance
end

local function extract_map(input)
	local map = {}

	for line in string.gmatch(input, "[^\n]+\n") do
		line = string.gsub(line, "\n", "")
		table.insert(map, line)
	end

	return map
end

local function get_start_position(map, current)
	for row, line in pairs(map) do
		local col = string.find(line, current.direction)

		if col then
			return row, col
		end
	end

	return nil
end

local function move_up(map, current)
	while true do
		if current.row - 1 <= 0 then
			map[current.row] = string.gsub(map[current.row], current.direction, "X")
			return map, current, true
		end

		local next_pos = string.sub(map[current.row - 1], current.col, current.col)

		if next_pos == "#" then
			current.direction = ">"
			map[current.row] = string.gsub(map[current.row], "%^", ">")
			break
		else
			local line_table = {}

			for char in string.gmatch(map[current.row - 1], ".") do
				table.insert(line_table, char)
			end

			line_table[current.col] = "^"
			map[current.row - 1] = table.concat(line_table, "")

			map[current.row] = string.gsub(map[current.row], current.direction, "X")

			current.row = current.row - 1
		end
	end

	return map, current, false
end

local function move_right(map, current)
	local current_line = {}

	for char in string.gmatch(map[current.row], ".") do
		table.insert(current_line, char)
	end

	for idx = current.col, #current_line do
		if idx == #current_line then
			current_line[idx] = "X"
			map[current.row] = table.concat(current_line, "")
			return map, current, true
		end

		local next_pos = current_line[idx + 1]

		if next_pos == "#" then
			current.direction = "v"
			current.col = idx
			current_line[idx] = current.direction
			break
		else
			current_line[idx] = "X"
			current_line[idx + 1] = ">"
		end
	end

	map[current.row] = table.concat(current_line, "")

	return map, current, false
end

local function move_down(map, current)
	while true do
		if current.row + 1 > #map then
			map[current.row] = string.gsub(map[current.row], current.direction, "X")
			return map, current, true
		end

		local next_pos = string.sub(map[current.row + 1], current.col, current.col)

		if next_pos == "#" then
			current.direction = "<"
			map[current.row] = string.gsub(map[current.row], "[v]", "<")
			break
		else
			local line_table = {}

			for char in string.gmatch(map[current.row + 1], ".") do
				table.insert(line_table, char)
			end

			line_table[current.col] = "v"
			map[current.row + 1] = table.concat(line_table, "")

			map[current.row] = string.gsub(map[current.row], current.direction, "X")

			current.row = current.row + 1
		end
	end

	return map, current, false
end

local function move_left(map, current)
	local current_line = {}

	for char in string.gmatch(string.reverse(map[current.row]), ".") do
		table.insert(current_line, char)
	end

	local rev_idx = #current_line - current.col + 1

	for idx = rev_idx, #current_line do
		if idx == #current_line then
			current_line[idx] = "X"
			map[current.row] = string.reverse(table.concat(current_line, ""))
			return map, current, true
		end

		local next_pos = current_line[idx + 1]

		if next_pos == "#" then
			current.direction = "%^"
			current_line[idx] = "^"
			break
		else
			current_line[idx] = "X"
			current_line[idx + 1] = "<"
		end
	end

	map[current.row] = string.reverse(table.concat(current_line, ""))

	current_line = {}
	for char in string.gmatch(map[current.row], ".") do
		table.insert(current_line, char)
	end

	for idx, char in pairs(current_line) do
		if char == "^" then
			current.col = idx
		end
	end

	return map, current, false
end

function M:part_1(input)
	local map = extract_map(input)

	local current = {
		row = nil,
		col = nil,
		direction = "%^",
	}

	current.row, current.col = get_start_position(map, current)

	if not current.row or not current.col then
		print("[Error] Could not find starting position!")
	end

	local exited_map = false

	while not exited_map do
		if current.direction == "%^" then
			map, current, exited_map = move_up(map, current)
		elseif current.direction == ">" then
			map, current, exited_map = move_right(map, current)
		elseif current.direction == "v" then
			map, current, exited_map = move_down(map, current)
		elseif current.direction == "<" then
			map, current, exited_map = move_left(map, current)
		else
			print()
			print("[Error] Not a valid direction!")
			break
		end
	end

	local total_positions = 0

	for _, line in pairs(map) do
		for _ in string.gmatch(line, "X") do
			total_positions = total_positions + 1
		end
	end

	return { "Total distinct positions visited by the guard is " .. total_positions }
end

function M:part_2(input)
	print(input)

	return { "Solution to part 2" }
end

return M

