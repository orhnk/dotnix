return {

  -- I use NixOS to manage my LSPs
  "williamboman/mason.nvim",

  opts = {
    install_root_dir = os.getenv "HOME" .. "/.local/share/nvim/mason/bin",
    ensure_installed = {
      -- lua stuff
      "lua-language-server",
      "stylua",

      -- web dev stuff
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "deno",
      "prettier",

      -- c/cpp stuff
      "clangd",
      "clang-format",

      -- Rust stuff
      "rust-analyzer",

      -- Shell stuff
      "shellcheck",
      "shfmt",

      -- Python
      -- TODO: Remove mason-dap-install plugin and use the default
      "black",
      "debugpy",
    },
  },
}
