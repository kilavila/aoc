---@meta

---@class FileModule
---@field new fun(self: FileModule): FileModule
---@field get_content fun(self: FileModule, file_path: string): string|nil
---@field new_event fun(self: FileModule, year: string, day: string): nil

---@class Puzzle
---@field new fun(self: Puzzle): Puzzle
---@field part_1 fun(self: Puzzle, input: string): string[]
---@field part_2 fun(self: Puzzle, input: string): string[]
