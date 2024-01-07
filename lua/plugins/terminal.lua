vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("UserTerminalConfig", {}),
    callback = function(ev)
        vim.opt_local.spell = false
    end,
})

return {}
