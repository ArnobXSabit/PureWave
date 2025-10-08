// index.js (or server.js)
require('dotenv').config(); // Load environment variables

const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const path = require("path");
const mysql = require("mysql2");
const bcrypt = require("bcrypt");

const app = express();

// ------------------ Middleware ------------------
app.use(cors({
  origin: "*", // allow all origins for deployment
  credentials: true
}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Serve frontend & static assets
app.use(express.static(path.join(__dirname, "../frontend")));
app.use("/Products", express.static(path.join(__dirname, "../frontend/Products")));
app.use("/Thumbnails", express.static(path.join(__dirname, "../frontend/Thumbnails")));

// ------------------ Database ------------------
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT // Important for Railway MySQL
});

db.connect(err => {
  if (err) console.error("❌ DB connection failed:", err);
  else console.log("✅ Connected to MySQL database");
});

// ------------------ Routes ------------------
// Assuming you have these route files in backend/routes/
const authRoutes = require("./routes/auth");
const productRoutes = require("./routes/products");
const dbRoutes = require("./routes/db");
const categoriesRoutes = require("./routes/categories");
const cartRoutes = require("./routes/cart");

app.use("/auth", authRoutes);
app.use("/api/products", productRoutes);
app.use("/api/db", dbRoutes);
app.use("/api/categories", categoriesRoutes);
app.use("/api/cart", cartRoutes);

// ------------------ Login Route ------------------
app.post("/login", (req, res) => {
  const { email, password } = req.body;

  db.query("SELECT * FROM users WHERE email = ?", [email], (err, results) => {
    if (err) return res.status(500).json({ message: "Database error" });
    if (results.length === 0) return res.status(401).json({ message: "Invalid email or password" });

    const user = results[0];
    bcrypt.compare(password, user.password_hash, (err, match) => {
      if (err) return res.status(500).json({ message: "Error checking password" });
      if (!match) return res.status(401).json({ message: "Invalid email or password" });

      res.json({
        user_id: user.user_id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        created_at: user.created_at
      });
    });
  });
});

// ------------------ Frontend Routes ------------------
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "../frontend/index.html"));
});

app.get("/:page", (req, res) => {
  const page = req.params.page;
  res.sendFile(path.join(__dirname, "../frontend", page), err => {
    if (err) res.status(404).send("Page not found");
  });
});

// ------------------ Error Handling ------------------
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ success: false, message: "Internal server error" });
});

// ------------------ Start Server ------------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
