---@class Puzzle
local M = {}
M.__index = M

function M:new()
	local instance = setmetatable({}, M)
	return instance
end

local function split_lists(input)
	local list_1 = {}
	local list_2 = {}

	for line in string.gmatch(input, "%d+%s+%d+") do
		local idx = 1

		for number in string.gmatch(line, "%d+") do
			if idx == 1 then
				table.insert(list_1, number)
				idx = idx + 1
			else
				table.insert(list_2, number)
			end
		end
	end

	return list_1, list_2
end

function M:part_1(input)
	local list_1, list_2 = split_lists(input)

	table.sort(list_1)
	table.sort(list_2)

	local total_distance = 0

	for idx = 1, #list_1 do
		local distance = nil

		if list_1[idx] > list_2[idx] then
			distance = list_1[idx] - list_2[idx]
		else
			distance = list_2[idx] - list_1[idx]
		end

		if distance then
			total_distance = total_distance + distance
		end
	end

	return { "Total distance is " .. total_distance }
end

function M:part_2(input)
	local list_1, list_2 = split_lists(input)
	local list_2_str = table.concat(list_2, " ")

	local similarity_score = 0

	for _, number in pairs(list_1) do
		for match in string.gmatch(list_2_str, number) do
			similarity_score = similarity_score + match
		end
	end

	return { "Total similarity score is " .. similarity_score }
end

return M

