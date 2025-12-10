<%@ page contentType="text/html; charset=UTF-8"%>
<%
    if(session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Librarian - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --warning: #f59e0b;
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

        .btn-secondary {
            background: #64748b;
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #475569;
            transform: translateY(-2px);
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

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #64748b;
        }

        .input-wrapper {
            position: relative;
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
            <h3>Edit Librarian</h3>
            <p>Update librarian information</p>
        </div>

        <div class="alert-info">
            <i class="fas fa-info-circle me-2"></i>
            <strong>Editing Mode:</strong> Modify the librarian details below and click Update to save changes.
        </div>

        <form action="AdminServlet" method="post">
            <input type="hidden" name="action" value="updateLibrarian">
            <input type="hidden" name="librarianId" value="<%= request.getAttribute("librarianId") %>">

            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-user"></i>
                    Librarian Name<span class="required-asterisk">*</span>
                </label>
                <input class="form-control" 
                       type="text" 
                       name="librarianName" 
                       value="<%= request.getAttribute("librarianName") %>"
                       placeholder="Enter full name" 
                       required>
                <div class="form-text">Full name of the librarian</div>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-briefcase"></i>
                    Years of Experience<span class="required-asterisk">*</span>
                </label>
                <input class="form-control" 
                       type="number" 
                       name="yearsOfExp" 
                       value="<%= request.getAttribute("yearsOfExp") %>"
                       placeholder="Enter years"
                       min="0"
                       max="50"
                       required>
                <div class="form-text">Total years of library experience</div>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-id-badge"></i>
                    Username<span class="required-asterisk">*</span>
                </label>
                <input class="form-control" 
                       type="text" 
                       name="username" 
                       value="<%= request.getAttribute("username") %>"
                       placeholder="Enter username" 
                       required
                       autocomplete="off">
                <div class="form-text">Unique username for login</div>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    <i class="fas fa-lock"></i>
                    Password<span class="required-asterisk">*</span>
                </label>
                <div class="input-wrapper">
                    <input class="form-control" 
                           type="password" 
                           name="password" 
                           id="password"
                           value="<%= request.getAttribute("password") %>"
                           placeholder="Enter new password or keep existing" 
                           required
                           autocomplete="new-password">
                    <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                </div>
                <div class="form-text">Update password or leave as is</div>
            </div>

            <button class="btn btn-primary w-100" type="submit">
                <i class="fas fa-save me-2"></i>Update Librarian
            </button>

            <a class="btn btn-secondary mt-3 w-100" href="AdminServlet?action=list">
                <i class="fas fa-arrow-left me-2"></i>Back to List
            </a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Password toggle functionality
        const togglePassword = document.getElementById('togglePassword');
        const password = document.getElementById('password');

        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
    </script>
</body>
</html>