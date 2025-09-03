const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const path = require("path");

const app = express();
const port = 3000;

// Allow Live Server to fetch API
app.use(cors({
  origin: "http://127.0.0.1:5500",
  credentials: true
}));

app.use(bodyParser.json());

// Serve frontend (if needed)
app.use(express.static(path.join(__dirname, "../frontend")));
app.use("/Products", express.static(path.join(__dirname, "../frontend/Products")));

// Import routes
const authRoutes = require("./routes/auth");
const productRoutes = require("./routes/products");
const dbRoutes = require("./routes/db");
const categoriesRoutes = require("./routes/categories");

app.use("/auth", authRoutes);
app.use("/api/products", productRoutes);
app.use("/api/db", dbRoutes);
app.use("/api/categories", categoriesRoutes);

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

app.listen(port, () => console.log(`🚀 Server running at http://localhost:${port}`));
