return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
        'mfussenegger/nvim-dap',
    },
    config = function()
        require("flutter-tools").setup {
            debugger = {
                enabled = true,
                register_configurations = function(_)
                    require("dap").configurations.dart = {}
                    require("dap.ext.vscode").load_launchjs()
                end,
            },
        }
    end
}
