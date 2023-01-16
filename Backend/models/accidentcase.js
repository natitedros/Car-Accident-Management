const { ObjectId } = require('bson')
const mongoose = require('mongoose')

const caseSchema = new mongoose.Schema({
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

})
const Case = mongoose.model('accidentcase', caseSchema)
module.exports = Case