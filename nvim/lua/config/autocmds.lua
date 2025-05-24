-- Set up autocommands

-- Color highlighting for trailing whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = "red" })
vim.cmd([[
  au ColorScheme * highlight ExtraWhitespace guibg=red
  au BufEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhiteSpace /\s\+$/
]])

-- Restore cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Restore cursor position when reopening files",
})

-- Default text width for plaintext files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    vim.opt_local.textwidth = 78
  end,
  desc = "Set textwidth for plaintext files",
})

-- Ruby, JavaScript, HTML, etc. indentation settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "haml", "eruby", "yaml", "html", "javascript", "sass", "cucumber" },
  callback = function()
    vim.opt_local.ai = true
    vim.opt_local.sw = 2
    vim.opt_local.sts = 2
    vim.opt_local.expandtab = true
    vim.opt_local.smartindent = true
    vim.opt_local.cindent = false
  end,
  desc = "Set indentation for web development languages",
})

-- Python indentation settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.sw = 4
    vim.opt_local.sts = 4
    vim.opt_local.expandtab = true
  end,
  desc = "Set Python indentation to 4 spaces",
})

-- Sass filetype detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.sass" },
  command = "setfiletype sass",
  desc = "Detect Sass files",
})

-- Markdown file settings
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.markdown", "*.md.erb" },
  callback = function()
    vim.opt_local.ai = true
    vim.opt_local.formatoptions = "tcroqn2"
    vim.opt_local.comments = "n:>"
    vim.opt_local.number = true
    vim.opt_local.wrapmargin = 0
    vim.opt_local.linebreak = true
    vim.opt_local.wrap = true
  end,
  desc = "Configure Markdown files for better readability",
})

-- ERB in Markdown detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md.erb",
  callback = function()
    vim.bo.filetype = "markdown.eruby"
  end,
  desc = "Set filetype for Markdown+ERB files",
})

-- LSP Hover documentation highlight
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
  end,
  desc = "Improve LSP documentation window styling",
})

-- Treesitter folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "ruby", "javascript", "typescript", "python" },
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
  end,
  desc = "Enable treesitter-based folding for supported languages",
})
