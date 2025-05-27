-- Basic Neovim settings
vim.g.mapleader = ","

-- Enable syntax and filetype detection
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- Editor behavior
vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.cmdheight = 1
vim.opt.encoding = 'utf-8'
vim.opt.expandtab = true
vim.opt.formatoptions:append('n')
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.lazyredraw = false
vim.opt.showcmd = false
vim.opt.smarttab = false
vim.opt.startofline = false
vim.opt.wrap = false

-- Indentation
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 4

-- UI display
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.report = 0
vim.opt.scrolloff = 3
vim.opt.showmatch = true
vim.opt.showtabline = 1
vim.opt.laststatus = 2
vim.opt.cursorline = false
vim.opt.cursorcolumn = false

-- Search behavior
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Text handling
vim.opt.virtualedit = 'block'
vim.opt.whichwrap:append('<,>,h,l,[,]')

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest,list'

-- Folding (using tree-sitter)
vim.opt.foldenable = false

-- Status line
vim.opt.shortmess = 'filtIoOA'

-- Shell
vim.opt.shell = 'zsh'

-- Temp file storage
vim.opt.backupdir = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'
vim.opt.directory = '~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp'

-- Custom keymaps for Ruby testing with Zellij
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby" },
  callback = function()
    vim.keymap.set('n', '<leader>r', ':lua tulpa.run_ruby_test_file()<CR>', {
      buffer = true,
      noremap = true,
      desc = "Run test file in Zellij"
    })
    vim.keymap.set('n', '<leader>R', ':lua tulpa.run_ruby_nearest_test()<CR>', {
      buffer = true,
      noremap = true,
      desc = "Run nearest test in Zellij"
    })
  end
})

-- GUI settings
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "Inconsolata:h14"
  vim.opt.wrap = true
  vim.opt.linebreak = true
end

-- Various settings
vim.g.netrw_home = os.getenv("HOME")
