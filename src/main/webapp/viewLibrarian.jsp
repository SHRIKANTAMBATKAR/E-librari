<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Librarians Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
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

        .stats-badge {
            background: var(--secondary-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
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

        .librarian-name {
            font-weight: 600;
            color: var(--primary-color);
        }

        .experience-badge {
            background: var(--success-color);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        .username-text {
            font-family: 'Courier New', monospace;
            background: #f0f0f0;
            padding: 0.3rem 0.6rem;
            border-radius: 6px;
            font-size: 0.9rem;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-edit {
            background: var(--warning-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 0.875rem;
        }

        .btn-edit:hover {
            background: #e67e22;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(243, 156, 18, 0.3);
            color: white;
        }

        .btn-delete {
            background: var(--danger-color);
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            color: white;
            font-size: 0.875rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
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

        .id-badge {
            background: #e9ecef;
            color: var(--primary-color);
            padding: 0.3rem 0.7rem;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.9rem;
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

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<div class="container">
    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-users"></i>
                Librarians Management
            </h1>
            <%
                java.util.List<java.util.Map<String, Object>> librarians =
                    (java.util.List<java.util.Map<String, Object>>) request.getAttribute("librarians");
                int librarianCount = (librarians != null) ? librarians.size() : 0;
            %>
            <span class="stats-badge">
                <i class="fas fa-user-tie"></i> <%= librarianCount %> Librarians
            </span>
        </div>

        <div class="table-container">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-user"></i> Name</th>
                        <th><i class="fas fa-briefcase"></i> Experience</th>
                        <th><i class="fas fa-at"></i> Username</th>
                        <th><i class="fas fa-cog"></i> Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (librarians != null && librarians.size() > 0) {
                        for (java.util.Map<String, Object> l : librarians) {
                %>
                <tr>
                    <td>
                        <span class="id-badge">#<%= l.get("librarianId") %></span>
                    </td>
                    <td class="librarian-name">
                        <i class="fas fa-user-circle" style="color: var(--secondary-color);"></i>
                        <%= l.get("librarianName") %>
                    </td>
                    <td>
                        <span class="experience-badge">
                            <i class="fas fa-award"></i>
                            <%= l.get("yearsOfExp") %> years
                        </span>
                    </td>
                    <td>
                        <span class="username-text">@<%= l.get("username") %></span>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <!-- EDIT BUTTON -->
                            <a href="AdminServlet?action=editForm&librarianId=<%= l.get("librarianId") %>"
                               class="btn-edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>

                            <!-- DELETE BUTTON -->
                            <form action="AdminServlet" method="post" class="d-inline"
                                  onsubmit="return confirm('Are you sure you want to delete this librarian?');">
                                <input type="hidden" name="action" value="deleteLibrarian">
                                <input type="hidden" name="librarianId" value="<%= l.get("librarianId") %>">
                                <button class="btn-delete" type="submit">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">
                        <div class="empty-state">
                            <i class="fas fa-users-slash"></i>
                            <h4>No Librarians Found</h4>
                            <p>Add new librarians to manage your library staff.</p>
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
            <a class="btn-back" href="adminDashboard.jsp">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>