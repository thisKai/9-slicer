'use strict'

const child_process = require('child_process')

const electron = require('electron')
const { app, BrowserWindow } = electron

const chokidar = require('chokidar')

let mainWindow // saves a global reference to mainWindow so it doesn't get garbage collected
console.log(app)
app.on('ready', createWindow) // called when electron has initialized

chokidar.watch(['./app/**/*.elm']).on('change', () => {
  child_process.exec('npm run build-elm', function(error, stdout, stderr){
    if(error)
      console.error(error)
    if(stdout)
      console.log(stdout)
    if(stderr)
      console.error(stderr)
  })
})
// tell chokidar to watch these files for changes
// reload the window if there is one
chokidar.watch(['./ports.js', './index.html', './app.js', './app.css', './sys/*.js']).on('change', () => {
  if (mainWindow) {
    mainWindow.reload()
  }
})

// This will create our app window, no surprise there
function createWindow () {
  mainWindow = new BrowserWindow({
    show: false,
    backgroundColor: '#000',
    width: 1024,
    height: 768,
  })

  // mainWindow.setMenu(null)

  mainWindow.once('ready-to-show', () => {
    mainWindow.show()
  })

  // display the index.html file
  mainWindow.loadURL(`file://${ __dirname }/index.html`)

  // open dev tools by default so we can see any console errors
  mainWindow.webContents.openDevTools()

  mainWindow.on('closed', () => {
    mainWindow = null
  })
}

/* Mac Specific things */

// when you close all the windows on a non-mac OS it quits the app
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') { app.quit() }
})

// if there is no mainWindow it creates one (like when you click the dock icon)
app.on('activate', () => {
  if (mainWindow === null) { createWindow() }
})
