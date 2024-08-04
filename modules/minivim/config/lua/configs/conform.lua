return {

  "stevearc/conform.nvim",

  event = "BufWritePre", -- format on save

  opts = {
    formatters_by_ft = {

      ["*"] = { "codespell", "trim_newlines", "trim_whitespaces", "typos" },
      c = { "clang-format" },
      cmake = { "cmake_format" },
      cpp = { "clang-format" },
      css = { "prettier" },
      go = { "gofmt" },
      haskell = { "ormolu" },
      html = { "prettier" },
      javascript = { { "deno_fmt", "prettier" } },
      json = { { "deno_fmt", "prettier" }, "fixjson" },
      lua = { "stylua" },
      nix = { "alejandra" },
      rust = { "rustfmt" },
      sh = { "shfmt", "shellcheck" },
      toml = { "taplo" },
      typescript = { { "deno_fmt", "prettier" } },
      yaml = { "prettier" },
      zig = { "zigfmt" },
      markdown = {
        { "deno_fmt", "prettier" },
        "doctoc",
        "injected",
      },
      python = {
        { "ruff_format", "black" },
        "docformatter",
        { "ruff_organize_imports", "reorder-python-imports" },
        "ruff_fix",
      },
    },

    -- runs async
    format_after_save = {
      -- conform.format() parameters
      timeout_ms = 500,
      lsp_format = "fallback",
    },

    default_format_opts = {
      async = true,
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
