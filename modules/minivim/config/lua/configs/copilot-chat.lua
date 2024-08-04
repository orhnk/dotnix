return {

  "CopilotC-Nvim/CopilotChat.nvim",

  branch = "canary",

  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
  },

  opts = {
    debug = true,
  },

  cmd = {
    "CopilotChatToggle",
    "CopilotChatExplain",
    "CopilotChatReview",
    "CopilotChatOptimize",
    "CopilotChatDocs",
    "CopilotChatTest",
    "CopilotChatFixDiagnostic",
    "CopilotChatCommit",
  },

  --   stylua: ignore
  keys = {
    {  "<leader>ai", "<cmd> CopilotChatToggle<CR>",        mode = { "n", "v" }, desc = "Chat Toggle"   },
    {  "<leader>ae", "<cmd> CopilotChatExplain<CR>",       mode = { "n", "v" }, desc = "Chat Explain"  },
    {  "<leader>ar", "<cmd> CopilotChatReview<CR>",        mode = { "n", "v" }, desc = "Chat Review"   },
    {  "<leader>ao", "<cmd> CopilotChatOptimize<CR>",      mode = { "n", "v" }, desc = "Chat Optimize" },
    {  "<leader>ad", "<cmd> CopilotChatDocs<CR>",          mode = { "n", "v" }, desc = "Chat Docs"     },
    {  "<leader>at", "<cmd> CopilotChatTest<CR>",          mode = { "n", "v" }, desc = "Chat Test"     },
    {  "<leader>af", "<cmd> CopilotChatFixDiagnostic<CR>", mode = { "n", "v" }, desc = "Chat Fix"      },
    {  "<leader>ap", "<cmd> CopilotChatCommit<CR>",        mode = { "n", "v" }, desc = "Chat Commit"   },
  },

  config = function(_, opts)
    require("CopilotChat").setup(opts)
  end,
}
