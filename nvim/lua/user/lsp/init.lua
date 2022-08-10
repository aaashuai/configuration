local ok, _ = pcall(require, "lspconfig")
if not ok then
    print("lspconfig not installed")
end

require "user.lsp.lsp-installer"
--require("lsp.handlers").setup()
--require("lsp.null-ls")


