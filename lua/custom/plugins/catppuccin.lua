return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.lavender, bold = true },
          LineNrAbove = { fg = colors.overlay1 },
          LineNrBelow = { fg = colors.overlay1 },
        }
      end,
    }
    vim.cmd.colorscheme 'catppuccin-macchiato'
  end,
}
