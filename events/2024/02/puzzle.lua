---@class Puzzle
local M = {
	title = "Day 2: Red-Nosed Reports",
}
M.__index = M

function M:new()
	local instance = setmetatable({}, M)
	return instance
end

local function extract_reports(input)
	local reports = {}

	for line in string.gmatch(input, "[^\n]*\n") do
		line = string.gsub(line, "\n", "")

		local levels = {}

		for number in string.gmatch(line, "%d+") do
			table.insert(levels, number)
		end

		table.insert(reports, levels)
	end

	return reports
end

local function check_levels(report)
	local decreasing = false

	if tonumber(report[1]) > tonumber(report[2]) then
		decreasing = true
	end

	for idx = 1, #report do
		if idx >= #report then
			break
		end

		local diff = nil

		if decreasing then
			diff = tonumber(report[idx]) - tonumber(report[idx + 1])
		else
			diff = tonumber(report[idx + 1]) - tonumber(report[idx])
		end

		if diff < 1 or diff > 3 then
			return false
		end
	end

	return true
end

local function copy_report(report)
	local report_copy = {}

	for _, level_copy in pairs(report) do
		table.insert(report_copy, level_copy)
	end

	return report_copy
end

local function problem_dampener(report)
	for idx, _ in pairs(report) do
		local report_copy = copy_report(report)
		table.remove(report_copy, idx)

		local is_safe = check_levels(report_copy)

		if is_safe then
			return true
		end
	end

	return false
end

function M:part_1(input)
	local reports = extract_reports(input)
	local safe_reports = 0

	for _, report in pairs(reports) do
		local is_safe = check_levels(report)

		if is_safe then
			safe_reports = safe_reports + 1
		end
	end

	return { "Number of safe reports is " .. safe_reports }
end

function M:part_2(input)
	local reports = extract_reports(input)
	local safe_reports = 0

	for _, report in pairs(reports) do
		local is_safe = check_levels(report)

		if is_safe then
			safe_reports = safe_reports + 1
		else
			local dampened_is_safe = problem_dampener(report)

			if dampened_is_safe then
				safe_reports = safe_reports + 1
			end
		end
	end

	return { "Number of safe reports is " .. safe_reports }
end

return M

