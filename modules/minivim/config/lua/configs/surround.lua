return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features

  dependencies = {
    -- "XXiaoA/ns-textobject.nvim",
    "chrisgrieser/nvim-various-textobjs",
  },

  keys = { "cs", "ds", "ys" },

  config = function(_, opts)
    require("nvim-surround").setup(opts)
  end,

  opts = {
    surrounds = {
      ["l"] = {
        add = function()
          local clipboard = vim.fn.getreg("+"):gsub("\n", "")
          return {
            { "[" },
            { "](" .. clipboard .. ")" },
          }
        end,
        -- find = "%b[]%b()",
        delete = "^(%[)().-(%]%b())()$",
        change = {
          target = "^()()%b[]%((.-)()%)$",
          replacement = function()
            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
            return {
              { "" },
              { clipboard },
            }
          end,
        },
      },
    },
  },
}
