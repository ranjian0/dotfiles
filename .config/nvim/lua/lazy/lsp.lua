local utils = require("core.utils")

local M = {}

function M.config()
  local mason_ok, mason = pcall(require, "mason")
  if mason_ok then
    mason.setup()
  end

  local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if mason_lspconfig_ok then
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "jsonls",
        "yamlls",
        "bashls",
      },
    })
  end

  local lsp_servers = {
    "lua_ls",
    "pyright",
    "ts_ls",
    "jsonls",
    "yamlls",
    "bashls",
  }

  for _, server in ipairs(lsp_servers) do
    if vim.lsp.config then
      pcall(vim.lsp.config, server, {})
    end
  end

  local cmp_ok, cmp = pcall(require, "cmp")
  local luasnip_ok, luasnip = pcall(require, "luasnip")

  if cmp_ok and luasnip_ok then
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      experimental = { ghost_text = true },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      })
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline" }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    local loaders_ok, loaders = pcall(require, "luasnip.loaders.from_snipmate")
    if loaders_ok then
      loaders.lazy_load({ paths = vim.fn.expand("~/.config/nvim/snippets/") })
    end
    luasnip.filetype_extend("all", { "_" })
  end

  local nlspsettings_ok, nlspsettings = pcall(require, "nlspsettings")
  if nlspsettings_ok then
    nlspsettings.setup({
      config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
      local_settings_dir = ".nlsp-settings",
      local_settings_root_markers_fallback = { ".git" },
      append_default_schemas = true,
      loader = "json"
    })
  end

local trouble_ok, trouble = pcall(require, "trouble")
  if trouble_ok then
    trouble.setup({
      position = "bottom",
      height = 10,
      width = 50,
      icons = true,
      mode = "workspace_diagnostics",
      fold_open = "",
      fold_closed = "",
      group = true,
      padding = true,
      action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = { "<cr>", "<tab>" },
        open_split = { "<c-x>" },
        open_vsplit = { "<c-v>" },
        open_tab = { "<c-t>" },
        jump_close = { "o" },
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = { "zM", "zm" },
        open_folds = { "zR", "zr" },
        toggle_fold = { "zA", "za" },
        previous = "k",
        next = "j"
      },
      indent_lines = true,
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      auto_fold = false,
      auto_jump = { "lsp_definitions" },
      signs = {
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "󰮍"
      },
      use_diagnostic_signs = false
    })
  end

  local treesitter_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if treesitter_ok then
    treesitter_configs.setup({
      ensure_installed = {
        "c", "lua", "luadoc", "vim", "vimdoc", "query",
        "python", "nim", "bash", "cpp", "dockerfile", "go", "glsl", "html", "javascript", "json",
        "markdown", "markdown_inline", "nginx", "rst", "rust", "sql", "toml", "typescript", "wgsl", "yaml", "zig"
      },
      sync_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = "<C-s>",
          node_decremental = "<M-r>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    })
  end
end

return M
