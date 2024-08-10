require "nvchad.mappings"

local utils = require("utils").mapping_utils

vim.g.mapleader = " "

-- stylua: ignore
local nvmappings_ns = {

  -- map jk to gj gk
  ["j"] = "gj",
  ["k"] = "gk",

  ["<leader>ww"] = { "<cmd> w <cr>", "Save"           },
  ["<leader>wq"] = { "<cmd> wq <cr>", "Save and Quit" },
  ["<leader>fq"] = { "<cmd> q! <cr>", "Force Quit"    },
  ["<leader>qq"] = { "<cmd> q <cr>", "Quite"          },

  -- Buffer Manageement
  ["<leader>bb"] = { "<cmd> enew <cr>", "New Buffer" },
  ["<leader>bd"] = { "<cmd> q <cr>", "Quit Buffer"   },
  ["<leader>bk"] = {
    function()
      require("nvchad.tabufline").close_buffer()
    end,
    "Close Buffer",
  },

  -- Telescope
  ["<leader>fr"] = { "<cmd> Telescope oldfiles <cr>", "Recent Files" },
  ["<leader>fd"] = { "<cmd> Telescope marks <cr>", "Marks"           },
  ["<leader>fc"] = { "<cmd> Telescope builtin <cr>", "Commands"      },

  -- Git
  ["<leader>gc"] = { "<cmd> Telescope git_commits <cr>", "Git Commits" },

  -- Other
  ["<leader>ht"] = { "<cmd> Telescope themes <cr>", "Themes" },
  ["<leader>nn"] = { "<cmd> set nu! <cr>", "Toggle LNum"     },
  ["<leader>nr"] = { "<cmd> set rnu! <cr>", "Toggle RNum"    },
  ["<leader>sq"] = { "<cmd> '<,'> sort <cr><esc>", "Sort"    },
}

-- Disable NvChad's mappings (btw you can remap them above)
local nvdelmap = {
  "<leader>e",
  "<leader>b",
  "<leader>h",
  "<leader>v",
  "<leader>x",
  "<leader>n",
  "<leader>/",
  "<leader>th",
  "<leader>fo",
  "<leader>ma",
  "<leader>cm",
  -- "<leader>",

  "<C-n>",
}

local idelmap = {
  "<C-b>",
  "<C-e>",
  "<C-h>",
  "<C-j>",
  "<C-k>",
  "<C-l>",
}

-- delete before mapping so no conflicts
utils.del({ "n" }, nvdelmap)
utils.del("i", idelmap)

utils.map({ "n", "v" }, nvmappings_ns, { noremap = true, silent = true })
