import { Client } from "pg";

async function main() {
  const connectionStrings = [
    "postgresql://elysia:elysia_pass@localhost:5432/elysia_db",
    "postgresql://postgres:1928@localhost:5432/elysia_realestate"
  ];

  for (const cs of connectionStrings) {
    console.log("Trying:", cs);
    const client = new Client({ connectionString: cs });
    try {
      await client.connect();
      console.log("Connected to", cs);
      const res = await client.query('SELECT current_database();');
      console.log("DB:", res.rows[0]);
      await client.end();
      break;
    } catch (e: any) {
      console.log("Failed:", e);
    }
  }
}
main();
