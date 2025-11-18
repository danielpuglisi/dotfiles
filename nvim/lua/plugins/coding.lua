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
    default_dir_path = vim.fn.expand("~/Pictures/screenshots"), -- Set default path
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
                  default = "claude-sonnet-4.5",
                },
                max_tokens = {
                  default = 8192
                }
              },
            })
          end,
          openrouter_kimi = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "moonshotai/kimi-k2",
                },
              },
            })
          end,
        },
        strategies = {
          --NOTE: Change the adapter as required
          chat = {
            -- adapter = "openrouter_kimi",
            adapter = "copilot",
            keymaps = {
              send = {
                modes = {
                  i = { "<C-CR>", "<C-s>" },
                },
              },
            },
            tools = {
              opts = {
                auto_submit_errors = true,  -- Send any errors to the LLM automatically?
                auto_submit_success = true, -- Send any successful output to the LLM automatically?
              },
            },
            -- slash_commands = {
            --   ["buffer"] = {
            --     opts = {
            --       provider = "telescope",
            --     },
            --   },
            --   ["help"] = {
            --     opts = {
            --       provider = "telescope",
            --     },
            --   },
            --   ["file"] = {
            --     opts = {
            --       provider = "telescope",
            --     },
            --   },
            --   ["symbols"] = {
            --     opts = {
            --       provider = "telescope",
            --     },
            --   },
            -- },
            opts = {
              ---Decorate the user message before it's sent to the LLM
              ---@param message string
              ---@param adapter CodeCompanion.Adapter
              ---@param context table
              ---@return string
              prompt_decorator = function(message, adapter, context)
                return string.format([[<prompt>%s</prompt>]], message)
              end,
            }
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
            auto_scroll = false,
            window = {
              width = 0.3,
              height = 0.6,
            },
          },
          diff = {
            enabled = true,
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
            { "<leader>co", ":copen<CR>",  description = "Open quickfix list" },
            { "<leader>cc", ":cclose<CR>", description = "Close quickfix list" },
            { "<leader>cn", ":cnext<CR>",  description = "Next quickfix item" },
            { "<leader>cp", ":cprev<CR>",  description = "Previous quickfix item" },
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua", -- AI programming
    event = "InsertEnter",
    enabled = function()
      -- Read node version from mise global config
      local function get_mise_node()
        local config = vim.fn.expand("~/.config/mise/config.toml")
        if vim.fn.filereadable(config) == 1 then
          for _, line in ipairs(vim.fn.readfile(config)) do
            local version = line:match('^node%s*=%s*["\']([^"\']+)["\']')
            if version then
              -- Resolve aliases like "latest" or "lts"
              if not version:match("^%d") then
                version = vim.fn.system("mise latest node@" .. version .. " 2>/dev/null"):gsub("%s+", "")
              end

              if version ~= "" then
                return vim.fn.expand("~/.local/share/mise/installs/node/" .. version .. "/bin/node")
              end
            end
          end
        end
        return nil
      end

      local node_path = get_mise_node()
      if not node_path then
        vim.notify("Copilot: Could not find mise node installation", vim.log.levels.WARN)
        return false
      end

      vim.g.copilot_node_path = node_path

      local version = vim.fn.system(node_path .. " --version"):gsub("%s+", "")
      local major = tonumber(version:match("v(%d+)"))
      if not major or major < 20 then
        vim.notify("Copilot requires Node.js ≥ 20. Found: " .. version, vim.log.levels.WARN)
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
