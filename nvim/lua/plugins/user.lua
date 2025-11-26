-- ~/.config/nvim/lua/user/plugins/heirline.lua
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    -- Replace the default filename component
    opts.statusline[4] = {
      provider = function()
        local cwd = vim.fn.getcwd()
        local file = vim.api.nvim_buf_get_name(0)
        -- make relative
        local rel = vim.fn.fnamemodify(file, ":.")
        -- OR force relative to cwd:
        -- local rel = vim.fn.fnamemodify(file, ":~:.")
        return rel ~= "" and rel or "[No Name]"
      end,
      hl = { fg = "fg" },
    }
    return opts
  end,
}
