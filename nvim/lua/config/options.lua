-- Basic Neovim settings
vim.g.mapleader = ","

vim.cmd('filetype off')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

vim.opt.compatible = false
vim.opt.autoindent = true
vim.opt.cursorcolumn = false
vim.opt.cursorline = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.cmdheight = 1
vim.opt.encoding = 'utf-8'
vim.opt.expandtab = true
vim.opt.formatoptions:append('n')
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.history = 1000
vim.opt.lazyredraw = false
vim.opt.showcmd = false
vim.opt.smarttab = false
vim.opt.startofline = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.report = 0
vim.opt.scrolloff = 3
vim.opt.shell = 'zsh'
vim.opt.shiftwidth = 2
vim.opt.shortmess = 'filtIoOA'
vim.opt.showmatch = true
vim.opt.showtabline = 1
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.switchbuf = 'useopen'
vim.opt.tabstop = 4
vim.opt.virtualedit = 'block'
vim.opt.whichwrap:append('<,>,h,l,[,]')
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest,list'
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevelstart = 20

-- Status line
vim.opt.statusline = "%<%f\\ (%{&ft})\\ %-4(%m%)%=%-19(%3l,%02c%03V%)"

-- Store temporary files in a central spot
vim.opt.backupdir = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'
vim.opt.directory = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'

-- Color configuration
-- if vim.fn.has("nvim") == 1 then
--   vim.opt.termguicolors = true
-- end

-- if vim.fn.filereadable(vim.fn.expand("~/.config/nvim/vimrc_background")) == 1 then
--   vim.g.base16colorspace = 256
--   vim.cmd('source ~/.config/nvim/vimrc_background')
-- end

-- Vroom configuration
vim.g.vroom_map_keys = 1
vim.g.vroom_use_colors = 1
vim.g.vroom_use_vimux = 1
vim.g.vroom_use_terminal = 0
vim.g.vroom_clear_screen = 0
vim.g.vroom_test_unit_command = 'bin/rails test'
vim.g.vroom_use_bundle_exec = 0

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', ':VroomRunTestFile<CR>', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>R', ':VroomRunNearestTest<CR>', { noremap = true })
  end
})

-- ag configuration
vim.g.ackprg = 'ag --vimgrep --smart-case'
vim.cmd([[
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
]])

-- GUI settings
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "Inconsolata:h14"
  vim.opt.wrap = true
  vim.opt.linebreak = true
end

-- Neomake
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*" },
  command = "Neomake"
})

-- CoC (Conquer of Completion) configuration
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")

-- Always show the signcolumn
if vim.fn.has("patch-8.1.1564") == 1 then
  vim.opt.signcolumn = "number"
else
  vim.opt.signcolumn = "yes"
end

-- Use tab for trigger completion with characters ahead and navigate
local function check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
  opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-space> to trigger completion
vim.keymap.set("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

-- Highlight the symbol and its references when holding the cursor
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
  group = "CocGroup",
  command = "silent call CocActionAsync('highlight')",
  desc = "Highlight symbol under cursor on CursorHold"
})

-- Symbol renaming
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

-- Formatting selected code
vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
vim.keymap.set("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
  group = "CocGroup",
  pattern = "typescript,json",
  command = "setl formatexpr=CocAction('formatSelected')",
  desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
  group = "CocGroup",
  pattern = "CocJumpPlaceholder",
  command = "call CocActionAsync('showSignatureHelp')",
  desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
vim.keymap.set("x", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })
vim.keymap.set("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })

-- Remap keys for applying codeActions to the current buffer
vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction)", { silent = true })

-- Apply AutoFix to problem on the current line
vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)", { silent = true })

-- Map function and class text objects
vim.keymap.set("x", "if", "<Plug>(coc-funcobj-i)", { silent = true })
vim.keymap.set("o", "if", "<Plug>(coc-funcobj-i)", { silent = true })
vim.keymap.set("x", "af", "<Plug>(coc-funcobj-a)", { silent = true })
vim.keymap.set("o", "af", "<Plug>(coc-funcobj-a)", { silent = true })
vim.keymap.set("x", "ic", "<Plug>(coc-classobj-i)", { silent = true })
vim.keymap.set("o", "ic", "<Plug>(coc-classobj-i)", { silent = true })
vim.keymap.set("x", "ac", "<Plug>(coc-classobj-a)", { silent = true })
vim.keymap.set("o", "ac", "<Plug>(coc-classobj-a)", { silent = true })

-- Use CTRL-S for selections ranges
vim.keymap.set("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
vim.keymap.set("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
vim.keymap.set("n", "<space>a", ":<C-u>CocList diagnostics<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<space>e", ":<C-u>CocList extensions<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<space>c", ":<C-u>CocList commands<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<space>o", ":<C-u>CocList outline<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<space>s", ":<C-u>CocList -I symbols<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<space>j", ":<C-u>CocNext<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<space>k", ":<C-u>CocPrev<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<space>p", ":<C-u>CocListResume<cr>", { silent = true, nowait = true })

-- Various settings
vim.g.netrw_home = os.getenv("HOME")

-- Tailwind CSS IntelliSense
vim.g.coc_global_extensions = { 'coc-tailwindcss' }
