const activate = (oni) => {
    // Take a screenshot on Control+Enter is pressed
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot())

    // Set zoom factor to 1.5 when Control+= is pressed
    oni.input.bind("<c-=>", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1.5))

    // Set zoom factor to 1 when Control+- is pressed
    oni.input.bind("<c-->", () => require("electron").remote.getCurrentWindow().webContents.setZoomFactor(1))
};

module.exports = {
    activate,

    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,

    "editor.fontFamily": "Fira Code Retina",

    "editor.maximizeScreenOnStart": true,

    "oni.bookmarks": ["F:\\User Files\\My Documents\\Git\\uni_work",
                      "F:\\User Files\\My Documents\\Git\\dotfiles"],

    "recorder.outputPath": "F:\\User Files\\My Pictures\\Oni",

    "experimental.sidebar.enabled": true,
    "debug.showTypingPrediction": true,

    "experimental.editor.textMateHighlighting.enabled": true,

    "vim.setting.autoread": true,
}
