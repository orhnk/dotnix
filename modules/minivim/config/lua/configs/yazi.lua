return {
  "mikavilpas/yazi.nvim",

  keys = {
    {
      -- Open in the current working directory
      "<leader>.",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open the file manager in nvim's working directory",
    },
  },

  opts = {
    -- use_ya_for_events_reading = true,
    -- use_yazi_client_id_flag = true,
  },
}
