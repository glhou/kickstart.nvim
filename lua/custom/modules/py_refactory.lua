local M = {}

--- @class Context
--- @field node TSNode
--- @field node_type string
--- @field bufnr integer
--- @field filepath string

--- @class RefactorAction
--- @field name string
--- @field execute fun(context: Context)

local function get_project_root()
  for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
    if client.config.root_dir then return client.config.root_dir end
  end
end

---@return string[]
local function find_test_files(project_root, filename)
  local matches = {}
  local target = 'test_' .. filename

  local function scan(dir)
    for name, type in vim.fs.dir(dir) do
      local path = vim.fs.joinpath(dir, name)

      if type == 'directory' then
        scan(path)
      elseif type == 'file' and name == target then
        table.insert(matches, path)
      end
    end
  end

  scan(vim.fs.joinpath(project_root, 'tests'))

  return matches
end

---@param context Context
---@param type string | nil
function create_test(context, type)
  local project_root = get_project_root()

  local name_node = context.node:field('name')[1]
  local function_name = vim.treesitter.get_node_text(name_node, context.bufnr)

  local filename = vim.fs.basename(context.filepath)
  local test_root = project_root
  if type then test_root = vim.fs.joinpath(project_root, 'tests', type) end
  local test_files = find_test_files(test_root, filename)

  if not test_files then
    vim.notify("Couldn't find a test file named " .. filename)
    return
  end

  vim.ui.select(test_files, {
    prompt = 'Select test file:',
    ---@param path string
    format_item = function(path)
      found_path = vim.fs.relpath(project_root, path)
      if not found_path then return 'path not found' end
      return found_path
    end,
  }, function(test_path)
    if not test_path then return end

    vim.fn.writefile({
      '',
      '',
      'def test_' .. vim.treesitter.get_node_text(context.node:field('name')[1], context.bufnr) .. '():',
      '    ...',
    }, test_path, 'a')
    vim.cmd.edit(test_path)
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(0), 0 })
  end)
end

---@param context Context
function create_unit_test(context) create_test(context, 'unit') end

---@param context Context
function create_integration_test(context) create_test(context, 'integration') end

---@param context Context
function create_normal_test(context) create_test(context) end

---@param context Context
function transform_args_to_kwargs(context) end

---@type table<string, RefactorAction[]>
local actions = {
  function_definition = {
    {
      name = 'Create unit test',
      execute = create_unit_test,
    },
    {
      name = 'Create integration test',
      execute = create_integration_test,
    },
    {
      name = 'Create normal test',
      execute = create_normal_test,
    },
  },
  call = {
    {
      name = 'Transform args into kwargs',
      execute = transform_args_to_kwargs,
    },
  },
}

---@param context Context
---@return RefactorAction[] | nil
local function find_action_node(context)
  ---@type TSNode?
  local node = context.node
  while node do
    local node_type = node:type()
    if actions[node_type] then
      if node then
        context.node = node
        context.node_type = node_type
      end
      return actions[node_type]
    end

    node = node:parent()
  end
end

---@return Context | nil
local function get_context()
  local node = vim.treesitter.get_node()

  if not node then return end

  return {
    node = node,
    node_type = node:type(),
    bufnr = vim.api.nvim_get_current_buf(),
    filepath = vim.api.nvim_buf_get_name(0),
  }
end

M.pick = function()
  local context = get_context()

  if not context then return end

  local node_actions = find_action_node(context)

  if not node_actions then return end

  vim.ui.select(node_actions, {
    prompt = 'Refactor:',
    format_item = function(action) return action.name end,
  }, function(action)
    if action then action.execute(context) end
  end)
end

M.setup = function() vim.keymap.set('n', '<leader>r', M.pick) end

return M
