const path = require('path')
const sharp = require('sharp')

function getSliceFilePath(imageUrl, sliceName){
   const {
     root,
     dir,
     base,
     ext,
     name,
   } = path.parse(imageUrl)

   const slicePath = path.join(dir, `${name}-${sliceName}${ext}`)
   console.log(slicePath)
   return slicePath
}

function saveImageCallback(err){
  if(err){
    console.error('Computer says no', err)
  }
}
function saveSlices(cropData){
  const {
    imageUrl,
    dimensions,
  } = cropData
  console.log(getSliceFilePath(imageUrl, 'topLeft'))
  const image = sharp(imageUrl)

  Object.keys(dimensions)
    .forEach(sliceName =>
      image
        .clone()
        .extract(dimensions[sliceName])
        .toFile(getSliceFilePath(imageUrl, sliceName), saveImageCallback)
    )
}


module.exports = saveSlices
