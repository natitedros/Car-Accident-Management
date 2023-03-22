const mongoose = require('mongoose')
const {isEmail} = require('validator')
const bcrypt = require('bcrypt')

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Please enter a name'],
        maxlength: [30, 'maximum character is 10'] 
    },
    role: {
        type: String,
        required: [true, 'Please choose a role'],
        
    },
    phoneNumber: {
        type: String,
        required: [true, 'Please enter a phone number'],
    },
    email: {
        type: String,
        required: [true, 'Please enter an email'],
        unique: true,
        lowercase: true,
        validate: [isEmail, 'Please enter a valid email']
    },
    password: {
        type: String,
        required: [true, 'Please enter a password'],
        minlength: [6, 'minimum password length is 6']
    },
    location:{
        type: {
            type: String,
            enum: ['Point']
          },
          coordinates: {
            type: [Number]
          },
    },
    badgeNumber:{
        type: String
    }
})

//fire function before save
userSchema.pre('save', async function (next) {
    const salt = await bcrypt.genSalt()
    this.password = await bcrypt.hash(this.password, salt)
    next()
})

//static method to login
userSchema.statics.login = async function(email, password) {
    const user = await this.findOne({ email })
    
    if (user){
        const auth = await bcrypt.compare(password, user.password)
        if (auth){
            return user
        }
        throw Error('incorrect password')
    }
    throw Error('incorrect email')
}

const User = mongoose.model('user', userSchema)
module.exports = User