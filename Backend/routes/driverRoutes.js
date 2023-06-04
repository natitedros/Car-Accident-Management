const { Router } = require('express')

const driverController = require('../controllers/driverController')

const { upload } = require('../middleware/imageUploadMiddleware')

const router = Router()

//posts the id of driver from the front end to filter by 
router.get('/mycases/:id', driverController.cases_get)
router.get('/mycars/:id', driverController.cars_get)
router.post('/addcar', driverController.add_car)
router.post('/minor/addcase', driverController.add_minor_case)
router.post('/major/addcase', driverController.add_major_case)
router.post('/caseimages/:id', upload.array("images", 5), driverController.add_case_images);

module.exports = router