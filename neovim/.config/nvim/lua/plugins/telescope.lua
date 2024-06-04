-- Telescope config
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {{"nvim-lua/plenary.nvim"}, {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    }},
    config = function()

        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local transform_mod = require("telescope.actions.mt").transform_mod
        local builtin = require("telescope.builtin")

        local custom_actions = {}

        local function multiopen(prompt_bufnr, method)
            local cmd_map = {
                vertical = "vsplit",
                horizontal = "split",
                tab = "tabe",
                default = "edit"
            }

            local picker = action_state.get_current_picker(prompt_bufnr)
            local multi_selection = picker:get_multi_selection()

            if #multi_selection > 1 then
                require("telescope.pickers").on_close_prompt(prompt_bufnr)
                pcall(vim.api.nvim_set_current_win, picker.original_win_id)

                for i, entry in ipairs(multi_selection) do
                    local cmd = i == 1 and "edit" or cmd_map[method]
                    vim.cmd(string.format("%s %s", cmd, entry.value))
                end
            else
                actions["select_" .. method](prompt_bufnr)
            end
        end

        local custom_actions = transform_mod({
            multi_selection_open_vsplit = function(prompt_bufnr)
                multiopen(prompt_bufnr, "vertical")
            end,
            multi_selection_open_split = function(prompt_bufnr)
                multiopen(prompt_bufnr, "horizontal")
            end,
            multi_selection_open_tab = function(prompt_bufnr)
                multiopen(prompt_bufnr, "tab")
            end,
            multi_selection_open = function(prompt_bufnr)
                multiopen(prompt_bufnr, "default")
            end
        })

        local function stopinsert(callback)
            return function(prompt_bufnr)
                vim.cmd.stopinsert()
                vim.schedule(function()
                    callback(prompt_bufnr)
                end)
            end
        end

        local is_inside_work_tree = {}

        _G.project_files = function()
            local opts = {} -- define here if you want to define something

            local cwd = vim.fn.getcwd()
            if is_inside_work_tree[cwd] == nil then
                vim.fn.system("git rev-parse --is-inside-work-tree")
                is_inside_work_tree[cwd] = vim.v.shell_error == 0
            end

            if is_inside_work_tree[cwd] then
                builtin.git_files(opts)
            else
                builtin.find_files(opts)
            end
        end

        require("telescope").setup {
            defaults = {
                vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number",
                                     "--column", "--hidden", "--smart-case"},
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                file_ignore_patterns = {"%.git/.*", "%.vim/.*", "node_modules/.*", "%.vscode/.*"},
                layout_config = {
                    vertical = {
                        mirror = true
                    },
                    width = 0.93,
                    prompt_position = "top"
                },
                mappings = {
                    i = {
                        -- close on escape
                        ["<esc>"] = actions.close,
                        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<cr>"] = stopinsert(custom_actions.multi_selection_open),
                        ["<c-v>"] = stopinsert(custom_actions.multi_selection_open_vsplit),
                        ["<c-s>"] = stopinsert(custom_actions.multi_selection_open_split),
                        ["<c-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
                        ["<c-f>"] = actions.to_fuzzy_refine
                    },
                    n = {
                        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                        ["<cr>"] = stopinsert(custom_actions.multi_selection_open),
                        ["<c-v>"] = stopinsert(custom_actions.multi_selection_open_vsplit),
                        ["<c-s>"] = stopinsert(custom_actions.multi_selection_open_split),
                        ["<c-t>"] = stopinsert(custom_actions.multi_selection_open_tab)
                    }
                }
            },
            extensions = {}
        }
    end,
    setup = function()
        require("telescope").load_extension("fzf")
    end,
    keys = {
        {"<c-p>", "<CMD>lua project_files()<CR>"},
        {"<c-f>", "<CMD>Telescope live_grep<CR>"},
        {"<leader>b", "<CMD>Telescope buffers<CR>"}
    }
}
