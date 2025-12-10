<%@ page contentType="text/html; charset=UTF-8"%>
<%
    // Check if user is logged in
    if(session.getAttribute("librarian") == null) {
        response.sendRedirect("librarianLogin.jsp");
        return;
    }
    String librarianName = (String) session.getAttribute("librarian");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Librarian Dashboard - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --secondary: #06b6d4;
            --success: #10b981;
            --danger: #ef4444;
            --light: #f8fafc;
            --dark: #1e293b;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: var(--light);
            min-height: 100vh;
        }

        /* Navbar Styles */
        .navbar-custom {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-brand i {
            font-size: 28px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        /* Dashboard Content */
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
        }

        .dashboard-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            cursor: pointer;
            border: 2px solid transparent;
            height: 100%;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border-color: var(--primary);
            text-decoration: none;
        }

        .card-icon {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin-bottom: 20px;
            transition: all 0.3s;
        }

        .dashboard-card:hover .card-icon {
            transform: scale(1.1);
        }

        .icon-blue { background: rgba(79, 70, 229, 0.1); color: var(--primary); }
        .icon-cyan { background: rgba(6, 182, 212, 0.1); color: var(--secondary); }
        .icon-green { background: rgba(16, 185, 129, 0.1); color: var(--success); }
        .icon-purple { background: rgba(139, 92, 246, 0.1); color: #8b5cf6; }
        .icon-orange { background: rgba(249, 115, 22, 0.1); color: #f97316; }
        .icon-red { background: rgba(239, 68, 68, 0.1); color: var(--danger); }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .card-description {
            color: #64748b;
            font-size: 14px;
            margin: 0;
        }

        .btn-logout {
            background: var(--danger);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-logout:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
        }

        /* Stats Cards */
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .stats-number {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary);
        }

        .stats-label {
            color: #64748b;
            font-size: 14px;
            margin-top: 5px;
        }

        /* Welcome Message */
        .welcome-message {
            animation: fadeInDown 0.5s ease-out;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Card Grid Animation */
        .dashboard-card {
            animation: fadeInUp 0.5s ease-out backwards;
        }

        .dashboard-card:nth-child(1) { animation-delay: 0.1s; }
        .dashboard-card:nth-child(2) { animation-delay: 0.2s; }
        .dashboard-card:nth-child(3) { animation-delay: 0.3s; }
        .dashboard-card:nth-child(4) { animation-delay: 0.4s; }
        .dashboard-card:nth-child(5) { animation-delay: 0.5s; }
        .dashboard-card:nth-child(6) { animation-delay: 0.6s; }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .dashboard-header {
                padding: 30px 0;
            }
            .user-info span {
                display: none;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="#">
                <i class="fas fa-book-reader"></i>
                <span>Library Management</span>
            </a>
            <div class="user-info">
                <span class="text-muted"><i class="fas fa-user-circle me-2"></i><%= librarianName %></span>
                <a href="LogoutServlet" class="btn btn-logout">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <div class="container">
            <div class="welcome-message">
                <h1 class="mb-2">Welcome, <%= librarianName %>!</h1>
                <p class="mb-0 opacity-75">Manage your library operations efficiently from one place</p>
            </div>
        </div>
    </div>

    <!-- Dashboard Content -->
    <div class="container pb-5">
        <!-- Quick Stats (Optional - you can populate with real data later) -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-book text-primary mb-2" style="font-size: 24px;"></i>
                    <div class="stats-number">-</div>
                    <div class="stats-label">Total Books</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-user-graduate text-success mb-2" style="font-size: 24px;"></i>
                    <div class="stats-number">-</div>
                    <div class="stats-label">Active Students</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-book-open text-warning mb-2" style="font-size: 24px;"></i>
                    <div class="stats-number">-</div>
                    <div class="stats-label">Books Issued</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-clock text-danger mb-2" style="font-size: 24px;"></i>
                    <div class="stats-number">-</div>
                    <div class="stats-label">Pending Returns</div>
                </div>
            </div>
        </div>

        <!-- Main Actions -->
        <h4 class="mb-4">Quick Actions</h4>
        <div class="row g-4">
            <!-- Add Book -->
            <div class="col-md-6 col-lg-4">
                <a href="addBook.jsp" class="dashboard-card">
                    <div class="card-icon icon-blue">
                        <i class="fas fa-book-medical"></i>
                    </div>
                    <h5 class="card-title">Add New Book</h5>
                    <p class="card-description">Register new books into the library inventory</p>
                </a>
            </div>

            <!-- View Books -->
            <div class="col-md-6 col-lg-4">
                <a href="BookServlet" class="dashboard-card">
                    <div class="card-icon icon-cyan">
                     <i class="fas fa-book-bookmark"></i>
                    </div>
                    <h5 class="card-title">View All Books</h5>
                    <p class="card-description">Browse and manage your book collection</p>
                </a>
            </div>

            <!-- Issue Book -->
            <div class="col-md-6 col-lg-4">
                <a href="OpenIssueBook" class="dashboard-card">
                    <div class="card-icon icon-green">
                        <i class="fas fa-hand-holding-heart"></i>
                    </div>
                    <h5 class="card-title">Issue Book</h5>
                    <p class="card-description">Issue books to students quickly and easily</p>
                </a>
            </div>

            <!-- Return Book -->
            <div class="col-md-6 col-lg-4">
                <a href="OpenReturnBook" class="dashboard-card">
                    <div class="card-icon icon-purple">
                        <i class="fas fa-undo-alt"></i>
                    </div>
                    <h5 class="card-title">Return Book</h5>
                    <p class="card-description">Process book returns and update records</p>
                </a>
            </div>

            <!-- Manage Students -->
            <div class="col-md-6 col-lg-4">
                <a href="StudentServlet?action=view" class="dashboard-card">
                    <div class="card-icon icon-orange">
                        <i class="fas fa-user-graduate"></i>
                    </div>
                    <h5 class="card-title">Manage Students</h5>
                    <p class="card-description">View and update student information</p>
                </a>
            </div>

            <!-- Reports (Placeholder for future feature) -->
            <div class="col-md-6 col-lg-4">
                <a href="#" class="dashboard-card" onclick="alert('Coming soon!'); return false;">
                    <div class="card-icon icon-red">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h5 class="card-title">Reports & Analytics</h5>
                    <p class="card-description">View library statistics and trends</p>
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>