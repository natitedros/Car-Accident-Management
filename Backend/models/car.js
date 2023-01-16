const { ObjectId } = require('bson')
const mongoose = require('mongoose')

const carSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Please enter the name of your car'],
        maxlength: [15, 'maximum character is 15']
    },
    platenumber:{
        type: String,
        required: [true, 'Please enter the plate number'],
        length: 6
    },
    ownerid:{
        type: ObjectId
    },
    region:{
        type: String
    }
})

const Car = mongoose.model('car', carSchema)
module.exports = Car