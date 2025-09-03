const db = require('./config/db');

async function test() {
  try {
    const [rows] = await db.promise().query("SELECT * FROM users LIMIT 5");
    console.log(rows);
    process.exit(0);
  } catch (err) {
    console.error("DB Error:", err);
    process.exit(1);
  }
}

test();
