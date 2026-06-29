import { Client } from 'pg';

async function run() {
  const client = new Client({
    connectionString: "postgresql://elysia:elysia_pass@72.61.71.6:5432/postgres",
    connectionTimeoutMillis: 5000
  });

  try {
    await client.connect();
    console.log("Connected to remote default postgres db");

    try {
      await client.query("CREATE DATABASE realestate_ae;");
      console.log("Created remote database realestate_ae");
    } catch (e: any) {
      console.log("realestate_ae creation:", e.message);
    }

    try {
      await client.query("ALTER DATABASE realestate_ae OWNER TO elysia;");
      await client.query("GRANT ALL PRIVILEGES ON DATABASE realestate_ae TO elysia;");
      console.log("Set owner and privileges on realestate_ae");
    } catch (e: any) {
      console.log("realestate_ae ownership:", e.message);
    }

  } catch (e: any) {
    console.error("Remote DB update error:", e.message);
  } finally {
    await client.end();
  }
}

run();
