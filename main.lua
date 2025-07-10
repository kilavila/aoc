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

if part == "1" or part == nil then
	answers = puzzle:part_1(input)

	if not answers then
		print("[Error] Puzzle solution 1 failed, answer not found!")
		os.exit(1)
	end

	print()
	print("[Puzzle 1 Solution]:")
	print()

	for _, answer in pairs(answers) do
		print(string.format("  %s", answer))
	end

	print()
end

if part == "2" or part == nil then
	answers = puzzle:part_2(input)

	if not answers then
		print("[Error] Puzzle solution 2 failed, answer not found!")
		os.exit(1)
	end

	print()
	print("[Puzzle 2 Solution]:")
	print()

	for _, answer in pairs(answers) do
		print(string.format("  %s", answer))
	end

	print()
end
