vim.o.wrap = true
vim.o.wrapmargin = 8
vim.o.spell = true
vim.cmd[[TypstPreviewFollowCursor]]
vim.o.spelllang = [[en,pt]]

local snippets = {
  md = "$  $<Left><Left>", -- math display
  mi = "$$<Left>",         -- math inline
}
for key, body in pairs(snippets) do
  vim.keymap.set('i', ';' .. key, body, { buffer = true })
end
