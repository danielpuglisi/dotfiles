--- Color
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = "red" })
vim.cmd([[
  au ColorScheme * highlight ExtraWhitespace guibg=red
  au BufEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhiteSpace /\s\+$/
]])

-- Plugin configurations
vim.g.vroom_use_colors = 1
vim.g.vroom_use_vimux = 1
vim.g.vroom_map_keys = 0
vim.g.vroom_clear_screen = 0
vim.g.vroom_use_bundle_exec = 0
vim.g.vroom_test_unit_command = 'bin/rails test'

vim.g.NERDTreeMinimalMenu = 1

vim.g.ackprg = 'ag --vimgrep --smart-case'

-- Color configuration
if vim.fn.has("nvim") == 1 then
  vim.opt.termguicolors = true
end

-- Load colorscheme
vim.g.base16colorspace = 256
local colors_name = vim.g.colors_name or ''
if colors_name ~= 'base16-eighties' then
  vim.cmd('colorscheme base16-eighties')
end
-- vim.cmd([[colorscheme base16-default-dark]])
--
