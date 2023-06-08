const User = require('../models/user')
const Case = require('../models/accidentcase')
const Cars  = require('../models/car')
const Car = require('../models/car')

module.exports.search_post = (req, res)=>{
    User.find({email: req.body.email})
        .then((result) => {
            res.status(201).json({id: result[0]._id, name: result[0].name, role: result[0].role})
        })
        .catch((err)=>{
            console.log(err)
            res.status(400).json({error: "No user found with this email"})
        })
}
module.exports.delete_user = (req, res)=>{
    User.findByIdAndDelete(req.params.id)
        .then((result)=>{
            Car.deleteMany({ ownerId: result._id })
                .then((res)=>{
                    res.status(201).json({message: "user deleted"})
                })
                .catch((err)=>console.log(err))
            console.log("user deleted")
        })
        .catch((err)=>console.log(err))
}
module.exports.toggle_activation = (req, res)=>{
    User.findByIdAndUpdate(req.params.id, { $bit: { isActive: { xor: 1 } } },
        { new: true })
        .then((result)=>{
            const msg = result.isActive ? "active" : "inactive";
            res.status(201).json({message: "user "+msg})
            console.log("user activation toggled")
        })
        .catch((err)=>console.log(err))
}
module.exports.list_cases = (req, res)=>{
    Case.find().sort( {createdAt: -1})
        .then((result)=>{
            res.status(201).json({cases: result})
        })
        .catch((err)=>console.log(err))
}