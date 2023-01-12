local M = {}
local autocmd = vim.api.nvim_create_autocmd
local config = {
    on_event = { 'BufWritePre' },
    ignore_ft = {},
    ignore_on_project = {},
}

local function trim_spaces()
    local trim = true
    local cwd = vim.fn.getcwd()
    for _, dir in ipairs(config["ignore_on_project"]) do
        if cwd == vim.fn.expand(dir) then
            trim = false
            break
        end
    end
    local buff_ft = vim.bo.filetype
    for _, ft in ipairs(config["ignore_ft"]) do
        if buff_ft == ft then
            trim = false
            break
        end
    end
    if trim then
        vim.cmd [[%s/\s\+$//eg]]
    end
end

function M.setup(options)
    config = vim.tbl_extend('force', config, options or {})
    vim.api.nvim_create_user_command("TrimSpaces", function ()
        trim_spaces()
    end, {})
    vim.api.nvim_create_augroup("nvim_whitespaces", { clear = true })
    autocmd(config["on_event"], {
        group = "nvim_whitespaces",
        pattern = "*",
        command = "TrimSpaces",
    })
end

return M
