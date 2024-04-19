
local js_lang = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
}


return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
        },
        {
            "nvim-neotest/nvim-nio",
        },
    },
    config = function ()
        require("dap").adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { vim.fn.stdpath('data') .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
            }
        }
        for _, language in ipairs({ "typescript", "javascript" }) do
            require("dap").configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach debugger",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    sourceMap = true,
                    processId = function ()
                        return require"dap.utils".pick_process({filter = "--inspect"})
                    end
                }
            }
        end
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
        vim.keymap.set('n', '<leader>db', function() require('dap').continue() end)
        vim.keymap.set('n', '<leader>B', function() require('dap').toggle_breakpoint() end)
    end
}
--
-- return {
--     "mxsdev/nvim-dap-vscode-js",
--     build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
--     dependencies = {
--         {
--             "mfussenegger/nvim-dap",
--         },
--         {
--             "rcarriga/nvim-dap-ui",
--         },
--         {
--             "microsoft/vscode-js-debug",
--         },
--     },
--     config = function () 
--         require("dapui").setup()
--         require("dap").adapters["pwa-node"] = {
--             type = "server",
--             host = "localhost",
--             port = "6969",
--             executable = {
--                 command = "node",
--             }
--         }
--         for _, language in ipairs({ "typescript", "javascript" }) do
--             require("dap").configurations[language] = {
--                 {
--                     type = "pwa-node",
--                     request = "launch",
--                     name = "Launch file",
--                     program = "${file}",
--                     cwd = "${workspaceFolder}",
--                 },
--             }
--         end
--
--     end
-- }
