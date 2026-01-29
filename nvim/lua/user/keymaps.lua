local which_key = require("which-key")

local function map(mode, l, r, override_opts)
  local opts = { noremap = true, silent = true }
  if override_opts ~= nil then
    for key, value in pairs(override_opts) do
      opts[key] = value
    end
  end
  vim.keymap.set(mode, l, r, opts)
end

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>f", "<cmd>Telescope find_files<cr>")
map("n", "<leader>s", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>S", "<cmd>Telescope grep_string<cr>")

map("n", "<leader>n", "<cmd>nohl<cr>")

-- Show file tree
map("n", "<leader>e", ":NvimTreeToggle<cr>")

-- Resize with arrows
map("n", "<S-Up>", ":resize -2<cr>")
map("n", "<S-Down>", ":resize +2<cr>")
map("n", "<S-Left>", ":vertical resize +2<cr>")
map("n", "<S-Right>", ":vertical resize -2<cr>")

-- Buffers
map("n", "<S-l>", ":BufferNext<cr>")
map("n", "<S-h>", ":BufferPrevious<cr>")
map("n", "<S-x>", ":BufferClose<cr>")
map("n", "<Leader>x", ":BufferCloseAllButCurrent<cr>")

map("i", "jk", "<ESC>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", ":move .+1<cr>==")
map("v", "<A-k>", ":move .-2<cr>==")

-- Move text up and down
map("x", "K", ":move '<-2<cr>gv-gv")
map("x", "J", ":move '>+1<cr>gv-gv")

-- Copies to OS clipboard
map({ "v", "n" }, "<leader>y", "\"+y")
map({ "v", "n" }, "<leader>Y", "\"+Y")

-- Replace text but dont replace default register
map("x", "<leader>p", '"_dP')

-- Start replace in file with word under cursor
map("n", "<leader>R", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { silent = false })
map("n", "<leader>F", ":/<C-r><C-w><cr>", { silent = false })


-- LSP
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
local function lsp_keymaps(bufnr)
  local bufopt = { buffer = bufnr }
  map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", bufopt)
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", bufopt)
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", bufopt)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", bufopt)
  map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", bufopt)
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", bufopt)
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", bufopt)
  map("n", "gR", "<cmd>lua vim.lsp.buf.references()<cr>", bufopt)
  map("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopt)
  map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", bufopt)
  map("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<cr>', bufopt)
  map("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<cr>', bufopt)
  map("n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<cr>', bufopt)
  map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", bufopt)
end

local sections = {
  n = {
    ["<Leader>"] = {
      g = { name = "Git" },
      l = { name = "LSP" },
      d = { name = "Debugger" },
      s = { name = "Search" },
      c = { name = "Comment" }
    }
  }
}
which_key.register({
  ["<Leader>"] = {
    g = {
      name = "Git",
      s = { "<cmd>:Git<cr>", "Status" },
      w = { "<cmd>:Gwrite<cr>", "Stage current file" },
      r = { "<cmd>:GRead<cr>", "Revert current file" },
      t = { "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", "Toggle Inline Blame" },
      h = {
        name = "+Hunk",
        n = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next" },
        p = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Previous" },
        v = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview" },
        r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Revert" },
        s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage" },
        d = { "<cmd>lua require('gitsigns').diffthis()<cr>", "Diff" },
        u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Undo Stage" },
        b = { "<cmd>lua require('gitsigns').blame_line({ full = true })<cr>", "Blame Line" },
      }
    }
  }
})

-- Debugging
which_key.register({
  ["<Leader>"] = {
    d = {
      name = "Debug",
      t = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle breakpoint" },
      S = { "<cmd>lua require('dap').continue()<cr>", "Start debugging" },
      s = {
        name = "+Step",
        c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
        v = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
        i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
      },
      h = {
        name = "+Hover",
        h = { "<cmd>lua require('dap.ui.variables').hover()<cr>", "Hover" },
        v = { "<cmd>lua require('dap.ui.variables').visual_hover()<cr>", "Visual Hover" },
      },
      u = {
        name = "+UI",
        h = { "<cmd>lua require('dap.ui.widgets').hover()<cr>", "Hover" },
        f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<cr>", "Float" },
      },
      r = {
        name = "+Repl",
        o = { "<cmd>lua require('dap').repl.open()<cr>", "Open" },
        l = { "<cmd>lua require('dap').repl.run_last()<cr>", "Run Last" },
      },
      b = {
        name = "+Breakpoints",
        t = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle" },
        c = {
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
          "Breakpoint Condition",
        },
        m = {
          "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<cr>",
          "Log Point Message",
        },
      },
      c = { "<cmd>lua require('dap').scopes()<cr>", "Scopes" },
    },
  }
})
map("n", "<F3>", "<cmd>lua require('dap').terminate()<cr>")
map("n", "<F4>", "<cmd>lua require('dap').toggle_breakpoint()<cr>")
map("n", "<F5>", "<cmd>lua require('dap').continue()<cr>")
map("n", "<F6>", "<cmd>lua require('dap').step_over()<cr>")
map("n", "<F7>", "<cmd>lua require('dap').step_into()<cr>")
map("n", "<F8>", "<cmd>lua require('dap').step_out()<cr>")
map("n", "<F9>", "<cmd>lua require('dap').repl.open()<cr>")

-- Lls - signature help
-- Lld - go to definition
-- LlD - go to declaration
-- Llh - hover
-- Llr - rename
-- Llc - code action
-- Llp - previous diagnostic
-- Lln - next diagnostic
-- Llf - open float
-- Llq - setloclist diagnostic

-- Lcc - toggle comment
-- Lcb - toggle block comment
-- C+/ - toggle comment

return {
  lsp_keymaps = lsp_keymaps
}
