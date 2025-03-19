#### Parameters:
  `-m` -- request method(GET,POST)
  `-u` -- url (https://example.con/api/endpoint)
  `-t` -- Bearer token to use
  `-d` -- request body 


#### Example usage:
  ##### Get request
  ```
  bash stress.sh -m GET -u https://mydomain.com/api/endpoint -t <jwt_token>
  ```

  ##### POST request
  ```
  bash stress.sh -m POST -u https://mydomain.com/api/endpoint -t <jwt_token> -d '{"name":"John Doe","email":"john@example.com"}'
  ```

