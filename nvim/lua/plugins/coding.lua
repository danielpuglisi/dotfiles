return {
  "tpope/vim-sleuth", -- Automatically detects which indents should be used in the current buffer
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      -- { "nvim-treesitter/nvim-treesitter" },
      -- { "nvim-lua/plenary.nvim" },
      -- { "hrsh7th/nvim-cmp" },
      -- { "stevearc/dressing.nvim", opts = {} },
      -- { "nvim-telescope/telescope.nvim" },
      { "echasnovski/mini.pick", config = true },
      { "ibhagwan/fzf-lua",      config = true },
      -- The following are optional:
      -- { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  -- default = "o3-mini-2025-01-31",
                  default = "claude-3.7-sonnet",
                  -- default = "claude-3.7-sonnet-thought",
                },
                max_tokens = {
                  default = 8192
                }
              },
            })
          end,
        },
        strategies = {
          chat = {
            keymaps = {
              send = {
                modes = {
                  i = { "<C-CR>", "<C-s>" },
                },
              },
            },
            -- roles = { llm = "CodeCompanion", user = "olimorris" },
            slash_commands = {
              ["buffer"] = {
                opts = {
                  provider = "telescope",
                },
              },
              ["help"] = {
                opts = {
                  provider = "telescope",
                },
              },
              ["file"] = {
                opts = {
                  provider = "telescope",
                },
              },
              ["symbols"] = {
                opts = {
                  provider = "telescope",
                },
              },
            },
          },
        },
        display = {
          action_palette = {
            provider = "default",
          },
          chat = {
            show_references = true,
            show_header_separator = false,
            show_settings = false,
          },
          diff = {
            provider = "mini_diff",
          },
        },
        opts = {
          log_level = "DEBUG",
        },
      })
    end,
    init = function()
      -- vim.cmd([[cab cc CodeCompanion]])
      require("legendary").keymaps({
        {
          itemgroup = "CodeCompanion",
          icon = "",
          description = "Use the power of AI...",
          keymaps = {
            {
              "<C-a>",
              "<cmd>CodeCompanionActions<CR>",
              description = "Open the action palette",
              mode = { "n", "v" },
            },
            {
              "<LocalLeader>a",
              "<cmd>CodeCompanionChat Toggle<CR>",
              description = "Toggle a chat buffer",
              mode = { "n", "v" },
            },
            {
              "<leader>a",
              "<cmd>CodeCompanion<CR>",
              description = "Toggle an inline chat",
              mode = { "n", "v" },
            },
            {
              "ga",
              "<cmd>CodeCompanionChat Add<CR>",
              description = "Add selected text to a chat buffer",
              mode = { "n", "v" },
            },
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua", -- AI programming
    event = "InsertEnter",
    keys = {
      {
        "<C-a>",
        function()
          require("copilot.suggestion").accept()
        end,
        desc = "Copilot: Accept suggestion",
        mode = { "i" },
      },
      {
        "<C-x>",
        function()
          require("copilot.suggestion").dismiss()
        end,
        desc = "Copilot: Dismiss suggestion",
        mode = { "i" },
      },
      {
        "<C-\\>",
        function()
          require("copilot.panel").open()
        end,
        desc = "Copilot: Show panel",
        mode = { "n", "i" },
      },
    },
    init = function()
      require("legendary").commands({
        itemgroup = "Copilot",
        commands = {
          {
            ":CopilotToggle",
            function()
              require("copilot.suggestion").toggle_auto_trigger()
            end,
            description = "Toggle on/off for buffer",
          },
        },
      })
    end,
    opts = {
      panel = {
        auto_refresh = true,
      },
      suggestion = {
        auto_trigger = true, -- Suggest as we start typing
        keymap = {
          accept_word = "<C-l>",
          accept_line = "<C-j>",
        },
      },
    },
  },
}
