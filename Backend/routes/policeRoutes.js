const { Router } = require('express')

const authController = require('../controllers/authController')
const policeController = require('../controllers/policeController')

const router = Router()
//gets cases the police handles
router.get('/mycases/:id', policeController.cases_get)
//updates the verdict of the case and status
router.post('/mycases/update/:id', policeController.update_case)
//list of cases near the police
router.post('/nearme', policeController.near_me_get)
//get the id of the case and add self as a handler
router.post('/cases/assign', policeController.assign_self)

router.post('/location/:id', policeController.update_location)

router.get('closecase/:id', policeController.close_case)

module.exports = router