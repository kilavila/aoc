---@class Puzzle
local M = {
	title = "Day 4: Ceres Search",
}
M.__index = M

function M:new()
	local instance = setmetatable({}, M)
	return instance
end

local function get_top_lines(lines, line_idx, char_idx)
	local l0 = lines[line_idx]
	local l1 = lines[line_idx - 1]
	local l2 = lines[line_idx - 2]
	local l3 = lines[line_idx - 3]

	if l0 and l1 and l2 and l3 then
		return l0, l1, l2, l3
	end

	return nil
end

local function get_bottom_lines(lines, line_idx, char_idx)
	local l0 = lines[line_idx]
	local l1 = lines[line_idx + 1]
	local l2 = lines[line_idx + 2]
	local l3 = lines[line_idx + 3]

	if l0 and l1 and l2 and l3 then
		return l0, l1, l2, l3
	end

	return nil
end

local function check_top(lines, line_idx, char_idx)
	local t0, t1, t2, t3 = get_top_lines(lines, line_idx, char_idx)

	if t0 and t1 and t2 and t3 then
		local c0 = t0[char_idx]
		local c1 = t1[char_idx]
		local c2 = t2[char_idx]
		local c3 = t3[char_idx]

		if c0 and c1 and c2 and c3 then
			local xmas = c0 .. c1 .. c2 .. c3

			if xmas == "XMAS" then
				return 1
			end
		end
	end

	return 0
end

local function check_top_right(lines, line_idx, char_idx)
	local t0, t1, t2, t3 = get_top_lines(lines, line_idx, char_idx)

	if t0 and t1 and t2 and t3 then
		local c0 = t0[char_idx]
		local c1 = t1[char_idx + 1]
		local c2 = t2[char_idx + 2]
		local c3 = t3[char_idx + 3]

		if c0 and c1 and c2 and c3 then
			local xmas = c0 .. c1 .. c2 .. c3

			if xmas == "XMAS" then
				return 1
			end
		end
	end

	return 0
end

local function check_right(line, char_idx)
	local c0 = line[char_idx]
	local c1 = line[char_idx + 1]
	local c2 = line[char_idx + 2]
	local c3 = line[char_idx + 3]

	if c0 and c1 and c2 and c3 then
		local xmas = c0 .. c1 .. c2 .. c3

		if xmas == "XMAS" then
			return 1
		end
	end

	return 0
end

local function check_bottom_right(lines, line_idx, char_idx)
	local b0, b1, b2, b3 = get_bottom_lines(lines, line_idx, char_idx)

	if b0 and b1 and b2 and b3 then
		local c0 = b0[char_idx]
		local c1 = b1[char_idx + 1]
		local c2 = b2[char_idx + 2]
		local c3 = b3[char_idx + 3]

		if c0 and c1 and c2 and c3 then
			local xmas = c0 .. c1 .. c2 .. c3

			if xmas == "XMAS" then
				return 1
			end
		end
	end

	return 0
end

local function check_bottom(lines, line_idx, char_idx)
	local b0, b1, b2, b3 = get_bottom_lines(lines, line_idx, char_idx)

	if b0 and b1 and b2 and b3 then
		local c0 = b0[char_idx]
		local c1 = b1[char_idx]
		local c2 = b2[char_idx]
		local c3 = b3[char_idx]

		if c0 and c1 and c2 and c3 then
			local xmas = c0 .. c1 .. c2 .. c3

			if xmas == "XMAS" then
				return 1
			end
		end
	end

	return 0
end

local function check_bottom_left(lines, line_idx, char_idx)
	local b0, b1, b2, b3 = get_bottom_lines(lines, line_idx, char_idx)

	if b0 and b1 and b2 and b3 then
		local c0 = b0[char_idx]
		local c1 = b1[char_idx - 1]
		local c2 = b2[char_idx - 2]
		local c3 = b3[char_idx - 3]

		if c0 and c1 and c2 and c3 then
			local xmas = c0 .. c1 .. c2 .. c3

			if xmas == "XMAS" then
				return 1
			end
		end
	end

	return 0
end

local function check_left(line, char_idx)
	local c0 = line[char_idx]
	local c1 = line[char_idx - 1]
	local c2 = line[char_idx - 2]
	local c3 = line[char_idx - 3]

	if c0 and c1 and c2 and c3 then
		local xmas = c0 .. c1 .. c2 .. c3

		if xmas == "XMAS" then
			return 1
		end
	end

	return 0
end

local function check_top_left(lines, line_idx, char_idx)
	local t0, t1, t2, t3 = get_top_lines(lines, line_idx, char_idx)

	if t0 and t1 and t2 and t3 then
		local c0 = t0[char_idx]
		local c1 = t1[char_idx - 1]
		local c2 = t2[char_idx - 2]
		local c3 = t3[char_idx - 3]

		if c0 and c1 and c2 and c3 then
			local xmas = c0 .. c1 .. c2 .. c3

			if xmas == "XMAS" then
				return 1
			end
		end
	end

	return 0
end

function M:part_1(input)
	local lines = {}

	for line in string.gmatch(input, "[^\n]*\n") do
		line = string.gsub(line, "\n", "")

		local characters = {}

		for char in string.gmatch(line, ".") do
			table.insert(characters, char)
		end

		table.insert(lines, characters)
	end

	local total_xmas = 0

	for line_idx, line in pairs(lines) do
		for char_idx, char in pairs(line) do
			if char == "X" then
				local t = check_top(lines, line_idx, char_idx)
				local tr = check_top_right(lines, line_idx, char_idx)
				local r = check_right(line, char_idx)
				local br = check_bottom_right(lines, line_idx, char_idx)
				local b = check_bottom(lines, line_idx, char_idx)
				local bl = check_bottom_left(lines, line_idx, char_idx)
				local l = check_left(line, char_idx)
				local tl = check_top_left(lines, line_idx, char_idx)

				total_xmas = total_xmas + t + tr + r + br + b + bl + l + tl
			end
		end
	end

	return { "XMAS appears " .. total_xmas .. " times" }
end

function M:part_2(input)
	local lines = {}

	for line in string.gmatch(input, "[^\n]*\n") do
		line = string.gsub(line, "\n", "")

		local characters = {}

		for char in string.gmatch(line, ".") do
			table.insert(characters, char)
		end

		table.insert(lines, characters)
	end

	local total_xmas = 0

	for line_idx, line in pairs(lines) do
		for char_idx, char in pairs(line) do
			if char == "A" then
				local top_line = lines[line_idx - 1]
				local bottom_line = lines[line_idx + 1]

				if top_line and bottom_line then
					local top_left = top_line[char_idx - 1]
					local top_right = top_line[char_idx + 1]
					local bottom_right = bottom_line[char_idx + 1]
					local bottom_left = bottom_line[char_idx - 1]

					if top_left and top_right and bottom_right and bottom_left then
						local str_1 = top_left .. char .. bottom_right
						local str_2 = top_right .. char .. bottom_left

						if str_1 == "MAS" or str_1 == "SAM" then
							if str_2 == "MAS" or str_2 == "SAM" then
								total_xmas = total_xmas + 1
							end
						end
					end
				end
			end
		end
	end

	return { "XMAS appears " .. total_xmas .. " times" }
end

return M

