const { Router } = require('express')

const authController = require('../controllers/authController')
const adminController = require('../controllers/adminController')

const router = Router()

router.post('/create', authController.signup_post)
router.post('/search', adminController.search_post)
router.delete('/delete', adminController.delete_user)
router.get('/cases', adminController.list_cases)

module.exports = router