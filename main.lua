local script_path = arg[0]:match("(.*/)")
package.path = (script_path or "") .. "?.lua;" .. package.path

local FileModule = require("util.file")

local mode, year, day, part = arg[1], arg[2], arg[3], arg[4]

if not part then
	part = "1"
end

if not mode or not year or not day or not part then
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
	print("[Error] Puzzle solution not found!")
	os.exit(1)
end

if part == "1" then
	answers = puzzle:part_1(input)
elseif part == "2" then
	answers = puzzle:part_2(input)
end

if not answers then
	print("[Error] Puzzle failed, answer not found!")
	os.exit(1)
end

print()
print("[Puzzle Solution]:")
print()

for _, answer in pairs(answers) do
	print(string.format("  %s", answer))
end

print()
