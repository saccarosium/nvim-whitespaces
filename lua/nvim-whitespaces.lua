local M = {}
local autocmd = vim.api.nvim_create_autocmd
local config = {
    on_event = 'BufWritePre',
    ignore_ft = { 'markdown' },
}

function M.setup(options)
    config = vim.tbl_extend('force', config, options or {})

    vim.api.nvim_create_user_command("TrimSpaces", function()
        local trim = true
        local buff_ft = vim.bo.filetype
        for _, i in ipairs(config["ignore_ft"]) do
            if buff_ft == i then
                trim = false
            end
        end
        if trim then
            vim.cmd("%s/\\s\\+$//e")
        end
    end,
    {})

    vim.api.nvim_create_augroup("nvim_whitespaces", { clear = true })

    autocmd({ config["on_event"] }, {
        group = "nvim_whitespaces",
        pattern = "*",
        command = "TrimSpaces",
    })
end

return M
