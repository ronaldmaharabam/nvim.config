vim.env.PATH = "/Users/ronaldmaharabam/.nvm/versions/node/v21.5.0/bin" .. vim.env.PATH


require("aron")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins")

local test = function ()
    local ts = vim.fn.input("Tab size > ")
    local is_number = tonumber(ts)
    if is_number then
        vim.opt.tabstop = is_number
        vim.opt.softtabstop = is_number
        vim.opt.shiftwidth = is_number
        print"tab size changed"
    end

end
vim.keymap.set("n", "<leader>ct", test, {noremap = true})


vim.keymap.set("n", "<leader>r",  ":w <CR> :!g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o %< % <CR>")


