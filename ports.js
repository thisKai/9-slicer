'use strict'

const {dialog} = require('electron').remote

const Elm = require('./app.js')

// start the elm app in the container
// and keep a reference for communicating with the app
const slicer = Elm.Main.fullscreen()
