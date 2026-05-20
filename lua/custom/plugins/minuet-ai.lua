local ollama_exists = vim.fn.executable 'ollama' == 1

---@type LazySpec
return ollama_exists
    and {
      'milanglacier/minuet-ai.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      opts = {
        provider = 'openai_fim_compatible',
        n_completion = 1,
        context_window = 512,
        request_timeout = 5,
        throttle = 500,
        debouce = 300,
        provider_options = {
          openai_fim_compatible = {
            api_key = 'TERM',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:7b',
            optional = {
              max_tokens = 256,
              stop = { '\n\n' },
              top_p = 0.9,
            },
          },
        },
        virtualtext = {
          auto_trigger_ft = { '*' },
          keymap = {
            accept = '<C-y>',
            accept_line = '<C-Y>',
            next = '<C-n>',
            prev = '<C-p>',
            dismiss = '<C-e>',
          },
        },
      },
    }
  or {}
