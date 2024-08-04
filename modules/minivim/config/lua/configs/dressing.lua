return { -- override vim.ui.select -like functions with UI
  "stevearc/dressing.nvim",

  event = "VeryLazy",

  opts = {
    select = {
      telescope = require("telescope.themes").get_ivy {}, -- ivy | dropdown | cursor
    },
  },

  config = function(_, opts)
    require("dressing").setup(opts)
  end,
}
