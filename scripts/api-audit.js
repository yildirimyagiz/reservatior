async function main() {
  const API_URL = 'http://localhost:3000/api/v1';

  async function login() {
    try {
      const response = await fetch(`${API_URL}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email: 'admin@propos.com',
          password: 'PasswordLess/11'
        })
      });
      const data = await response.json();
      return data.token;
    } catch (e) {
      console.error('Login failed', e.message);
      return null;
    }
  }

  async function checkRoute(path, token) {
    try {
      const response = await fetch(`${API_URL}${path}`, {
        headers: { 
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json' 
        }
      });
      
      if (response.status === 200 || response.status === 201) {
        console.log(`✅ [OK] ${path} - Status: ${response.status}`);
      } else if (response.status === 404) {
        console.log(`❌ [NOT FOUND] ${path}`);
      } else {
        console.log(`⚠️ [ISSUE] ${path} - Status: ${response.status}`);
      }
    } catch (e) {
      console.log(`⚠️ [ERROR] ${path} - ${e.message}`);
    }
  }

  console.log('--- RESERVATIOR API AUDIT ---');
  const token = await login();
  if (!token) {
    console.error('Could not get auth token.');
    return;
  }

  const routesToCheck = [
    '/auth/me',
    '/users',
    '/organizations',
    '/properties',
    '/listings',
    '/bookings',
    '/reservations',
    '/admin/plans',
    '/admin/users',
    '/tax-records',
    '/deposit-protections',
    '/solicitor-management',
    '/right-to-rent-checks',
    '/exchange-rates',
    '/reports',
    '/lead-conversions'
  ];

  for (const route of routesToCheck) {
    await checkRoute(route, token);
  }
}

main();
