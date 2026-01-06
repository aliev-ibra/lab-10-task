# Lab 10 – Secure HTTP Request Handling

## Overview

This project demonstrates **secure request processing, input validation, and proper HTTP response handling** in a Spring Boot application.  
It implements REST endpoints for user management with validation, custom constraints, exception handling, and security.

**Objectives:**

- Handle HTTP requests securely (headers, parameters, JSON, form data).  
- Validate inputs using DTOs and custom validators.  
- Return meaningful HTTP status codes and structured JSON errors.  
- Implement basic authentication for endpoint access.  

---

## Project Structure

Lab10Application/
│
├─ src/main/java/com/example/lab10/
│ ├─ config/ # Security configuration
│ ├─ controller/ # REST endpoints (UserController)
│ ├─ dto/ # UserDTO with validation
│ ├─ exception/ # GlobalExceptionHandler
│ ├─ model/ # User entity
│ ├─ repository/ # Spring Data JPA repository
│ ├─ service/ # User service logic
│ └─ validation/ # Custom password validator
│
├─ src/main/resources/
│ ├─ db/migration/ # Database migrations
│ ├─ application.properties
│ └─ .env.example
│
├─ test_endpoints.ps1 # PowerShell script to test endpoints
├─ API_DOCS.md # Endpoint documentation
├─ README.md
├─ pom.xml
└─ mvnw.cmd

yaml
Copy code

---

## Setup & Run

1. Clone the repository:

```powershell
git clone https://github.com/aliev-ibra/lab-10-task.git
cd lab-10-task/Lab10Application
Build and run the Spring Boot application:

powershell
Copy code
.\mvnw.cmd clean install
.\mvnw.cmd spring-boot:run
The server runs on http://localhost:8081 (configured in application.properties).

API Endpoints
Method	Path	Description	Request Body / Params	Response / Status Codes
GET	/hello	Test endpoint	None	200 OK (text/plain)
GET	/users	List all users (requires Basic Auth)	None	200 OK (JSON)
POST	/users	Create a new user	JSON (UserDTO)	201 Created / 400 Bad Request
GET	/users/{id}	Get a specific user	Path variable id	200 OK / 404 Not Found
PUT	/users/{id}	Full update of user	JSON (UserDTO)	200 OK / 400 Bad Request / 404 Not Found
PATCH	/users/{id}	Partial update of user	JSON (fields to update)	200 OK / 400 Bad Request / 404 Not Found
DELETE	/users/{id}	Delete a user	Path variable id	200 OK / 404 Not Found

Validation Notes:

username – must not be blank, 3–20 characters.

email – valid email format required.

password – must contain at least 1 digit, 1 lowercase, 1 uppercase, 1 special character (custom validator).

Validation errors return 400 Bad Request with structured JSON:

json
Copy code
{
  "error": "Validation Error",
  "details": {
    "password": "Password must contain at least one digit, one lowercase, one uppercase, and one special character"
  },
  "status": 400,
  "timestamp": "2026-01-06T23:15:37.9243999"
}
Security
Basic Authentication is enabled for /users/**.

Default test user: test@example.com / password123.

Security configuration is in SecurityConfig.java.

Testing Endpoints
You can test endpoints using PowerShell & curl or Postman.

Example using curl in PowerShell:

powershell
Copy code
# Test hello endpoint
curl.exe -v http://localhost:8081/hello

# Create a new user
curl.exe -v -X POST -H "Content-Type: application/json" -d "@user.json" http://localhost:8081/users

# List all users (requires Basic Auth)
curl.exe -v -u test@example.com:password123 http://localhost:8081/users
You can also use the provided test_endpoints.ps1 script:

powershell
Copy code
.\test_endpoints.ps1
It verifies GET, POST, PUT, PATCH, DELETE requests and checks validation responses.

