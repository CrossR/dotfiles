import * as React from "C:\\Program Files (x86)\\Oni\\resources\\app\\node_modules\\react"
import * as Oni from "C:\\Program Files (x86)\\Oni\\resources\\app\\node_modules\\oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("Config activated.")
    // General helpers

    const currentFile = oni.editors.activeEditor.activeBuffer.filePath
    const currentExtension = oni.editors.activeEditor.activeBuffer.language

    // Add a bookmarks menu to swap easily between different workspaces.

    const makeBookmarksMenu = () => {
        const bookmarkMenu = oni.menu.create()

        const bookmarks = oni.configuration.getValue("oni.bookmarks") as any[]

        const menuItems = bookmarks.map((s) => ({icon: "bookmark",
                                                 detail: s,
                                                 label: s.split("\\").pop()}))

        bookmarkMenu.show()
        bookmarkMenu.setItems(menuItems)

        bookmarkMenu.onItemSelected.subscribe(menuItem => {
            if (menuItem) {
                oni.workspace.changeDirectory(menuItem.detail)
            }
        })
    }

    // Setup a terminal selection menu.
    // Needs to have a vim-script setup function called to save references to each
    // terminal.

    const terminals = oni.configuration.getValue("oni.terminals") as any[]

    oni.editors.activeEditor.neovim.command(`call Term_toggle_setup(${terminals.length})`)

    const makeTermMenu = () => {
        const termMenu = oni.menu.create()

        let termId = 0

        const menuItems = terminals.map((t) => ({
            icon: "terminal",
            detail: t.command,
            label: t.name,
            metadata: {id: termId++}
        })) as any

        termMenu.show()
        termMenu.setItems(menuItems)

        termMenu.onItemSelected.subscribe(menuItem => {
            if (menuItem) {
                oni.editors.activeEditor.neovim.command(`call Term_open(${menuItem.metadata.id},"${menuItem.detail}")`)
            }
        })
    }

    // Take a screenshot on Control+Enter is pressed
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot())

    // Set zoom factor to 1.5 when Control+= is pressed
    oni.input.bind("<c-=>", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1.25))

    // Set zoom factor to 1 when Control+- is pressed
    oni.input.bind("<c-->", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1))

    oni.input.bind("<s-c-w>", makeBookmarksMenu)
    oni.input.bind("<s-c-n>", makeTermMenu)

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("Config deactivated.")
}

export const configuration = {
    activate,
    deactivate,

    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,

    "ui.colorscheme": "onedark",

    "editor.fontFamily": "Fira Code Retina",
    "editor.quickOpen.filterStrategy": "regex",

    "experimental.welcome.enabled": false,
    "experimental.markdownPreview.enabled": true,
    "experimental.browser.enabled": true,
    "experimental.editor.textMateHighlighting.enabled": true,

    "debug.showTypingPrediction": true,

    "sidebar.marks.enabled": true,
    "sidebar.plugins.enabled": true,

    "vim.setting.autoread": true,

    "autoClosingPairs.enabled": true,
    "autoClosingPairs.default": [
        { "open": "{", "close": "}" },
        { "open": "[", "close": "]" },
        { "open": "(", "close": ")" },
        { "open": "<", "close": ">" },
        { "open": "'", "close": "'" },
        { "open": "`", "close": "`" },
        { "open": '"', "close": '"' },
    ],

    "oni.bookmarks": [
        "C:\\Users\\Ryan\\Documents\\Git\\uni_work",
        "C:\\Users\\Ryan\\Documents\\Git\\meng_project",
        "C:\\Users\\Ryan\\Documents\\Git\\oni",
        "C:\\Users\\Ryan\\Documents\\Git\\dotfiles"
    ]

    "oni.terminals": [
        {"name": "CMD", "command": "cmd"},
        {"name": "PowerShell", "command": "powershell"},
        {"name": "Bash", "command": "bash"},
        {"name": "Anaconda", "command":
            "cmd /K " +
            "F:/ProgramData/Anaconda/Scripts/activate.bat " +
            "F:/ProgramData/Anaconda"},
    ],
}
