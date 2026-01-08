# 📚 E-Library 
An **E-Library Management System** built using **Java, JSP, Servlets, JDBC, and MySQL**.  
The application follows the **MVC (Model–View–Controller)** architecture and implements **role-based authentication** for **Admin, Librarian, and Student** users.

---

## 📌 Project Overview

We built this E-Library Management System to digitally manage library operations for colleges, libraries, and institutions.  
The system replaces manual record keeping with a **secure, web-based solution**, enabling administrators, librarians, and students to access features based on their roles.

---

## 🎯 Objectives

- Implement secure authentication and role-based access control  
- Manage books, librarians, and students efficiently  
- Apply MVC architecture in a real-world Java web application  
- Perform CRUD operations using JDBC  
- Understand end-to-end Java web application workflow  

---

## 🔐 User Roles & Authentication

The system supports **three user roles**, each with specific permissions:

### 👑 Admin
- Secure admin login  
- Add and delete librarians  
- Manage student records  
- Monitor overall system activity  

### 📚 Librarian
- Secure librarian login  
- Add, update, and delete books  
- Issue and return books  
- Add and manage student details  

### 🎓 Student
- Secure student login  
- View available books  
- Track issued books and return status  

Authentication is handled using **login credentials stored in the database**, with role-based access enforced at the servlet level.

---

## 🚀 Features

### 📖 Book Management
- Add new books  
- Update existing book details  
- Delete book records  
- View all books in tabular format  

### 👤 User Management
- Admin can add and remove librarians  
- Admin can manage student accounts  
- Librarian can add student records  

### 🔄 Book Issue System
- Issue books to students  
- Track issued and returned books  
- Prevent duplicate or invalid book issuance  

### ⚙️ Functional Highlights
- Role-based access control using session management  
- Secure database operations using `PreparedStatement`  
- JSP with JSTL for dynamic UI  
- Clean and structured admin and librarian dashboards  

---

## 🛠️ Technology Stack

| Layer      | Technology                     |
|------------|--------------------------------|
| Frontend   | JSP, HTML, CSS                 |
| Backend    | Java, Servlets, JDBC           |
| Database   | MySQL                          |
| Server     | Apache Tomcat                  |

---

## 🧱 Architecture (MVC)

### Model
- `User.java` – Represents Admin, Librarian, and Student  
- `Book.java` – Represents book data  
- `IssueBook.java` – Tracks issued and returned books  
- `UserDAO.java` – Handles authentication and user management  
- `BookDAO.java` – Handles book-related database operations  

### View
- `login.jsp`  
- `adminDashboard.jsp`  
- `librarianDashboard.jsp`  
- `studentDashboard.jsp`  
- `addBook.jsp`, `editBook.jsp`, `listBooks.jsp`  

### Controller
- `LoginServlet.java` – Handles authentication  
- `AdminServlet.java` – Manages librarians and students  
- `LibrarianServlet.java` – Handles book operations and issue system  

---

## 🔄 Application Workflow

1. User logs in with credentials  
2. System authenticates user and determines role  
3. User is redirected to role-specific dashboard  
4. Requests are handled by appropriate servlets  
5. DAO performs database operations using JDBC  
6. Updated data is displayed via JSP pages  

---

## ▶️ How to Run the Project

1. Clone the repository  
   ```bash
   git clone https://github.com/SHRIKANTAMBATKAR/E-librari.git

2. Open the project in Eclipse IDE

3. Configure Apache Tomcat Server

4. Create MySQL database and required tables (users, books, issue_records)

5. Update database credentials in DAO classes

6. Run the project on the server

## 🔐 Security & Validation

- Uses POST method for login and form submissions
- Uses PreparedStatement to prevent SQL injection
- Session-based authentication for role validation
- Unauthorized access is restricted by role checks

## 📚 Learning Outcomes

- Role-based authentication in Java web applications
- Session management and access control
- MVC architecture implementation
- Real-world CRUD and transaction handling
- Secure web application development practices

🚧 Future Enhancements

- Password encryption using BCrypt
- Email notifications for book issue and return
- Book reservation system
- Search and advanced filtering
- REST API integration and frontend migration
