local ensure_installed = {
    "lua-language-server",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "pyright",
    "rust-analyzer",
    "rustfmt",
    "mypy",
    "ruff",
    "debugpy",
}
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        {                            -- Optional
            'williamboman/mason.nvim',

        },
        {
            'williamboman/mason-lspconfig.nvim', -- Optional
            cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
            build = function()
                pcall(vim.cmd, 'MasonInstallAll')
            end,
            config = function()
                -- custom nvchad cmd to install all mason binaries listed
                vim.api.nvim_create_user_command("MasonInstallAll", function()
                    vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
                end, {})

                vim.g.mason_binaries_list = ensure_installed
            end,
        },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },     -- Required
        { 'hrsh7th/cmp-nvim-lsp' }, -- Required
        { 'hrsh7th/cmp-buffer' },   -- Required
        { 'L3MON4D3/LuaSnip' },     -- Required
    }
}
