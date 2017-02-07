'use strict'

const {dialog} = require('electron').remote

const Elm = require('./app')
const {openImageUrl} = require('./sys/file-dialogs')

const saveSlices = require('./save-slices')

// start the elm app in the container
// and keep a reference for communicating with the app
const slicer = Elm.Main.fullscreen()

slicer.ports.requestOpenUrl.subscribe(() => {
  openImageUrl(dialog)
    .then(filePath => {
      const image = new Image()
      image.onload = e => {
        slicer.ports.openImage.send({
          url: `${filePath}?bust=${new Date().getTime()}`,
          size: {
            width: image.naturalWidth,
            height: image.naturalHeight,
          },
        })
      }
      image.src = filePath
    })
    .catch(err => console.log(err))
})


slicer.ports.saveSlices.subscribe(saveSlices)
