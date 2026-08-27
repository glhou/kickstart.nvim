vim.pack.add { 'https://github.com/catppuccin/nvim' }
require('catppuccin').setup {
  custom_highlights = function(colors)
    return {
      LineNr = { fg = colors.lavender, bold = true },
      LineNrAbove = { fg = colors.overlay1 },
      LineNrBelow = { fg = colors.overlay1 },
    }
  end,
}
vim.cmd.colorscheme 'catppuccin-latte'
