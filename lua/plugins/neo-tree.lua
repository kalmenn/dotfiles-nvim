-- TODO: set keymaps

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false,
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = false,
            },
            follow_current_file = {
                enabled = true,
            },
            group_empty_dirs = true,
            use_libuv_file_watcher = true,
        },
        buffers = {
            follow_current_file = {
                enabled = true,
            },
            group_empty_dirs = true,
        },
        window = {
            position = "right",
            width = 30,
        },
        source_selector = {
            winbar = true,
        }
    },
    keys = {
        { "<C-N>t", "<cmd>Neotree toggle<cr>",           "Toggle Neotree" },
        { "<C-N>f", "<cmd>Neotree filesystem focus<cr>", "Focus filesystem in Neotree" },
        { "<C-N>b", "<cmd>Neotree buffers focus<cr>",    "Focus buffers in Neotree" },
        { "<C-N>g", "<cmd>Neotree git_status focus<cr>", "Focus git status in Neotree" },
    },
}
