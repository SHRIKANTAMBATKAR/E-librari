<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - E-Library</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            max-width: 420px;
            width: 100%;
        }

        .login-card {
            background: #fff;
            border-radius: 18px;
            padding: 40px 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        /* Header */
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .icon-wrapper {
            width: 70px;
            height: 70px;
            background: #f5576c;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: auto;
            margin-bottom: 15px;
            color: #fff;
            font-size: 30px;
        }

        .login-title {
            font-size: 26px;
            font-weight: 700;
            color: #1f2937;
        }

        .login-subtitle {
            font-size: 14px;
            color: #6b7280;
        }

        /* Form */
        .form-label {
            font-weight: 600;
            font-size: 14px;
            color: #1f2937;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }

        .form-control {
            height: 48px;
            padding-left: 42px;
            border-radius: 10px;
            border: 1px solid #d1d5db;
        }

        .form-control:focus {
            border-color: #f5576c;
            box-shadow: 0 0 0 3px rgba(245,87,108,0.15);
        }

        .password-toggle {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6b7280;
            cursor: pointer;
        }

        /* Buttons */
        .btn-login {
            width: 100%;
            height: 48px;
            background: #f5576c;
            border: none;
            border-radius: 10px;
            color: #fff;
            font-weight: 600;
            margin-top: 10px;
        }

        .btn-login:hover {
            background: #e03e54;
        }

        .btn-back {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            width: 100%;
            height: 48px;
            margin-top: 12px;
            border-radius: 10px;
            border: 1px solid #d1d5db;
            background: #fff;
            text-decoration: none;
            color: #1f2937;
            font-weight: 600;
        }

        .btn-back:hover {
            background: #f9fafb;
        }

        /* Alert */
        .alert {
            font-size: 14px;
            border-radius: 10px;
        }

        /* Security badge */
        .security-badge {
            text-align: center;
            font-size: 13px;
            color: #6b7280;
            margin-top: 20px;
            border-top: 1px solid #e5e7eb;
            padding-top: 15px;
        }

        .security-badge i {
            color: #10b981;
            margin-right: 4px;
        }

        @media (max-width: 576px) {
            .login-card {
                padding: 30px 20px;
            }
        }
    </style>
</head>

<body>

<div class="login-container">
    <div class="login-card">

        <!-- Header -->
        <div class="login-header">
            <div class="icon-wrapper">
                <i class="fas fa-user-shield"></i>
            </div>
            <h1 class="login-title">Admin Login</h1>
            <p class="login-subtitle">Access the admin dashboard</p>
        </div>

        <!-- Error -->
        <% if(request.getParameter("error") != null) { %>
            <div class="alert alert-danger">
                Invalid username or password
            </div>
        <% } %>

        <!-- Form -->
        <form action="AdminLogin" method="post" id="loginForm">

            <div class="mb-3">
                <label class="form-label">Username</label>
                <div class="input-wrapper">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" name="username" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" name="password" id="password" class="form-control" required>
                    <button type="button" class="password-toggle" onclick="togglePassword()">
                        <i class="fas fa-eye" id="toggleIcon"></i>
                    </button>
                </div>
            </div>

            <button class="btn-login" type="submit">Login</button>

            <a href="index.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
        </form>

        <div class="security-badge">
            <i class="fas fa-shield-alt"></i> Secure Admin Access
        </div>

    </div>
</div>

<script>
    function togglePassword() {
        const pwd = document.getElementById("password");
        const icon = document.getElementById("toggleIcon");

        if (pwd.type === "password") {
            pwd.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            pwd.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    }
</script>

</body>
</html>
