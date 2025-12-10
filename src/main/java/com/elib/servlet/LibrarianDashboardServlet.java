package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/OpenLibrarianDashboard")
public class LibrarianDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int totalBooks = 0;
        int activeStudents = 0;
        int issuedBooks = 0;
        int pendingReturns = 0;

        try (Connection con = DBConnection.getConnection()) {

            // Total Books
            String sql1 = "SELECT SUM(noOfCopies) AS total FROM book";
            try (PreparedStatement ps = con.prepareStatement(sql1);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalBooks = rs.getInt("total");
            }

            // Active Students
            String sql2 = "SELECT COUNT(*) AS total FROM student";
            try (PreparedStatement ps = con.prepareStatement(sql2);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) activeStudents = rs.getInt("total");
            }

            // Books Currently Issued
            String sql3 = "SELECT COUNT(*) AS total FROM libraryregister WHERE status='issued'";
            try (PreparedStatement ps = con.prepareStatement(sql3);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) issuedBooks = rs.getInt("total");
            }

            // Pending Returns
            String sql4 = "SELECT COUNT(*) AS total FROM libraryregister WHERE status='issued' AND returningDate < CURDATE()";
            try (PreparedStatement ps = con.prepareStatement(sql4);
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) pendingReturns = rs.getInt("total");
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // send stats to JSP
        req.setAttribute("totalBooks", totalBooks);
        req.setAttribute("activeStudents", activeStudents);
        req.setAttribute("issuedBooks", issuedBooks);
        req.setAttribute("pendingReturns", pendingReturns);

        req.getRequestDispatcher("librarianDashboard.jsp").forward(req, resp);
    }
}
