package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.sql.Date;
import java.util.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ============================================
        // ISSUE BOOK
        // ============================================
        if ("issue".equals(action)) {

            int studId = Integer.parseInt(req.getParameter("studId"));
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            Date returningDate = Date.valueOf(req.getParameter("returningDate"));

            Connection con = null;

            try {
                con = DBConnection.getConnection();
                con.setAutoCommit(false);

                // 1) Check if student already has 4 books
                int issuedCount = 0;

                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT noOfBooksIssued FROM student WHERE studId=?")) {

                    ps.setInt(1, studId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) issuedCount = rs.getInt("noOfBooksIssued");
                    else throw new ServletException("Student not found");
                }

                if (issuedCount >= 4) {
                    con.rollback();
                    resp.sendRedirect("OpenIssueBook?msg=Student+already+has+4+books");
                    return;
                }

                // 2) Check if book has available copies
                int copies = 0;

                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT noOfCopies FROM book WHERE bookId=?")) {

                    ps.setInt(1, bookId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) copies = rs.getInt("noOfCopies");
                    else throw new ServletException("Book not found");
                }

                if (copies <= 0) {
                    con.rollback();
                    resp.sendRedirect("OpenIssueBook?msg=No+copies+available");
                    return;
                }

                // 3) Insert issue record
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO libraryregister (studId, bookId, issuedDate, returningDate, status) VALUES (?, ?, CURDATE(), ?, 'issued')")) {

                    ps.setInt(1, studId);
                    ps.setInt(2, bookId);
                    ps.setDate(3, returningDate);
                    ps.executeUpdate();
                }

                // 4) Decrease book copies
                try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE book SET noOfCopies = noOfCopies - 1 WHERE bookId=?")) {

                    ps.setInt(1, bookId);
                    ps.executeUpdate();
                }

                // 5) Increase student's issued count
                try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE student SET noOfBooksIssued = noOfBooksIssued + 1 WHERE studId=?")) {

                    ps.setInt(1, studId);
                    ps.executeUpdate();
                }

                con.commit();
                resp.sendRedirect("OpenIssueBook?msg=Book+Issued+Successfully");

            } catch (SQLException e) {
                try { if (con != null) con.rollback(); } catch (SQLException ignored) {}
                throw new ServletException(e);
            } finally {
                try { if (con != null) con.setAutoCommit(true); con.close(); } catch (Exception ignored) {}
            }

            return;
        }

        // ============================================
        // RETURN BOOK
        // ============================================
        if ("return".equals(action)) {

            int recordId = Integer.parseInt(req.getParameter("recordId"));

            Connection con = null;

            try {
                con = DBConnection.getConnection();
                con.setAutoCommit(false);

                int studId = -1, bookId = -1;

                // 1) Fetch issued record
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT studId, bookId, status FROM libraryregister WHERE id=?")) {

                    ps.setInt(1, recordId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        studId = rs.getInt("studId");
                        bookId = rs.getInt("bookId");

                        if (!"issued".equalsIgnoreCase(rs.getString("status"))) {
                            con.rollback();
                            resp.sendRedirect("OpenReturnBook?msg=Book+is+already+returned");
                            return;
                        }
                    } else {
                        throw new ServletException("Issue record not found");
                    }
                }

                // 2) Update register status
                try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE libraryregister SET returnDate=CURDATE(), status='returned' WHERE id=?")) {

                    ps.setInt(1, recordId);
                    ps.executeUpdate();
                }

                // 3) Increase book copies
                try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE book SET noOfCopies = noOfCopies + 1 WHERE bookId=?")) {

                    ps.setInt(1, bookId);
                    ps.executeUpdate();
                }

                // 4) Decrease student's issued count
                try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE student SET noOfBooksIssued = noOfBooksIssued - 1 WHERE studId=?")) {

                    ps.setInt(1, studId);
                    ps.executeUpdate();
                }

                con.commit();
                resp.sendRedirect("OpenReturnBook?msg=Book+Returned+Successfully");

            } catch (SQLException e) {
                try { if (con != null) con.rollback(); } catch (SQLException ignored) {}
                throw new ServletException(e);
            } finally {
                try { if (con != null) con.setAutoCommit(true); con.close(); } catch (Exception ignored) {}
            }
        }
    }

    // ==========================================================
    // LIST ISSUED BOOKS (for returnBook.jsp)
    // ==========================================================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("viewIssued".equals(action) || action == null) {

            List<Map<String, Object>> issued = new ArrayList<>();

            String sql =
                    "SELECT r.id, s.studName, b.bookName, r.issuedDate, r.returningDate " +
                    "FROM libraryregister r " +
                    "JOIN student s ON r.studId = s.studId " +
                    "JOIN book b ON r.bookId = b.bookId " +
                    "WHERE r.status = 'issued'";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("id", rs.getInt("id"));
                    m.put("studentName", rs.getString("studName"));
                    m.put("bookName", rs.getString("bookName"));
                    m.put("issuedDate", rs.getDate("issuedDate"));
                    m.put("returningDate", rs.getDate("returningDate"));
                    issued.add(m);
                }

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            req.setAttribute("issuedRecords", issued);
            req.getRequestDispatcher("returnBook.jsp").forward(req, resp);
        }
    }
}
