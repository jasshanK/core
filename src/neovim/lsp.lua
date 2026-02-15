local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
    'marksman', 'nushell', 'nixd', 'pyright', 
    'ts_ls', 'html', 'cssls', 'rust_analyzer', 
    'ccls', 'zls'
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server, { capabilities = capabilities })
end

vim.lsp.enable('lua_ls', {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } }
        }
    }
})

local elixirls_path = vim.fn.exepath('elixir-ls')
vim.lsp.enable('elixirls', {
    cmd = { string.sub(elixirls_path, 1, #elixirls_path - 14) .. "/lib/language_server.sh" },
    capabilities = capabilities,
})
