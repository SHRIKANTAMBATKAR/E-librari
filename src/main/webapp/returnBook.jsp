<%@ page contentType="text/html; charset=UTF-8"%>
<%
    if(session.getAttribute("librarian") == null) {
        response.sendRedirect("librarianLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return Book - Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4f46e5;
            --primary-dark: #4338ca;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --purple: #8b5cf6;
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
            background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(139, 92, 246, 0.3);
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

        .table-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.08);
        }

        .table {
            margin-bottom: 0;
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

        .btn-return {
            background: var(--success);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-return:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(16, 185, 129, 0.3);
            color: white;
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

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 11px;
        }

        .badge-overdue {
            background: #fee2e2;
            color: #dc2626;
        }

        .badge-due-soon {
            background: #fef3c7;
            color: #d97706;
        }

        .badge-safe {
            background: #d1fae5;
            color: #059669;
        }

        .no-records {
            text-align: center;
            padding: 60px 20px;
            color: #64748b;
        }

        .no-records i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .stats-bar {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .stat-card {
            flex: 1;
            min-width: 200px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            border-left: 4px solid var(--primary);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--primary);
        }

        .stat-label {
            color: #64748b;
            font-size: 13px;
            margin-top: 5px;
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
                <a href="LogoutServlet" class="btn btn-outline-danger btn-sm">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h2><i class="fas fa-undo-alt"></i>Return Book</h2>
            <p>Process book returns and manage issued records</p>
        </div>

        <%
            java.util.List<java.util.Map<String, Object>> issuedRecords =
                (java.util.List<java.util.Map<String, Object>>) request.getAttribute("issuedRecords");

            int totalIssued = (issuedRecords != null) ? issuedRecords.size() : 0;
            int overdue = 0;
            int dueSoon = 0;

            // Calculate stats
            if (issuedRecords != null) {
                java.util.Date today = new java.util.Date();
                for (java.util.Map<String, Object> r : issuedRecords) {
                    try {
                        String returnDateStr = (String) r.get("returningDate");
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date returnDate = sdf.parse(returnDateStr);
                        
                        long diff = returnDate.getTime() - today.getTime();
                        long daysDiff = diff / (1000 * 60 * 60 * 24);
                        
                        if (daysDiff < 0) {
                            overdue++;
                        } else if (daysDiff <= 3) {
                            dueSoon++;
                        }
                    } catch (Exception e) {
                        // Skip if date parsing fails
                    }
                }
            }
        %>

        <!-- Stats Bar -->
        <div class="stats-bar">
            <div class="stat-card">
                <div class="stat-value"><%= totalIssued %></div>
                <div class="stat-label">Total Issued Books</div>
            </div>
            <div class="stat-card" style="border-left-color: #ef4444;">
                <div class="stat-value" style="color: #ef4444;"><%= overdue %></div>
                <div class="stat-label">Overdue Books</div>
            </div>
            <div class="stat-card" style="border-left-color: #f59e0b;">
                <div class="stat-value" style="color: #f59e0b;"><%= dueSoon %></div>
                <div class="stat-label">Due Within 3 Days</div>
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <% if (issuedRecords != null && !issuedRecords.isEmpty()) { %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                <th><i class="fas fa-user-graduate me-2"></i>Student</th>
                                <th><i class="fas fa-book me-2"></i>Book</th>
                                <th><i class="fas fa-calendar-plus me-2"></i>Issued Date</th>
                                <th><i class="fas fa-calendar-check me-2"></i>Return Date</th>
                                <th><i class="fas fa-info-circle me-2"></i>Status</th>
                                <th><i class="fas fa-cog me-2"></i>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            java.util.Date today = new java.util.Date();
                            for (java.util.Map<String, Object> r : issuedRecords) {
                                String statusBadge = "badge-safe";
                                String statusText = "On Time";
                                
                                try {
                                    String returnDateStr = (String) r.get("returningDate");
                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                    java.util.Date returnDate = sdf.parse(returnDateStr);
                                    
                                    long diff = returnDate.getTime() - today.getTime();
                                    long daysDiff = diff / (1000 * 60 * 60 * 24);
                                    
                                    if (daysDiff < 0) {
                                        statusBadge = "badge-overdue";
                                        statusText = "OVERDUE";
                                    } else if (daysDiff <= 3) {
                                        statusBadge = "badge-due-soon";
                                        statusText = "Due Soon";
                                    }
                                } catch (Exception e) {
                                    // Keep default status
                                }
                        %>
                            <tr>
                                <td><strong>#<%= r.get("id") %></strong></td>
                                <td><i class="fas fa-user text-primary me-2"></i><%= r.get("studentName") %></td>
                                <td><i class="fas fa-book-open text-success me-2"></i><%= r.get("bookName") %></td>
                                <td><%= r.get("issuedDate") %></td>
                                <td><%= r.get("returningDate") %></td>
                                <td><span class="badge <%= statusBadge %>"><%= statusText %></span></td>
                                <td>
                                    <form action="RegisterServlet" method="post" style="margin: 0;">
                                        <input type="hidden" name="action" value="return">
                                        <input type="hidden" name="recordId" value="<%= r.get("id") %>">
                                        <button class="btn btn-return btn-sm" type="submit">
                                            <i class="fas fa-check-circle me-1"></i>Return
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="no-records">
                    <i class="fas fa-inbox"></i>
                    <h4>No Issued Books</h4>
                    <p class="text-muted">There are currently no books issued to students.</p>
                    <a href="OpenIssueBook" class="btn btn-primary mt-3">
                        <i class="fas fa-hand-holding-heart me-2"></i>Issue a Book
                    </a>
                </div>
            <% } %>
        </div>

        <!-- Back Button -->
        <div class="mt-4 mb-5">
            <a class="btn-back" href="librarianDashboard.jsp">
                <i class="fas fa-arrow-left"></i>Back to Dashboard
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add confirmation before returning book
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                if (!confirm('Are you sure you want to mark this book as returned?')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>