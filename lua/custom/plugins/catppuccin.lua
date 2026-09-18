vim.pack.add { 'https://github.com/catppuccin/nvim' }
require('catppuccin').setup {
  custom_highlights = function(colors)
    return {
      LineNr = { fg = colors.lavender, bold = true },
      LineNrAbove = { fg = colors.mauve },
      LineNrBelow = { fg = colors.mauve }, -- someting
      ['@comment.todo.comment'] = {
        fg = colors.peach,
        bg = 'NONE',
      },
      ['@comment.warning.comment'] = {
        fg = colors.yellow,
        bg = 'NONE',
      },
      ['@comment.note.comment'] = {
        fg = colors.sky,
        bg = 'NONE',
      },
      MiniHipatternsTodo = { fg = colors.peach, bg = 'NONE', bold = true }, -- TODO
      MiniHipatternsNote = { fg = colors.sky, bg = 'NONE', bold = true }, -- NOTE
      MiniHipatternsWip = { fg = colors.mauve, bold = true }, -- WIP
      MiniHipatternsFix = { fg = colors.red, bold = true }, -- FIX
      MiniHipatternsWarn = { fg = colors.yellow, bold = true }, -- WARN
    }
  end,
}
vim.cmd.colorscheme 'catppuccin-latte'
