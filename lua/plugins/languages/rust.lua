return {
    {
        "Saecki/crates.nvim",
        tag = "stable",
        init = function()
            local crates = require("crates")
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "Cargo.toml",
                group = vim.api.nvim_create_augroup("UserCratesNvimConfig", {}),
                callback = function(ev)
                    local opts = { silent = true, buffer = ev.buffer }

                    vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
                    vim.keymap.set("n", "<leader>cr", crates.reload, opts)

                    vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
                    vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
                    vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

                    vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
                    vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
                    vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
                    vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
                    vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
                    vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

                    vim.keymap.set("n", "<leader>ce", crates.expand_plain_crate_to_inline_table, opts)
                    vim.keymap.set("n", "<leader>cE", crates.extract_crate_into_table, opts)

                    vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
                    vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
                    vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
                    vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
                end,
            })
        end,
        opts = {},
        event = "BufEnter Cargo.toml",
    },
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        lazy = true,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("rust-tools").setup({
                server = {
                    capabilities = capabilities,
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                            },
                        },
                    },
                },
            })
        end,
    },
}
