local ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
if not ok then
    print("treesitter not installed")
    return
end

treesitter_config.setup({
	ensure_installed = {"c", "lua", "javascript", "python", "go", "yaml", "json", "bash", "vue", "vim"}, -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
})
