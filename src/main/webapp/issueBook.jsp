<%@ page contentType="text/html; charset=UTF-8"%>
<%
    if(session.getAttribute("librarian") == null) {
        response.sendRedirect("librarianLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Issue Book - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --success: #10b981;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .form-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            max-width: 600px;
            width: 100%;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .page-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 32px;
            color: white;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .page-header h3 {
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #64748b;
            margin: 0;
        }

        .form-label {
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }

        .form-label i {
            margin-right: 8px;
            color: var(--primary);
        }

        .form-select,
        .form-control {
            border-radius: 10px;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            transition: all 0.3s;
        }

        .form-select:focus,
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            outline: none;
        }

        .btn-primary {
            background: var(--primary);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 70, 229, 0.3);
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #64748b;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            transition: all 0.3s;
            margin-top: 15px;
            width: 100%;
            font-weight: 600;
        }

        .btn-back:hover {
            background: #f8fafc;
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .btn-back i {
            margin-right: 8px;
        }

        .form-text {
            color: #94a3b8;
            font-size: 13px;
            margin-top: 5px;
        }

        .required-asterisk {
            color: #ef4444;
            margin-left: 3px;
        }

        .info-badge {
            display: inline-block;
            background: #e0e7ff;
            color: var(--primary);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 8px;
        }

        .no-data-message {
            text-align: center;
            padding: 20px;
            background: #fef3c7;
            border-radius: 10px;
            color: #92400e;
            margin-bottom: 20px;
        }

        @media (max-width: 576px) {
            .form-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="page-header">
            <div class="page-icon">
                <i class="fas fa-hand-holding-heart"></i>
            </div>
            <h3>Issue Book</h3>
            <p>Issue a book to a student from the library</p>
        </div>

        <%
            java.util.List<java.util.Map<String, Object>> students =
                (java.util.List<java.util.Map<String, Object>>) request.getAttribute("students");

            java.util.List<java.util.Map<String, Object>> books =
                (java.util.List<java.util.Map<String, Object>>) request.getAttribute("books");

            boolean hasStudents = (students != null && !students.isEmpty());
            boolean hasBooks = (books != null && !books.isEmpty());
        %>

        <% if (!hasStudents || !hasBooks) { %>
            <div class="no-data-message">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <% if (!hasStudents && !hasBooks) { %>
                    No students or books available. Please add students and books first.
                <% } else if (!hasStudents) { %>
                    No students registered. Please add students first.
                <% } else { %>
                    No books available. Please add books to the library.
                <% } %>
            </div>
        <% } %>

        <form action="RegisterServlet" method="post">
            <input type="hidden" name="action" value="issue">

            <!-- STUDENT DROPDOWN -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-user-graduate"></i>
                    Select Student<span class="required-asterisk">*</span>
                </label>
                <select class="form-select" name="studId" required <%= !hasStudents ? "disabled" : "" %>>
                    <% if (hasStudents) { %>
                        <option value="" selected disabled>Choose a student...</option>
                        <%
                            for (java.util.Map<String, Object> s : students) {
                        %>
                            <option value="<%= s.get("studId") %>">
                                <%= s.get("studName") %> - Year <%= s.get("year") %> (<%= s.get("domain") %>)
                            </option>
                        <%
                            }
                        %>
                    <% } else { %>
                        <option value="">No students available</option>
                    <% } %>
                </select>
                <div class="form-text">Select the student receiving the book</div>
            </div>

            <!-- BOOK DROPDOWN -->
            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-book"></i>
                    Select Book<span class="required-asterisk">*</span>
                </label>
                <select class="form-select" name="bookId" required <%= !hasBooks ? "disabled" : "" %>>
                    <% if (hasBooks) { %>
                        <option value="" selected disabled>Choose a book...</option>
                        <%
                            for (java.util.Map<String, Object> b : books) {
                                int copies = Integer.parseInt(String.valueOf(b.get("noOfCopies")));
                                String copiesClass = copies > 0 ? "text-success" : "text-danger";
                                boolean available = copies > 0;
                        %>
                            <option value="<%= b.get("bookId") %>" <%= !available ? "disabled" : "" %>>
                                <%= b.get("bookName") %> 
                                <% if (b.get("author") != null && !b.get("author").toString().isEmpty()) { %>
                                    by <%= b.get("author") %>
                                <% } %>
                                - <span class="<%= copiesClass %>"><%= copies %> available</span>
                            </option>
                        <%
                            }
                        %>
                    <% } else { %>
                        <option value="">No books available</option>
                    <% } %>
                </select>
                <div class="form-text">Select the book to issue</div>
            </div>

           
            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-calendar-check"></i>
                    Expected Return Date<span class="required-asterisk">*</span>
                </label>
                <input class="form-control" 
                       type="date" 
                       name="returningDate"
                       min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                       required>
                <div class="form-text">Date when the book should be returned</div>
            </div>

            <button class="btn btn-primary w-100" 
                    type="submit" 
                    <%= (!hasStudents || !hasBooks) ? "disabled" : "" %>>
                <i class="fas fa-hand-holding-heart me-2"></i>Issue Book
            </button>

            <a class="btn-back" href="librarianDashboard.jsp">
                <i class="fas fa-arrow-left"></i>Back to Dashboard
            </a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Set default return date to 14 days from today
        const dateInput = document.querySelector('input[name="returningDate"]');
        const today = new Date();
        const returnDate = new Date(today.setDate(today.getDate() + 14));
        const formattedDate = returnDate.toISOString().split('T')[0];
        dateInput.value = formattedDate;
    </script>
</body>
</html>
