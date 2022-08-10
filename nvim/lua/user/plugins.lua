-- region Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("packer not installed")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}


return packer.startup(function(use)
    use {'wbthomason/packer.nvim', commit="afab89594f4f702dc3368769c95b782dbdaeaf0a"}                                                    -- Package manager

    -- git
    use {'tpope/vim-fugitive', commit="66a921bbe38bea19f6b581c8a56d5a8a41209e35"}                                                        -- Git commands in nvim
    use { 'lewis6991/gitsigns.nvim', requires = {
            'nvim-lua/plenary.nvim', commit="31807eef4ed574854b8a53ae40ea3292033a78ea"
        }, commit = "9c3ca027661136a618c82275427746e481c84a4e" }       -- Add git related info in the signs columns and popups

    -- colorschema
    use {'mjlbach/onedark.nvim', commit = 'e5e6b1e66ade328c201374ec3c9d0f9b4be23394'}                                                      -- Theme inspired by Atom

    -- cmp plugins
    use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
    use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
    use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

    -- lsp
    use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" } -- enable LSP
    use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
    use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters
    -- use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }
    -- others
    use "kylechui/nvim-surround"


  if is_bootstrap then
    require('packer').sync()
  end
end)

