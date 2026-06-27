import { createBatchStores } from "./batch-store-creator";
import { mkdirSync, existsSync } from "fs";
import { join } from "path";

// Generate all stores
const generateAllStores = () => {
  const storeDir = join(__dirname, "..");

  // Ensure store directory exists
  if (!existsSync(storeDir)) {
    mkdirSync(storeDir, { recursive: true });
  }

  // Generate stores
  createBatchStores(["users", "properties", "contacts", "deals"]);

  console.log("All stores generated successfully!");
};

// Run if executed directly
if (require.main === module) {
  generateAllStores();
}

export default generateAllStores;
