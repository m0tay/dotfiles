vim.opt.wrap = true
vim.opt.wrapmargin = 0
vim.opt.textwidth = 0
vim.opt.formatoptions:remove { 't' }
vim.opt.spell = true
vim.opt.spelllang = [[en,pt]]
vim.bo.makeprg = [[typst compile --diagnostic-format short %]]

vim.cmd [[TypstPreviewFollowCursor]]

local snippets = {
  md = "\\$ $1 \\$", -- math display
  mi = "\\$$1\\$",   -- math inline
  le = "#align(left)[$1]",
  ri = "#align(right)[$1]",
  ce = "#align(center)[$1]",
  cl = "#align(center, block[\n\t#set align(left)\n\t$1\n])",
  cr = "#align(center, block[\n\t#set align(right)\n\t$1\n])",
  ho = "#align(horizontal)[$1]",
  ve = "#align(vertical)[$1]",
  fp = "#page(flipped: true)[\n\t$1\n]",
  lv = "#let $1 = $2",
  lf = "#let $1 = ($2) => {\n\t$3\n}",
}

for key, body in pairs(snippets) do
  vim.keymap.set('i', ';' .. key, function()
    vim.snippet.expand(body)
  end, { buffer = true })
end

vim.fn.setreg('h', [[I=]]) -- add = to start

vim.lsp.enable [[typst_lsp]]
