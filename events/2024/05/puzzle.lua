---@class Puzzle
local M = {
	title = "Day 5: Print Queue",
}
M.__index = M

function M:new()
	local instance = setmetatable({}, M)
	return instance
end

local function extract_rules(input)
	local rules = {}

	for line in string.gmatch(input, "%d+|%d+") do
		table.insert(rules, line)
	end

	return rules
end

local function extract_updates(input)
	local updates = {}

	for line in string.gmatch(input, "[^\n]+\n") do
		if string.find(line, ",") then
			local update = {}

			for number in string.gmatch(line, "%d+") do
				table.insert(update, number)
			end

			table.insert(updates, update)
		end
	end

	return updates
end

local function check_page_number(rules, update, number, index)
	for idx = index, #update do
		local test_rule = update[idx] .. "|" .. number

		for _, rule in pairs(rules) do
			if rule == test_rule then
				return true
			end
		end
	end

	return false
end

local function check_update(rules, update)
	for index, number in pairs(update) do
		local wrong_order = check_page_number(rules, update, number, index)

		if wrong_order then
			return false
		end
	end

	return true
end

function M:part_1(input)
	local rules = extract_rules(input)
	local updates = extract_updates(input)

	local total_sum = 0

	for _, update in pairs(updates) do
		local correctly_ordered = check_update(rules, update)

		if correctly_ordered then
			local mid_num_idx = ((#update - 1) / 2) + 1
			total_sum = total_sum + update[mid_num_idx]
		end
	end

	return { "Sum of middle numbers from correctly ordered updates is " .. total_sum }
end

function M:part_2(input)
	print(input)

	return { "Solution to part 2" }
end

return M
