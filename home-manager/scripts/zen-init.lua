-- Zen writing mode for journaling
-- Strips all editor chrome, soft wrap, centered cursor

-- Hide everything
vim.o.number = false
vim.o.relativenumber = false
vim.o.signcolumn = "no"
vim.o.laststatus = 0
vim.o.ruler = false
vim.o.showcmd = false
vim.o.showmode = false
vim.o.cmdheight = 0
vim.o.showtabline = 0
vim.o.fillchars = "eob: "
vim.o.cursorline = false
vim.o.colorcolumn = ""

-- Theme — reads JL_THEME env var from journal.sh
vim.o.termguicolors = true
local theme = vim.fn.getenv("JL_THEME")

if theme == "light" then
  vim.o.background = "light"
  vim.api.nvim_set_hl(0, "Normal", { fg = "#6b6462", bg = "#e8e4df" })
  vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#b8a09a" })
  vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#a0aeb5" })
  vim.api.nvim_set_hl(0, "markdownH1", { fg = "#8a7e72", bold = true })
  vim.api.nvim_set_hl(0, "markdownH2", { fg = "#8a7e72", bold = true })
  vim.api.nvim_set_hl(0, "Title", { fg = "#8a7e72", bold = true })
else
  vim.o.background = "dark"
  vim.api.nvim_set_hl(0, "Normal", { fg = "#a9b1b8", bg = "#2b2d30" })
  vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#7a5c5c" })
  vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#5c6a7a" })
  vim.api.nvim_set_hl(0, "markdownH1", { fg = "#8fa7b8", bold = true })
  vim.api.nvim_set_hl(0, "markdownH2", { fg = "#8fa7b8", bold = true })
  vim.api.nvim_set_hl(0, "Title", { fg = "#8fa7b8", bold = true })
end

-- Writing comfort
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.scrolloff = 999
vim.o.spell = false

-- Navigate by visual line
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })

-- Insert new journal entry header (#MMDD + blank line) with ,n
vim.keymap.set("n", ",n", function()
  local header = "#" .. os.date("%m%d")
  vim.api.nvim_put({ "", header, "", "" }, "l", true, true)
end, { silent = true, desc = "New journal entry" })

-- Quick save
vim.keymap.set("n", ",w", ":w<CR>", { silent = true })

-- Jump to end of file on open
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    vim.cmd("normal! G")
  end,
})
