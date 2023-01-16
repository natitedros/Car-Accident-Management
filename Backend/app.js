const express = require('express')
const morgan = require('morgan')
const mongoose = require('mongoose')
const cookieParser = require('cookie-parser')
const authRoutes = require('./routes/authRoutes')

//connect to db
const dbURI = 'mongodb+srv://carcrashdatabase:natibasha@cluster0.xqkdez6.mongodb.net/CarAccDb?retryWrites=true&w=majority'

const app = express()

mongoose.connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true})
    .then((result) => console.log('Connected to db'))
    .catch((err) => console.log(err))

app.listen(3000)

//middleware and static fields
app.use(morgan('dev'))
app.use(express.json());
app.use(cookieParser())

app.use(authRoutes)