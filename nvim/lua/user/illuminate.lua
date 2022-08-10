-- vim.g.Illuminate_ftblacklist = {'alpha', 'NvimTree'}
vim.g.Illuminate_ftwhitelist = {'vim', 'sh', 'python', 'lua'}

vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
