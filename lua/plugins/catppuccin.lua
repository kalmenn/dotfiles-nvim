return { {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                treesitter = true,
            },
            transparent_background = true,
        })
        vim.cmd.colorscheme("catppuccin")
    end,
} }
