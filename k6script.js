import { check } from 'k6';
import http from 'k6/http';

export default function () {
  const url = __ENV.URL;
  const method = __ENV.METHOD;
  const token = __ENV.TOKEN;
  let res;

  // Set headers
  const headers = {
    Authorization: `Bearer ${token}`,
    'Content-Type': 'application/json',
  };

  // Conditional logic based on the method
  if (method === 'GET') {
    res = http.get(url, { headers });
  } else if (method === 'POST') {
    const data = __ENV.DATA; // Request body for POST
    res = http.post(url, data, { headers });
  }

  // Check the response
    check(res, {
    'is status 502': (r) => r.status === 502,
    'is status 200': (r) => r.status === 200,
    'is status 500': (r) => r.status === 500,
    'is status 403': (r) => r.status === 403,
    'is status 401': (r) => r.status === 401,
    'is status 400': (r) => r.status === 400,
  });
}

// K6 Load Test Configuration
export let options = {
  vus: 1000, // Number of virtual users
  duration: '30s', // Duration of the test
  rps: 1000, // Requests per second
};
