local M = {}
local autocmd = vim.api.nvim_create_autocmd
local config = {
    on_event = 'BufWritePre',
    ft_ignore = { 'TelescopePrompt', 'Trouble', 'help' },
}

function M.trim()
    vim.cmd("%s/\\s\\+$//eg")
end

function M.setup(options)
    config = vim.tbl_extend('force', config, options or {})

    vim.api.nvim_create_augroup("nvim-whitespaces", {clear = true})
    autocmd({config["on_event"]}, {
        group = "sacca",
        pattern = config["ft_ignore"],
        command = "%s/\\s\\+$//e",
    })
end

return M
