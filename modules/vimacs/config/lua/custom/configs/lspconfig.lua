local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- stylua: ignore start
-- if you just want default config for the servers then put them in a table
local servers = {
  -- "cssls",
  "clangd",        -- C/C++
  "rust_analyzer", -- Rust
  "cmake",         -- CMake
  "nil_ls",        -- Nix
  "taplo",         -- TOML
  "zls"            -- Zig
}
-- stylua: ignore end
--                                    ^^^^^^^^^^^^^^^^-- TODO: Set up with rust-tools.nvim
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
