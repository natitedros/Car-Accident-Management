const { Router } = require('express')

const authController = require('../controllers/authController')
const policeController = require('../controllers/policeController')

const router = Router()
//gets cases the police handles
router.get('/cases/:id', policeController.cases_get)
//updates the verdict of the case and status
router.post('/cases/update/:id', policeController.update_case)

module.exports = router