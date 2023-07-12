local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()

local options = {
    preselect = cmp.PreselectMode.None,
    completion = {
        completeopt = "menu,menuone,noselect",
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-p>'] = cmp_action.luasnip_jump_forward(),
        ['<C-n>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll Docs
        --
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
    },

}

return options
