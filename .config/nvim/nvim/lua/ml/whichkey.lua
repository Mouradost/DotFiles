local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  vim.notify("which_key not loaded", vim.log.levels.ERROR, { title = "Initialization" })
  return
end

local setup = {
  plugins = {
    marks = true,    -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 50, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,   -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,   -- default bindings on <c-w>
      nav = true,       -- misc bindings to work with windows
      z = true,         -- bindings for folds, spelling and others prefixed with z
      g = true,         -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+",    -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",     -- none, single, double, shadow
    position = "bottom",    -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                            -- min and max height of the columns
    width = { min = 20, max = 50 },                                            -- min and max width of the columns
    spacing = 3,                                                               -- spacing between columns
    align = "left",                                                            -- align columns left, center or right
  },
  ignore_missing = true,                                                       -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                            -- show help message on the command line when the popup is visible
  triggers = "auto",                                                           -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",    -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["A"] = { "<cmd>Alpha<cr>", "Dashboard (Alpha)" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["<tab>"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope diagnostics<cr>",
      "Document Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
    i = { "<cmd>Mason<cr>", "Installer Info" },
    I = { "<cmd>LspInfo<cr>", "Lsp Info" },
    L = { "<cmd>MasonLog<cr>", "Mason Log" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.refresh()<cr> <cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    -- l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    R = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "CodeLens Refresh" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  L = {
    name = "Latex",
    c = { "<cmd>VimtexCompile<cr>", "Start/stop compilation" },
    e = { "<cmd>VimtexErrors<cr>", "Compilation Errors" },
    o = { "<cmd>VimtexCompileOutput<cr>", "Compile output" },
    v = { "<cmd>VimtexView<cr>", "View" },
    w = { "<cmd>VimtexCountWords<cr>", "Word count" },
    l = { "<cmd>VimtexCountLetters<cr>", "Letters count" },
    s = { "<cmd>VimtexStatus<cr>", "Vimtex status" },
    S = { "<cmd>VimtexStopAll<cr>", "Vimtex stop all" },
    i = { "<cmd>VimtexInfo<cr>", "Vimtex status" },
    C = { "<cmd>VimtexClean<cr>", "Clear" },
    m = { "<cmd>:w | TermExec: cmd='axum-markdown-preview %:p' <cr>", "Markdown Preview" },
    u = { "<cmd>TermExec: cmd='checkcites main.aux' <cr>", "Check citations" },
    U = { "<cmd>TermExec: cmd='checkcites --unused main.aux' <cr>", "Check unused citations" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  S = {
    name = "Spelling",
    S = { "<cmd>set spell!<cr>", "On / Off" },
    E = { "<cmd>set spelllang=en<cr>", "set language to English" },
    F = { "<cmd>set spelllang=fr<cr>", "set language to French" },
  },
  d = {
    name = "Debugging",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
    B = {
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      "Breakpoint condition",
    },
    l = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Log message" },
    r = { "<cmd>lua require'dap'.repl.open()<CR>" },
  },
  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    t = { "<cmd>lua _BPYTOP_TOGGLE()<cr>", "Bpytop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  r = {
    name = "Run file",
    p = { "<cmd>:w | TermExec cmd='python %'<cr>", "Python" },
    r = { "<cmd>:w | TermExec cmd='cargo run --quiet'<cr>", "Rust" },
    l = { "<cmd>TermExec cmd='latexmk -pdf -pvc % | zathura -'<cr>", "Latex live view" },
  },
  R = {
    name = "Rust tools",
    i = {
      name = "Inlay Hints",
      s = { "<cmd>:RustSetInlayHints<cr>", "Set" },
      u = { "<cmd>:RustUnsetInlayHints<cr>", "Unset" },
      d = { "<cmd>:RustDisableInlayHints<cr>", "Disable" },
      e = { "<cmd>:RustEnableInlayHints<cr>", "Enable" },
    },
    c = { "<cmd>:RustCodeAction<cr>", "Code Action" },
    d = { "<cmd>:RustDebuggables<cr>", "Debuggables" },
    f = { "<cmd>:RustFmt<cr>", "Format" },
    F = { "<cmd>:! leptosfmt --max-width 80 %<cr>", "Format (leptosfmt)" },
    D = { "<cmd>:! dioxus fmt -f %<cr>", "Format (leptosfmt)" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
