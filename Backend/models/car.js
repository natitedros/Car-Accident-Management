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
    model:{
        type: String,
        required: [true, "Please enter the car model"]
    },
    color:{
        type: String,
        required: [true, "Please enter the car color"]
    },
    ownerId:{
        type: String,
        required: [true, 'Please enter the owner id'],
    },
    region:{
        type: String,
        required: [true, 'Please enter the region'],
    }
})

const Car = mongoose.model('car', carSchema)
module.exports = Car