# AstroNvim Onboarding Guide

Your practical guide to using this nvim setup for mono-repo projects.

> **Note:** This config targets AstroNvim v5+ which requires Neovim 0.10+.
> v5 uses `snacks.nvim` (not Telescope) and `blink.cmp` (not nvim-cmp).

## First Launch

On first launch, nvim will auto-install:
- Lazy.nvim (plugin manager)
- All configured plugins
- Mason packages (LSPs, formatters, linters)
- Treesitter parsers

This takes a few minutes. Run `:Lazy` to check plugin status, `:Mason` to check tool status.

---

## Essential Keybindings

**Leader key is `Space`**, local leader is `,`

### Navigation

| Key | Action |
|-----|--------|
| `Space f f` | Find files (Snacks picker) |
| `Space f w` | Find word (live grep) |
| `Space f b` | Find buffers |
| `Space f o` | Find recent files |
| `Space f p` | Find files in project root |
| `Space e` | Toggle file explorer (Neo-tree) |

### Buffers & Windows

| Key | Action |
|-----|--------|
| `]b` / `[b` | Next/previous buffer |
| `Space b d` | Pick buffer to close |
| `Space w` | Quick save |
| `Ctrl+h/j/k/l` | Navigate windows |
| `Space /` | Toggle comment |

### LSP (when attached)

| Key | Action |
|-----|--------|
| `g d` | Go to definition |
| `g r` | Go to references |
| `g D` | Go to declaration |
| `K` | Hover documentation |
| `Space l a` | Code actions |
| `Space l r` | Rename symbol |
| `Space l f` | Format file |
| `Space l h` | Toggle inlay hints |
| `Space l d` | Line diagnostics |
| `]d` / `[d` | Next/prev diagnostic |

### Diagnostics (Trouble)

| Key | Action |
|-----|--------|
| `Space x x` | All diagnostics |
| `Space x X` | Buffer diagnostics only |
| `Space x Q` | Quickfix list |
| `]q` / `[q` | Next/prev quickfix item |

### Search & Motion

| Key | Action |
|-----|--------|
| `s{char}{char}` | Leap to location (fast jump) |
| `Space f t` | Find TODOs |
| `*` / `#` | Search word under cursor |

---

## Mono-Repo Workflows

### Opening a Project

```bash
# Open from project root - LSP will use this as workspace
cd ~/projects/my-monorepo
nvim .
```

Or open a specific package:
```bash
cd ~/projects/my-monorepo/packages/backend
nvim .
```

### Project Root Detection

The `project.nvim` plugin auto-detects project root using:
- `.git` directory
- `package.json`, `tsconfig.json` (TypeScript)
- `pyproject.toml`, `setup.py` (Python)
- `meson.build`, `CMakeLists.txt` (C++)

Press `Space f p` to search files from detected root.

### Working with Multiple Languages

Your setup handles polyglot repos. LSPs attach per-filetype:

| File | LSP |
|------|-----|
| `.ts`, `.tsx` | typescript-language-server |
| `.py` | pyright |
| `.cpp`, `.c`, `.h` | clangd |
| `meson.build` | (treesitter highlighting) |
| `CMakeLists.txt` | cmake-language-server |

---

## TypeScript Projects

### Setup Requirements

Ensure your project has:
```
tsconfig.json       # Root or per-package
package.json        # For module resolution
```

### Mono-repo with Multiple tsconfigs

For Nx, Turborepo, or pnpm workspaces, each package typically has its own `tsconfig.json`. The LSP will find the nearest one.

### Common Operations

1. **Go to definition across packages**: `g d` works across package boundaries
2. **Find all references**: `g r` shows cross-package usage
3. **Rename symbol**: `Space l r` renames across files
4. **Import suggestions**: Autocomplete suggests imports
5. **Format on save**: Uses prettier (disable LSP formatting for ts_ls)

### ESLint Integration

ESLint runs via `eslint-lsp`. Errors appear inline. Fix all with `Space l a` on the error.

---

## Python Projects

### Setup Requirements

```
pyproject.toml   # or setup.py
pyrightconfig.json  # optional, for stricter settings
```

### Virtual Environments

Pyright auto-detects venvs. Activate before opening nvim:

```bash
source .venv/bin/activate  # or: poetry shell
nvim .
```

Or set in `pyrightconfig.json`:
```json
{
  "venvPath": ".",
  "venv": ".venv"
}
```

### Formatting

Ruff handles formatting and linting. Format on save is enabled.

### Type Checking

Pyright runs in "basic" mode. For stricter checking:
```json
// pyrightconfig.json
{
  "typeCheckingMode": "strict"
}
```

---

## C++ Projects (Meson/CMake)

### Meson Setup

Generate `compile_commands.json`:
```bash
meson setup builddir
# compile_commands.json is in builddir/
```

Symlink or copy to project root for clangd:
```bash
ln -s builddir/compile_commands.json .
```

### CMake Setup

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/compile_commands.json .
```

### Clangd Features

Your clangd config includes:
- `--background-index`: Index files for faster navigation
- `--clang-tidy`: Run clang-tidy checks inline
- `--header-insertion=iwyu`: Suggest missing includes

### Header Navigation

| Key | Action |
|-----|--------|
| `g d` | Go to definition (works for headers) |
| `g r` | Find all references |
| `Space l s` | Document symbols |

### Debugging (DAP)

codelldb is installed. Configure in `.vscode/launch.json` format or use nvim-dap directly:

```lua
-- Quick debug current file
:DapContinue
```

---

## Helpful Commands

| Command | Purpose |
|---------|---------|
| `:LspInfo` | See attached LSPs |
| `:Mason` | Manage LSP/tools |
| `:Lazy` | Manage plugins |
| `:checkhealth` | Diagnose issues |
| `Space f k` | Search all keybindings |

### Which-Key

Press `Space` and wait - a popup shows all available commands. This is your cheat sheet.

---

## Troubleshooting

### LSP Not Attaching

1. Check `:LspInfo` for errors
2. Verify project has config file (tsconfig.json, etc.)
3. Run `:LspInstall <server>` if missing
4. Check `:Mason` that server is installed

### No Formatting on Save

1. Check `:LspInfo` for attached formatters
2. Some servers are disabled for formatting (lua_ls, ts_ls) - use external tools
3. Manually format with `Space l f`

### Slow on Large Files

Large files (>500KB or >20k lines) auto-disable treesitter and some features. This is intentional.

### Clangd Can't Find Headers

1. Ensure `compile_commands.json` exists in project root
2. Regenerate after adding new files
3. Check `.clangd` file for custom include paths

---

## Cheat Sheet

Print this or keep it handy. **Leader = Space**, LocalLeader = `,`

### File & Project Navigation

```
Space f f     Find files in project
Space f w     Live grep (search text)
Space f b     Find open buffers
Space f o     Recent files
Space f p     Files from project root
Space f t     Find TODO/FIXME/HACK
Space f k     Search keybindings
Space f '     Find marks
Space f "     Find registers
Space e       Toggle file explorer (Neo-tree)
Space o       Focus file explorer
```

### Buffers

```
]b            Next buffer
[b            Previous buffer
Space b b     Switch buffer (picker)
Space b d     Pick buffer to close
Space b c     Close current buffer
Space b C     Close all buffers except current
Space b n     New empty buffer
Space w       Save current buffer
Space W       Save all buffers
```

### Windows & Splits

```
Ctrl+h/j/k/l  Navigate windows
Space \       Horizontal split
Space |       Vertical split
Space q       Close window
Ctrl+Up/Down  Resize vertically
Ctrl+Left/Right  Resize horizontally
```

### LSP - Code Intelligence

```
K             Hover documentation
g d           Go to definition
g D           Go to declaration
g r           Go to references
g I           Go to implementation
g y           Go to type definition
Space l a     Code actions
Space l r     Rename symbol
Space l s     Document symbols
Space l S     Workspace symbols
Space l f     Format buffer
Space l h     Toggle inlay hints
Space l d     Line diagnostics (float)
Space l D     All buffer diagnostics
]d            Next diagnostic
[d            Previous diagnostic
```

### LSP - Advanced

```
Space l i     LSP info
Space l l     CodeLens refresh
Space l L     CodeLens run
Space u i     Toggle inlay hints (global)
Space u H     Toggle syntax highlighting
Space u Y     Toggle LSP semantic tokens
```

### Diagnostics & Trouble

```
Space x x     Toggle all diagnostics
Space x X     Buffer diagnostics only
Space x L     Location list
Space x Q     Quickfix list
]q            Next quickfix item
[q            Previous quickfix item
]x            Next Trouble item
[x            Previous Trouble item
```

### Git Integration

```
Space g g     Lazygit (if installed)
Space g b     Git blame line
Space g B     Git branches
Space g c     Git commits
Space g C     Git commits (buffer)
Space g s     Git status
Space g d     Git diff
]g            Next git hunk
[g            Previous git hunk
Space g h     Preview hunk
Space g r     Reset hunk
Space g R     Reset buffer
Space g S     Stage hunk
Space g u     Undo stage hunk
```

### Search & Replace

```
*             Search word under cursor (forward)
#             Search word under cursor (backward)
n / N         Next/previous search result
Space s r     Search and replace (Spectre)
Space s w     Search current word
```

### Motion & Editing

```
s{c}{c}       Leap to location (2-char search)
S{c}{c}       Leap backwards
g s           Leap from windows
g c c         Comment line
g c           Comment selection (visual)
< / >         Indent in visual mode (stays selected)
J             Join lines
Space u w     Toggle word wrap
```

### Completion (blink.cmp)

```
Ctrl+Space    Trigger completion
Tab           Next item / expand snippet
Shift+Tab     Previous item
Enter         Confirm selection
Ctrl+e        Close completion
Ctrl+d        Scroll docs down
Ctrl+u        Scroll docs up
```

### Snippets

```
Tab           Expand or jump next
Shift+Tab     Jump previous
```

### Debugging (DAP)

```
Space d b     Toggle breakpoint
Space d B     Conditional breakpoint
Space d c     Continue
Space d C     Run to cursor
Space d i     Step into
Space d o     Step over
Space d O     Step out
Space d r     Toggle REPL
Space d l     Run last
Space d q     Quit/terminate
Space d u     Toggle DAP UI
```

### Terminal

```
Space t f     Float terminal
Space t h     Horizontal terminal
Space t v     Vertical terminal
Ctrl+\        Toggle terminal (in terminal mode)
```

### Sessions & Projects

```
Space S l     Load session
Space S s     Save session
Space S d     Delete session
Space S f     Search sessions
Space p       Recent projects
```

### UI Toggles

```
Space u a     Toggle autopairs
Space u b     Toggle background
Space u c     Toggle autocompletion
Space u d     Toggle diagnostics
Space u g     Toggle signcolumn
Space u h     Toggle inlay hints
Space u l     Toggle statusline
Space u L     Toggle codelens
Space u n     Toggle line numbers
Space u N     Toggle relative numbers
Space u p     Toggle paste mode
Space u s     Toggle spellcheck
Space u S     Toggle conceal
Space u t     Toggle tabline
Space u u     Toggle URL highlight
Space u w     Toggle wrap
Space u y     Toggle syntax highlight
Space u z     Toggle zen mode
```

### Misc

```
Space n       New file
Space q       Quit
Space Q       Force quit
Space /       Toggle comment
.             Repeat last command
u             Undo
Ctrl+r        Redo
z z           Center cursor line
z t           Cursor line to top
z b           Cursor line to bottom
```

---

## Printable Quick Card

```
╔══════════════════════════════════════════════════════════════════╗
║  ASTRONVIM CHEAT SHEET  (Leader = Space)                         ║
╠══════════════════════════════════════════════════════════════════╣
║  FIND                          LSP                               ║
║  SPC f f  files                g d      definition               ║
║  SPC f w  grep text            g r      references               ║
║  SPC f b  buffers              K        hover docs               ║
║  SPC f o  recent               SPC l a  code action              ║
║  SPC e    explorer             SPC l r  rename                   ║
║                                SPC l f  format                   ║
║  BUFFERS                       ]d [d    next/prev diagnostic     ║
║  ]b [b    next/prev                                              ║
║  SPC b d  pick close           GIT                               ║
║  SPC w    save                 SPC g g  lazygit                  ║
║                                SPC g s  status                   ║
║  WINDOWS                       ]g [g    next/prev hunk           ║
║  C-h/j/k/l  navigate                                             ║
║  SPC |    vsplit               DIAGNOSTICS                       ║
║  SPC \    hsplit               SPC x x  trouble toggle           ║
║                                ]q [q    quickfix nav             ║
║  MOTION                                                          ║
║  s{c}{c}  leap forward         DEBUG                             ║
║  S{c}{c}  leap backward        SPC d b  breakpoint               ║
║  * / #    search word          SPC d c  continue                 ║
║                                SPC d i  step into                ║
║  EDIT                          SPC d o  step over                ║
║  gcc      comment line                                           ║
║  gc       comment (visual)     TERMINAL                          ║
║  < >      indent (visual)      SPC t f  float terminal           ║
╚══════════════════════════════════════════════════════════════════╝
```
