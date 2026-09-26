vim.bo.makeprg = vim.fn.filereadable("Makefile") == 1 and "make -k" or "clang -std=c11 -Wall -Wextra -g -fsanitize=address %"
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
