local configs = require("nvim-treesitter.configs")
configs.setup {
    auto_install = false,
    ensure_installed = {},
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    }
}
