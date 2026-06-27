async function main() {
  const hash = "$2b$10$3VJ0OG279ryUHI.eSVqBTO28kcTom9h6C1wXpuKe0Qxl0pVFAJF5S"; // admin12345
  const valid = await Bun.password.verify("admin12345", hash);
  console.log(`Password "admin12345" valid? ${valid}`);
  
  const invalid = await Bun.password.verify("wrong", hash);
  console.log(`Password "wrong" valid? ${invalid}`);
}
main();
