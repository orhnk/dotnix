local telescope_actions = require "telescope.actions"

return { -- Overriding

  "nvim-telescope/telescope.nvim",

  opts = {
    defaults = {
      mappings = {

        i = {
          ["<TAB>"] = telescope_actions.select_default,
        },

        n = {
          ["<TAB>"] = telescope_actions.select_default,
          ["l"] = telescope_actions.select_default,
        },
      },
    },

    -- TODO: https://github.com/nvim-telescope/telescope.nvim/issues/3220
    extensions = {
      ["*"] = {
        theme = "ivy",
      },
    },
  },
}
