# Neovim Configuration with NvF and NixOS

A modern, feature-rich Neovim configuration built using NVF managed through NixOS for reproducible, declarative configuration management.

## 🚀 Features

### Core Functionality

- **LSP Support**: Full Language Server Protocol integration for intelligent code completion and diagnostics
- **Treesitter**: Advanced syntax highlighting and code parsing
- **Autocompletion**: Nvim-cmp powered completion with multiple sources
- **File Management**: Neo-tree file explorer with git integration
- **Fuzzy Finding**: Telescope for file search, live grep, and more
- **AI Assistant**: Claude-powered code suggestions via Avante-nvim

### Language Support

- **Web Development**: HTML, CSS, JavaScript/TypeScript, PHP
- **Programming**: Python, Go, Rust, Java, Lua
- **Configuration**: Nix, YAML, SQL, Bash
- **Documentation**: Markdown with enhanced features
- **Org Mode**: Full Org mode support for note-taking and task management

### UI & Experience

- **Theme**: Doom One theme for a modern, dark appearance
- **Status Line**: Lualine for informative status display
- **Keymaps**: Which-key integration for discoverable shortcuts
- **Spell Checking**: Built-in spell checking with English support
- **Terminal Integration**: Built-in terminal with floating window support

## 🎯 Key Features

### AI-Powered Development

- **Claude Integration**: AI code suggestions and completions
- **Auto-suggestions**: Context-aware code recommendations
- **Diff Application**: Easy application of AI-generated code changes

### File Management

- **Neo-tree**: Sidebar file explorer with git status
- **Telescope**: Powerful fuzzy finder for files, grep, and more
- **File Browser**: Emacs-like file navigation experience

### Development Tools

- **LSP**: Language-specific features for all supported languages
- **Treesitter**: Advanced syntax highlighting and code analysis
- **Formatting**: Prettier integration for code formatting
- **Image Support**: ImageMagick integration for image display

## ⌨️ Keymaps

### Navigation

- `<leader>ff` - Find files with Telescope
- `<leader>fg` - Live grep with Telescope
- `<leader>t` - Toggle Neo-tree file explorer
- `<leader>.` - Open file browser in current directory

### Window Management

- `<leader>wh/j/k/l` - Navigate between windows
- `<leader>ws` - Split horizontally
- `<leader>wv` - Split vertically
- `<leader>wx` - Close buffer
- `<leader>wc` - Close pane

### Terminal

- `<leader>ot` - Open terminal below
- `<leader>oT` - Open terminal to the right
- `<leader>T` - Toggle floating terminal

### Buffer Management

- `<leader><Tab>h/l` - Previous/next buffer
- `<leader><Tab>1-9` - Go to specific buffer
- `<leader><Tab>p` - Pin/unpin buffer
- `<leader><Tab>x` - Close buffer

### System Integration

- `<leader>=dc` - Open Neovim configuration
- `<leader>=dn` - Open Nix configuration
- `<leader>y/Y` - Copy to system clipboard
- `<leader>p/P` - Paste from system clipboard

## 🏗️ Architecture

### Configuration Structure

```
nvim/
├── nvf-configuration.nix    # Main configuration file
├── plugins.nix              # Plugin definitions and settings
├── languages.nix            # Language-specific configurations
├── keymaps.nix              # Basic keymap definitions
├── lua-keymaps.nix          # Lua-based keymap configurations
├── lua-plugin-configs.nix   # Lua plugin configurations
├── lua-theme-config.nix     # Theme Lua configurations
├── lua-markdown-config.nix  # Markdown-specific settings
├── lua-markdown-theme.nix   # Markdown theme configurations
├── autocomplete.nix         # Autocompletion settings
├── formatter.nix            # Code formatting configuration
├── theme.nix                # Theme selection
├── notes.nix                # Note-taking features
└── org-mode-import.nix      # Org mode integration
```

### NixOS Integration

This configuration is designed to work seamlessly with NixOS, providing:

- **Reproducible builds**: Same configuration across all systems
- **Dependency management**: Automatic handling of required packages
- **System integration**: Proper integration with NixOS packages
- **Declarative configuration**: Version-controlled, declarative setup

## 🚀 Getting Started

### Prerequisites

- NixOS or Nix with flakes enabled
- Neovim 0.9.0+
- Required system packages (automatically managed by Nix)

### Installation

1. Clone this repository to your dotfiles
2. Import the configuration in your NixOS configuration
3. Rebuild your system: `sudo nixos-rebuild switch`

### Configuration

The main configuration file is `nvf-configuration.nix`. Key sections include:

- **vim.statusline**: Status line configuration
- **vim.telescope**: Fuzzy finder settings
- **vim.autocomplete**: Completion system configuration
- **vim.lsp**: Language server settings
- **vim.spellcheck**: Spell checking configuration
- **vim.filetree**: File explorer settings

## 🔧 Customization

### Adding Plugins

Add new plugins in `plugins.nix`:

```nix
vim.lazy.plugins."plugin-name" = {
  package = pkgs.vimPlugins.plugin-name;
  event = [{ event = "BufReadPre"; pattern = "*"; }];
};
```

### Language Support

Enable additional languages in `languages.nix`:

```nix
vim.languages.newLanguage = {
  enable = true;
  treesitter.enable = true;
  lsp.enable = true;
};
```

### Keymaps

Add custom keymaps in `lua-keymaps.nix`:

```lua
vim.keymap.set('n', '<leader>custom', '<cmd>CustomCommand<cr>', { desc = "Custom Action" })
```

## 🌟 Highlights

- **AI Integration**: Claude-powered code assistance
- **Modern UI**: Clean, professional appearance with Doom One theme
- **Productivity**: Comprehensive tooling for development workflows
- **NixOS Native**: Built for NixOS from the ground up
- **Extensible**: Easy to customize and extend

## 📚 Resources

- [NvF Documentation](https://github.com/NotAShelf/nvf)
- [Neovim Documentation](https://neovim.io/doc/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Treesitter](https://tree-sitter.github.io/tree-sitter/)

