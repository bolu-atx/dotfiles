# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is an AstroNvim v5+ user configuration. AstroNvim is a Neovim distribution that provides a pre-configured IDE-like experience. This repo contains user customizations layered on top of the base AstroNvim setup.

## Architecture

**Plugin Management**: Uses lazy.nvim for plugin loading. The bootstrap happens in `init.lua`, which loads `lazy_setup.lua` and `polish.lua`.

**Load Order**:
1. `init.lua` - Bootstraps lazy.nvim
2. `lazy_setup.lua` - Configures lazy.nvim with AstroNvim core, community plugins, and user plugins
3. `lua/community.lua` - AstroCommunity plugin imports (currently disabled)
4. `lua/plugins/*.lua` - User plugin configurations (each file returns a LazySpec)
5. `lua/polish.lua` - Final customizations after all plugins load (currently disabled)

**Key Plugin Files**:
- `astrocore.lua` - Core options, mappings, diagnostics, filetypes (active)
- `astrolsp.lua` - LSP configuration (template, disabled)
- `astroui.lua` - UI/theme configuration (template, disabled)
- `mason.lua` - Mason package installations (template, disabled)
- `user.lua` - Custom heirline statusline showing relative file paths (active)

**Disabled Files**: Files starting with `if true then return {} end` are inactive templates.

## Lua Formatting

Uses StyLua with these settings (`.stylua.toml`):
- 120 column width
- 2 spaces indentation
- No call parentheses
- Collapse simple statements

## Custom Keybindings

- `<Space>` - Leader key
- `,` - Local leader
- `gH` - Toggle between C/C++ source and header files
- `]b` / `[b` - Navigate buffer tabs
- `<Leader>bd` - Close buffer from tabline picker
