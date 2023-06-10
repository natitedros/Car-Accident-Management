const { Router } = require('express')

const commonController = require('../controllers/commonController')

const router = Router()

router.post('/changepassword/:id', commonController.change_password)
router.post('/changenumber/:id', commonController.change_number)

module.exports = router