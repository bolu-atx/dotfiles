-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 20000 }, -- handle larger files
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    -- Diagnostics configuration
    diagnostics = {
      virtual_text = true,
      underline = true,
      severity_sort = true,
    },
    -- Filetypes for meson and other project files
    filetypes = {
      extension = {
        wrap = "ini", -- meson wrap files
      },
      filename = {
        ["meson.build"] = "meson",
        ["meson_options.txt"] = "meson",
        [".clang-format"] = "yaml",
        [".clang-tidy"] = "yaml",
        ["pyrightconfig.json"] = "jsonc",
        ["tsconfig.json"] = "jsonc",
      },
    },
    -- vim options
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        scrolloff = 8, -- keep 8 lines visible above/below cursor
        sidescrolloff = 8,
        tabstop = 4,
        shiftwidth = 4,
        expandtab = true,
        smartindent = true,
        undofile = true, -- persistent undo
        updatetime = 250, -- faster CursorHold events
        timeoutlen = 300, -- faster which-key popup
      },
      g = {},
    },
    -- Mappings
    mappings = {
      n = {
        -- Buffer navigation
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- Quick save
        ["<Leader>w"] = { "<cmd>w<cr>", desc = "Save file" },

        -- Better window navigation
        ["<C-h>"] = { "<C-w>h", desc = "Move to left window" },
        ["<C-j>"] = { "<C-w>j", desc = "Move to lower window" },
        ["<C-k>"] = { "<C-w>k", desc = "Move to upper window" },
        ["<C-l>"] = { "<C-w>l", desc = "Move to right window" },

        -- Quickfix navigation (useful for grep results)
        ["]q"] = { "<cmd>cnext<cr>zz", desc = "Next quickfix" },
        ["[q"] = { "<cmd>cprev<cr>zz", desc = "Prev quickfix" },

        -- Trouble integration
        ["<Leader>xx"] = { "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        ["<Leader>xX"] = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
        ["<Leader>xL"] = { "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
        ["<Leader>xQ"] = { "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },

        -- Project root detection (snacks.nvim picker in v5)
        ["<Leader>fp"] = { function() Snacks.picker.files { cwd = vim.fn.getcwd() } end, desc = "Find files in project" },
      },
      v = {
        -- Stay in visual mode when indenting
        ["<"] = { "<gv", desc = "Unindent line" },
        [">"] = { ">gv", desc = "Indent line" },
      },
    },
  },
}
