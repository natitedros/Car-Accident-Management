const Case = require('../models/accidentcase')
const Car = require('../models/car')
const cloudinary = require('cloudinary').v2;
require('dotenv').config();

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

module.exports.cases_get = (req, res) =>{
    Case.find({subjectId: req.params.id})
        .then((result)=>{
            res.status(201).json(result)
        })
        .catch((err)=>console.log(err))
}

module.exports.cars_get = (req, res)=>{
    Car.find({ownerId: req.params.id})
        .then((result)=>{
            res.status(201).json(result)
        })
        .catch((err)=>console.log(err))
}

module.exports.add_car = (req, res)=>{
    const car = new Car(req.body)
    car.save()
        .then((result)=>{
            res.status(201).json({car: result._id})
        })
        .catch((err)=>console.log(err))
}

module.exports.add_minor_case = (req, res)=>{
    const accidentcase = new Case(req.body)
    accidentcase.save()
        .then((result)=>{
            res.status(201).json({case: result._id})
        })
        .catch((err)=>console.log(err))
}

module.exports.add_case_images = async (req, res) => {
    if (req.files) {

        const imageNames = await Promise.all(
            req.files.map(async (image) => new Promise((resolve, reject) => {
                console.log(image)
                cloudinary.uploader.upload_stream((error, result) => {
                    if (error) {
                        reject(error)
                    }
                    resolve(result.url);
                }).end(image.buffer)
            }))
        )

        const id = req.params.id
        Case.findByIdAndUpdate(id, { images: imageNames })
            .then((result)=>res.status(200).json({ case: result._id }))
            .catch((err)=>console.log(err))
    } else {
        res.status(400).send("Please upload a valid image");
    }
}