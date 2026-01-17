return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        neotree = true,
        telescope = true,
        treesitter = true,
        native_lsp = true,
        cmp = true,
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
