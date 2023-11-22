local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp.config")

vim.notify("Unable to setup custom configuration", vim.log.levels.INFO, { title = "Config" })

tailwindcss_colorizer_cmp.setup({})
