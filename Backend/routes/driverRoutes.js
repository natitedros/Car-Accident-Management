const { Router } = require('express')

const authController = require('../controllers/authController')
const driverController = require('../controllers/driverController')

const router = Router()

//posts the id of driver from the front end to filter by 
router.post('/cases', driverController.cases_get)
router.post('/cars', driverController.cars_get)
router.post('/addcar', driverController.add_car)

module.exports = router