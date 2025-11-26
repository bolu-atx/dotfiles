-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Lua (for neovim config editing)
  { import = "astrocommunity.pack.lua" },

  -- TypeScript / JavaScript
  { import = "astrocommunity.pack.typescript" },

  -- Python
  { import = "astrocommunity.pack.python" },

  -- C/C++
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.cmake" },

  -- Useful extras for mono-repos
  { import = "astrocommunity.project.project-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
}
