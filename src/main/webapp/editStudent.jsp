<%@ page contentType="text/html;charset=UTF-8" %>
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
    <title>Edit Student - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --warning: #f59e0b;
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
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
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

        .form-control {
            border-radius: 10px;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            outline: none;
        }

        .btn-success {
            background: var(--success);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn-success:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
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

        .alert-info {
            background: #dbeafe;
            border: 2px solid #3b82f6;
            color: #1e40af;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
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
                <i class="fas fa-user-edit"></i>
            </div>
            <h3>Edit Student</h3>
            <p>Update student information</p>
        </div>

        <div class="alert-info">
            <i class="fas fa-info-circle me-2"></i>
            <strong>Editing Mode:</strong> Modify the student details below and click Update to save changes.
        </div>

        <form action="StudentServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="studId" value="<%= request.getAttribute("studId") %>">

            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-user"></i>
                    Student Name<span class="required-asterisk">*</span>
                </label>
                <input class="form-control" 
                       type="text" 
                       name="studName" 
                       value="<%= request.getAttribute("studName") %>"
                       placeholder="Enter student full name" 
                       required>
                <div class="form-text">Full name of the student</div>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-calendar-alt"></i>
                    Year<span class="required-asterisk">*</span>
                </label>
                <input class="form-control" 
                       type="number" 
                       name="year" 
                       value="<%= request.getAttribute("year") %>"
                       placeholder="Enter academic year"
                       min="1"
                       max="6"
                       required>
                <div class="form-text">Current academic year of study</div>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-graduation-cap"></i>
                    Domain/Course<span class="required-asterisk">*</span>
                </label>
                <input class="form-control" 
                       type="text" 
                       name="domain" 
                       value="<%= request.getAttribute("domain") %>"
                       placeholder="Enter course or domain"
                       required>
                <div class="form-text">Field of study or major</div>
            </div>

            <button class="btn btn-success w-100" type="submit">
                <i class="fas fa-save me-2"></i>Update Student
            </button>

            <a class="btn-back" href="StudentServlet?action=view">
                <i class="fas fa-arrow-left"></i>Back to Student List
            </a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>