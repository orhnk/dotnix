local function plugins(plugin_list)
  local plugin_pool = {}

  local ignored_plugins = plugin_list.ignore
  local enabled_plugins = plugin_list.enable

  -- Handle enabled plugins
  for _, plugin in ipairs(enabled_plugins) do
    table.insert(plugin_pool, require("configs." .. plugin))
  end

  -- Handle force_stop plugins
  for _, plugin in ipairs(ignored_plugins) do
    local config = require("configs." .. plugin)
    config.enabled = false
    table.insert(plugin_pool, config)
  end

  return plugin_pool
end

return plugins {
  enable = {
    "better-escape",
    "conform",
    "copilot",
    "copilot-chat",
    "dressing",
    "easy-align",
    -- "file-browser",
    "flash",
    "lazy",
    "lsp-signature",
    "lspconfig",
    "surround",
    "telescope",
    "textobjs",
    "treesitter",
    "treesj",
    "wakatime",
    "which-key",
    "yazi",
  },

  ignore = { -- Force Stop Plugins (NvChad Defaults)
    "mason",
    "nvimtree",
  },
}
