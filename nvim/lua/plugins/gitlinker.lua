return {
  "ruifm/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  opts = {},
  keys = {
    {
      "<Leader>yg",
      function() require("gitlinker").get_buf_range_url "n" end,
      desc = "Yank GitHub permalink",
    },
    {
      "<Leader>yg",
      function() require("gitlinker").get_buf_range_url "v" end,
      mode = "v",
      desc = "Yank GitHub permalink (selection)",
    },
  },
}
