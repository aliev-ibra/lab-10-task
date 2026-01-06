# API Documentation

## Users

### GET /users
Retrieve all users.

- **Method**: `GET`
- **Path**: `/users`
- **Responses**:
    - `200 OK`: List of users.
    ```json
    [
        {
            "id": 1,
            "username": "user1",
            "email": "user1@example.com",
            "password": "Password1!"
        }
    ]
    ```

### POST /users
Create a new user.

- **Method**: `POST`
- **Path**: `/users`
- **Headers**: `Content-Type: application/json`
- **Body**:
    ```json
    {
        "username": "newuser",
        "email": "new@example.com",
        "password": "Password123!"
    }
    ```
- **Responses**:
    - `201 Created`: The created user.
    - `400 Bad Request`: Validation error.

### PUT /users/{id}
Update an existing user.

- **Method**: `PUT`
- **Path**: `/users/{id}`
- **Headers**: `Content-Type: application/json`
- **Path Variables**: `id` (Long)
- **Body**:
    ```json
    {
        "username": "updateduser",
        "email": "updated@example.com",
        "password": "NewPassword123!"
    }
    ```
- **Responses**:
    - `200 OK`: The updated user.
    - `404 Not Found`: User not found.
    - `400 Bad Request`: Validation error.

### PATCH /users/{id}
Partially update an existing user.

- **Method**: `PATCH`
- **Path**: `/users/{id}`
- **Headers**: `Content-Type: application/json`
- **Path Variables**: `id` (Long)
- **Body**: (Any subset of fields)
    ```json
    {
        "email": "newemail@example.com"
    }
    ```
- **Responses**:
    - `200 OK`: The updated user.
    - `404 Not Found`: User not found.

### DELETE /users/{id}
Delete a user.

- **Method**: `DELETE`
- **Path**: `/users/{id}`
- **Path Variables**: `id` (Long)
- **Responses**:
    - `204 No Content`: Successful deletion.
    - `404 Not Found`: User not found.
