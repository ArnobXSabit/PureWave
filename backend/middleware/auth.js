const jwt = require("jsonwebtoken");
const JWT_SECRET = "purewave_secret_key"; // Keep secret in production (.env)

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(" ")[1]; // Bearer TOKEN

  if (!token) return res.status(401).json({ success: false, message: "Token missing" });

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ success: false, message: "Invalid token" });
    req.user = user; // decoded user info
    next();
  });
};

module.exports = authenticateToken;
