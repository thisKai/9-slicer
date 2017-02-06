'use strict'

const {dialog} = require('electron').remote

const Elm = require('./app.js')
const {openImageUrl} = require('./sys/file-dialogs.js')


// start the elm app in the container
// and keep a reference for communicating with the app
const slicer = Elm.Main.fullscreen()

slicer.ports.requestOpenUrl.subscribe(() => {
  openImageUrl(dialog)
    .then(filePath => {
      const image = new Image()
      image.src = filePath
      slicer.ports.receiveUrl.send(filePath)
    })
    .catch(err => console.log(err))
})

slicer.ports.saveSlices.subscribe(cropData => {
  console.log(cropData)
})
