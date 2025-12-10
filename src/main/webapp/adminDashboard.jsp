<%@ page contentType="text/html; charset=UTF-8"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - E-Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --primary-color: #f5576c;
            --primary-light: #fef2f2;
            --secondary-color: #8b5cf6;
            --success-color: #10b981;
            --info-color: #3b82f6;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --dark-color: #1f2937;
            --light-bg: #f9fafb;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            --card-shadow-hover: 0 10px 30px rgba(0, 0, 0, 0.12);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 0;
        }

        /* Top Navigation Bar */
        .top-navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            padding: 1rem 0;
            margin-bottom: 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
            animation: slideDown 0.5s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .navbar-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .brand-icon {
            width: 45px;
            height: 45px;
            background: var(--primary-gradient);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 15px rgba(245, 87, 108, 0.3);
        }

        .brand-icon i {
            color: white;
            font-size: 1.3rem;
        }

        .brand-text h1 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            margin: 0;
        }

        .brand-text p {
            font-size: 0.8rem;
            color: #6b7280;
            margin: 0;
        }

        .navbar-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem 1rem;
            background: var(--light-bg);
            border-radius: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        .user-details h6 {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--dark-color);
            margin: 0;
        }

        .user-details p {
            font-size: 0.75rem;
            color: #6b7280;
            margin: 0;
        }

        .logout-btn {
            padding: 0.6rem 1.5rem;
            background: white;
            border: 2px solid #fee2e2;
            color: var(--danger-color);
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logout-btn:hover {
            background: #fef2f2;
            border-color: var(--danger-color);
            transform: translateY(-2px);
        }

        /* Main Container */
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem 3rem;
            animation: fadeInUp 0.6s ease;
        }

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

        /* Welcome Section */
        .welcome-section {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--primary-gradient);
        }

        .welcome-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h2 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .welcome-text p {
            color: #6b7280;
            font-size: 1rem;
        }

        .welcome-time {
            text-align: right;
        }

        .current-date {
            font-size: 0.9rem;
            color: #6b7280;
            margin-bottom: 0.25rem;
        }

        .current-time {
            font-size: 1.5rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Action Cards Grid */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .action-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            color: inherit;
            position: relative;
            overflow: hidden;
            border: 2px solid transparent;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            transition: width 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow-hover);
        }

        .action-card:hover::before {
            width: 100%;
            opacity: 0.05;
        }

        /* Card Color Variants */
        .card-add::before { background: #f093fb; }
        .card-view::before { background: #4facfe; }
        .card-manage::before { background: #43e97b; }
        .card-navigate::before { background: #fa709a; }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            transition: transform 0.3s ease;
        }

        .action-card:hover .card-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .card-add .card-icon {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .card-view .card-icon {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .card-manage .card-icon {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }

        .card-navigate .card-icon {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }

        .card-icon i {
            font-size: 1.8rem;
            color: white;
        }

        .card-content h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .card-content p {
            color: #6b7280;
            font-size: 0.95rem;
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        .card-arrow {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            font-size: 0.9rem;
            transition: gap 0.3s ease;
        }

        .card-add .card-arrow { color: #f5576c; }
        .card-view .card-arrow { color: #4facfe; }
        .card-manage .card-arrow { color: #43e97b; }
        .card-navigate .card-arrow { color: #fa709a; }

        .action-card:hover .card-arrow {
            gap: 1rem;
        }

        /* Stats Cards */
        .stats-section {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            background: white;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .actions-grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }

            .welcome-content {
                flex-direction: column;
                text-align: center;
                gap: 1.5rem;
            }

            .welcome-time {
                text-align: center;
            }
        }

        @media (max-width: 768px) {
            .navbar-content {
                padding: 0 1rem;
            }

            .dashboard-container {
                padding: 0 1rem 2rem;
            }

            .user-details {
                display: none;
            }

            .actions-grid {
                grid-template-columns: 1fr;
            }

            .welcome-section {
                padding: 1.5rem;
            }

            .welcome-text h2 {
                font-size: 1.5rem;
            }
        }

        /* Accessibility */
        .action-card:focus {
            outline: 3px solid rgba(245, 87, 108, 0.3);
            outline-offset: 3px;
        }

        /* Loading Animation */
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
    </style>
</head>

<body>
    <!-- Top Navigation -->
    <nav class="top-navbar">
        <div class="navbar-content">
            <div class="navbar-brand">
                <div class="brand-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <div class="brand-text">
                    <h1>E-Library Admin</h1>
                    <p>Management Dashboard</p>
                </div>
            </div>

            <div class="navbar-actions">
                <div class="user-info">
                    <div class="user-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div class="user-details">
                        <h6>Administrator</h6>
                        <p>Full Access</p>
                    </div>
                </div>

                <a href="LogoutServlet" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Dashboard Container -->
    <div class="dashboard-container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-content">
                <div class="welcome-text">
                    <h2>Welcome back, Admin! 👋</h2>
                    <p>Manage your library system efficiently from this dashboard</p>
                </div>
                <div class="welcome-time">
                    <p class="current-date" id="currentDate"></p>
                    <div class="current-time" id="currentTime"></div>
                </div>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="stats-section">
            <h3 class="section-title">
                <i class="fas fa-bolt"></i>
                Quick Actions
            </h3>
        </div>

        <!-- Action Cards Grid -->
        <div class="actions-grid">
            <!-- Add Librarian Card -->
            <a href="addLibrarian.jsp" class="action-card card-add">
                <div class="card-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="card-content">
                    <h3>Add Librarian</h3>
                    <p>Register new librarian accounts and grant system access</p>
                    <div class="card-arrow">
                        Add New
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </a>

            <!-- View Librarians Card -->
            <a href="AdminServlet?action=list" class="action-card card-view">
                <div class="card-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="card-content">
                    <h3>View Librarians</h3>
                    <p>Browse, edit, and manage all librarian accounts</p>
                    <div class="card-arrow">
                        View All
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </a>

            <!-- Manage Students Card -->
            <a href="StudentServlet?action=view" class="action-card card-manage">
                <div class="card-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="card-content">
                    <h3>Manage Students</h3>
                    <p>View and manage student records and activities</p>
                    <div class="card-arrow">
                        Manage
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </a>

            <!-- Librarian Panel Card -->
            <a href="librarianLogin.jsp" class="action-card card-navigate">
                <div class="card-icon">
                    <i class="fas fa-exchange-alt"></i>
                </div>
                <div class="card-content">
                    <h3>Librarian Panel</h3>
                    <p>Switch to librarian interface for book management</p>
                    <div class="card-arrow">
                        Switch Panel
                        <i class="fas fa-arrow-right"></i>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <script>
        // Update time and date
        function updateDateTime() {
            const now = new Date();
            
            // Format date
            const dateOptions = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            };
            const dateStr = now.toLocaleDateString('en-US', dateOptions);
            document.getElementById('currentDate').textContent = dateStr;
            
            // Format time
            const timeStr = now.toLocaleTimeString('en-US', { 
                hour: '2-digit', 
                minute: '2-digit'
            });
            document.getElementById('currentTime').textContent = timeStr;
        }

        // Update immediately and then every second
        updateDateTime();
        setInterval(updateDateTime, 1000);

        // Add entrance animation stagger to cards
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.action-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });

        // Confirm logout
        document.querySelector('.logout-btn').addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to logout?')) {
                e.preventDefault();
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>