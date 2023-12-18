return {
    "mbbill/undotree",
    keys = {
        {
            "<A-u>",
            function()
                vim.cmd.UndotreeToggle();
                vim.cmd.UndotreeFocus();
            end
        },
    },
}
