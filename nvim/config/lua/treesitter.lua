local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

configs.setup{
  ensure_installed = 'all',
  ignore_install = {
    'phpdoc' -- phpdoc has issues with ARM64
  },

  highlight = {
    enable = true,
  },

  context_commentstring = {
    enable = true
  },
}
