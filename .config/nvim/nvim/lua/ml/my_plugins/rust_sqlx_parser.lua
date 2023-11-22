local group = vim.api.nvim_create_augroup("ML_Rust_Sql_Parse_Action", { clear = true })
local pattern = "*.rs"

local run_formatter = function(text)
  local split = vim.split(text, "\n")
  local result = table.concat(vim.list_slice(split, 2, #split - 1), "\n")

  -- Finds sql-format-via-python somewhere in your nvim config path
  local bin = vim.api.nvim_get_runtime_file("bin/sql_parse.py", false)[1]
  if bin == nil then
    vim.notify(vim.inspect(bin), vim.log.levels.INFO, { title = "My Plugin" })
    return
  end

  local j = require("plenary.job"):new({
    command = "python",
    args = { bin },
    writer = { result },
  })
  return j:sync()
end

local unparse_embedded_sql = [[
(macro_invocation
 (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

 (token_tree
   (raw_string_literal) @sql)
   (#offset! @sql 1 0 0 0))

(macro_invocation
 (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query_as"))

 (token_tree
   (raw_string_literal) @sql)
   (#offset! @sql 1 0 0 0))

  ]]

local embedded_sql = vim.treesitter.query.parse("rust", unparse_embedded_sql)

local get_root = function(buffer)
  local parser = vim.treesitter.get_parser(buffer, "rust", {})
  local tree = parser:parse()[1]
  return tree:root()
end

local format_data_sql = function(buffer)
  buffer = buffer or vim.api.nvim_get_current_buf()

  if vim.bo[buffer].filetype ~= "rust" then
    vim.notify("Can only be used with rust files !", vim.log.levels.WARN, { title = "Rust SQL injector" })
  end

  local root = get_root(buffer)

  local changes = {}
  for id, node in embedded_sql:iter_captures(root, buffer, 0, -1) do
    local name = embedded_sql.captures[id]
    if name == "sql" then
      local range = { node:range() }
      local indentation = string.rep(" ", range[2])

      -- Run the formatter
      local formatted = run_formatter(vim.treesitter.get_node_text(node, buffer))
      if formatted == nil then
        vim.notify("Received nil formatted string", vim.log.levels.ERROR, { title = "Rust SQL injector" })
        return
      end

      -- Add some indentation
      for idx, line in ipairs(formatted) do
        formatted[idx] = indentation .. line
      end

      -- keep track and insert in reverse
      table.insert(changes, 1, {
        start = range[1] + 1,
        final = range[3],
        formatted = formatted,
      })
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(buffer, change.start, change.final, false, change.formatted)
  end
end

vim.api.nvim_create_user_command("SqlMagic", function()
  -- format_data_sql()
  vim.treesitter.query.set("rust", "injections", unparse_embedded_sql)
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = pattern,
  callback = function()
    format_data_sql()
  end,
})
