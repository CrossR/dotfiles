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

    // Take a screenshot on Control+Enter is pressed
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot())

    // Set zoom factor to 1.5 when Control+= is pressed
    oni.input.bind("<c-=>", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1.25))

    // Set zoom factor to 1 when Control+- is pressed
    oni.input.bind("<c-->", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1))

    oni.input.bind("<s-c-v>", () => openLatexPDF(), isTexDoc)
    oni.input.bind("<s-c-w>", makeBookmarksMenu)
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
    "editor.fontSize" : "14px",
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
}
