import * as React from "react"
import * as Oni from "oni-api"

import { existsSync, lstatSync, readdirSync, readFileSync } from "fs"
import { extname, join, posix, sep } from "path"
import { platform } from "os"

const FONT_STEP = 2
const SAVE_FONT_CHANGES = false
const LEADER = ","

const isWindows = platform == "win32"
const isLinux = platform == "linux"
const isMac = platform == "darwin"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("Config activated.")

    // General helpers
    const currentFile = () => oni.editors.activeEditor.activeBuffer.filePath
    const currentExtension = () =>
        oni.editors.activeEditor.activeBuffer.language
    const currentProject = () => oni.workspace.activeWorkspace

    const isVisualMode = () => oni.editors.activeEditor.mode === "visual"
    const isNormalMode = () => oni.editors.activeEditor.mode === "normal"
    const isNotInsertMode = () => oni.editors.activeEditor.mode !== "insert"
    const isNotCommandLine = () =>
        oni.editors.activeEditor.mode !== "cmdline_normal"
    const isMenuOpen = () => oni.menu.isMenuOpen()

    // Run some setup for my terminal menu.
    const terminals = oni.configuration.getValue("oni.terminals") as any[]

    oni.editors.activeEditor.neovim.command(
        `call Term_toggle_setup(${terminals.length})`
    )

    // Take a screenshot on Control+Enter is pressed
    oni.input.bind("<c-enter>", () => oni.recorder.takeScreenshot())

    // Increase font size
    oni.input.bind("<c-=>", () => increaseFontSize(oni))

    // Decrease font size
    oni.input.bind("<c-->", () => decreaseFontSize(oni))

    // Move about splits easier.
    oni.input.bind("<c-h>", () =>
        oni.editors.activeEditor.neovim.command(`call OniNextWindow('h')<CR>`)
    )
    oni.input.bind("<c-j>", () =>
        oni.editors.activeEditor.neovim.command(`call OniNextWindow('j')<CR>`)
    )
    oni.input.bind("<c-k>", () =>
        oni.editors.activeEditor.neovim.command(`call OniNextWindow('k')<CR>`)
    )
    oni.input.bind("<c-l>", () =>
        oni.editors.activeEditor.neovim.command(`call OniNextWindow('l')<CR>`)
    )

    // Unbind the symbols menu, so I can use Ctrl-t again.
    oni.input.unbind("<c-t>")

    // Let sneak work when a menu is open.
    // This allows my janky sessions saving code to work,
    // and lets me sneak to the confirm/deny button.
    oni.input.unbind("<c-g>")
    oni.input.bind("<c-g>", "sneak.show", () => isNormalMode())

    oni.input.unbind("<s-c-f>")
    oni.input.bind("<s-c-f>", "quickOpen.searchFileByContent", () =>
        isNormalMode()
    )

    oni.input.bind("<F9>", "markdown.togglePreview")

    oni.input.bind("<s-c-w>", () => makeBookmarksMenu(oni))
    oni.input.bind("<s-c-n>", () => makeTermMenu(oni, terminals))
    oni.input.bind("<s-c-s>", () => makeSessionsMenu(oni))

    oni.input.bind("<s-c-q>", () => makeWikiMenu(oni))

    oni.input.bind("<s-c-{>", () =>
        oni.editors.activeEditor.neovim.command("tabprevious")
    )
    oni.input.bind("<s-c-}>", () =>
        oni.editors.activeEditor.neovim.command("tabnext")
    )
}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("Config deactivated.")
}

export const configuration = {
    activate,
    deactivate,

    "oni.useDefaultConfig": false,
    "oni.loadInitVim": true,

    "ui.colorscheme": "gruvbox_dark",

    "editor.renderer": "webgl",
    "editor.fontFamily": "Consolas",
    "editor.fontSize": "14",
    "editor.fontLigatures": false,

    "configuration.showReferenceBuffer": false,

    "tabs.showIndex": true,
    "browser.enabled": true,

    "experimental.welcome.enabled": true,

    "experimental.markdownPreview.enabled": true,
    "experimental.markdownPreview.syntaxTheme": "gruvbox-dark",

    "experimental.achievements.enabled": true,
    "experimental.learning.enabled": true,
    "experimental.particles.enabled": true,
    "experimental.colorHighlight.enabled": true,
    "experimental.indentLines.enabled": true,
    "experimental.vcs.sidebar": true,
    "experimental.sessions.enabled": true,

    "debug.showTypingPrediction": true,
    "debug.showNotificationOnError": true,

    "sidebar.default.open": false,
    "sidebar.marks.enabled": true,
    "sidebar.plugins.enabled": true,

    "vim.setting.autoread": true,

    "autoClosingPairs.enabled": true,
    "autoClosingPairs.default": [
        { open: "{", close: "}" },
        { open: "[", close: "]" },
        { open: "(", close: ")" },
        { open: "<", close: ">" },
        { open: "'", close: "'" },
        { open: "`", close: "`" },
        { open: '"', close: '"' },
    ],

    "oni.terminals": [
        { name: "CMD", command: "cmd" },
        { name: "PowerShell", command: "powershell" },
        { name: "Bash", command: "bash" },
        {
            name: "Anaconda",
            command:
                "cmd /K " +
                "F:/ProgramData/Anaconda3/Scripts/activate.bat " +
                "F:/ProgramData/Anaconda3",
        },
    ],

    "oni.plugins.prettier": {
        settings: {
            semi: false,
            tabWidth: 4,
            useTabs: false,
            singleQuote: false,
            trailingComma: "es5",
            bracketSpacing: true,
            jsxBracketSameLine: false,
            arrowParens: "avoid",
            printWidth: 80,
        },
        formatOnSave: true,
        enabled: true,
        allowedFiletypes: [
            ".js",
            ".jsx",
            ".ts",
            ".tsx",
            ".html",
            ".json",
            ".graphql",
        ],
    },

    "experimental.indentLines.bannedFiletypes": [".md"],
}

// Various helpers for dealing with files easier.
const isDirectory = source => lstatSync(source).isDirectory()
const isFile = source => lstatSync(source).isFile()
const extensionMatches = (source, extension) => extname(source) === extension
const getFileName = source => source.split(sep).pop()
const getFolderName = source => source.split(sep).pop()
const getFileNameNoExtension = source =>
    source
        .split(sep)
        .pop()
        .split(".")[0]
const getFolder = source =>
    source
        .split(sep)
        .slice(0, -1)
        .join(sep)

function getDirectories(source: string) {
    return readdirSync(source)
        .map(name => join(source, name))
        .filter(isDirectory)
}

function getAllFiles(source: string) {
    const allFolderContents = readdirSync(source).map(name =>
        join(source, name)
    )

    let files = []

    for (const folderContent of allFolderContents) {
        if (isDirectory(folderContent)) {
            files = files.concat(getAllFiles(folderContent))
        } else if (isFile(folderContent)) {
            files.push(folderContent)
        }
    }

    return files
}

// Add a bookmarks menu to swap easily between different workspaces.
// Dynamically generated from my Git folder.
async function makeBookmarksMenu(oni: Oni.Plugin.Api) {
    const bookmarkMenu = oni.menu.create()

    const gitFolder = await oni.editors.activeEditor.neovim.eval(
        "$GIT_DEFAULT_DIR"
    )

    if (!gitFolder) {
        return
    }

    const gitProjects = getDirectories(gitFolder)

    let menuItems = gitProjects.map(b => ({
        icon: "bookmark",
        detail: b,
        label: b.split(sep).pop(),
    }))

    // Add the open folder option as well.
    menuItems.unshift({
        icon: "folder-open",
        detail: "Set a folder as the workspace for Oni",
        label: "Open Folder",
    })

    bookmarkMenu.show()
    bookmarkMenu.setItems(menuItems)

    bookmarkMenu.onItemSelected.subscribe(menuItem => {
        if (menuItem && menuItem.label !== "Open Folder") {
            oni.workspace.changeDirectory(menuItem.detail)
        } else if (menuItem && menuItem.label === "Open Folder") {
            oni.workspace.openFolder()
        }
    })
}

// Remove unwanted files from the Wiki menu.
function inWikiBlackList(filename: string) {
    const ignoredFiles = [
        "index.md", // Easily accessible with <leader>ww
    ]

    const ignoredFolders = [
        "diary", // No need for these.
    ]

    const fileMatchIndex = ignoredFiles.indexOf(getFileName(filename))
    const folderMatchIndex = ignoredFolders.indexOf(
        getFolderName(getFolder(filename))
    )

    if (fileMatchIndex !== -1 || folderMatchIndex !== -1) {
        return true
    }

    return false
}

// Menu to fuzzy search Wiki files.
async function makeWikiMenu(oni: Oni.Plugin.Api) {
    const wikiMenu = oni.menu.create()

    const wikiFolder = await oni.editors.activeEditor.neovim.eval(
        "g:nvim_diary_template#notes_path"
    )

    if (!wikiFolder) {
        return
    }

    let wikiEntries = getAllFiles(wikiFolder)

    const markdownFiles = wikiEntries.filter(
        f => extensionMatches(f, ".md") && !inWikiBlackList(f)
    )

    let menuItems = markdownFiles.map(e => ({
        icon: "sticky-note",
        detail: e,
        label: getFileNameNoExtension(e),
    }))

    wikiMenu.show()
    wikiMenu.setItems(menuItems)

    wikiMenu.onItemSelected.subscribe(menuItem => {
        if (menuItem) {
            oni.editors.openFile(menuItem.detail)
        }
    })
}

// Setup a terminal selection menu.
function makeTermMenu(oni: Oni.Plugin.Api, terminals: any[]) {
    const termMenu = oni.menu.create()

    let termId = 0

    const menuItems = terminals.map(t => ({
        icon: "terminal",
        detail: t.command,
        label: t.name,
        metadata: { id: termId++ },
    })) as any

    termMenu.show()
    termMenu.setItems(menuItems)

    termMenu.onItemSelected.subscribe(menuItem => {
        if (menuItem) {
            oni.editors.activeEditor.neovim.callFunction("Term_open", [
                menuItem.metadata.id,
                menuItem.detail,
            ])
        }
    })
}

// Create a session loading menu.
async function makeSessionsMenu(oni: Oni.Plugin.Api) {
    const sessionMenu = oni.menu.create()

    const neovimConfigPath = await oni.editors.activeEditor.neovim.eval(
        "$MYVIMRC"
    )
    const sessionsFolder = join(getFolder(neovimConfigPath), "sessions")

    const vimSessions = getAllFiles(sessionsFolder)

    const menuItems = vimSessions.map(s => ({
        icon: "window-restore ",
        detail: s,
        label: getFileNameNoExtension(s),
    })) as any

    menuItems.unshift({
        icon: "save",
        detail: "Save the current workspace with s! .",
        label: "Save Workspace",
        pinned: true,
    })

    sessionMenu.show()
    sessionMenu.setItems(menuItems)

    sessionMenu.onItemSelected.subscribe(menuItem => {
        if (menuItem) {
            oni.editors.activeEditor.neovim.command(`source ${menuItem.detail}`)
        }
    })

    sessionMenu.onFilterTextChanged.subscribe(filterText => {
        if (filterText) {
            if (filterText.startsWith("s! ") && filterText.endsWith(".")) {
                const sessionName = filterText.split(" ")[1]
                const checkSave = oni.notifications.createItem()

                checkSave.setContents(
                    "Save Workspace",
                    `Would you like to save workspace ${sessionName}?`
                )

                checkSave.setButtons([
                    {
                        title: "Yes",
                        callback: () => {
                            oni.editors.activeEditor.neovim.command(
                                `Obsession ${sessionsFolder}\\${sessionName}.vim`
                            )
                            checkSave.hide()
                            sessionMenu.hide()
                        },
                    },
                    {
                        title: "No",
                        callback: () => {},
                    },
                ])

                checkSave.show()
            }
        }
    })
}

function increaseFontSize(oni: Oni.Plugin.Api) {
    const currentFontSize = oni.configuration.getValue(
        "editor.fontSize"
    ) as string

    let newFontSize = parseInt(currentFontSize) + FONT_STEP

    oni.configuration.setValues({
        "editor.fontSize": newFontSize,
    })
}

function decreaseFontSize(oni: Oni.Plugin.Api) {
    const currentFontSize = oni.configuration.getValue(
        "editor.fontSize"
    ) as string

    let newFontSize = parseInt(currentFontSize) - FONT_STEP
    newFontSize = newFontSize <= 2 ? 2 : newFontSize

    oni.configuration.setValues({
        "editor.fontSize": newFontSize,
    })
}
