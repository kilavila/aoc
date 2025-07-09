---@class Puzzle
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

return M
