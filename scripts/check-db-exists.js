const { Client } = require('pg');

async function main() {
  const client = new Client({ connectionString: 'postgresql://postgres:1928@localhost:5432/postgres' });
  await client.connect();
  const res = await client.query("SELECT datname FROM pg_database WHERE datname = 'elysia_realestate'");
  console.log("Exists:", res.rows.length > 0);
  await client.end();
}

main().catch(console.error);
