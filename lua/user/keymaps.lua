local which_key = require("which-key")

local opts = { noremap = true, silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>s", "<cmd>Telescope live_grep<cr>", opts)

keymap("n", "<leader>n", "<cmd>nohl<cr>", opts)

-- Show file tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize -2<CR>", opts)

-- Buffers
keymap("n", "<S-l>", ":BufferNext<CR>", opts)
keymap("n", "<S-h>", ":BufferPrevious<CR>", opts)
keymap("n", "<S-x>", ":BufferClose<CR>", opts)

-- Insert --
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":move .+1<CR>==", opts)
keymap("v", "<A-k>", ":move .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)

-- LSP
keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
local function lsp_keymaps(bufnr)
  -- Insert
  vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- Normal
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
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

which_key.register({
  ["<Leader>"] = {
    d = {
      name = "Debug",
      t = { "<cmd>lua require('dap').toggle()<CR>", "Toggle breakpoint" },
      s = {
        name = "+Step",
        c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
        v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
        i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
        o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
      },
      h = {
        name = "+Hover",
        h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
        v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
      },
      u = {
        name = "+UI",
        h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
        f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
      },
      r = {
        name = "+Repl",
        o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
        l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
      },
      b = {
        name = "+Breakpoints",
        t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle" },
        c = {
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
          "Breakpoint Condition",
        },
        m = {
          "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
          "Log Point Message",
        },
      },
      c = { "<cmd>lua require('dap').scopes()<CR>", "Scopes" },
    },
  }
})
--     nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
--[[ nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR> ]]
--[[ nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR> ]]
--[[ nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR> ]]
--[[ nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR> ]]
--[[ nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR> ]]
--[[ nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR> ]]
--[[ nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR> ]]
--[[ nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR> ]]
-- Lda - debugger attach
-- Ldb - toggle breakpoint
-- Ldc - debug console

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
