return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "BurntSushi/ripgrep",
        "nvim-lua/plenary.nvim",
        "sharkdp/fd",
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    keys = {
        { "<C-t>f", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files with Telescope" },
        { "<C-p>",  "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files with Telescope" },
        { "<C-t>b", "<cmd>Telescope buffers<cr>",    desc = "Fuzzy find open buffers with Telescope" },
        { "<C-t>s", "<cmd>Telescope lsp_document_symbols<cr>",    desc = "Fuzzy find lsp symbols in current document with Telescope" },
    },
    opts = {
        pickers = {
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--no-ignore-vcs" },
            },
        },
    },
}
