vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local opt = vim.opt_local

        opt.textwidth = 0
        opt.wrapmargin = 0
        opt.wrap = true
        opt.linebreak = true

        opt.spell = true
        opt.spelllang = "en_gb"

        opt.cursorline = true
        opt.cursorlineopt = "line"

        --need to add highlighting of currently typed text
        local highlight_comment = vim.api.nvim_get_hl(0, { name = 'Comment' })
        local highlight_normal = vim.api.nvim_get_hl(0, { name = 'Normal' })

        vim.api.nvim_set_hl(0, 'Normal', vim.tbl_extend('force', highlight_comment, { bg = '#000000' }))
        vim.api.nvim_set_hl(0, 'CursorLine', vim.tbl_extend('force', highlight_normal, { bg = '#000000' }))
        vim.api.nvim_set_hl(0, 'Visual', vim.tbl_extend('force', highlight_normal, { bg = '#000000' }))
    end
})
