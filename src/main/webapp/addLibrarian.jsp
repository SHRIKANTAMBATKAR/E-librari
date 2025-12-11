<%@ page contentType="text/html; charset=UTF-8"%>
<%
    if(session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Librarian - Library Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            --hover-shadow: 0 8px 15px rgba(0, 0, 0, 0.12);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            padding: 2rem 0;
        }

        .form-container {
            background: white;
            border-radius: 20px;
            box-shadow: var(--hover-shadow);
            padding: 2.5rem;
            max-width: 550px;
            margin: 0 auto;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 3px solid var(--secondary-color);
        }

        .form-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .form-header h2 i {
            color: var(--secondary-color);
        }

        .form-header p {
            color: #6c757d;
            margin: 0;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
        }

        .form-label i {
            color: var(--secondary-color);
        }

        .form-control {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .input-group {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            padding: 0.5rem;
            z-index: 10;
            transition: color 0.3s ease;
        }

        .password-toggle:hover {
            color: var(--secondary-color);
        }

        .btn-submit {
            background: var(--success-color);
            border: none;
            border-radius: 10px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            color: white;
            font-size: 1.05rem;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }

        .btn-submit:hover {
            background: #229954;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(39, 174, 96, 0.3);
        }

        .btn-back {
            background: #6c757d;
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            width: 100%;
            margin-top: 1rem;
        }

        .btn-back:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(108, 117, 125, 0.3);
            color: white;
        }

        .required-indicator {
            color: #e74c3c;
            margin-left: 0.25rem;
        }

        .form-hint {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
            display: block;
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem 0;
            }

            .form-container {
                padding: 1.5rem;
                margin: 1rem;
            }

            .form-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>

<body>

<div class="container">
    <div class="form-container">
        <div class="form-header">
            <h2>
                <i class="fas fa-user-plus"></i>
                Add New Librarian
            </h2>
            <p>Fill in the details to register a new librarian</p>
        </div>

        <form action="AdminServlet" method="post" id="librarianForm">
            <input type="hidden" name="action" value="addLibrarian">

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-user"></i>
                    Full Name
                    <span class="required-indicator">*</span>
                </label>
                <input class="form-control" 
                       type="text" 
                       name="librarianName" 
                       placeholder="Enter librarian's full name"
                       required>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-briefcase"></i>
                    Years of Experience
                </label>
                <input class="form-control" 
                       type="number" 
                       name="yearsOfExp"
                       min="0"
                       max="50"
                       placeholder="Enter years of experience">
                <small class="form-hint">Leave blank if no prior experience</small>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-at"></i>
                    Username
                    <span class="required-indicator">*</span>
                </label>
                <input class="form-control" 
                       type="text" 
                       name="username" 
                       placeholder="Choose a unique username"
                       required>
                <small class="form-hint">This will be used for login</small>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-lock"></i>
                    Password
                    <span class="required-indicator">*</span>
                </label>
                <div class="input-group">
                    <input class="form-control" 
                           type="password" 
                           name="password" 
                           id="password"
                           placeholder="Create a secure password"
                           required>
                    <button type="button" 
                            class="password-toggle" 
                            onclick="togglePassword()">
                        <i class="fas fa-eye" id="toggleIcon"></i>
                    </button>
                </div>
                <small class="form-hint">Minimum 6 characters recommended</small>
            </div>

            <button type="submit" class="btn-submit">
                <i class="fas fa-save"></i> Save Librarian
            </button>
        </form>

        <a class="btn-back" href="adminDashboard.jsp">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
