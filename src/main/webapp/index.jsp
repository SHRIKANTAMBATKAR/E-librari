<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>E-Library Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #6366f1;
            --primary-dark: #4f46e5;
            --secondary-color: #8b5cf6;
            --accent-color: #ec4899;
            --success-color: #10b981;
            --bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background elements */
        .bg-decoration {
            position: fixed;
            border-radius: 50%;
            opacity: 0.1;
            pointer-events: none;
            z-index: 0;
        }

        .bg-circle-1 {
            width: 400px;
            height: 400px;
            background: white;
            top: -100px;
            right: -100px;
            animation: float 20s infinite ease-in-out;
        }

        .bg-circle-2 {
            width: 300px;
            height: 300px;
            background: white;
            bottom: -50px;
            left: -50px;
            animation: float 15s infinite ease-in-out reverse;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            25% { transform: translate(20px, -20px) rotate(5deg); }
            50% { transform: translate(-20px, 20px) rotate(-5deg); }
            75% { transform: translate(20px, 20px) rotate(3deg); }
        }

        .main-container {
            position: relative;
            z-index: 1;
            max-width: 900px;
            width: 100%;
        }

        .hero-section {
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeInDown 0.8s ease;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo-icon {
            width: 80px;
            height: 80px;
            background: white;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .logo-icon i {
            font-size: 2.5rem;
            background: var(--bg-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-title {
            color: white;
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 20px rgba(0, 0, 0, 0.2);
        }

        .hero-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
            font-weight: 400;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            animation: fadeInUp 0.8s ease 0.2s both;
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

        .access-card {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-decoration: none;
            color: inherit;
            display: block;
            position: relative;
            overflow: hidden;
        }

        .access-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--bg-gradient);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .access-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }

        .access-card:hover::before {
            transform: scaleX(1);
        }

        .card-icon-wrapper {
            width: 70px;
            height: 70px;
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .access-card:hover .card-icon-wrapper {
            transform: scale(1.1) rotate(5deg);
        }

        .admin-card .card-icon-wrapper {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .librarian-card .card-icon-wrapper {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .student-card .card-icon-wrapper {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }

        .card-icon-wrapper i {
            font-size: 2rem;
            color: white;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #1f2937;
        }

        .card-description {
            color: #6b7280;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .card-arrow {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.95rem;
            transition: gap 0.3s ease;
        }

        .access-card:hover .card-arrow {
            gap: 1rem;
        }

        .footer-text {
            text-align: center;
            color: rgba(255, 255, 255, 0.8);
            margin-top: 3rem;
            font-size: 0.9rem;
            animation: fadeIn 1s ease 0.5s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .footer-text i {
            color: #ec4899;
            margin: 0 0.3rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2rem;
            }

            .hero-subtitle {
                font-size: 1rem;
            }

            .cards-container {
                grid-template-columns: 1fr;
            }

            .access-card {
                padding: 1.5rem;
            }
        }

        /* Accessibility */
        .access-card:focus {
            outline: 3px solid white;
            outline-offset: 3px;
        }

        /* Loading animation for smooth page load */
        @keyframes shimmer {
            0% { background-position: -1000px 0; }
            100% { background-position: 1000px 0; }
        }
    </style>
</head>

<body>
    <!-- Animated background decorations -->
    <div class="bg-decoration bg-circle-1"></div>
    <div class="bg-decoration bg-circle-2"></div>

    <div class="main-container">
        <!-- Hero Section -->
        <div class="hero-section">
            <div class="logo-icon">
                <i class="fas fa-book-open"></i>
            </div>
            <h1 class="hero-title">Welcome to E-Library</h1>
            <p class="hero-subtitle">Your Gateway to Knowledge and Learning</p>
        </div>

        <!-- Access Cards -->
        <div class="cards-container">
            <!-- Admin Card -->
            <a href="OpenAdminLogin" class="access-card admin-card">
                <div class="card-icon-wrapper">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h2 class="card-title">Admin Portal</h2>
                <p class="card-description">
                    Manage librarians and oversee complete system operations
                </p>
                <div class="card-arrow">
                    Access Portal
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>

            <!-- Librarian Card -->
            <a href="OpenLibrarianLogin" class="access-card librarian-card">
                <div class="card-icon-wrapper">
                    <i class="fas fa-user-tie"></i>
                </div>
                <h2 class="card-title">Librarian Panel</h2>
                <p class="card-description">
                    Manage books, issue returns, and handle student records
                </p>
                <div class="card-arrow">
                    Access Panel
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>

            <!-- Student Card -->
            <a href="OpenStudentView" class="access-card student-card">
                <div class="card-icon-wrapper">
                    <i class="fas fa-book-reader"></i>
                </div>
                <h2 class="card-title">Browse Books</h2>
                <p class="card-description">
                    Explore our collection and check book availability
                </p>
                <div class="card-arrow">
                    View Collection
                    <i class="fas fa-arrow-right"></i>
                </div>
            </a>
        </div>

        <!-- Footer -->
        <div class="footer-text">
            <p>Made with <i class="fas fa-heart"></i> for Learning</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>