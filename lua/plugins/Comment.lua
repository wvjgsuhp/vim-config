-- see https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
