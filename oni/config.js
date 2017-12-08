const activate = (oni) => {
    // access the Oni plugin API here
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot());
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

    "experimental.editor.typingPrediction": true,
    "debug.showTypingPrediction": true,

    "experimental.editor.textMateHighlighting.enabled": true,
}
