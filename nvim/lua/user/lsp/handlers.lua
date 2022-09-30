local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = false,
		underline = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local imap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
	end
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, noremap = true, desc = desc })
	end
	nmap("gd", vim.lsp.buf.declaration, "[G]oto [D]efinition")
	nmap("gD", vim.lsp.buf.definition, "[G]oto [D]eclaration")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
	nmap("<C-p>", vim.lsp.buf.signature_help, "[N]Signature Documentation")
	imap("<C-p>", vim.lsp.buf.signature_help, "[I]Signature Documentation")

	--diagnostic
	nmap("<leader>e", vim.diagnostic.open_float, "show line diagnostic")
	nmap("<leader>x", vim.diagnostic.goto_next, "Next Diagnostic")
	nmap("<leader>X", vim.diagnostic.goto_prev, "Next Diagnostic")

	nmap("<leader>lf", vim.lsp.buf.formatting, "Foramt language")
	--nmap("<leader>li", LspInfo, 'LSP Info')
	--nmap("<leader>lI", LspInstallInfo, 'Lsp Install Info')
	nmap("<leader>la", vim.lsp.buf.code_action, "Lsp Code Action")
	nmap("<leader>lr", vim.lsp.buf.rename, "Lsp Rename")
	nmap("<leader>lq", vim.diagnostic.setloclist, "unknown")
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M
