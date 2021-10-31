if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive' " git
Plug 'tpope/vim-rhubarb'  " git
Plug 'morhetz/gruvbox'    " schema
Plug 'cohama/lexima.vim'  " auto close ()
Plug 'preservim/nerdtree' " file explore
Plug 'preservim/tagbar'   " tag bar
Plug 'mhinz/vim-startify' " startup page
Plug 'tpope/vim-surround'  " surround edit


if has("nvim")
  Plug 'hoob3rt/lualine.nvim'  " status lie
  " Plug 'kristijanhusak/defx-git'
  " Plug 'kristijanhusak/defx-icons'
  " Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }  " file explore
  Plug 'neovim/nvim-lspconfig'  " lsp
  " Plug 'glepnir/lspsaga.nvim'  " lsp popup tips; fixed by bellow
  Plug 'jasonrhansen/lspsaga.nvim', {'branch': 'finder-preview-fixes'}
  Plug 'folke/lsp-colors.nvim' 
  Plug 'nvim-lua/completion-nvim'  " auto completion
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } 
  Plug 'kyazdani42/nvim-web-devicons' " icons
  Plug 'nvim-lua/popup.nvim' 
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'  " quick search
  Plug 'windwp/nvim-autopairs'  " auto pairs
  " Plug 'karb94/neoscroll.nvim'   " speed slow
  " bufferline ?
endif

call plug#end()

