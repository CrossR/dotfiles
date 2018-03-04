const activate = oni => {

    // General helpers

    const currentFile = oni.editors.activeEditor.activeBuffer.filePath
    const currentExtension = oni.editors.activeEditor.activeBuffer.language

    // Open the generated PDF from a Latex doc in the embedded browser

    const isTexDoc = () => currentExtension === "tex"

    const openLatexPDF = () => {
        const pdfFile = currentFile.replace(/\.[^/.]+$/, "") + ".pdf"
        const escapedPdf = "file:///" + encodeURI(pdfFile.replace(/\\/g,"/"))

        oni.commands.executeCommand("browser.openUrl", escapedPdf)
    }

    function delay(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    const reloadLatexPDF = async () => {
        if (!isTexDoc()) {
            return
        }

        await delay(3000)

        oni.commands.executeCommand("browser.reload")
    }

    oni.editors.activeEditor.onBufferSaved.subscribe(evt => {
        reloadLatexPDF()
    })

    // Add a bookmarks menu to swap easily between different workspaces.

    const makeBookmarksMenu = () => {
        const bookmarkMenu = oni.menu.create()

        const bookmarks = oni.configuration.getValue("oni.bookmarks")

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

    const terminals = oni.configuration.getValue("oni.terminals")

    oni.editors.activeEditor.neovim.command(`call Term_toggle_setup(${terminals.length})`)

    const makeTermMenu = () => {
        const termMenu = oni.menu.create()

        let termId = 0

        const menuItems = terminals.map((t) => ({
            icon: "terminal",
            detail: t.command,
            label: t.name,
            metadata: {id: termId++}
        
        }))

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

    oni.input.bind("<s-c-v>", () => openLatexPDF(), isTexDoc)
    oni.input.bind("<s-c-w>", makeBookmarksMenu)
    oni.input.bind("<s-c-n>", makeTermMenu)
};

const deactivate = () => {
    console.log("config deactivated")
}

module.exports = {
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
