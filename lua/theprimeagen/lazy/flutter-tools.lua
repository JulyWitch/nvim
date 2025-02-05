return {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("flutter-tools").setup({
			flutter_lookup_cmd = "dirname $(which flutter)",
			fvm = false,
			widget_guides = { enabled = true },
			closing_tags = {
				enabled = true,
				highlight = "LineNr",
				prefix = "󰡒  ",
				priority = 0,
			},
			dev_log = {
				enabled = true,
				notify_errors = false,
				filter = function(log_line)
					if log_line:find("ImpellerValidationBreak") then
						return false
					end
					return true
				end,
			},
			decorations = {
				statusline = {
					app_version = true,
					device = true,
					project_config = true,
				},
			},
			lsp = {
				-- Explicitly set the Dart SDK path
				cmd = {
					vim.fn.expand("$HOME/development/flutter/bin/dart"), -- Adjust this path to your Dart SDK location
					"language-server",
					"--protocol=lsp",
				},
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					analysisExcludedFolders = {
						vim.fn.expand("$HOME/.pub-cache"),
						vim.fn.expand("$HOME/development"),
					},
					renameFilesWithClasses = "prompt",
					enableSnippets = true,
					updateImportsOnRename = true,
				},
			},
			debugger = {
				enabled = true,
				run_via_dap = true,
				exception_breakpoints = {},
				evaluate_to_string_in_debug_views = true,
				register_configurations = function()
					local dap = require("dap")
					dap.adapters.dart = {
						type = "executable",
						command = vim.fn.resolve(vim.fn.exepath("flutter")),
						args = { "debug-adapter" },
					}
					dap.configurations.dart = {
						{
							type = "dart",
							request = "launch",
							name = "Launch Flutter Program",
							program = "${workspaceFolder}/lib/main.dart",
							cwd = "${workspaceFolder}",
						},
					}
					require("dap.ext.vscode").load_launchjs()
				end,
			},
		})
	end,
}
