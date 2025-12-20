<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>E-Library Home</title>

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

        .main-container {
            max-width: 900px;
            width: 100%;
        }

        /* Hero */
        .hero-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo-icon {
            width: 80px;
            height: 80px;
            background: #fff;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: auto;
            margin-bottom: 20px;
        }

        .logo-icon i {
            font-size: 36px;
            color: #6366f1;
        }

        .hero-title {
            color: #fff;
            font-size: 32px;
            font-weight: 700;
        }

        .hero-subtitle {
            color: rgba(255,255,255,0.9);
            font-size: 18px;
        }

        /* Cards */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
        }

        .access-card {
            background: #fff;
            border-radius: 16px;
            padding: 30px;
            text-align: center;
            text-decoration: none;
            color: #1f2937;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .access-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .card-icon {
            width: 70px;
            height: 70px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: auto;
            margin-bottom: 20px;
            color: #fff;
            font-size: 28px;
        }

        .admin { background: #f43f5e; }
        .librarian { background: #3b82f6; }
        .student { background: #10b981; }

        .card-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .card-description {
            font-size: 15px;
            color: #6b7280;
            margin-bottom: 20px;
        }

        .card-link {
            font-weight: 600;
            color: #6366f1;
        }

        /* Footer */
        .footer-text {
            text-align: center;
            margin-top: 40px;
            color: rgba(255,255,255,0.85);
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

<div class="main-container">

    <!-- Hero -->
    <div class="hero-section">
        <div class="logo-icon">
            <i class="fas fa-book-open"></i>
        </div>
        <h1 class="hero-title">Welcome to E-Library</h1>
        <p class="hero-subtitle">Your Gateway to Knowledge and Learning</p>
    </div>

    <!-- Cards -->
    <div class="cards-container">

        <a href="OpenAdminLogin" class="access-card">
            <div class="card-icon admin">
                <i class="fas fa-user-shield"></i>
            </div>
            <div class="card-title">Admin Portal</div>
            <div class="card-description">
                Manage librarians and system operations
            </div>
            <div class="card-link">Access Portal →</div>
        </a>

        <a href="OpenLibrarianLogin" class="access-card">
            <div class="card-icon librarian">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="card-title">Librarian Panel</div>
            <div class="card-description">
                Manage books and student records
            </div>
            <div class="card-link">Access Panel →</div>
        </a>

        <a href="OpenStudentView" class="access-card">
            <div class="card-icon student">
                <i class="fas fa-book-reader"></i>
            </div>
            <div class="card-title">Browse Books</div>
            <div class="card-description">
                Explore books and check availability
            </div>
            <div class="card-link">View Collection →</div>
        </a>

    </div>

    <!-- Footer -->
    <div class="footer-text">
        Made with <i class="fas fa-heart text-danger"></i> for Learning
    </div>

</div>

</body>
</html>
