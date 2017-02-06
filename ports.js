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
      image.onload = e => {
        console.log(image.naturalWidth, image.naturalHeight)
        slicer.ports.openImage.send({
          sourceUrl: filePath,
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

slicer.ports.saveSlices.subscribe(cropData => {
  console.log(cropData)
})
