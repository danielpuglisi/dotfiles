-- Utility functions for Neovim

-- Switch between implementation and test files in Ruby projects
function tulpa.open_test_alternate()
  local current_file = vim.fn.expand("%")
  local new_file = current_file
  local in_spec = string.match(current_file, "^spec/") ~= nil
  local going_to_spec = not in_spec
  local in_app = string.match(current_file, "controllers") or string.match(current_file, "models") or
      string.match(current_file, "views")

  if going_to_spec then
    if in_app then
      new_file = new_file:gsub("^app/", "")
    end
    new_file = new_file:gsub(".rb$", "_spec.rb")
    new_file = "spec/" .. new_file
  else
    new_file = new_file:gsub("_spec%.rb$", ".rb")
    new_file = new_file:gsub("^spec/", "")
    if in_app then
      new_file = "app/" .. new_file
    end
  end

  -- Check if the file exists before opening
  if vim.fn.filereadable(new_file) == 1 or vim.fn.filereadable(vim.fn.findfile(new_file)) == 1 then
    vim.cmd("e " .. new_file)
  else
    vim.notify("Test alternate file not found: " .. new_file, vim.log.levels.WARN)
  end
end

-- Strip trailing whitespace from the current buffer
function tulpa.strip_whitespace()
  local cursor_pos = vim.fn.getcurpos()
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos('.', cursor_pos)
  vim.notify("Trailing whitespace removed", vim.log.levels.INFO)
end

-- Rename the current file
function tulpa.rename_file()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', vim.fn.expand('%'), 'file')
  if new_name ~= '' and new_name ~= old_name then
    -- Save the current file first
    vim.cmd('silent! write')
    -- Rename the file
    local success, err = os.rename(old_name, new_name)
    if success then
      vim.cmd('edit ' .. new_name)
      vim.cmd('silent! bdelete! ' .. old_name)
      vim.notify("File renamed to " .. new_name, vim.log.levels.INFO)
    else
      vim.notify("Failed to rename file: " .. (err or "Unknown error"), vim.log.levels.ERROR)
    end
  end
end

-- Simple custom tabline
function tulpa.tabline()
  local buffers = ""
  local current_buf = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)
      local filename = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")

      -- Add + if buffer is modified
      if vim.bo[buf].modified then
        filename = filename .. "+"
      end

      if buf == current_buf then
        buffers = buffers .. "%#TabLineSel# " .. filename .. " %#TabLine#"
      else
        buffers = buffers .. " " .. filename .. " "
      end
      buffers = buffers .. "|"
    end
  end

  -- Just filetype and position info on the right
  return buffers .. "%=(%{&ft}) %3l,%02c%03V"
end

-- Run Ruby tests in a new Zellij pane
function tulpa.run_in_zellij_pane(command)
  -- Create a new pane and run the command
  local zellij_command = string.format('zellij run --floating --cwd "%s" -- %s', vim.fn.getcwd(), command)

  vim.fn.system(zellij_command)
end

function tulpa.run_ruby_test_file()
  local file = vim.fn.expand('%')
  local command = 'bin/rails test ' .. file
  tulpa.run_in_zellij_pane(command)
end

function tulpa.run_ruby_nearest_test()
  local file = vim.fn.expand('%')
  local line = vim.fn.line('.')
  local command = 'bin/rails test ' .. file .. ':' .. line
  tulpa.run_in_zellij_pane(command)
end
