const { ObjectId } = require('bson')
const mongoose = require('mongoose')

const caseSchema = new mongoose.Schema({
    location:{
        type: {
            type: String,
            enum: ['Point']
          },
          coordinates: {
            type: [Number]
          },
    },
    subjectId: {
        type: String,
        required: true
    },
    //opened, closed, pending
    status:{
        type: String
    },
    handlerId: {
        type: String
    },
    severity: {
        type: String,
        enum: ["minor", "major"]
    },
    carColor: {
        type: String,
        required: true
    },
    carPlateNumber: {
        type: String,
        required: true
    },
    carName: {
        type: String,
        required: true
    },
    carModel: {
        type: String,
        required: true
    },
    driverName: {
        type: String,
        required: true
    },
    driverPhoneNumber: {
        type: String,
        required: true
    },
    verdict: {
        type: String,
    }


},{timestamps: true})
const Case = mongoose.model('accidentcase', caseSchema)
module.exports = Case