const Case = require('../models/accidentcase')
const Car = require('../models/car')

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