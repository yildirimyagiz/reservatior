const { Client } = require('pg');

async function main() {
  const client = new Client({ connectionString: 'postgresql://postgres:1928@localhost:5432/elysia_realestate' });
  await client.connect();
  const res = await client.query("SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'Organization'");
  console.log("Columns:", res.rows.map(r => `${r.column_name} (${r.is_nullable})`));
  await client.end();
}

main().catch(console.error);
