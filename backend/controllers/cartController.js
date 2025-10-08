const pool = require("../config/db");

// ---------------- GET Cart ----------------
exports.getCart = async (req, res) => {
  const userId = req.user.user_id;
  try {
    const [rows] = await pool.execute(
      `SELECT c.cart_id, c.quantity, c.size, 
              p.product_id, p.name, p.price, 
              COALESCE(i.image_url, 'Products/default.jpg') AS image
       FROM cart c
       JOIN products p ON c.product_id = p.product_id
       LEFT JOIN images i ON p.product_id = i.product_id
       WHERE c.user_id = ?
       GROUP BY c.cart_id`,
      [userId]
    );
    res.json({ success: true, cart: rows });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: "Failed to fetch cart" });
  }
};

// ---------------- ADD to Cart ----------------
exports.addToCart = async (req, res) => {
  const userId = req.user.user_id;
  const { product_id, quantity, size } = req.body;

  if (!product_id || !quantity || !size) {
    return res.status(400).json({
      success: false,
      message: "Product, quantity and size required",
    });
  }

  const qty = parseInt(quantity);
  if (isNaN(qty) || qty < 1)
    return res.status(400).json({ success: false, message: "Invalid quantity" });

  try {
    const [existing] = await pool.execute(
      "SELECT * FROM cart WHERE user_id=? AND product_id=? AND size=?",
      [userId, product_id, size]
    );

    if (existing.length > 0) {
      const newQty = existing[0].quantity + qty;
      await pool.execute(
        "UPDATE cart SET quantity=? WHERE cart_id=?",
        [newQty, existing[0].cart_id]
      );
    } else {
      await pool.execute(
        "INSERT INTO cart (user_id, product_id, quantity, size, added_at) VALUES (?,?,?,?,NOW())",
        [userId, product_id, qty, size]
      );
    }

    res.json({ success: true, message: "Product added to cart" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: "Failed to add to cart" });
  }
};

// ---------------- UPDATE Quantity ----------------
exports.updateCart = async (req, res) => {
  const { cartId } = req.params;
  const { quantity } = req.body;

  const qty = parseInt(quantity);
  if (isNaN(qty) || qty < 1)
    return res.status(400).json({ success: false, message: "Invalid quantity" });

  try {
    const [result] = await pool.execute(
      "UPDATE cart SET quantity=? WHERE cart_id=? AND user_id=?",
      [qty, cartId, req.user.user_id]
    );

    if (result.affectedRows === 0)
      return res.status(404).json({ success: false, message: "Cart item not found" });

    res.json({ success: true, message: "Cart updated" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: "Failed to update cart" });
  }
};

// ---------------- DELETE Cart Item ----------------
exports.deleteCartItem = async (req, res) => {
  const { cartId } = req.params;

  try {
    const [result] = await pool.execute(
      "DELETE FROM cart WHERE cart_id=? AND user_id=?",
      [cartId, req.user.user_id]
    );

    if (result.affectedRows === 0)
      return res.status(404).json({ success: false, message: "Cart item not found" });

    res.json({ success: true, message: "Item removed" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: "Failed to remove item" });
  }
};
