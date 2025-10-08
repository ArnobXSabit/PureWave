const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: process.env.DB_HOST,        // Railway host
  user: process.env.DB_USER,        // root
  password: process.env.DB_PASSWORD, // your password
  database: process.env.DB_NAME,     // railway
  port: process.env.DB_PORT,         // 56981
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

pool.getConnection()
  .then(() => console.log("✅ MySQL2 connected"))
  .catch(err => console.error("❌ MySQL2 connection error:", err));

module.exports = pool;
