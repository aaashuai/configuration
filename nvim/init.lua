-- region Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'                                                    -- Package manager

    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- Add git related info in the signs columns and popups
    use 'tpope/vim-fugitive'                                                        -- Git commands in nvim

    use 'mjlbach/onedark.nvim'                                                      -- Theme inspired by Atom

  if is_bootstrap then
    require('packer').sync()
  end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


-- [[ Setting options ]]
-- See `:help vim.o`

-- Set colorschema
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

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
vim.o.inccommand = 'split'

vim.o.smarttab = true  -- use with shiftwidth, front of a line, use shiftwidth. in other places, use tabstop or softtabstop
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.breakindent = true -- vague

vim.o.wildignore = "*/node_modules/*,*/__pycache__/*,*/venv/*"

vim.o.clipboard = 'unnamedplus'

-- [[ highlight ]]
-- highlight the current line
vim.o.cursorline = true
vim.o.pumblend = 5
vim.o.background = 'dark'


-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
local keymap = vim.keymap.set
local opts = { silent = true }
keymap("", "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Normal --

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-a>", "gg<S-v>G")

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)


-- gitsigns
local ok, gitsigns = pcall(require, "gitsigns")
if ok then
  gitsigns.setup {
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
      interval = 1000,
      follow_files = true
  },
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
    }
else
    print("gitsigns not install")
end















