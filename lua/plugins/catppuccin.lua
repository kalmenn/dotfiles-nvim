return { {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            integrations = {
                treesitter = false,
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end
} }
