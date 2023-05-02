const multer = require("multer");
const storageEngine = multer.diskStorage({
    destination: "./images",
      filename: (req, file, cb) => {
        cb(null, `${Date.now()}--${file.originalname}`);
      },
});

const tempStorage = multer.memoryStorage()

const path = require("path");

const checkFileType = function (file, cb) {
    //Allowed file extensions
    const fileTypes = /jpeg|jpg|png|gif|svg/;

    //check extension names
    const extName = fileTypes.test(path.extname(file.originalname).toLowerCase());

    if (extName) {
        return cb(null, true);
    } else {
        cb("Error: You can Only Upload Images!!");
    }
};

const upload = multer({
    storage: tempStorage,
    limits: { fileSize: 2000000 },
    fileFilter: (req, file, cb) => {
        checkFileType(file, cb);
    },
});

module.exports = { upload }