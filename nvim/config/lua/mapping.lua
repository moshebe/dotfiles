local map = vim.keymap.set

-- General
map('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit' })
map('n', '<leader>h', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
map('n', '<C-s>', '<cmd>write<cr>', { desc = 'Save file' })

-- Better window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize with arrows
map('n', '<C-Up>', ':resize -2<CR>', { desc = 'Resize window up' })
map('n', '<C-Down>', ':resize +2<CR>', { desc = 'Resize window down' })
map('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize window left' })
map('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize window right' })

-- Better indenting
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- Move selected line / block of text in visual mode
map('x', 'K', ":move '<-2<CR>gv-gv", { desc = 'Move selection up' })
map('x', 'J', ":move '>+1<CR>gv-gv", { desc = 'Move selection down' })

-- Better terminal navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h', { desc = 'Terminal: move to left window' })
map('t', '<C-j>', '<C-\\><C-N><C-w>j', { desc = 'Terminal: move to lower window' })
map('t', '<C-k>', '<C-\\><C-N><C-w>k', { desc = 'Terminal: move to upper window' })
map('t', '<C-l>', '<C-\\><C-N><C-w>l', { desc = 'Terminal: move to right window' })

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help tags' })
map('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent files' })
map('n', '<leader>fc', '<cmd>Telescope commands<cr>', { desc = 'Commands' })
map('n', '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', { desc = 'Document symbols' })
map('n', '<leader>fw', '<cmd>Telescope lsp_workspace_symbols<cr>', { desc = 'Workspace symbols' })

-- Neo-tree
map('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle file explorer' })
map('n', '<leader>o', '<cmd>Neotree focus<cr>', { desc = 'Focus file explorer' })

-- Buffer navigation
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', '<leader>c', '<cmd>bdelete<cr>', { desc = 'Close buffer' })

-- Git
map('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
map('n', '<leader>gj', '<cmd>lua require("gitsigns").next_hunk()<cr>', { desc = 'Next git hunk' })
map('n', '<leader>gk', '<cmd>lua require("gitsigns").prev_hunk()<cr>', { desc = 'Previous git hunk' })
map('n', '<leader>gl', '<cmd>lua require("gitsigns").blame_line()<cr>', { desc = 'View git blame' })
map('n', '<leader>gp', '<cmd>lua require("gitsigns").preview_hunk()<cr>', { desc = 'Preview git hunk' })
map('n', '<leader>gh', '<cmd>DiffviewFileHistory<cr>', { desc = 'File history' })
map('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diff view' })

-- LSP
map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Format' })
map('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP info' })
map('n', '<leader>lI', '<cmd>Mason<cr>', { desc = 'Mason info' })

-- Diagnostics
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { desc = 'Toggle diagnostics' })
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { desc = 'Workspace diagnostics' })
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { desc = 'Document diagnostics' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Terminal
map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Float terminal' })
map('n', '<leader>th', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', { desc = 'Horizontal terminal' })
map('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<cr>', { desc = 'Vertical terminal' })

-- Markdown
map('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'Markdown preview' })

-- Database
map('n', '<leader>db', '<cmd>DBUIToggle<cr>', { desc = 'Toggle database UI' })

-- Comments
map('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<cr>', { desc = 'Toggle comment' })
map('x', '<leader>/', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>', { desc = 'Toggle comment' })