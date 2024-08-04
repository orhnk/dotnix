return { -- (Emacs) Dired-like Optional file manager for telescope-project.nvim
  "nvim-telescope/telescope-file-browser.nvim",

  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        extensions = {
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
          },
        },
      },
    },
    "nvim-lua/plenary.nvim",
  },

  keys = {
    {
      "<leader>.",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      desc = "File Manager",
    },
  },

  config = function()
    -- To get telescope-file-browser loaded and working with telescope,
    -- you need to call load_extension, somewhere after setup function:
    require("telescope").load_extension "file_browser"
  end,
}
