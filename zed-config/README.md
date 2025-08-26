# Zed Configuration Based on Neovim Setup

This directory contains a Zed editor configuration that mirrors your Neovim setup with vim mode bindings and similar functionality.

## Installation

1. **Locate your Zed config directory:**
   - macOS: `~/.config/zed/`
   - Linux: `~/.config/zed/`
   - Windows: `%APPDATA%\Zed\`

2. **Copy the configuration files:**
   ```bash
   # From this directory, copy files to your Zed config directory
   cp settings.json ~/.config/zed/settings.json
   cp keymap.json ~/.config/zed/keymap.json
   cp tasks.json ~/.config/zed/tasks.json
   ```

3. **Restart Zed** for the changes to take effect.

## Key Mappings

This configuration replicates your Neovim key bindings as closely as possible:

### Leader Key
- Leader key is `space` (same as your Neovim config)

### Insert Mode
- `jj` → Escape to normal mode

### Normal Mode Navigation
- `j/k` → Visual line movement (gj/gk equivalent)
- `0` → Start of line (swapped with ^)
- `^` → First non-whitespace character (swapped with 0)
- `=` → Repeat find (replaces comma functionality)

### Buffer Management
- `,d` → Close current buffer
- `,D` → Close all buffers
- `,b` → Switch to previous buffer
- `,p` → Previous buffer
- `,n` → Next buffer

### Window Management
- `,v` → Vertical split
- `,h/j/k/l` → Navigate between panes
- `,z` → Zoom/maximize current pane
- `,=` → Equalize pane sizes
- `,c` → Close current pane
- `,+/-` → Resize panes

### Find and Replace
- `,rr` → Find and replace with confirmation
- `,rg` → Find and replace globally
- `,rw` → Find and replace word under cursor

### File Operations
- `,ff` → Find files
- `,fg` → Project-wide search
- `,ft` → Search for word under cursor
- `,fm` → Recent files
- `,fe` → Buffer switcher
- `,fs` → Git status/branches
- `,fq` → Diagnostics panel

### LSP Features
- `gd` → Go to definition
- `gi` → Go to implementation
- `,fr` → Find references
- `gr` → Rename symbol
- `ga` → Code actions
- `K` → Hover documentation
- `ctrl-h` → Toggle inlay hints
- `ctrl-j/k` → Next/previous diagnostic

### Git Integration
- `space h j/k` → Next/previous hunk
- `space h h` → Show hunk diff
- `space h u` → Revert hunk
- `gb` → Git blame
- `gh` → Git history (recent projects)

### Testing (Neotest equivalent)
- `space t t` → Run tests
- `space t T` → Run all tests
- `space t r` → Run nearest test
- `space t l` → Run last test
- `space t s` → Toggle test summary (outline)

### Debugging (DAP equivalent)
- `space d b` → Toggle breakpoint
- `space d c` → Continue debugging
- `space d i` → Step into
- `space d o` → Step over
- `space d O` → Step out
- `space d u` → Toggle debug UI

### Project Panel (NvimTree equivalent)
- `,m` → Toggle project panel
- `,,` → Reveal current file in project panel

### Other Useful Bindings
- `,y` → Clear search highlights
- `,sa` → Select all
- `,q` → Quit all
- `,w` → Save all
- `,sh` → Toggle invisible characters
- `space p` → Replace word with paste (greatest remap)
- `space x x` → Toggle diagnostics
- `space u` → Undo
- `space s r` → Search and replace

### Visual Mode
- `J/K` → Move selected lines down/up

### Project Panel Bindings
When focused on the project panel:
- `o/Enter` → Open file
- `s` → Open in vertical split
- `t` → Open in new tab
- `a` → New file
- `d` → Delete
- `r` → Rename
- `q` → Close panel
- `H` → Toggle hidden files

## Language-Specific Features

### Formatters
The configuration includes formatters for:
- **JavaScript/TypeScript**: Prettier
- **Go**: gofumpt
- **Rust**: rustfmt
- **Lua**: stylua
- **JSON/HTML/CSS/YAML**: Prettier

### LSP Configuration
- **Go**: gopls with same settings as your Neovim config
- **Rust**: rust-analyzer with clippy
- **TypeScript**: Automatic import organization

### Code Actions
- Automatic import organization on save for TS/JS
- Remove unused imports
- Format on save enabled

## Tasks

The `tasks.json` file includes predefined tasks for:
- Running tests (Go, Jest, Vitest, Cargo)
- Building projects
- Linting (ESLint, Clippy)
- Formatting

Access tasks via `space t t` or the command palette.

## Themes

- **Dark theme**: Kanagawa (matching your Neovim setup)
- **Light theme**: One Light
- **Theme switching**: Follows system preference
- Toggle with `space t b`

## Additional Features

### Copilot Integration
- Enabled by default
- `ctrl-d/u` for next/previous suggestion in insert mode

### Git Integration
- Git gutter enabled
- Inline blame available
- Hunk navigation and management

### Project Features
- Auto-format on save
- Relative line numbers
- 8-line scroll offset
- Tab size 2 spaces
- Remove trailing whitespace on save

## Differences from Neovim

Some features that work differently or aren't available:
1. **Harpoon**: Replaced with bookmark-like functionality using tab switching
2. **Undo tree**: Basic undo instead of full tree visualization
3. **Cellular automaton**: Not available (mapped to select all as placeholder)
4. **Complex autocmds**: Replaced with Zed's built-in file type detection
5. **Plugin ecosystem**: Limited to Zed's built-in features and extensions

## Tips

1. Use `cmd-shift-p` (macOS) or `ctrl-shift-p` (Linux/Windows) to access the command palette
2. Many vim motions and text objects work as expected
3. Visual block mode is available with `ctrl-v`
4. Search with `/` and `?` works as in vim
5. Registers and macros are supported (though more limited than vim)

## Troubleshooting

1. **Key bindings not working**: Ensure vim mode is enabled in settings
2. **Formatters not found**: Install required tools (prettier, stylua, gofumpt, etc.)
3. **LSP issues**: Check that language servers are installed and available in PATH
4. **Tasks not running**: Verify commands exist and have proper permissions

For more information, see the [Zed documentation](https://zed.dev/docs).