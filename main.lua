local script_path = arg[0]:match("(.*/)")
package.path = (script_path or "") .. "?.lua;" .. package.path

local FileModule = require("util.file")

local mode, year, day, part = arg[1], arg[2], arg[3], arg[4]

if not mode or not year or not day then
	print("[Error] Missing argument!")
	print("Usage: aoc <type> <year> <day> <part>")
	print("Example: aoc test 2024 04 1")
	print("Example: aoc run 2024 04 1")

	os.exit(1)
end

local file = FileModule:new()

if mode == "new" then
	file:new_event(year, day)
	os.exit(0)
end

local path = arg[0]
path = path:gsub("main.lua", "")
local current_event = {
	input = path .. "events/" .. year .. "/" .. day .. "/input.txt",
	test_input = path .. "events/" .. year .. "/" .. day .. "/input.test.txt",
	puzzle = require("events." .. year .. "." .. day .. ".puzzle"),
}

local input = nil

if mode == "run" then
	input = file:get_content(current_event.input)
elseif mode == "test" then
	input = file:get_content(current_event.test_input)
else
	print("[Error] Invalid mode, use; new, test or run")
	os.exit(1)
end

if not input then
	os.exit(1)
end

local puzzle = nil
local answers = nil

puzzle = current_event.puzzle:new()

if not puzzle then
	print("[Error] Puzzle module not found!")
	os.exit(1)
end

print()
print("\27[32mAdvent of Code")
print("\27[30m{'year':\27[32m" .. year .. "\27[30m}\27[0m")
print()
print("--- " .. puzzle.title .. " ---")
print()

if part == "1" or part == nil then
	local time = {
		["start"] = os.clock(),
		["end"] = nil,
	}

	answers = puzzle:part_1(input)

	time["end"] = os.clock()

	if not answers then
		print("[Error] Puzzle solution 1 failed, answer not found!")
		os.exit(1)
	end

	print()
	print("---\27[34m Part One \27[0m--- [\27[31m" .. (time["end"] - time["start"]) * 1000 .. "ms\27[0m]")
	print()

	for _, answer in pairs(answers) do
		print(string.format("  \27[33m%s\27[0m", answer))
	end

	print()
end

if part == "2" or part == nil then
	local time = {
		["start"] = os.clock(),
		["end"] = nil,
	}

	answers = puzzle:part_2(input)

	time["end"] = os.clock()

	if not answers then
		print("[Error] Puzzle solution 2 failed, answer not found!")
		os.exit(1)
	end

	print()
	print("---\27[34m Part Two \27[0m--- [\27[31m" .. (time["end"] - time["start"]) * 1000 .. "ms\27[0m]")
	print()

	for _, answer in pairs(answers) do
		print(string.format("  \27[33m%s\27[0m", answer))
	end

	print()
end
