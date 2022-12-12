local M = {}
local autocmd = vim.api.nvim_create_autocmd
local config = {
    on_event = 'BufWritePre',
    ft = { '*.lua', '*.vim' },
}

function M.trim()
    vim.cmd("%s/\\s\\+$//eg")
end

function M.setup(options)
    config = vim.tbl_extend('force', config, options or {})

    vim.api.nvim_create_augroup("nvim_whitespaces", {clear = true})

    autocmd({config["on_event"]}, {
        group = "nvim_whitespaces",
        pattern = config["ft"],
        command = "%s/\\s\\+$//e",
    })
end

return M
