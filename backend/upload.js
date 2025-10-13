const cloudinary = require('./cloudinary');
const fs = require('fs');
const path = require('path');

// Allowed image extensions
const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.svg'];

async function uploadFolder(folderPath) {
  try {
    const subfolders = fs.readdirSync(folderPath).filter(f => fs.statSync(path.join(folderPath, f)).isDirectory());

    for (const subfolder of subfolders) {
      const subfolderPath = path.join(folderPath, subfolder);
      const files = fs.readdirSync(subfolderPath).filter(file =>
        allowedExtensions.includes(path.extname(file).toLowerCase())
      );

      console.log(`Uploading ${files.length} files from ${subfolder}...`);

      for (const file of files) {
        const filePath = path.join(subfolderPath, file);
        try {
          const result = await cloudinary.uploader.upload(filePath);
          console.log(`Uploaded ${file}: ${result.secure_url}`);
          // TODO: insert result.secure_url into MySQL here
        } catch (err) {
          console.error(`Error uploading file ${file}:`, err.message);
        }
      }
    }
  } catch (err) {
    console.error('Error uploading folder:', err);
  }
}

// Call the function on the 'images' folder
uploadFolder(path.join(__dirname, 'images'));
