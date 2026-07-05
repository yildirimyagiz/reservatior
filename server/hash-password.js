const { Bun } = require('bun');

async function hashPassword() {
  const password = 'Parola341';
  const hash = await Bun.password.hash(password, { algorithm: 'bcrypt', cost: 10 });
  console.log(hash);
}

hashPassword();
