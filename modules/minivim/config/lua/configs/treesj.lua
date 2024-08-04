return {

  "Wansmer/treesj",

  dependencies = { "nvim-treesitter/nvim-treesitter" },

  keys = {
    {
      "<leader>jj",
      function()
        require("treesj").toggle()
      end,
      mode = "n",
      desc = "UnJoin",
    },
  },

  opts = {
    use_default_keymaps = false,
    max_join_length = 220,
  },
}
