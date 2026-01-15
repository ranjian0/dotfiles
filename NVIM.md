# Neovim Configuration Cheatsheet

Comprehensive guide to all keymaps and functionality in this Neovim configuration.

**Last Updated:** 2025-01-15
**Configuration Status:** All fixes applied, no breaking errors

---

## Table of Contents

- [Editor Basics](#editor-basics)
- [Window Management](#window-management)
- [File Management](#file-management)
- [Search & Navigation](#search--navigation)
- [LSP & Code Intelligence](#lsp--code-intelligence)
- [Git Integration](#git-integration)
- [Terminal](#terminal)
- [Testing](#testing)
- [Quickfix & Diagnostics](#quickfix--diagnostics)
- [Search & Replace](#search--replace)
- [Session Management](#session-management)
- [Harpoon Quick Navigation](#harpoon-quick-navigation)
- [Text Objects & Movement](#text-objects--movement)
- [Auto Features](#auto-features)

---

## Editor Basics

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<Esc>` | Normal, Insert | Clear search highlight |
| `<C-s>` | Insert, Visual, Normal, Select | Save file |
| `<A-j>` | Normal, Insert, Visual | Move line down |
| `<A-k>` | Normal, Insert, Visual | Move line up |
| `<leader>qq` | Normal | Quit all |
| `<leader>cS` | Normal | Convert tabs to spaces |
| `<leader>cT` | Normal | Convert spaces to tabs |
| `<leader>cW` | Normal | Trim trailing whitespace |

### Auto Features

- **Auto-save on focus lost** - Files save automatically when window loses focus
- **Auto trim whitespace** - Trailing whitespace removed on save
- **Auto create parent dirs** - Directories created when saving new files
- **Yank highlighting** - Yanked text highlighted briefly
- **Auto-resize splits** - Splits resized when terminal resizes
- **Auto-format on save** - LSP formats code before saving
- **Disable auto-comment** - New lines don't automatically add comment prefix

---

## Window Management

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<C-h>` | Normal | Go to left window |
| `<C-j>` | Normal | Go to lower window |
| `<C-k>` | Normal | Go to upper window |
| `<C-l>` | Normal | Go to right window |
| `<C-Up>` | Normal | Increase window height |
| `<C-Down>` | Normal | Decrease window height |
| `<C-Left>` | Normal | Decrease window width |
| `<C-Right>` | Normal | Increase window width |

---

## File Management

### Buffer Management

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>bn` | Normal | Next buffer |
| `<leader>bp` | Normal | Previous buffer |
| `<leader>bd` | Normal | Delete buffer (Bdelete) |

### File Tree (Neo-tree)

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>fe` | Normal | Toggle file tree |
| `q` | Neo-tree | Close |

---

## Search & Navigation

### Telescope

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>ff` | Normal | Find files (root dir) |
| `<leader>fg` | Normal | Live grep (root dir) |
| `<leader>fb` | Normal | Switch buffer |
| `<leader>fc` | Normal | Git commit history |
| `<leader>ft` | Normal | Colorschemes with preview |
| `<leader>fk` | Normal | Keymaps |
| `<leader>ffg` | Normal | Find files (git only) |
| `<leader>fu` | Normal | Recent files (frecency) |
| `<leader>fw` | Normal | Undo history |
| `<leader>fp` | Normal | Projects |

### Telescope Mappings

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<C-j>` | Insert | Move to next result |
| `<C-k>` | Insert | Move to previous result |
| `<C-q>` | Insert | Send to quickfix |
| `<Esc>` | Insert | Close |
| `q` | Normal | Close |

---

## LSP & Code Intelligence

### LSP Core

| Keymap | Mode | Description |
|--------|-------|-------------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `K` | Normal | Hover documentation |
| `gi` | Normal | Go to implementation |
| `<leader>sh` | Normal | Signature help |
| `<leader>ca` | Normal, Visual | Code actions |
| `<leader>wa` | Normal | Add workspace folder |
| `<leader>wr` | Normal | Remove workspace folder |
| `<leader>wl` | Normal | List workspace folders |

### LSP Keymaps (Leader + l)

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>la` | Normal | Code action |
| `<leader>ld` | Normal | Preview definition |
| `<leader>lr` | Normal | Rename |
| `<leader>lq` | Normal | Diagnostics to loclist |
| `<leader>lh` | Normal | Signature help |
| `<leader>lf` | Normal | Format |
| `<leader>lk` | Normal | Hover doc |
| `<leader>lo` | Normal | Outline |
| `<leader>ln` | Normal | Next diagnostic |
| `<leader>lN` | Normal | Previous diagnostic |

### Glance (Code Navigation)

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>lgd` | Normal | Glance definitions |
| `<leader>lgr` | Normal | Glance references |
| `<leader>lgt` | Normal | Glance type definitions |
| `<leader>lgi` | Normal | Glance implementations |

### Autocompletion (nvim-cmp)

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<C-Space>` | Insert | Complete |
| `<C-e>` | Insert | Abort |
| `<CR>` | Insert | Confirm selection |

---

## Git Integration

### LazyGit

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>gg` | Normal | Open LazyGit |

### Gitsigns

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>gu` | Normal | Undo stage hunk |
| `<leader>gn` | Normal | Next hunk |
| `<leader>gN` | Normal | Previous hunk |
| `<leader>gc` | Normal | Preview hunk |
| `<leader>gr` | Normal | Reset hunk |
| `<leader>gR` | Normal | Reset buffer |
| `<leader>gl` | Normal | Blame line |
| `<leader>gd` | Normal | Diff this |
| `<leader>gs` | Normal | Select hunk |
| `<leader>gD` | Normal | Open diffview |

### Git Conflict

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>co` | Normal | Choose ours |
| `<leader>ct` | Normal | Choose theirs |
| `<leader>cb` | Normal | Choose both |
| `<leader>c0` | Normal | Choose none |
| `]x` | Normal | Next conflict |
| `[x` | Normal | Previous conflict |

### Diffview

- **Auto-opens** with `<leader>gD`
- **Navigation**: Standard telescope/vim navigation
- **Actions**: Check `:h diffview-available-actions`

---

## Terminal

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<F5>` | Normal | Toggle terminal (default) |
| `<C-g>` | Terminal | Exit terminal mode |
| `<leader>tt` | Normal | Toggle terminal (tab) |
| `<leader>tn` | Normal | Toggle terminal (new) |
| `<leader>tf` | Normal | Toggle terminal (float) |
| `<leader>th` | Normal | Toggle terminal (horizontal) |
| `<leader>tv` | Normal | Toggle terminal (vertical) |

---

## Testing

### Test Management

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>tr` | Normal | Run nearest test |
| `<leader>tf` | Normal | Run file tests |
| `<leader>td` | Normal | Debug test |
| `<leader>ts` | Normal | Toggle test summary |
| `<leader>to` | Normal | Open test output |

### Test Summary Mappings

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<CR>` | Normal | Expand/Select test |
| `e` | Normal | Expand all tests |
| `o` | Normal | Show output |
| `O` | Normal | Show short output |
| `i` | Normal | Jump to test |
| `r` | Normal | Run test |
| `R` | Normal | Run all tests |
| `d` | Normal | Debug test |
| `q` / `<Esc>` | Normal | Close |
| `?` | Normal | Help |

---

## Quickfix & Diagnostics

| Keymap | Mode | Description |
|--------|-------|-------------|
| `[q` | Normal | Previous quickfix item |
| `]q` | Normal | Next quickfix item |
| `[Q` | Normal | First quickfix item |
| `]Q` | Normal | Last quickfix item |
| `<leader>xq` | Normal | Open quickfix |
| `<leader>xl` | Normal | Open loclist |

### Diagnostic Navigation

| Keymap | Mode | Description |
|--------|-------|-------------|
| `[d` | Normal | Previous diagnostic |
| `]d` | Normal | Next diagnostic |
| `[e` | Normal | Previous error |
| `]e` | Normal | Next error |

---

## Search & Replace (Spectre)

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>sr` | Normal | Search and replace (global) |
| `<leader>sw` | Normal | Search in current file |
| `<leader>sp` | Normal | Search in selection |

### Spectre Actions

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<CR>` | Normal | Go to file |
| `dd` | Normal | Toggle item |
| `<leader>R` | Normal | Replace all |
| `<leader>rc` | Normal | Replace current |
| `<leader>o` | Normal | Show options |
| `q` | Normal | Close |

---

## Session Management (Persisted)

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>ps` | Normal | Save session |
| `<leader>pl` | Normal | Load session |
| `<leader>pd` | Normal | Delete session |

**Features:**
- Auto-save sessions
- Git branch-aware sessions
- Follow current working directory

---

## Harpoon Quick Navigation

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>ha` | Normal | Add file to harpoon |
| `<leader>hr` | Normal | Remove file from harpoon |
| `<leader>hh` | Normal | Toggle harpoon menu |
| `<leader>ht` | Normal | Telescope harpoon marks |
| `<C-h>` | Normal | Go to harpoon mark 1 |
| `<C-t>` | Normal | Go to harpoon mark 2 |
| `<C-n>` | Normal | Go to harpoon mark 3 |
| `<C-s>` | Normal | Go to harpoon mark 4 |

---

## Text Objects & Movement

### Treesitter Text Objects

| Keymap | Mode | Description |
|--------|-------|-------------|
| `af` | Operator | Function outer |
| `if` | Operator | Function inner |
| `ac` | Operator | Class outer |
| `ic` | Operator | Class inner |
| `aa` | Operator | Parameter outer |
| `ia` | Operator | Parameter inner |

### Treesitter Movement

| Keymap | Mode | Description |
|--------|-------|-------------|
| `]m` | Normal | Next function |
| `[m` | Normal | Previous function |
| `]M` | Normal | Next function end |
| `[M` | Normal | Previous function end |
| `]]` | Normal | Next class |
| `[[` | Normal | Previous class |
| `][` | Normal | Next class end |
| `[]` | Normal | Previous class end |

### Incremental Selection

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<C-n>` | Normal | Init/Increment selection |
| `<C-s>` | Normal | Scope increment |
| `<M-r>` | Normal | Decrement selection |

### Mini.surround (Surround)

| Keymap | Mode | Description |
|--------|-------|-------------|
| `sa` | Normal | Add surround |
| `sd` | Normal | Delete surround |
| `sf` | Normal | Find surround |
| `sF` | Normal | Find surround left |
| `sh` | Normal | Highlight surround |
| `sr` | Normal | Replace surround |
| `sn` | Normal | Update n-lines |

### Mini.ai Text Objects

- Enhanced text objects with treesitter support
- `a` = block/conditional/loop outer
- `i` = block/conditional/loop inner
- `f` = function
- `c` = class
- `t` = tag
- `d` = comment

---

## Plugin Management

| Keymap | Mode | Description |
|--------|-------|-------------|
| `<leader>ll` | Normal | Open Lazy (plugin manager) |
| `<leader>cm` | Normal | Open Mason (LSP manager) |
| `<leader>cv` | Normal | Select Python virtualenv |

---

## Visual Features

### Indent Guides (indent-blankline)
- Rainbow-colored indent lines
- Shows scope boundaries
- Automatically adapts to file structure

### Word Highlighting (illuminate)
- Highlights word under cursor
- Supports LSP, Treesitter, and regex
- Performance-optimized for large files

### Color Highlighting (colorizer)
- Highlights hex colors (#RRGGBB, #RGB)
- Highlights color names
- Works in all filetypes

### Pattern Highlighting (mini.hipatterns)
- Highlights hex colors inline
- Highlights TODO/FIXME/NOTE/HACK markers
- Real-time updating

### Inlay Hints
- Auto-enabled for LSPs that support it
- Shows parameter names and types inline

---

## Python Specific

### Virtual Environment
- Auto-detects venv
- Selector: `<leader>cv`
- Mason installs: `lua_ls`, `pyright`, `ruff`, `black`

### Testing
- Uses pytest runner
- Supports debugging with DAP
- Test summary with expandable tree

---

## Configuration

### Formatters (conform.nvim)
- **Lua**: stylua
- **Python**: black, isort
- **JavaScript/TypeScript**: prettier
- **JSON/YAML/Markdown**: prettier
- **Go**: gofmt
- **Rust**: rustfmt
- **C/C++**: clang-format
- **Bash/Sh**: shfmt

### Linters (nvim-lint)
- **JavaScript/TypeScript**: eslint
- **Python**: ruff
- **Markdown**: markdownlint
- **Bash/Sh**: shellcheck

---

## Tips & Tricks

1. **Fast Navigation**: Use harpoon (`<C-h/t/n/s>`) for frequently accessed files
2. **Quick Search**: `<leader>fg` for ripgrep, `<leader>fu` for recent files
3. **Code Navigation**: Use `gd` for definition, `<leader>lgd` for Glance overview
4. **Git Work**: `<leader>gg` for LazyGit, `<leader>gD` for diffs
5. **Session Save**: Use `<leader>ps` before closing for session persistence
6. **Testing**: Run tests directly from file with `<leader>tf`
7. **Search/Replace**: Use `<leader>sr` for powerful project-wide search
8. **LSP**: Use `<leader>lo` for outline view, `<leader>ca` for code actions

---

## Plugin List

### Core
- lazy.nvim - Plugin manager
- Mason.nvim - LSP manager
- nvim-lspconfig - LSP configuration
- nvim-treesitter - Syntax highlighting & text objects
- nvim-cmp - Autocompletion
- LuaSnip - Snippets

### Navigation & Search
- Telescope.nvim - Fuzzy finder
- telescope-frecency - Recent files
- telescope-undo - Undo history
- nvim-spectre - Search & replace
- Harpoon - Quick file marks
- Neo-tree - File tree

### Git
- LazyGit - Git UI
- Gitsigns - Git signs in gutter
- Diffview - Git diff viewer
- git-conflict - Merge conflict resolution

### UI & Visuals
- noice.nvim - UI improvements
- indent-blankline - Indent guides
- nvim-illuminate - Word highlighting
- nvim-colorizer - Color highlighting
- mini.hipatterns - Pattern highlighting
- lualine - Statusline
- bufferline - Buffer tabs

### Editing
- nvim-autopairs - Auto brackets/quotes
- mini.pairs - Lightweight pairs
- mini.ai - Advanced text objects
- mini.surround - Surround text
- conform.nvim - Formatting
- nvim-lint - Linting

### Testing
- neotest - Test runner
- neotest-python - Python adapter

### Quality of Life
- persisted.nvim - Session management
- project.nvim - Project detection
- better-escape - Faster jk escape
- toggleterm.nvim - Terminal management
- Comment.nvim - Commenting
- which-key.nvim - Keymap hints

---

*Last updated: 2025-01-15*
