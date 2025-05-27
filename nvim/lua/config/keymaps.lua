-- Key mappings

-- General editor mappings
vim.keymap.set('n', 'WW', ':w!<CR>', { noremap = true, desc = "Force save" })
vim.keymap.set('n', 'Q', 'gqap', { noremap = true, desc = "Format paragraph" })
vim.keymap.set('v', 'Q', 'gq', { noremap = true, desc = "Format selection" })

-- Better navigation for wrapped lines
vim.keymap.set('n', 'j', 'gj', { noremap = true, desc = "Move down (visual line)" })
vim.keymap.set('n', 'k', 'gk', { noremap = true, desc = "Move up (visual line)" })
vim.keymap.set('v', 'j', 'gj', { noremap = true, desc = "Move down (visual line)" })
vim.keymap.set('v', 'k', 'gk', { noremap = true, desc = "Move up (visual line)" })
vim.keymap.set('n', '<Down>', 'gj', { noremap = true, desc = "Move down (visual line)" })
vim.keymap.set('n', '<Up>', 'gk', { noremap = true, desc = "Move up (visual line)" })
vim.keymap.set('v', '<Down>', 'gj', { noremap = true, desc = "Move down (visual line)" })
vim.keymap.set('v', '<Up>', 'gk', { noremap = true, desc = "Move up (visual line)" })
vim.keymap.set('i', '<Down>', '<C-o>gj', { noremap = true, desc = "Move down (visual line)" })
vim.keymap.set('i', '<Up>', '<C-o>gk', { noremap = true, desc = "Move up (visual line)" })

-- Path expansion
vim.keymap.set('c', '%%', "<C-R>=expand('%:h').'/'<cr>", { noremap = true, desc = "Expand to current file's directory" })
vim.keymap.set('n', '<leader>e', ':edit %%', { noremap = true, desc = "Edit file in same directory" })
vim.keymap.set('n', '<leader>V', ':view %%', { noremap = true, desc = "View file in same directory" })

-- Telescope search mappings
vim.keymap.set("n", "<Leader>g", function()
  require("telescope.builtin").live_grep({ prompt_title = "Search CWD", path_display = { "smart" } })
end, { desc = "Search current directory" })

vim.keymap.set("n", "<Leader>N", function()
  require("telescope.builtin").live_grep({
    prompt_title = "Find TODOs",
    default_text = "TODO|FIXME|CHANGED|NOTE",
  })
end, { desc = "Find TODOs, FIXMEs, etc." })

-- Alternative file finder keys (since <C-p> is now for Legendary)
vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').find_files({ hidden = true })
end, { noremap = true, desc = "Find files (Telescope)" })

-- Buffer management
vim.keymap.set('n', '<C-t>', ':enew<CR>', { noremap = true, desc = "New buffer" })
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, desc = "Next buffer" })
vim.keymap.set('n', '<C-h>', ':bprevious<CR>', { noremap = true, desc = "Previous buffer" })
vim.keymap.set('n', '<leader>x', ':bp <BAR> bd #<CR>', { noremap = true, desc = "Close buffer without closing window" })
vim.keymap.set('n', '<leader>bl', ':ls<CR>', { noremap = true, desc = "List buffers" })

-- RI Documentation lookup for Ruby
vim.keymap.set('n', ',di', ':call ri#OpenSearchPrompt(0)<cr>', { noremap = true, desc = "RI documentation lookup" })
vim.keymap.set('n', ',DI', ':call ri#OpenSearchPrompt(1)<cr>',
  { noremap = true, desc = "RI documentation lookup (vertical)" })
vim.keymap.set('n', ',DK', ':call ri#LookupNameUnderCursor()<cr>',
  { noremap = true, desc = "RI lookup word under cursor" })

-- Clear search highlighting
vim.keymap.set('n', '<CR>', ':nohlsearch<cr>', { noremap = true, desc = "Clear search highlighting" })

-- Toggle 'set list' (display invisible characters)
vim.keymap.set('n', '<leader>l', ':set list!<cr>', { noremap = true, desc = "Toggle invisible characters" })

-- Toggle spell checking
vim.keymap.set('n', '<F9>', ':setlocal spell! spelllang=en_us<CR>', { noremap = true, desc = "Toggle spell checking" })

-- Custom functions
vim.keymap.set('n', '<leader>.', ':lua tulpa.open_test_alternate()<CR>',
  { desc = "Switch between test and implementation" })
vim.keymap.set('n', '<leader>s', ':lua tulpa.strip_whitespace()<CR>', { desc = "Strip trailing whitespace" })
vim.keymap.set('n', '<leader>n', ':lua tulpa.rename_file()<CR>', { desc = "Rename current file" })
