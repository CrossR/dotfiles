const activate = oni => {

    const currentFile = () => oni.editors.activeEditor.activeBuffer.filePath
    const currentExtension = () => oni.editors.activeEditor.activeBuffer.language
    const isTexDoc = () => currentExtension() === "tex"
    const pdfFile = () => currentFile().replace(/\.[^/.]+$/, "") + ".pdf"
    const escapedPdf = () => "file:///" + escape(pdfFile.replace(/\\/g,"/"))

    // Take a screenshot on Control+Enter is pressed
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot())

    // Set zoom factor to 1.5 when Control+= is pressed
    oni.input.bind("<c-=>", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1.25))

    // Set zoom factor to 1 when Control+- is pressed
    oni.input.bind("<c-->", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1))

    oni.input.bind("<s-c-v>", () => oni.commands.executeCommand("browser.openUrl", escapedPdf), isTexDoc)
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
        { "open": "'", "close": "'" },
        { "open": "`", "close": "`" },
        { "open": '"', "close": '"' },
    ],
}
