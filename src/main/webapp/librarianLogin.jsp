<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Librarian Login - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --secondary: #06b6d4;
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

        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            display: flex;
        }

        .login-left {
            flex: 1;
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-right {
            flex: 1;
            padding: 60px 40px;
        }

        .brand-logo {
            font-size: 48px;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .feature-list {
            list-style: none;
            padding: 0;
            margin-top: 30px;
        }

        .feature-list li {
            padding: 10px 0;
            display: flex;
            align-items: center;
            opacity: 0;
            animation: fadeInUp 0.5s forwards;
        }

        .feature-list li:nth-child(1) { animation-delay: 0.1s; }
        .feature-list li:nth-child(2) { animation-delay: 0.2s; }
        .feature-list li:nth-child(3) { animation-delay: 0.3s; }
        .feature-list li:nth-child(4) { animation-delay: 0.4s; }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .feature-list li i {
            margin-right: 10px;
            color: rgba(255, 255, 255, 0.8);
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

        .input-group-text {
            background: white;
            border: 2px solid #e2e8f0;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }

        .form-control-icon {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }

        .btn-primary {
            background: var(--primary);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 70, 229, 0.3);
        }

        .btn-outline-secondary {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-outline-secondary:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .login-left {
                display: none;
            }
            .login-right {
                padding: 40px 20px;
            }
        }

        .alert {
            border-radius: 10px;
            border: none;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <!-- Left Panel -->
        <div class="login-left">
            <div class="brand-logo">
                <i class="fas fa-book-reader"></i>
            </div>
            <h1 class="mb-3">Library Management System</h1>
            <p class="mb-4">Your gateway to efficient library operations and seamless book management.</p>
            <ul class="feature-list">
                <li><i class="fas fa-check-circle"></i> Manage books and inventory</li>
                <li><i class="fas fa-check-circle"></i> Track student records</li>
                <li><i class="fas fa-check-circle"></i> Issue and return books</li>
                <li><i class="fas fa-check-circle"></i> Real-time analytics</li>
            </ul>
        </div>

        <!-- Right Panel - Login Form -->
        <div class="login-right">
            <h2 class="mb-2">Welcome Back!</h2>
            <p class="text-muted mb-4">Login to access your librarian dashboard</p>
            
            <!-- Error Message (if any) -->
            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    Invalid username or password. Please try again.
                </div>
            <% } %>

            <form action="LibrarianLoginServlet" method="post">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input class="form-control form-control-icon" 
                               type="text" 
                               name="username" 
                               placeholder="Enter your username" 
                               required 
                               autocomplete="username">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input class="form-control form-control-icon" 
                               type="password" 
                               name="password" 
                               placeholder="Enter your password" 
                               required 
                               autocomplete="current-password">
                    </div>
                </div>

                <button class="btn btn-primary w-100 mb-3" type="submit">
                    <i class="fas fa-sign-in-alt me-2"></i>Login
                </button>

                <a href="index.jsp" class="btn btn-outline-secondary w-100">
                    <i class="fas fa-arrow-left me-2"></i>Back to Home
                </a>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>