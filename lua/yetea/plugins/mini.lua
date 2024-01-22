return {
  {
    'echasnovski/mini.animate',
    version = '*',
    event = "VeryLazy",
    opts = {},
    config = function()
      require('mini.animate').setup()
    end
  },
  {
    'echasnovski/mini.bracketed',
    version = '*',
    event = "VeryLazy",
    opts = {},
    config = function()
      require('mini.bracketed').setup()
    end
  },
  {
    'echasnovski/mini.bufremove',
    version = '*',
    event = "VeryLazy",
    opts = {},
    config = function()
      require('mini.bufremove').setup()
    end,
    keys = {
      {
        "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
      -- stylua: ignore
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    config = function()
      require('mini.comment').setup()
    end
  },
  {
    'echasnovski/mini.cursorword',
    version = '*',
    event = "VeryLazy",
    opts = {},
    config = function()
      require('mini.cursorword').setup()
    end
  },
  {
    'echasnovski/mini.indentscope',
    version = '*',
    event = "VeryLazy",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function()
      require('mini.indentscope').setup()
    end
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    event = "VeryLazy",
    opts = {},
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    config = function() 
      require('mini.surround').setup()
    end,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding" },
        { opts.mappings.find,           desc = "Find right surrounding" },
        { opts.mappings.find_left,      desc = "Find left surrounding" },
        { opts.mappings.highlight,      desc = "Highlight surrounding" },
        { opts.mappings.replace,        desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
  },
}
