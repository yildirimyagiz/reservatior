const API_URL = 'http://localhost:3005/api/v1';

async function login(email, password) {
  try {
    const response = await fetch(`${API_URL}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password })
    });
    const data = await response.json();
    return data.token;
  } catch (e) {
    return null;
  }
}

async function testRole(name, email, password, scenarios) {
  console.log(`\n--- Testing Role: ${name} (${email}) ---`);
  const token = await login(email, password);
  if (!token) {
    console.log(`❌ Login failed for ${name}`);
    return;
  }

  for (const s of scenarios) {
    try {
      const response = await fetch(`${API_URL}${s.path}`, {
        method: s.method || 'GET',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        },
        body: s.body ? JSON.stringify(s.body) : undefined
      });
      
      const isAllowed = response.status < 400;
      const expectedAllowed = s.expected === 'ALLOW';
      
      if (isAllowed === expectedAllowed) {
        console.log(`✅ [${s.method || 'GET'}] ${s.path} -> ${response.status} (${expectedAllowed ? 'Allowed' : 'Denied'} as expected)`);
      } else {
        console.log(`❌ [${s.method || 'GET'}] ${s.path} -> ${response.status} (Unexpected ${isAllowed ? 'Allow' : 'Deny'})`);
      }
    } catch (e) {
      console.log(`⚠️ ERROR testing ${s.path}: ${e.message}`);
    }
  }
}

async function main() {
  const genericOrgId = 'org-test-123';

  // SCENARIOS
  const adminScenarios = [
    { path: '/admin/plans', method: 'GET', expected: 'ALLOW' },
    { path: '/admin/users', method: 'GET', expected: 'ALLOW' },
    { path: '/organizations', method: 'GET', expected: 'ALLOW' },
    { path: '/properties', method: 'GET', expected: 'ALLOW' }
  ];

  const agentScenarios = [
    { path: '/properties', method: 'GET', expected: 'ALLOW' },
    { path: '/leads', method: 'GET', expected: 'ALLOW' },
    { path: '/admin/plans', method: 'GET', expected: 'DENY' },
    { path: '/admin/users', method: 'GET', expected: 'DENY' },
    { 
      path: '/properties', 
      method: 'POST', 
      expected: 'ALLOW',
      body: {
        orgId: genericOrgId,
        name: 'Test Apartment',
        region: 'USA_NORTHEAST',
        currency: 'USD',
        addressLine1: 'Audit St 1',
        city: 'New York',
        state: 'NY',
        postalCode: '10001',
        country: 'US',
        type: 'APARTMENT',
        propertyCategory: 'RESIDENTIAL',
        bedrooms: 2,
        bathrooms: 1,
        size: 85,
        sizeUnit: 'SQM',
        listingStatus: 'AVAILABLE'
      }
    }
  ];

  const tenantScenarios = [
    { path: '/leases', method: 'GET', expected: 'ALLOW' },
    { path: '/financial/taxes', method: 'GET', expected: 'DENY' },
    { path: '/admin/plans', method: 'GET', expected: 'DENY' },
    { path: '/properties', method: 'POST', expected: 'DENY', body: {} }
  ];

  await testRole('SUPER_ADMIN', 'admin@propos.com', 'PasswordLess/11', adminScenarios);
  await testRole('AGENT', 'agent.test@propos.com', 'PasswordLess/11', agentScenarios);
  await testRole('TENANT', 'tenant.test@propos.com', 'PasswordLess/11', tenantScenarios);

  console.log('\n--- Full System Test Completed ---');
}

main();
