--------------------------------------------------------------------
-- LEADER KEYS by AtillaNedim
--------------------------------------------------------------------
-- Space = leader (commands, LSP, Git, etc.)
-- Alt   = Super key (fast navigation & tools)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

--------------------------------------------------------------------
-- FILE EXPLORER (ALT)
--------------------------------------------------------------------
map("n", "<M-e>", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })

--------------------------------------------------------------------
-- FLOATING TERMINAL (ALT)
--------------------------------------------------------------------
-- Open terminal
map("n", "<M-t>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Floating Terminal" })
-- Close terminal (must exit terminal-mode first)
map("t", "<M-t>", "<C-\\><C-n><cmd>ToggleTerm<cr>", { desc = "Close Floating Terminal" })

--------------------------------------------------------------------
-- TELESCOPE (ALT)
--------------------------------------------------------------------
map("n", "<M-f>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<M-g>", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<M-b>", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<M-h>", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

--------------------------------------------------------------------
-- BUFFER NAVIGATION
--------------------------------------------------------------------
map("n", "<M-]>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<M-[>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<M-w>", "<cmd>bdelete<cr>", { desc = "Close Buffer" })

--------------------------------------------------------------------
-- WINDOW NAVIGATION (ALT + hjkl)
--------------------------------------------------------------------
map("n", "<M-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<M-l>", "<C-w>l", { desc = "Window Right" })
map("n", "<M-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<M-k>", "<C-w>k", { desc = "Window Up" })

--------------------------------------------------------------------
-- SPLITS
--------------------------------------------------------------------
map("n", "<M-s>", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", "<M-v>", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

--------------------------------------------------------------------
-- LEADER COMMANDS (SPACE)
--------------------------------------------------------------------
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy.nvim" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
-- Undo/Redo on familiar shortcuts
map({ "n", "v" }, "<C-z>", "u", opts)
map("i", "<C-z>", "<C-o>u", opts)
map("c", "<C-z>", "<Nop>", opts) -- prevent shell suspend
map("t", "<C-z>", "<Nop>", opts) -- prevent terminal job suspend
map({ "n", "v" }, "<C-y>", "<C-r>", opts)
map("i", "<C-y>", "<C-o><C-r>", opts)

--------------------------------------------------------------------
-- VISUAL MODE
--------------------------------------------------------------------
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

--------------------------------------------------------------------
-- INSERT MODE
--------------------------------------------------------------------
map("i", "jk", "<Esc>", opts)
-- Delete from cursor to end of current word (Ctrl+Delete)
map("i", "<C-Del>", "<C-o>de", { desc = "Delete word forward" })
-- Same for Ctrl+Enter (if terminal sends <C-CR>)
map("i", "<C-CR>", "<C-o>de", { desc = "Delete word forward" })
-- Delete previous word (Ctrl+Backspace); fallback to <C-h> if terminal uses that
map("i", "<C-BS>", "<C-w>", { desc = "Delete word backward" })
map("i", "<C-h>", "<C-w>", { desc = "Delete word backward (fallback)" })
-- Some terminals send <BS> (0x7f) even with Ctrl held
map("i", "<BS>", "<C-w>", { desc = "Delete word backward (BS 0x7f)" })


--------------------------------------------------------------------
-- WINDOW FOCUS & RESIZE (ALT + CTRL)
--------------------------------------------------------------------

-- Jump instantly to the main editor window
-- (works from Neo-tree, terminal, etc.)
vim.keymap.set("n", "<M-CR>", "<C-w>w", { desc = "Focus Editor Window" })
vim.keymap.set("t", "<M-CR>", "<C-\\><C-n><C-w>w", { desc = "Focus Editor Window" })

-- Resize window width
vim.keymap.set("n", "<M-C-]>", "<cmd>vertical resize +5<cr>", { desc = "Increase Window Width" })
vim.keymap.set("n", "<M-C-[>", "<cmd>vertical resize -5<cr>", { desc = "Decrease Window Width" })
