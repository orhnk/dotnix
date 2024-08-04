return { -- One of the simplest and most useful plugin
  "max397574/better-escape.nvim",
  event = "InsertEnter",

  opts = {
    mappings = {
      v = { j = { k = false } },
      s = { j = { k = false } },
    },
  },

  config = function(_, opts)
    require("better_escape").setup(opts)
  end,
}
