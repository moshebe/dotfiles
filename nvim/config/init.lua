-- Disable netrw before anything else
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('options')
require('plugins')
require('mapping')
require('treesitter')

vim.cmd [[
	autocmd! User GoyoEnter Limelight
	autocmd! User GoyoLeave Limelight!
]]

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  command = "lua vim.lsp.buf.format()",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lua", "ruby", "yaml", "html", "json"},
  command = "setlocal shiftwidth=2 sts=2 expandtab smartindent",
})

