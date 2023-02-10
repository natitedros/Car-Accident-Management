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
    }

},{timestamps: true})
const Case = mongoose.model('accidentcase', caseSchema)
module.exports = Case