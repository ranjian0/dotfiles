local M = {}

function M.config()
  require("opencode").setup({
    preferred_picker = "telescope",
    preferred_completion = "nvim-cmp",
    default_global_keymaps = true,
    default_mode = "build",
    keymap_prefix = "<leader>o",
    opencode_executable = "opencode",
    ui = {
      position = "right",
      input_position = "bottom",
      window_width = 0.40,
      zoom_width = 0.8,
      input_height = 0.15,
      display_model = true,
      display_context_size = true,
      display_cost = true,
      window_highlight = "Normal:OpencodeBackground,FloatBorder:OpencodeBorder",
      icons = {
        preset = "nerdfonts",
        overrides = {},
      },
      output = {
        tools = {
          show_output = true,
          show_reasoning_output = true,
        },
        rendering = {
          markdown_debounce_ms = 250,
          on_data_rendered = nil,
        },
      },
      input = {
        text = {
          wrap = false,
        },
      },
      picker = {
        snacks_layout = nil,
      },
      completion = {
        file_sources = {
          enabled = true,
          preferred_cli_tool = "server",
          ignore_patterns = {
            "^%.git/",
            "^%.svn/",
            "^%.hg/",
            "node_modules/",
            "%.pyc$",
            "%.o$",
            "%.obj$",
            "%.exe$",
            "%.dll$",
            "%.so$",
            "%.dylib$",
            "%.class$",
            "%.jar$",
            "%.war$",
            "%.ear$",
            "target/",
            "build/",
            "dist/",
            "out/",
            "deps/",
            "%.tmp$",
            "%.temp$",
            "%.log$",
            "%.cache$",
          },
          max_files = 10,
          max_display_length = 50,
        },
      },
    },
    context = {
      enabled = true,
      cursor_data = {
        enabled = false,
        context_lines = 5,
      },
      diagnostics = {
        info = false,
        warn = true,
        error = true,
        only_closest = false,
      },
      current_file = {
        enabled = true,
        show_full_path = true,
      },
      files = {
        enabled = true,
        show_full_path = true,
      },
      selection = {
        enabled = true,
      },
      buffer = {
        enabled = false,
      },
      git_diff = {
        enabled = false,
      },
    },
    debug = {
      enabled = false,
      capture_streamed_events = false,
      show_ids = true,
      quick_chat = {
        keep_session = false,
        set_active_session = false,
      },
    },
    prompt_guard = nil,
    hooks = {
      on_file_edited = nil,
      on_session_loaded = nil,
      on_done_thinking = nil,
      on_permission_requested = nil,
    },
    quick_chat = {
      default_model = nil,
      default_agent = "plan",
      instructions = nil,
    },
  })
end

return M
