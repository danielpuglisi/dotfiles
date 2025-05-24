return {
  { "nvim-lua/plenary.nvim" },    -- Required dependency for many plugins
  {
    "mrjones2014/legendary.nvim", -- A command palette for keymaps, commands and autocmds
    priority = 10000,
    lazy = false,
    dependencies = "kkharji/sqlite.lua",
    keys = {
      {
        "<leader>p",
        function()
          require("legendary").find()
        end,
        desc = "Open Legendary",
      },
    },
    config = function()
      require("legendary").setup({
        select_prompt = "Legendary",
        include_builtin = false,
        extensions = {
          codecompanion = false,
          lazy_nvim = true,
          which_key = false,
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-bqf", -- Better quickfix window,
    ft = "qf",
  },
  {
    "numToStr/Comment.nvim", -- Modern commenting plugin
    config = true,
    event = "VeryLazy",
  },
  { "tpope/vim-surround" },        -- Easily add, change or delete surrounding characters
  { "AndrewRadev/splitjoin.vim" }, -- Easily split or join lines (gS / gJ)
  { "tpope/vim-fugitive" },        -- Git integration for Vim
  { "tpope/vim-rhubarb" },         -- GitHub integration for Vim
  { "benmills/vimux" },            -- Run commands in a tmux pane
  { "skalnik/vim-vroom" },         -- Run code in a REPL-like environment

  -- Rails support
  { "tpope/vim-rails" },   -- Rails-specific commands and helpers
  { "vim-ruby/vim-ruby" }, -- Ruby syntax highlighting and indentation
}
