// backend/server.js
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const path = require("path");

const app = express();
const port = 3000;

// ------------------ Middleware ------------------
app.use(cors({
  origin: "http://127.0.0.1:5500", // your frontend Live Server
  credentials: true
}));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Serve frontend & static assets
app.use(express.static(path.join(__dirname, "../frontend")));
app.use("/Products", express.static(path.join(__dirname, "../frontend/Products")));
app.use("/Thumbnails", express.static(path.join(__dirname, "../frontend/Thumbnails")));

// ------------------ Routes ------------------
const authRoutes = require("./routes/auth");
const productRoutes = require("./routes/products");
const dbRoutes = require("./routes/db");
const categoriesRoutes = require("./routes/categories");
const cartRoutes = require("./routes/cart"); // <-- added cart routes

app.use("/auth", authRoutes);
app.use("/api/products", productRoutes);
app.use("/api/db", dbRoutes);
app.use("/api/categories", categoriesRoutes);
app.use("/api/cart", cartRoutes); // <-- mounted cart routes

// ------------------ Default Routes ------------------
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "../frontend/index.html"));
});

// Catch-all HTML route
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
app.listen(port, () => console.log(`🚀 Server running at http://localhost:${port}`));
