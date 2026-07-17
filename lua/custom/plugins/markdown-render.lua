return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require('render-markdown').setup {
      file_types = { 'markdown', 'vimwiki' },
      completions = {
        -- Settings for blink.cmp completions source
        blink = { enabled = true },
      },

      checkbox = {
        custom = {
          partial = {
            raw = '[.]',
            rendered = '◔ ',
            highlight = 'RenderMarkdownTodo',
          },
          half = {
            raw = '[o]',
            rendered = '◑ ',
            highlight = 'RenderMarkdownTodo',
          },
          almost = {
            raw = '[O]',
            rendered = '◕ ',
            highlight = 'RenderMarkdownTodo',
          },
        },
      },
    }
    vim.treesitter.language.register('markdown', 'vimwiki')
  end,
}
