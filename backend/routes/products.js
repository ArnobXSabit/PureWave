const express = require("express");
const router = express.Router();
const productsController = require("../controllers/productsController");

// GET /api/products?category_id=1
router.get("/", productsController.getAllProducts);

module.exports = router;
