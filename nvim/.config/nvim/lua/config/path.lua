-- path
local paths_to_add = {
    "/opt/homebrew/bin",
    vim.fn.expand("~/.dotnet/tools"),
    vim.fn.expand("~/.cargo/bin"),
    vim.fn.expand("~/.npm-global/bin")
}
for _, p in ipairs(paths_to_add) do
    if not string.find(vim.env.PATH, p, 1, true) then
        vim.env.PATH = p .. ":" .. vim.env.PATH
    end
end
