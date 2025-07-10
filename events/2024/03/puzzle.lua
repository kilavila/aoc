---@class Puzzle
local M = {
	title = "Day 3: Mull It Over",
}
M.__index = M

function M:new()
	local instance = setmetatable({}, M)
	return instance
end

local function mul_handler(mul)
	local num_1 = nil
	local num_2 = nil

	for number in string.gmatch(mul, "%d+") do
		if not num_1 then
			num_1 = number
		else
			num_2 = number
		end
	end

	local sum = num_1 * num_2
	return sum
end

function M:part_1(input)
	local total_sum = 0

	for match in string.gmatch(input, "mul%(%d%d?%d?%,%d%d?%d?%)") do
		local sum = mul_handler(match)
		total_sum = total_sum + sum
	end

	return { "Mul result is " .. total_sum }
end

function M:part_2(input)
	local total_sum = 0

	input = string.gsub(input, "don't%(%).-do%(%)", "TESTING")

	for match in string.gmatch(input, "mul%(%d%d?%d?%,%d%d?%d?%)") do
		local sum = mul_handler(match)
		total_sum = total_sum + sum
	end

	return { "Mul result is " .. total_sum }
end

return M

