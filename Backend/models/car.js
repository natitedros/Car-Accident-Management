const { ObjectId } = require('bson')
const mongoose = require('mongoose')

const carSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Please enter the name of your car'],
        maxlength: [15, 'maximum character is 15']
    },
    plateNumber:{
        type: String,
        required: [true, 'Please enter the plate number'],
        length: 6
    },
    ownerId:{
        type: String
    },
    region:{
        type: String
    }
})

const Car = mongoose.model('car', carSchema)
module.exports = Car