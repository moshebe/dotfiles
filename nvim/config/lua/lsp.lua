-- LSP servers configs using new vim.lsp.config API (Neovim 0.11+)
local servers = {
  'gopls',
  'buf_ls',
  'jsonls',
  'html',
  'cssls',
  'vuels',
  'yamlls',
  'ts_ls',
  'bashls',
  'terraformls',
  'sqlls',
}

for _, server in ipairs(servers) do
  vim.lsp.config[server] = {}
  vim.lsp.enable(server)
end
