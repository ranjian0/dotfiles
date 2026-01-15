local M = {}

function M.config()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "isort" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      go = { "gofmt" },
      rust = { "rustfmt" },
      cpp = { "clang-format" },
      c = { "clang-format" },
      bash = { "shfmt" },
      sh = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
end

return M
