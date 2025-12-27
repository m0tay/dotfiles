if vim.b.current_compiler == nil then
  vim.cmd [[compiler javac]]
end

local filename = vim.fn.expand("%:t:r")
if filename == "" then
  return
end

local package_name = nil
local lines = vim.fn.getline(1, math.min(20, vim.fn.line("$")))
for _, line in ipairs(lines) do
  local pkg = line:match("^%s*package%s+([%w%.]+)%s*;")
  if pkg then
    package_name = pkg
    break
  end
end

local main_class
if package_name then
  main_class = package_name .. "." .. filename
else
  main_class = filename
end

local makefile_content = {
  "MAIN = " .. main_class,
  "SRC = " .. filename .. ".java",
  "BIN = bin",
  "",
  "all:",
  "\tmkdir -p $(BIN)",
  "\tjavac -d $(BIN) $(SRC)",
  "",
  "run: all",
  "\tjava -cp $(BIN) $(MAIN)",
  "",
  "clean:",
  "\trm -rf $(BIN)",
  "",
}

-- vim.fn.writefile(vim.tbl_map(tostring, makefile_content), "Makefile")

