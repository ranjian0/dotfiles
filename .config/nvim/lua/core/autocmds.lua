local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function is_modifiable_buffer()
  return vim.bo.modifiable
end

-- General settings
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    if not is_modifiable_buffer() then return end
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Resize splits if window gets resized
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Auto resize splits",
})

-- Auto save when losing focus
autocmd("FocusLost", {
  group = augroup("auto_save", { clear = true }),
  pattern = "*",
  command = "silent! wa",
  desc = "Auto save on focus lost",
})

-- Create parent directories when saving a new file
autocmd("BufWritePre", {
  group = augroup("create_parent_dirs", { clear = true }),
  callback = function()
    if not is_modifiable_buffer() then return end
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
  desc = "Create parent directories when saving",
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    if not is_modifiable_buffer() then return end
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Remove trailing whitespace on save",
})

-- Disable automatic commenting on new line
autocmd("BufEnter", {
  group = augroup("disable_auto_comment", { clear = true }),
  pattern = "*",
  callback = function()
    if not is_modifiable_buffer() then return end
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable automatic commenting",
})

-- Close folds when opening a file
autocmd("BufRead", {
  group = augroup("close_folds", { clear = true }),
  pattern = "*",
  callback = function()
    if not is_modifiable_buffer() then return end
    vim.cmd("normal zR")
  end,
  desc = "Open all folds on file read",
})

-- Use q to quit in certain filetypes
autocmd("FileType", {
  group = augroup("quit_with_q", { clear = true }),
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.opt_local.buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
  desc = "Quit with q in certain filetypes",
})

-- Enable inlay hints
if vim.lsp.inlay_hint then
  autocmd("LspAttach", {
    group = augroup("inlay_hints", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end,
    desc = "Enable inlay hints",
  })
end

-- LSP attach for keymaps
autocmd("LspAttach", {
  group = augroup("lsp_attach", { clear = true }),
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client then
      return
    end

    local opts = { buffer = buffer, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    if client.supports_method("textDocument/codeAction") then
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        callback = function()
          if not is_modifiable_buffer() then return end
          vim.lsp.buf.format({ bufnr = buffer, timeout_ms = 2000 })
        end,
      })
    end
  end,
  desc = "LSP keymaps and configuration",
})
