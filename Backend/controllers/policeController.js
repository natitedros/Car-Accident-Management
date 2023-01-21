const Case = require('../models/accidentcase')

module.exports.cases_get = (req, res)=>{
    Case.find({handlerId: req.params.id})
        .then((result)=>{
            res.status(201).json({cases: result})
        })
        .catch((err)=>console.log(err))
}

module.exports.update_case = (req, res)=>{
    Case.findByIdAndUpdate(req.params.id, req.body)
        .then(()=>res.status(201).json({message: "update success"}))
        .catch((err)=>console.log(err))
}