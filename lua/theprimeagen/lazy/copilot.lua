return {
	"zbirenbaum/copilot.lua",
	config = function()
		require("copilot").setup({
			panel = {
				auto_refresh = true,
			},
		})
	end,
}
