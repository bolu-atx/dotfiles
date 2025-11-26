-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Lua
        "lua-language-server",
        "stylua",

        -- TypeScript / JavaScript
        "typescript-language-server",
        "prettier",
        "eslint-lsp",

        -- Python
        "pyright",
        "ruff",
        "debugpy",

        -- C/C++
        "clangd",
        "clang-format",
        "codelldb",

        -- CMake / Meson
        "cmake-language-server",
        "neocmakelsp",

        -- General
        "tree-sitter-cli",
      },
    },
  },
}
