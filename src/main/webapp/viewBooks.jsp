<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Library Books Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            --hover-shadow: 0 8px 15px rgba(0, 0, 0, 0.12);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            background: white;
            border-radius: 20px;
            box-shadow: var(--hover-shadow);
            padding: 2.5rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 3px solid var(--secondary-color);
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 2rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .page-title i {
            color: var(--secondary-color);
        }

        .search-section {
            background: var(--light-bg);
            padding: 1.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: var(--card-shadow);
        }

        .search-wrapper {
            max-width: 600px;
            margin: 0 auto;
        }

        .search-input {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .btn-search {
            background: var(--secondary-color);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
        }

        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background: linear-gradient(135deg, var(--primary-color) 0%, #34495e 100%);
        }

        .table thead th {
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.5px;
            padding: 1rem;
            border: none;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #f0f0f0;
        }

        .table tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            color: #333;
        }

        .book-name {
            font-weight: 600;
            color: var(--primary-color);
        }

        .badge-copies {
            background: var(--success-color);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .btn-delete {
            background: var(--accent-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1.2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-delete:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(231, 76, 60, 0.3);
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
            gap: 0.5rem;
        }

        .btn-back:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(108, 117, 125, 0.3);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1rem;
        }

        .stats-badge {
            background: var(--secondary-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 1.5rem;
                margin-top: 1rem;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .page-title {
                font-size: 1.5rem;
            }

            .table-container {
                overflow-x: auto;
            }
        }
    </style>
</head>

<body>

<div class="container">
    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-book"></i>
                Books Collection
            </h1>
            <%
                java.util.List<java.util.Map<String, Object>> books =
                    (java.util.List<java.util.Map<String, Object>>) request.getAttribute("books");
                int bookCount = (books != null) ? books.size() : 0;
            %>
            <span class="stats-badge">
                <i class="fas fa-layer-group"></i> <%= bookCount %> Books
            </span>
        </div>

        <div class="search-section">
            <form action="BookServlet" method="get" class="search-wrapper">
                <div class="d-flex gap-2">
                    <input type="text" 
                           name="search" 
                           class="form-control search-input"
                           placeholder="🔍 Search by name, author, or year..."
                           value="<%= request.getAttribute("search") == null ? "" : request.getAttribute("search") %>">
                    <button class="btn btn-primary btn-search" type="submit">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </form>
        </div>

        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-book-open"></i> Book Name</th>
                        <th><i class="fas fa-user-edit"></i> Author</th>
                        <th><i class="fas fa-calendar"></i> Year</th>
                        <th><i class="fas fa-copy"></i> Copies</th>
                        <th><i class="fas fa-cog"></i> Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (books != null && books.size() > 0) {
                        for (java.util.Map<String, Object> b : books) {
                %>
                <tr>
                    <td><strong>#<%= b.get("bookId") %></strong></td>
                    <td class="book-name"><%= b.get("bookName") %></td>
                    <td><%= b.get("author") %></td>
                    <td><%= b.get("publishedYear") %></td>
                    <td>
                        <span class="badge-copies">
                            <%= b.get("noOfCopies") %>
                        </span>
                    </td>
                    <td>
                        <form class="d-inline" action="BookServlet" method="post" 
                              onsubmit="return confirm('Are you sure you want to delete this book?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="bookId" value="<%= b.get("bookId") %>">
                            <button class="btn btn-delete btn-sm" type="submit">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6">
                        <div class="empty-state">
                            <i class="fas fa-book-open"></i>
                            <h4>No Books Found</h4>
                            <p>Try adjusting your search or add new books to the library.</p>
                        </div>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="mt-4">
            <a class="btn-back" href="librarianDashboard.jsp">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>