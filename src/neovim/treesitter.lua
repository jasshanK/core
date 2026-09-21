vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
