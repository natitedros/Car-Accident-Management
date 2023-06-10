const User = require('../models/user')
const bcrypt = require('bcrypt')

module.exports.change_password = (req, res) => {
    const id = req.params.id
    const { newPassword, oldPassword } = req.body;
    console.log(newPassword, oldPassword)
    if (newPassword == null | oldPassword == null){
        return res.status(400).json({message: "No password entered!"});
    }
    User.findById(id)
        .then((result)=> {
            bcrypt.compare(oldPassword, result.password)
            .then((auth)=>{
                if (auth){
                    bcrypt.genSalt().then((salt)=>{
                        bcrypt.hash(newPassword, salt).then((newP)=>{
                            User.findByIdAndUpdate(id, {password : newP})
                                .then(()=>{
                                    return res.status(201).json({ message: "Password successfully changed!" });
                                })
                                .catch((err)=>console.log(err))
                                })
                    })
                    
                } else{
                    res.status(400).json({message: "Old password not entered correctly!"})
                }
            })
            })
}

module.exports.change_number = (req, res) => {
    const id = req.params.id
    const { newNumber } = req.body;
    User.findByIdAndUpdate(id, {phoneNumber : newNumber})
        .then((result)=>{
            res.status(201).json({message: "Phone Number Updated!"})
        })
        .catch((err)=>{
            console.log(err)
            res.status(201).json({message: "Something went wrong, try again!"})
        })

}