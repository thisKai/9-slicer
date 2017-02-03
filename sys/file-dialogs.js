let electron = require('electron')
if(electron.remote) electron = electron.remote

const {BrowserWindow, dialog} = electron

function openImageUrl(){
  return new Promise((resolve, reject) => {
    const win = BrowserWindow.getFocusedWindow()
    dialog.showOpenDialog(win, {
      filters: [
        { name: 'PNG Image', extensions: ['png'] },
      ],
      properties: [ 'openFile' ],
    },
    function(filePaths){
      if(filePaths && filePaths[0]){
        resolve(filePaths[0])
      }else{
        reject()
      }
    })
  })
}

module.exports = {openImageUrl}
