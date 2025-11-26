-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      -- Core
      "lua",
      "vim",
      "vimdoc",
      "query",

      -- TypeScript / JavaScript
      "typescript",
      "tsx",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",

      -- Python
      "python",
      "toml",

      -- C/C++
      "c",
      "cpp",
      "cmake",
      "meson",
      "ninja",

      -- Markup / Config
      "markdown",
      "markdown_inline",
      "yaml",
      "dockerfile",
      "gitignore",
      "bash",
    },
  },
}
