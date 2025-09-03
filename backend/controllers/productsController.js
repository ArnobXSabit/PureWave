const pool = require("../config/db");

// Get products (optionally filtered by category)
exports.getAllProducts = async (req, res) => {
  const categoryId = req.query.category_id; // optional
  const user = req.user || null; // from auth middleware

  try {
    // 1️⃣ Fetch products with category info
    let query = `
      SELECT 
        p.product_id,
        p.name,
        p.price,
        p.description,
        p.category_id,
        c.category_name,
        cp.category_name AS parent_name
      FROM products p
      LEFT JOIN categories c ON p.category_id = c.category_id
      LEFT JOIN categories cp ON c.parent_id = cp.category_id
    `;
    const params = [];

    if (categoryId) {
      query += " WHERE p.category_id = ?";
      params.push(categoryId);
    }

    query += " ORDER BY p.product_id ASC";

    const [productsRows] = await pool.execute(query, params);

    // 2️⃣ Fetch all images for these products
    const productIds = productsRows.map(p => p.product_id);
    let imagesMap = {};

    if (productIds.length) {
      const [imagesRows] = await pool.query(
        `SELECT product_id, image_url FROM images WHERE product_id IN (?)`,
        [productIds]
      );

      // Map images to product_id
      imagesRows.forEach(img => {
        if (!imagesMap[img.product_id]) imagesMap[img.product_id] = [];
        imagesMap[img.product_id].push(`http://localhost:3000/${img.image_url}`); // ✅ full URL
      });
    }

    // 3️⃣ Map products with images
    const products = productsRows.map(p => ({
      product_id: p.product_id,
      name: p.name,
      price: p.price,
      description: p.description,
      category_id: p.category_id,
      category_name: p.category_name,
      parent_name: p.parent_name,
      images: imagesMap[p.product_id] || [] // array of image URLs
    }));

    res.json({
      success: true,
      user,
      products
    });

  } catch (err) {
    console.error("Failed to fetch products:", err);
    res.status(500).json({ success: false, message: "Internal server error" });
  }
};
