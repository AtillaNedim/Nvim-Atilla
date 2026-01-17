return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    source_selector = {
      winbar = true,
      statusline = false,
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- HEADER / TAB COLORS
    vim.api.nvim_set_hl(0, "NeoTreeTabActive", {
      fg = "#1e1e2e",
      bg = "#89b4fa",
      bold = true,
    })

    vim.api.nvim_set_hl(0, "NeoTreeTabInactive", {
      fg = "#cdd6f4",
      bg = "#313244",
    })

    vim.api.nvim_set_hl(0, "NeoTreeTabSeparator", {
      fg = "#45475a",
      bg = "#313244",
    })
  end,
}

