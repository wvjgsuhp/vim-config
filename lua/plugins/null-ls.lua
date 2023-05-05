-- plugin: null-ls.nvim
-- see: https://github.com/jose-elias-alvarez/null-ls.nvim
-- rafi settings

-- install:
-- brew install stylua shellcheck vint markdownlint-cli
-- brew install shfmt shellharden hadolint proselint

local builtins = require("null-ls").builtins
local on_attach = require("plugins.lspconfig").on_attach

local function has_exec(filename)
	return function(_)
		return vim.fn.executable(filename) == 1
	end
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
require("null-ls").setup({
	-- Ensure key maps are setup
	on_attach = on_attach,

	sources = {
		-- Whitespace
		builtins.diagnostics.trail_space.with({
			disabled_filetypes = { "gitcommit" },
		}),

		-- Javascript
		builtins.diagnostics.eslint,

		-- Lua
		builtins.formatting.stylua,

		-- SQL
		builtins.formatting.sqlformat,

		-- Shell
		-- builtins.code_actions.shellcheck,
		builtins.formatting.shfmt.with({
			runtime_condition = has_exec("shfmt"),
			extra_filetypes = { "bash" },
		}),

		-- Markdown
		builtins.diagnostics.markdownlint.with({
			runtime_condition = has_exec("markdownlint"),
			extra_filetypes = { "vimwiki" },
		}),
	},
})
