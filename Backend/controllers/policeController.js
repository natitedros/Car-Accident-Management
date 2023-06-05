const Case = require('../models/accidentcase')
const User = require('../models/user')

module.exports.cases_get = (req, res)=>{
    Case.find({handlerId: req.params.id}).sort({ createdAt: -1 })
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

module.exports.near_me_get = (req, res)=>{
    const {location} = req.body
    const longitude = location.coordinates[0]
    const lattitude = location.coordinates[1]
    const query = {
        location:
          { $nearSphere :
             {
               $geometry: { type: "Point",  coordinates: [ longitude, lattitude ] }, 
               $maxDistance: 50000
             }
          },
          status: "open"
        }
    Case.collection.createIndex( { location : "2dsphere" } )
    Case.find(query).sort({ createdAt: -1 })
        .then((result)=>res.status(201).json({cases: result}))
        .catch((err)=>console.log(err))
    }

module.exports.assign_self = (req, res)=>{
    const {policeId, caseId} = req.body
    Case.findByIdAndUpdate(caseId, {handlerId: policeId, status: "pending"})
        .then(()=>res.status(201).json({message: "success"}))
        .catch((err)=>console.log(err))
}
