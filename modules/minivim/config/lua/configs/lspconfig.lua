return {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()

    -- EXAMPLE
    local on_attach = require("nvchad.configs.lspconfig").on_attach
    local on_init = require("nvchad.configs.lspconfig").on_init
    local capabilities = require("nvchad.configs.lspconfig").capabilities

    local lspconfig = require "lspconfig"

    -- stylua: ignore
    local servers = {
      -- "cssls",
      -- "html",
      "clangd",        -- C/C++
      "rust_analyzer", -- Rust
      "cmake",         -- CMake
      "nil_ls",        -- Nix
      "taplo",         -- TOML
      "zls"            -- Zig
    }

    -- lsps with default config
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end

    -- typescript
    lspconfig.tsserver.setup {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }

  end,
}
