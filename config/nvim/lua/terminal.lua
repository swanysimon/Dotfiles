local function is_window(window)
  return window and vim.api.nvim_win_is_valid(window)
end


local function window_options()
  local lines = vim.o.lines
  local columns = vim.o.columns

  local height = math.ceil(lines * 0.8)
  local x = math.ceil((lines - height) * 0.5 - 1)

  local width = math.ceil(columns * 0.9)
  local y = math.ceil((columns - width) * 0.5 - 1)

  return {
    border = "single",
    relative = "editor",
    style = "minimal",
    height = height,
    width = width,
    row = x,
    col = y,
  }
end


local M = {}


function M:new()
  return setmetatable(
    {
      window = nil,
      buffer = nil,
      terminal = nil,
      previous = { number = nil, window = nil, cursor = nil, },
    },
    { __index = self }
  )
end


function M:open()
  if is_window(self.window) then
    return vim.api.nvim_set_current_win(self.window)
  end

  self.previous.window = vim.api.nvim_get_current_win()
  self.previous.number = vim.fn.winnr("#")
  self.previous.cursor = vim.api.nvim_win_get_cursor(self.previous.window)

  local existing_buffer = self.buffer and vim.api.nvim_buf_is_valid(self.buffer)
  if not existing_buffer then
    self.buffer = vim.api.nvim_create_buf(false, true)
  end

  self.window = vim.api.nvim_open_win(self.buffer, true, window_options())

  if not existing_buffer then
    local shell = assert(os.getenv("SHELL"), "[Floating Terminal] $SHELL not set!")
    self.terminal = vim.fn.termopen(
      shell,
      {
        clear_env = false,
        on_exit = function(_, code, ...)
          if code == 0 then
            self:close(true)
          end
        end,
      }
    )
  end

  vim.cmd("startinsert")
  return self
end


function M:close(buf_delete)
  if not is_window(self.window) then
    return self
  end

  vim.api.nvim_win_close(self.window, false)
  self.window = nil

  if buf_delete then
    vim.api.nvim_buf_delete(self.buffer, { force = true })
    vim.fn.jobstop(self.terminal)
    self.buffer = nil
    self.terminal = nil
  end

  if self.previous.window and self.previous.cursor ~= nil then
    if self.previous.number > 0 then
      vim.cmd(("silent! %s wincmd w"):format(self.previous.number))
    end

    if is_window(self.previous.window) then
      vim.api.nvim_set_current_win(self.previous.window)
      vim.api.nvim_win_set_cursor(self.previous.window, self.previous.cursor)
    end

    self.previous = { number = nil, window = nil, cursor = nil, }
  end

  return self
end


function M:toggle()
  if is_window(self.window) then
    self:close(false)
  else
    self:open()
  end
end


return M
