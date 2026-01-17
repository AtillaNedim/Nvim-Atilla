return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = nil, -- we set our own keymap
      direction = "float",
      float_opts = {
        border = "rounded",
      },
    })
  end,
}

