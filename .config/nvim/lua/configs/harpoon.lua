local M = {}

function M.config()
  local harpoon = require("harpoon")

  -- Monkey-patch harpoon's save to avoid serializing functions
  local original_save = harpoon.save
  harpoon.save = function()
    local ok, err = pcall(function()
      -- Temporarily remove problematic function reference from config
      local cache_config = vim.fn.stdpath("data") .. "/harpoon.json"
      local config = harpoon.get_global_settings() or {}

      -- Save config manually without function references
      vim.fn.writefile({ vim.fn.json_encode({
        projects = {},
        global_settings = config
      }) }, cache_config, "w")
    end)
    if not ok then
      -- If manual save fails, try original (might show error but won't crash)
      pcall(original_save)
    end
  end

  harpoon:setup({
    global_settings = {
      save_on_toggle = false,
      save_on_change = false,
    },
  })

  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    }):find()
  end

  vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
  vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end)
  vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end)

  vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
  vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
  vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
  vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)
end

return M
