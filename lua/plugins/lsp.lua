--- Automatically set the filetype for all buffers matching a pattern.
--- Uses an autocommand under the hood
--- @param pattern string|string[] What buffers to match on.
--- @see vim.api.nvim_create_autocmd
--- @param filetype string The filetype to set for the matching buffers
local function bind_filetype(pattern, filetype)
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = pattern,
        callback = function()
            vim.bo.filetype = filetype
        end,
    })
end

return {
    { import = "plugins/languages" },
    {
        "folke/neodev.nvim",
        opts = {
            lspconfig = false,
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function() end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<space>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set({ "n", "i" }, "<C-space>", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<space>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                    vim.keymap.set("n", "<C-m>", "<cmd>Telescope lsp_document_symbols<cr>", opts)
                end,
            })
        end,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            bind_filetype("*.wgsl", "wgsl")

            require("mason-lspconfig").setup({
                handlers = {
                    -- default handler
                    function(server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    -- overrides
                    ["rust_analyzer"] = function()
                        require("lazy").load({ plugins = { "rust-tools.nvim" } })
                    end,
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            before_init = require("neodev.lsp").before_init,
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
                    end,
                },
            })
        end,
    },
}
