return {
  {
    "zaldih/themery.nvim",
    priority = 900,
    lazy = false,
    config = function()
      -- Set up an autocmd to run customizations on any colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "@variable", { link = "@field" })
          vim.api.nvim_set_hl(0, "@variable.member", { link = "TSVariable" })
          vim.api.nvim_set_hl(0, "@comment", { bg = "NONE" })
        end,
      })

      require("themery").setup({
        themes = { "base16-eighties", "base16-atelier-dune-light" },
        livePreview = true,
        defaultTheme = "base16-eighties"
      })
    end
  },
  {
    "RRethy/nvim-base16",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("base16-eighties")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    opts = {
      sort_by = "case_sensitive",
      view = {
        width = 30,
        relativenumber = false,
      },
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          window_picker = {
            enable = true,
          },
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- NERDTree-like mappings
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'd', api.fs.create, opts('Create Directory'))
        vim.keymap.set('n', 'D', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
      end,
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      -- Disable netrw as recommended by nvim-tree docs
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Set termguicolors to enable highlight groups
      vim.opt.termguicolors = true
    end,
    keys = {
      {
        "<C-n>",
        function()
          require("nvim-tree.api").tree.toggle()
        end,
        desc = "NvimTree: Toggle File Explorer",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icon = false,
          enforce_regular_tabs = true,
          modified_icon = "+",
          diagnostics = "nvim_lsp",
          indicator = {
            style = "icon",
            icon = "▎",
          },
          numbers = function(opts)
            return string.format('%s', opts.ordinal)
          end,
          custom_filter = function(buf_number, buf_numbers)
            -- Filter out special buffers
            local buftype = vim.bo[buf_number].buftype
            if buftype == "quickfix" or buftype == "terminal" or buftype == "help" then
              return false
            end
            return true
          end
        },
        highlights = {
          buffer_selected = {
            italic = false,
            bold = true,
          },
        },
      })
    end
  },
  {
    "stevearc/aerial.nvim", -- Toggled list of classes, methods etc in current file
    opts = {
      attach_mode = "global",
      close_on_select = true,
      layout = {
        min_width = 30,
        default_direction = "prefer_right",
      },
      -- Use nvim-navic icons
      icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰌗 ",
        Method = "󰆧 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘",
        Interface = "󰕘",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰌗 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
      },
    },
    keys = {
      { "<C-t>", "<cmd>AerialToggle<CR>", mode = { "n", "x", "o" }, desc = "Aerial Toggle" },
    },
  },
  {
    "folke/todo-comments.nvim", -- Highlight and search for todo comments within the codebase
    event = "BufEnter",
    keys = {
      { "<Leader>t", "<cmd>TodoTelescope<CR>", desc = "Todo comments" },
    },
    opts = {
      signs = false,
      highlight = {
        keyword = "bg",
      },
      keywords = {
        FIX = { icon = " " }, -- Custom fix icon
      },
    },
  },
}
