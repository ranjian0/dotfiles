local utils = require("core.utils")

vim.api.nvim_create_user_command("NvimHealth", function()
  print("Checking core modules...")

  local core_modules = { "core.utils", "core.keymaps", "core.autocmds", "core.theme" }
  for _, module in ipairs(core_modules) do
    local ok, _ = pcall(require, module)
    if ok then
      print("  ✓ " .. module)
    else
      print("  ✗ " .. module)
    end
  end

  print("\nChecking lazy configs...")

  local lazy_configs = {
    "lazy.lsp",
    "lazy.editor",
    "lazy.ui",
    "lazy.git",
    "lazy.nav",
    "lazy.term",
    "lazy.ai",
    "lazy.test",
    "lazy.format",
    "lazy.extras",
  }
  for _, config in ipairs(lazy_configs) do
    local ok, _ = pcall(require, config)
    if ok then
      print("  ✓ " .. config)
    else
      print("  ✗ " .. config)
    end
  end

  print("\nChecking critical plugins...")

  local critical_plugins = {
    "lazy.nvim",
    "nvim-lspconfig",
    "nvim-treesitter",
    "telescope.nvim",
    "mason.nvim",
  }
  for _, plugin in ipairs(critical_plugins) do
    local ok = pcall(require, plugin)
    if ok then
      print("  ✓ " .. plugin)
    else
      print("  ✗ " .. plugin)
    end
  end

  print("\nChecking LSP servers...")

  local lsp_servers = { "lua_ls", "pyright", "ts_ls", "jsonls", "yamlls", "bashls" }
  local mason_ok = pcall(require, "mason-registry")
  if mason_ok then
    local registry = require("mason-registry")
    for _, server in ipairs(lsp_servers) do
      local ok, pkg = pcall(registry.get_package, server)
      if ok and pkg:is_installed() then
        print("  ✓ " .. server)
      else
        print("  ! " .. server .. " (not installed)")
      end
    end
  else
    print("  ! Mason registry not available")
  end

  print("\nHealth check complete!")
end, { desc = "Run nvim health check" })
