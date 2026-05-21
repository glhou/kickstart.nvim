local ollama_exists = vim.fn.executable 'ollama' == 1

return ollama_exists
    and {
      'olimorris/codecompanion.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      opts = {
        interactions = {
          chat = {
            adapter = {
              name = 'ollama',
              model = 'qwen3:8b',
            },
          },
          inline = {
            adapter = {
              name = 'ollama',
              model = 'qwen2.5-coder:7b',
            },
          },
          cmd = {
            adapter = {
              name = 'ollama',
              model = 'qwen3:8b',
            },
          },
          background = {
            adapter = {
              name = 'ollama',
              model = 'qwen3:8b',
            },
          },
        },
        opts = {
          log_level = 'DEBUG',
        },
      },
    }
  or {}
