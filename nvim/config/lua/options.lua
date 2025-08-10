-- General
vim.opt.mouse = 'a'                -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'  -- Use system clipboard
vim.opt.swapfile = false          -- Don't use swapfile
vim.opt.completeopt = 'menuone,noselect'  -- Better completion experience
vim.opt.conceallevel = 0          -- Make `` visible in markdown files
vim.opt.fileencoding = 'utf-8'    -- Use UTF-8 encoding
vim.opt.hidden = true             -- Enable background buffers
vim.opt.history = 100            -- Remember N lines in history
vim.opt.lazyredraw = true        -- Faster scrolling
vim.opt.synmaxcol = 240          -- Max column for syntax highlight
vim.opt.updatetime = 250         -- Faster completion
vim.opt.timeoutlen = 300        -- Faster key sequence completion

-- UI
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.signcolumn = 'yes'       -- Always show signcolumn
vim.opt.cursorline = true        -- Highlight current line
vim.opt.wrap = false             -- Display long lines as just one line
vim.opt.scrolloff = 8            -- Lines of context
vim.opt.sidescrolloff = 8        -- Columns of context
vim.opt.cmdheight = 1            -- More space for displaying messages
vim.opt.showmode = false         -- Don't show mode since we have a statusline
vim.opt.ruler = false            -- Hide the line and column number of the cursor position
vim.opt.numberwidth = 4          -- Set number column width
vim.opt.pumheight = 10          -- Pop up menu height
vim.opt.showcmd = false         -- Hide (partial) command in the last line of the screen
vim.opt.termguicolors = true    -- True color support

-- Tabs and Indentation
vim.opt.expandtab = true        -- Use spaces instead of tabs
vim.opt.shiftwidth = 2          -- Shift 2 spaces when tab
vim.opt.tabstop = 2             -- 1 tab == 2 spaces
vim.opt.smartindent = true      -- Makes indenting smart
vim.opt.autoindent = true       -- Good auto indent

-- Search
vim.opt.hlsearch = true         -- Highlight search results
vim.opt.ignorecase = true       -- Ignore case in search patterns
vim.opt.smartcase = true        -- Override ignorecase if search pattern contains upper case
vim.opt.incsearch = true        -- Show search matches as you type

-- Splits
vim.opt.splitbelow = true       -- Horizontal splits will automatically be below
vim.opt.splitright = true       -- Vertical splits will automatically be to the right

-- Performance
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = 250
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100

-- Backups
vim.opt.backup = false          -- Don't create backup files
vim.opt.writebackup = false     -- Don't create backup files during write
vim.opt.undofile = true        -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir' -- Set undodir

-- Wild Menu
vim.opt.wildmenu = true        -- Command-line completion
vim.opt.wildmode = 'longest:full,full'  -- Command-line completion mode
vim.opt.wildignore:append { '*/node_modules/*', '*/vendor/*', '*.o', '*.obj', '*.dll', '*.exe' }

-- Format Options
vim.opt.formatoptions:append { 'r', 'o' }  -- Continue comments when pressing ENTER

-- Global Status Line
vim.opt.laststatus = 3         -- Global status line

-- Fold Settings
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable some built-in plugins
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Create required directories
local required_dirs = {
  vim.fn.stdpath('data') .. '/undodir',
  vim.fn.stdpath('data') .. '/backup',
  vim.fn.stdpath('data') .. '/swap',
}

for _, dir in pairs(required_dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end