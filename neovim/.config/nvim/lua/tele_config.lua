-- Telescope config

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local custom_actions = {}

function custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = #picker:get_multi_selection()
    if num_selections > 1 then
        local cwd = picker.cwd
        if cwd == nil then
            cwd = ""
        else
            cwd = string.format("%s/", cwd)
        end
        vim.cmd("bw!")
        for _, entry in ipairs(picker:get_multi_selection()) do
            vim.cmd(string.format("%s %s%s", open_cmd, cwd, entry.value))
        end
        vim.cmd("stopinsert")
    else
        if open_cmd == "vsplit" then
            actions.file_vsplit(prompt_bufnr)
        elseif open_cmd == "split" then
            actions.file_split(prompt_bufnr)
        elseif open_cmd == "tabe" then
            actions.file_tab(prompt_bufnr)
        else
            actions.file_edit(prompt_bufnr)
        end
    end
end

function custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function custom_actions.multi_selection_open_split(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "split")
end
function custom_actions.multi_selection_open_tab(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "tabe")
end
function custom_actions.multi_selection_open(prompt_bufnr)
    custom_actions._multiopen(prompt_bufnr, "edit")
end

require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--smart-case"
        },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        file_ignore_patterns = {
            "%.git/.*",
            "%.vim/.*",
            "node_modules/.*",
            "%.vscode/.*",
        },
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
                ["<cr>"] = custom_actions.multi_selection_open,
                ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
                ["<c-s>"] = custom_actions.multi_selection_open_split,
                ["<c-t>"] = custom_actions.multi_selection_open_tab
            },
            n = {
                ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
                ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<cr>"] = custom_actions.multi_selection_open,
                ["<c-v>"] = custom_actions.multi_selection_open_vsplit,
                ["<c-s>"] = custom_actions.multi_selection_open_split,
                ["<c-t>"] = custom_actions.multi_selection_open_tab
            }
        }
    },
    extensions = {}
}

require('telescope').load_extension('fzf')
