vim.filetype.add({
    extension = {
        typ = function(_, bufnr)
            vim.bo[bufnr].shiftwidth = 2
            vim.bo[bufnr].tabstop = 2
            return "typst"
        end,
    },
})
