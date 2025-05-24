-- Set the global namespace
_G.tulpa = {}

---Check if a certain feature/version/commit exists in nvim
---@param feature string
---@return boolean
function tulpa.has(feature)
  return vim.fn.has(feature) > 0
end

tulpa.nightly = tulpa.has("nvim-0.11")

---Determine if you're on an external monitor
---@return boolean
function tulpa.on_big_screen()
  return vim.o.columns > 150 and vim.o.lines >= 40
end

-- Set CodeCompanion token path
vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")
