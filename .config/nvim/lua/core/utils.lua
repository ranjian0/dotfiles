local M = {}

function M.safe_require(module)
  local ok, result = pcall(require, module)
  if ok then return result end
  vim.notify("Failed to load module: " .. module, vim.log.levels.WARN)
  return nil
end

function M.safe_setup(plugin_name, setup_fn)
  if M.safe_require(plugin_name) then
    local ok, err = pcall(setup_fn)
    if not ok then
      vim.notify("Failed to setup " .. plugin_name .. ": " .. err, vim.log.levels.ERROR)
    end
  end
end

function M.safe_load_config(config_name)
  local ok, config = pcall(require, "lazy." .. config_name)
  if ok and type(config) == "table" and config.config then
    config.config()
  elseif not ok then
    vim.notify("Failed to load config: " .. config_name, vim.log.levels.WARN)
  end
end

return M
