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
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      auto_resize_height = true,
      preview = {
        auto_preview = false,
      },
      func_map = {
        open = "o",
        openc = "", -- open and close quickfix
      },
    },
  },
  {
    "tpope/vim-commentary",
    event = "VeryLazy",
    config = function()
      vim.keymap.set('n', '\\\\', 'gcc', { remap = true, desc = "Toggle comment" })
      vim.keymap.set('v', '\\\\', 'gc', { remap = true, desc = "Toggle comment for selection" })

      -- Set commentstring for JSON files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "json",
        callback = function()
          vim.bo.commentstring = "//%s"
        end,
        desc = "Set commentstring for JSON files",
      })
    end,
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
