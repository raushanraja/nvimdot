local ensure_installed = {
    "autopep8",
    "lua-language-server",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "pyright",
    "rust-analyzer",
    "rustfmt",
    "mypy",
    "debugpy",
}
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        { 'williamboman/mason.nvim' },
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
        { 'hrsh7th/cmp-nvim-lsp' },                                                    -- Required
        { "hrsh7th/cmp-nvim-lua" },
        { 'hrsh7th/cmp-buffer' },                                                      -- Required
        { 'L3MON4D3/LuaSnip',        dependencies = "rafamadriz/friendly-snippets", }, -- Required
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-path" },


        -- autopairing of (){}[] etc
        { "windwp/nvim-autopairs", },





        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            opts = { suggestion = { auto_trigger = true, debounce = 150 } },
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = { "zbirenbaum/copilot.lua" },
            event = "InsertEnter", -- Required
            opts = function(_, opts)
                local cmp, copilot = require "cmp", require "copilot.suggestion"
                local snip_status_ok, luasnip = pcall(require, "luasnip")
                if not snip_status_ok then return end
                local function has_words_before()
                    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                    return col ~= 0 and
                        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
                end
                if not opts.mapping then opts.mapping = {} end
                opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
                    if copilot.is_visible() then
                        copilot.accept()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" })

                opts.mapping["<C-x>"] = cmp.mapping(function()
                    if copilot.is_visible() then copilot.next() end
                end)

                opts.mapping["<C-z>"] = cmp.mapping(function()
                    if copilot.is_visible() then copilot.prev() end
                end)

                opts.mapping["<C-right>"] = cmp.mapping(function()
                    if copilot.is_visible() then copilot.accept_word() end
                end)

                opts.mapping["<C-l>"] = cmp.mapping(function()
                    if copilot.is_visible() then copilot.accept() end
                end)

                opts.mapping["<C-down>"] = cmp.mapping(function()
                    if copilot.is_visible() then copilot.accept_line() end
                end)

                opts.mapping["<C-j>"] = cmp.mapping(function()
                    if copilot.is_visible() then copilot.accept_line() end
                end)

                opts.mapping["<C-c>"] = cmp.mapping(function()
                    if copilot.is_visible() then copilot.dismiss() end
                end)

                return opts
            end,
        },

    }
}
