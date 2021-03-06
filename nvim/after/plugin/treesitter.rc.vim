if !exists('g:loaded_nvim_treesitter')
  echo "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "toml",
    "json",
    "yaml",
    "python",
    "c",
    "lua",
    "go",
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.python.used_by = { "python" }
EOF

