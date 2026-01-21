require('nvim-treesitter.configs').setup{
  ensure_installed = {
    "lua", "vim", "vimdoc", "query",
    "javascript", "typescript", "tsx",
    "go", "rust", "python",
    "bash", "fish",
    "markdown", "markdown_inline",
    "yaml", "json", "toml",
    "dockerfile", "terraform",
    "html", "css",
    "git_config", "git_rebase", "gitcommit", "gitignore",
  },
  auto_install = false,

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  },
}
