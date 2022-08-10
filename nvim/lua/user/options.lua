-- [[ Setting options ]]
-- See `:help vim.o`

-- Set colorschema
vim.o.termguicolors = true
vim.cmd([[colorscheme onedark]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Make line numbers default
vim.o.nu = true
vim.o.rnu = true

-- Save undo history
vim.o.undofile = true
-- Create bakcup file
-- vim.o.backup = false
vim.o.backupskip = "/tmp/*,~/tmp/*"
-- no swapfile
vim.o.swapfile = false
-- encoding
vim.scriptencoding = "utf-8"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
-- highlight all matches on previous search pattern
vim.o.hlsearch = true
-- always show tabs
vim.o.showtabline = 1
-- make indenting smarter again
vim.o.smartindent = true
vim.o.autoindent = true
-- smart case
vim.o.smartcase = true
-- force all horizontal splits to go below current window
vim.o.splitbelow = true
-- force all vertical splits to go to the right of current window
vim.o.splitright = true
-- faster write to file(default 4000ms)
vim.o.updatetime = 300
-- convert tab to space
vim.o.expandtab = true
-- display lines as one long line
vim.o.wrap = false
-- always show the sign column
vim.o.signcolumn = "yes"
-- keep x lines in the end when scroll down and scroll left
vim.o.scrolloff = 999
vim.o.sidescrolloff = 8
-- show typing command on status bar
vim.o.showcmd = true
vim.o.timeoutlen = 1000

vim.o.cmdheight = 1
vim.o.shell = "zsh"
vim.o.title = true
vim.o.inccommand = "split"

vim.o.smarttab = true -- use with shiftwidth, front of a line, use shiftwidth. in other places, use tabstop or softtabstop
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.breakindent = true -- vague

vim.o.wildignore = "*/node_modules/*,*/__pycache__/*,*/venv/*"

vim.o.clipboard = "unnamedplus"

-- [[ highlight ]]
-- highlight the current line
vim.o.cursorline = true
vim.o.pumblend = 5
vim.o.background = "dark"
