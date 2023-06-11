require "toggleterm".setup {
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil,          -- change the default shell
}

function TTerm(count, direction, size)
    local cmd = nil
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new { cmd = cmd, count = count, direction = direction, size = size }
    term:toggle(size, direction)
end
