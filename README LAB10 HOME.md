# Lab10 Home Task – Spring Boot REST API

This project is a Spring Boot RESTful application developed as **Lab10 Home Task**.  
It demonstrates core backend concepts including REST APIs, database integration, validation, and authentication.

---

## 🚀 Features

- RESTful API design
- User registration and retrieval
- Basic Authentication with Spring Security
- Password hashing using BCrypt
- Input validation with proper HTTP status codes
- Database versioning using Flyway
- Maven-based project structure

---

## 🧱 Technologies Used

- Java 17+
- Spring Boot
- Spring Web
- Spring Data JPA
- Spring Security (Basic Auth)
- Hibernate
- Flyway
- H2 / PostgreSQL (configurable)
- Maven

---

## 📂 Project Structure

src/main/java/com/example/lab10
├── controller
│ └── HelloController.java
├── model
│ └── User.java
├── repository
│ └── UserRepository.java
├── service
│ └── UserService.java
├── Lab10Application.java

src/main/resources
├── db/migration
│ └── V1__create_users_table.sql
├── application.properties

yaml
Copy code

---

## 🔐 Security

- HTTP Basic Authentication
- Passwords are stored using **BCrypt hashing**
- Protected endpoints require valid credentials
- Unauthorized access returns **401 Unauthorized**

---

## 📡 API Endpoints

### 1️⃣ Health Check
```http
GET /hello
Response

Copy code
200 OK
OK
2️⃣ Create User
http
Copy code
POST /users
Content-Type: application/json
Request Body

json
Copy code
{
  "username": "testuser",
  "email": "test@example.com",
  "password": "password123"
}
Response

h
Copy code
201 Created
3️⃣ Get Users (Authenticated)
http
Copy code
GET /users
Authorization: Basic Auth
Valid Credentials

makefile
Copy code
email: test@example.com
password: password123
Responses

200 OK – Authorized

401 Unauthorized – Invalid credentials

⚠️ Validation & Error Handling
Scenario	HTTP Status
Invalid request body	400 Bad Request
Unauthorized access	401 Unauthorized
Duplicate user	500 Internal Server Error

Duplicate user insertion triggers a database constraint violation (unique email).

▶️ How to Run
Start the application
powershell
Copy code
.\mvnw.cmd spring-boot:run
Test endpoints using curl
powershell
Copy code
curl.exe http://localhost:8080/hello
🧪 Example Test Commands
powershell
Copy code
curl.exe -X POST -H "Content-Type: application/json" -d "@user.json" http://localhost:8080/users
powershell
Copy code
curl.exe -u test@example.com:password123 http://localhost:8080/users
📌 Notes
Flyway is used for database schema versioning

Application follows layered architecture (Controller → Service → Repository)

Designed to meet Lab10 academic requirements
