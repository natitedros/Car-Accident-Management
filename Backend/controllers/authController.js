const User = require('../models/user')
const jwt = require('jsonwebtoken')

//handle errors
const handleErrors = (err)=>{

    let error = {name: "", email: "", password: ""}

    //handles registered email
    if (err.code === 11000){
        error.email = "That email is already registered"
        return error
    }
    //if the input violates the validations
    // console.log(err.message, err.code)
    if (err.message === 'incorrect email'){
        error.email = 'That email is not registered'
    }
    if (err.message === 'incorrect password'){
        error.password = 'That password is incorrect'
    }
    if (err.message.includes('user validation failed')){
        Object.values(err.errors).forEach(({properties}) => {
            //properties.path=email and properties.message='the message displayed'
            error[properties.path] = properties.message
        })
    }
    return error
}

module.exports.signup_post = async (req, res)=>{
    const {name, role, email, password, location} = req.body;
    
    try{
        const user = await User.create({ name, role, email, password, location })
        //add the session key here
        res.status(201).json({ user: user._id })

    }catch(err){
        const errors = handleErrors(err)
        res.status(400).json({errors})
        // console.log(err)
    }
}