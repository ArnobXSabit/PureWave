const express = require("express");
const router = express.Router();
const pool = require("../config/db");
const authenticateToken = require("../middleware/auth");

// ---------------- GET Cart ----------------
router.get("/", authenticateToken, async (req, res) => {
  const userId = req.user.user_id;
  try {
    const [rows] = await pool.execute(
      `SELECT c.cart_id, c.quantity, c.size, p.product_id, p.name, p.price, i.image_url AS image
       FROM cart c
       JOIN products p ON c.product_id = p.product_id
       LEFT JOIN images i ON p.product_id = i.product_id
       WHERE c.user_id = ?`,
      [userId]
    );
    res.json({ success:true, cart: rows });
  } catch(err){
    console.error(err);
    res.status(500).json({ success:false, message:"Failed to fetch cart" });
  }
});

// ---------------- ADD to Cart ----------------
router.post("/", authenticateToken, async (req,res)=>{
  const userId=req.user.user_id;
  const { product_id, quantity, size } = req.body;
  if(!product_id || !quantity || !size) return res.status(400).json({success:false,message:"Product, quantity and size required"});

  try{
    const [existing] = await pool.execute(
      "SELECT * FROM cart WHERE user_id=? AND product_id=? AND size=?",
      [userId, product_id, size]
    );

    if(existing.length>0){
      const newQty=existing[0].quantity + quantity;
      await pool.execute("UPDATE cart SET quantity=? WHERE cart_id=?", [newQty, existing[0].cart_id]);
    } else {
      await pool.execute("INSERT INTO cart (user_id, product_id, quantity, size, added_at) VALUES (?,?,?,?,NOW())", [userId, product_id, quantity, size]);
    }
    res.json({success:true,message:"Product added to cart"});
  }catch(err){ console.error(err); res.status(500).json({success:false,message:"Failed to add to cart"}); }
});

// ---------------- UPDATE Quantity ----------------
router.put("/:cartId", authenticateToken, async (req,res)=>{
  const { cartId } = req.params;
  const { quantity } = req.body;
  if(!quantity) return res.status(400).json({success:false,message:"Quantity required"});

  try{
    await pool.execute("UPDATE cart SET quantity=? WHERE cart_id=? AND user_id=?", [quantity, cartId, req.user.user_id]);
    res.json({success:true,message:"Cart updated"});
  }catch(err){ console.error(err); res.status(500).json({success:false,message:"Failed to update cart"}); }
});

// ---------------- DELETE Cart Item ----------------
router.delete("/:cartId", authenticateToken, async (req,res)=>{
  const { cartId } = req.params;
  try{
    await pool.execute("DELETE FROM cart WHERE cart_id=? AND user_id=?", [cartId, req.user.user_id]);
    res.json({success:true,message:"Item removed"});
  }catch(err){ console.error(err); res.status(500).json({success:false,message:"Failed to remove item"}); }
});

module.exports = router;
