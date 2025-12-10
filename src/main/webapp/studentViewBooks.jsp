<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Books - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --secondary: #06b6d4;
            --success: #10b981;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f8fafc;
            min-height: 100vh;
        }

        .navbar-custom {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
            margin-bottom: 30px;
        }

        .page-header {
            background: linear-gradient(135deg, var(--secondary) 0%, #0891b2 100%);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(6, 182, 212, 0.3);
        }

        .page-header h2 {
            font-weight: 700;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .page-header h2 i {
            margin-right: 15px;
            font-size: 36px;
        }

        .page-header p {
            margin: 0;
            opacity: 0.9;
        }

        .search-container {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 25px;
        }

        .search-box {
            display: flex;
            gap: 10px;
            max-width: 600px;
        }

        .search-input {
            flex: 1;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 20px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .search-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            outline: none;
        }

        .btn-search {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s;
            white-space: nowrap;
        }

        .btn-search:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 70, 229, 0.3);
        }

        .btn-clear {
            background: #64748b;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-clear:hover {
            background: #475569;
            transform: translateY(-2px);
        }

        .table-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }

        .table thead th {
            background: var(--primary);
            color: white;
            font-weight: 600;
            border: none;
            padding: 15px;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 15px;
            vertical-align: middle;
            border-color: #e2e8f0;
        }

        .table tbody tr {
            transition: all 0.3s;
        }

        .table tbody tr:hover {
            background: #f8fafc;
            transform: scale(1.01);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .badge-available {
            background: #d1fae5;
            color: #059669;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 12px;
        }

        .badge-unavailable {
            background: #fee2e2;
            color: #dc2626;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 12px;
        }

        .btn-back {
            background: #64748b;
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
        }

        .btn-back:hover {
            background: #475569;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(100, 116, 139, 0.3);
            color: white;
        }

        .btn-back i {
            margin-right: 8px;
        }

        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #64748b;
        }

        .no-results i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .stats-info {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #64748b;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .book-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--secondary) 0%, #0891b2 100%);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        @media (max-width: 768px) {
            .table-container {
                padding: 15px;
                overflow-x: auto;
            }
            
            .page-header {
                padding: 25px 20px;
            }

            .page-header h2 {
                font-size: 24px;
            }

            .search-box {
                flex-direction: column;
            }

            .btn-search, .btn-clear {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar-custom">
        <div class="container-fluid px-4">
            <div class="d-flex justify-content-between align-items-center w-100">
                <div class="d-flex align-items-center">
                    <i class="fas fa-book-reader fs-3 text-primary me-3"></i>
                    <h5 class="mb-0">Library Management</h5>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h2><i class="fas fa-books"></i>Browse Books</h2>
            <p>Explore our collection of available books</p>
        </div>

        <%
            List<Map<String, Object>> books = (List<Map<String, Object>>) request.getAttribute("books");
            String searchQuery = request.getAttribute("search") == null ? "" : (String) request.getAttribute("search");
            int totalBooks = (books != null) ? books.size() : 0;
            int availableBooks = 0;
            
            if (books != null) {
                for (Map<String, Object> b : books) {
                    int copies = Integer.parseInt(String.valueOf(b.get("noOfCopies")));
                    if (copies > 0) availableBooks++;
                }
            }
        %>

        <!-- Search Container -->
        <div class="search-container">
            <div class="stats-info">
                <i class="fas fa-info-circle"></i>
                <span>Showing <strong><%= totalBooks %></strong> books (<strong><%= availableBooks %></strong> available)</span>
            </div>
            <form action="OpenStudentView" method="get">
                <div class="search-box">
                    <input type="text" 
                           name="search" 
                           class="search-input"
                           placeholder="Search by book name, author, or year..."
                           value="<%= searchQuery %>">
                    <button class="btn-search" type="submit">
                        <i class="fas fa-search me-2"></i>Search
                    </button>
                    <% if (!searchQuery.isEmpty()) { %>
                        <a href="OpenStudentView" class="btn-clear">
                            <i class="fas fa-times me-2"></i>Clear
                        </a>
                    <% } %>
                </div>
            </form>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <% if (books != null && !books.isEmpty()) { %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                <th><i class="fas fa-book me-2"></i>Book Name</th>
                                <th><i class="fas fa-user-edit me-2"></i>Author</th>
                                <th><i class="fas fa-calendar me-2"></i>Published Year</th>
                                <th><i class="fas fa-layer-group me-2"></i>Copies</th>
                                <th><i class="fas fa-info-circle me-2"></i>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            for (Map<String, Object> b : books) {
                                int copies = Integer.parseInt(String.valueOf(b.get("noOfCopies")));
                                boolean isAvailable = copies > 0;
                        %>
                            <tr>
                                <td>
                                    <div class="book-icon">
                                        <i class="fas fa-book"></i>
                                    </div>
                                </td>
                                <td><strong><%= b.get("bookName") %></strong></td>
                                <td><%= b.get("author") != null ? b.get("author") : "N/A" %></td>
                                <td><%= b.get("publishedYear") != null ? b.get("publishedYear") : "N/A" %></td>
                                <td>
                                    <strong class="<%= isAvailable ? "text-success" : "text-danger" %>">
                                        <%= copies %>
                                    </strong>
                                </td>
                                <td>
                                    <% if (isAvailable) { %>
                                        <span class="badge-available">
                                            <i class="fas fa-check-circle me-1"></i>Available
                                        </span>
                                    <% } else { %>
                                        <span class="badge-unavailable">
                                            <i class="fas fa-times-circle me-1"></i>Out of Stock
                                        </span>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="no-results">
                    <i class="fas fa-search"></i>
                    <h4>No Books Found</h4>
                    <% if (!searchQuery.isEmpty()) { %>
                        <p class="text-muted">No books match your search "<strong><%= searchQuery %></strong>"</p>
                        <a href="OpenStudentView" class="btn btn-primary mt-3">
                            <i class="fas fa-refresh me-2"></i>View All Books
                        </a>
                    <% } else { %>
                        <p class="text-muted">There are currently no books in the library.</p>
                    <% } %>
                </div>
            <% } %>
        </div>

        <!-- Back Button -->
        <div class="mt-4 mb-5 text-center">
            <button onclick="history.back()" class="btn-back">
                <i class="fas fa-arrow-left"></i>Go Back
            </button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>