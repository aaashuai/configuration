local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
    print("nvim-lsp-installer not installed")
end

local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
}

lsp_installer.setup {
    ensure_installed=servers;
}

local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    print("lspconfig not installed")
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        on_capabilities = require("user.lsp.handlers").on_capabilities,
    }
    if server == "sumneko_lua" then
      local sumneko_opts = require "user.lsp.settings.sumneko_lua"
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end
    lspconfig[server].setup(opts)

end
