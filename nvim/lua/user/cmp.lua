local ok, cmp = pcall(require, "cmp")
if not ok then
    print("cmp not installed")
    return
end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "'",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end


cmp.setup({
    snippet = {},
    mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(0), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            -- todo lua snip
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {"i", "s"}
        ),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            -- todo lua snip
            else
                fallback()
            end
        end, {"i", "s"}
        )

    }),
    formatting = {
        fields = {"kind", "abbr", "menu"},
        	format = function(entry, vim_item)
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "",
				nvim_lua = "",
				luasnip = "",
				buffer = "",
				path = "",
				emoji = "",
			})[entry.source.name]
			return vim_item
		end,
    },
    sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		-- { name = "luasnip" },
		-- { name = "buffer" },
		-- { name = "path" },
	},
    	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = true,
	},
})
