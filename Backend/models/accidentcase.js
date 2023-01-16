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
        type: ObjectId,
        required: true
    },
    //opened, status, pending
    status:{
        type: String
    },
    handlerId: {
        type: ObjectId
    }

},{timestamps: true})
const Case = mongoose.model('accidentcase', caseSchema)
module.exports = Case