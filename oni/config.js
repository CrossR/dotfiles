const activate = (oni) => {

    const currentFile = () => Oni.editors.activeEditor.activeBuffer.filePath
    const currentExtension = () => currentFile().replace(/^.*\./, '')
    const isTexDoc = () => currentExtension() === "tex"
    const pdfFile = () => currentFile().replace(/\.[^/.]+$/, "") + ".pdf"
    const escapedPdf = () => "file:///" + escape(pdfFile.replace(/\\/g,"/"))

    // Take a screenshot on Control+Enter is pressed
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot())

    // Set zoom factor to 1.5 when Control+= is pressed
    oni.input.bind("<c-=>", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1.25))

    // Set zoom factor to 1 when Control+- is pressed
    oni.input.bind("<c-->", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1))

    oni.input.bind("<s-c-v>", () => Oni.commands.executeCommand("browser.openUrl", escapedPdf), isTexDoc)
};

module.exports = {
    activate,

    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,

    "editor.fontFamily": "Fira Code Retina",
    "editor.quickOpen.filterStrategy": "regex",

    "editor.maximizeScreenOnStart": true,

    "oni.bookmarks": ["F:\\User Files\\My Documents\\Git\\uni_work",
                      "F:\\User Files\\My Documents\\Git\\dotfiles"],
    "recorder.outputPath": "C:\\Users\\Ryan\\Pictures\\Oni",

    "experimental.markdownPreview.enabled": true,

    "experimental.sidebar.enabled": true,

    "experimental.browser.enabled": true,

    "experimental.commandline.mode": true,
    "experimental.commandline.icons": true,
    "experimental.wildmenu.mode": true,

    "debug.showTypingPrediction": true,

    "experimental.editor.textMateHighlighting.enabled": true,

    "vim.setting.autoread": true,

    "autoClosingPairs.enabled": true,
    "autoClosingPairs.default": [
        { "open": "{", "close": "}" },
        { "open": "[", "close": "]" },
        { "open": "(", "close": ")" },
        { "open": "'", "close": "'" },
        { "open": "`", "close": "`" },
    ],
}
