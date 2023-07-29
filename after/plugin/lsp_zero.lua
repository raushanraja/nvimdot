local lsp = require('lsp-zero').preset('recommended')
local cmp_opts = require("config.cmp")


require("mason").setup({
    ui = {
        icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ﮊ",
        },

        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        },
    },
})


lsp.on_attach(function(client, bufnr)
    local opts = lsp.default_keymaps({ buffer = bufnr, remap = false })

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>fs", "<cmd>SymbolsOutline<cr>", opts)
    vim.keymap.set("n", "<leader>fd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['null-ls'] = { 'javascript', 'typescript', 'lua', 'python', 'rust' },
    }
})


lsp.setup()

-- Setup cmp
local cmp = require('cmp')
cmp.setup(cmp_opts)


-- AUTOPAIR SETUP
local autopairs_opts = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
}
require("nvim-autopairs").setup(autopairs_opts)
-- setup cmp for autopairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
