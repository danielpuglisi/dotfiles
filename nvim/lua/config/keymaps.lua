-- Key mappings
vim.keymap.set('n', 'WW', ':w!<CR>', { noremap = true })
vim.keymap.set('n', 'Q', 'gqap', { noremap = true })
vim.keymap.set('v', 'Q', 'gq', { noremap = true })
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })
vim.keymap.set('v', 'j', 'gj', { noremap = true })
vim.keymap.set('v', 'k', 'gk', { noremap = true })
vim.keymap.set('n', '<Down>', 'gj', { noremap = true })
vim.keymap.set('n', '<Up>', 'gk', { noremap = true })
vim.keymap.set('v', '<Down>', 'gj', { noremap = true })
vim.keymap.set('v', '<Up>', 'gk', { noremap = true })
vim.keymap.set('i', '<Down>', '<C-o>gj', { noremap = true })
vim.keymap.set('i', '<Up>', '<C-o>gk', { noremap = true })

vim.keymap.set('c', '%%', "<C-R>=expand('%:h').'/'<cr>", { noremap = true })
vim.keymap.set('n', '<leader>e', ':edit %%', { noremap = true })
vim.keymap.set('n', '<leader>V', ':view %%', { noremap = true })

vim.keymap.set('n', '<leader>N', ":Ag --ignore-dir=log 'TODO\\|FIXME\\|CHANGED\\|NOTE' *<CR>", { noremap = true })

-- Buffer management
vim.keymap.set('n', '<C-t>', ':enew<CR>', { noremap = true })
vim.keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true })
vim.keymap.set('n', '<C-h>', ':bprevious<CR>', { noremap = true })
vim.keymap.set('n', '<leader>x', ':bp <BAR> bd #<CR>', { noremap = true })
vim.keymap.set('n', '<leader>bl', ':ls<CR>', { noremap = true })

-- Commentary
vim.keymap.set('n', '\\\\', ':Commentary<CR>', { noremap = true })
vim.keymap.set('v', '\\\\', ':Commentary<CR>', { noremap = true })

-- RI Documentation lookup
vim.keymap.set('n', ',di', ':call ri#OpenSearchPrompt(0)<cr>', { noremap = true })
vim.keymap.set('n', ',DI', ':call ri#OpenSearchPrompt(1)<cr>', { noremap = true })
vim.keymap.set('n', ',DK', ':call ri#LookupNameUnderCursor()<cr>', { noremap = true })

-- Clear search buffer
vim.keymap.set('n', '<CR>', ':nohlsearch<cr>', { noremap = true })

-- Toggle 'set list'
vim.keymap.set('n', '<leader>l', ':set list!<cr>', { noremap = true })

-- Goyo & Pencil
vim.keymap.set('n', '<F10>', ':Goyo <bar> :TogglePencil <CR>', { noremap = true })
vim.keymap.set('n', '<F9>', ':setlocal spell! spelllang=en_us<CR>', { noremap = true })

-- FZF
vim.keymap.set('n', '<C-p>', ':FZF<CR>')

-- NERDTree
vim.g.NERDTreeMinimalMenu = 1
vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>')

-- Functions
vim.keymap.set('n', '<leader>.', ':lua tulpa.open_test_alternate()<CR>')
vim.keymap.set('n', '<leader>s', ':lua tulpa.strip_whitespace()<CR>')
vim.keymap.set('n', '<leader>n', ':lua tulpa.rename_file()<CR>')
