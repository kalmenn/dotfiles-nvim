return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        init = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
        config = function()
            local lspconfig = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities();

            lspconfig.pyright.setup({
                capabilities = capabilities,
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end
    },
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "Saecki/crates.nvim",
                tag = 'stable',
                init = function()
                    local crates = require('crates')
                    vim.api.nvim_create_autocmd("BufEnter", {
                        pattern = "Cargo.toml",
                        group = vim.api.nvim_create_augroup('UserCratesNvimConfig', {}),
                        callback = function(ev)
                            local opts = { silent = true, buffer = ev.buffer }

                            vim.keymap.set('n', '<leader>ct', crates.toggle, opts)
                            vim.keymap.set('n', '<leader>cr', crates.reload, opts)

                            vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts)
                            vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts)
                            vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts)

                            vim.keymap.set('n', '<leader>cu', crates.update_crate, opts)
                            vim.keymap.set('v', '<leader>cu', crates.update_crates, opts)
                            vim.keymap.set('n', '<leader>ca', crates.update_all_crates, opts)
                            vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, opts)
                            vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, opts)
                            vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, opts)

                            vim.keymap.set('n', '<leader>ce', crates.expand_plain_crate_to_inline_table, opts)
                            vim.keymap.set('n', '<leader>cE', crates.extract_crate_into_table, opts)

                            vim.keymap.set('n', '<leader>cH', crates.open_homepage, opts)
                            vim.keymap.set('n', '<leader>cR', crates.open_repository, opts)
                            vim.keymap.set('n', '<leader>cD', crates.open_documentation, opts)
                            vim.keymap.set('n', '<leader>cC', crates.open_crates_io, opts)
                        end,
                    })
                end,
                opts = {},
                event = "BufEnter Cargo.toml",
            },
        },
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities();

            require("rust-tools").setup({
                server = {
                    on_attach = function(_, bufnr)
                        local rt = require("rust-tools");
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                    capabilities = capabilities,
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                            },
                        },
                    },
                },
            });
        end,
    }
}
