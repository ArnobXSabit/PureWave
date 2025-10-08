const pool = require("../config/db");

// ---------------- GET all categories ----------------
exports.getCategories = async (req, res) => {
  try {
    const [rows] = await pool.execute(`
      SELECT 
        c.category_id, 
        c.category_name, 
        c.thumbnail_url, 
        c.thumbnail_order,
        c.parent_id,
        p.category_name AS parent_name
      FROM categories c
      LEFT JOIN categories p ON c.parent_id = p.category_id
      ORDER BY c.thumbnail_order ASC, c.category_id ASC
    `);

    // Format response for frontend
    const formatted = rows.map(row => ({
      category_id: row.category_id,
      category_name: row.category_name,
      parent_id: row.parent_id,
      parent_name: row.parent_name,
      thumbnail_order: row.thumbnail_order,
      thumbnail: {
        url: row.thumbnail_url,
      },
    }));

    res.json(formatted);
  } catch (err) {
    console.error("Error fetching categories:", err);
    res.status(500).json({ error: "Server error" });
  }
};
