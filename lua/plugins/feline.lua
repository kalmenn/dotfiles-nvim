return {
    'freddiehaddad/feline.nvim',
    dependencies = {
        "lewis6991/gitsigns.nvim",
    },
    lazy = false,
    config = function(_, opts)
        require('feline').setup()
        -- require('feline').winbar.setup()       -- to use winbar
        require('feline').statuscolumn.setup() -- to use statuscolumn

        -- require('feline').use_theme()          -- to use a custom theme
    end
}
