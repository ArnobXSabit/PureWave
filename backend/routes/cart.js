const express = require("express");
const router = express.Router();
const authenticateToken = require("../middleware/auth");
const cartController = require("../controllers/cartController");

// GET Cart
router.get("/", authenticateToken, cartController.getCart);

// ADD to Cart
router.post("/", authenticateToken, cartController.addToCart);

// UPDATE Quantity
router.put("/:cartId", authenticateToken, cartController.updateCart);

// DELETE Cart Item
router.delete("/:cartId", authenticateToken, cartController.deleteCartItem);

module.exports = router;
