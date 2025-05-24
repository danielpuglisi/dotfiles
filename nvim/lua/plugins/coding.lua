return {
  "tpope/vim-sleuth",        -- Automatically detects which indents should be used in the current buffer
  {
    "echasnovski/mini.diff", -- Already in your configuration
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },

  -- Add markview.nvim
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },

  -- Add img-clip.nvim
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "echasnovski/mini.pick", config = true },
      { "ibhagwan/fzf-lua",      config = true },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-3.7-sonnet",
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
      require("legendary").keymaps({
        {
          itemgroup = "CodeCompanion",
          icon = "",
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
    enabled = function()
      -- Try to use the nodenv global version regardless of local project settings
      local node_path = vim.fn.expand("~/.nodenv/versions/$(nodenv global)/bin/node")
      node_path = vim.fn.system("echo " .. node_path):gsub("%s+", "")

      -- Store for plugin use
      vim.g.copilot_node_path = node_path

      -- Check version
      local version_output = vim.fn.system(node_path .. " --version")
      local major_version = tonumber(string.match(version_output, "v(%d+)"))

      if not major_version or major_version < 20 then
        vim.notify("Copilot requires Node.js ≥ 20. Found: " .. version_output, vim.log.levels.WARN)
        return false
      end

      return true
    end,
    keys = {
      { "<C-a>",  function() require("copilot.suggestion").accept() end,  mode = { "i" } },
      { "<C-x>",  function() require("copilot.suggestion").dismiss() end, mode = { "i" } },
      { "<C-\\>", function() require("copilot.panel").open() end,         mode = { "n", "i" } },
    },
    init = function()
      require("legendary").commands({
        itemgroup = "Copilot",
        commands = {
          { ":CopilotToggle", function() require("copilot.suggestion").toggle_auto_trigger() end },
        },
      })
    end,
    opts = {
      panel = { auto_refresh = true },
      suggestion = {
        auto_trigger = true,
        keymap = { accept_word = "<C-l>", accept_line = "<C-j>" },
      },
      server_opts_overrides = {
        node_path = function() return vim.g.copilot_node_path end,
      },
    },
  }
}
