const express = require("express");
const router = express.Router();
const pool = require("../config/db"); // your MySQL pool
const authenticateToken = require("../middleware/auth");

// Get all cart items for logged-in user
router.get("/", authenticateToken, async (req, res) => {
  const userId = req.user.user_id; // from JWT payload

  try {
    const [rows] = await pool.execute(
      `SELECT c.cart_id, c.quantity, p.product_id, p.name, p.price, i.image_url AS image
       FROM cart c
       JOIN products p ON c.product_id = p.product_id
       LEFT JOIN images i ON p.product_id = i.product_id
       WHERE c.user_id = ?`,
      [userId]
    );

    res.json({ success: true, cart: rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: "Failed to fetch cart" });
  }
});

// Update quantity
router.put("/:cartId", authenticateToken, async (req, res) => {
  const { cartId } = req.params;
  const { quantity } = req.body;

  try {
    await pool.execute(
      "UPDATE cart SET quantity = ? WHERE cart_id = ?",
      [quantity, cartId]
    );
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false });
  }
});

// Remove item
router.delete("/:cartId", authenticateToken, async (req, res) => {
  const { cartId } = req.params;

  try {
    await pool.execute("DELETE FROM cart WHERE cart_id = ?", [cartId]);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false });
  }
});

module.exports = router;
