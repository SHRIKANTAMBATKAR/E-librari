package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ======================
    // POST – ADD / DELETE
    // ======================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ADD BOOK
        if ("add".equals(action)) {
            String name = req.getParameter("bookName");
            String author = req.getParameter("author");
            String yearStr = req.getParameter("publishedYear");
            String copiesStr = req.getParameter("noOfCopies");

            int year = (yearStr == null || yearStr.isEmpty()) ? 0 : Integer.parseInt(yearStr);
            int copies = (copiesStr == null || copiesStr.isEmpty()) ? 1 : Integer.parseInt(copiesStr);

            String sql = "INSERT INTO book (bookName, author, publishedYear, noOfCopies) VALUES (?, ?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, name);
                ps.setString(2, author);
                ps.setInt(3, year);
                ps.setInt(4, copies);
                ps.executeUpdate();

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            resp.sendRedirect("BookServlet?action=list");
            return;
        }

        // DELETE BOOK
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("bookId"));

            String sql = "DELETE FROM book WHERE bookId = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);
                ps.executeUpdate();

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            resp.sendRedirect("BookServlet?action=list");
        }
    }

    // ======================
    // GET – LIST / SEARCH
    // ======================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String search = req.getParameter("search"); // Search keyword

        // LIST + SEARCH
        if ("list".equals(action) || action == null) {

            List<Map<String, Object>> books = new ArrayList<>();

            String sql;

            // If search bar not empty, filter results
            if (search != null && !search.trim().isEmpty()) {
                sql = "SELECT * FROM book WHERE bookName LIKE ? OR author LIKE ? OR publishedYear LIKE ?";
            } else {
                sql = "SELECT * FROM book";
            }

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                if (search != null && !search.trim().isEmpty()) {
                    String key = "%" + search + "%";
                    ps.setString(1, key);
                    ps.setString(2, key);
                    ps.setString(3, key);
                }

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    Map<String, Object> b = new HashMap<>();
                    b.put("bookId", rs.getInt("bookId"));
                    b.put("bookName", rs.getString("bookName"));
                    b.put("author", rs.getString("author"));
                    b.put("publishedYear", rs.getInt("publishedYear"));
                    b.put("noOfCopies", rs.getInt("noOfCopies"));
                    books.add(b);
                }

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            req.setAttribute("books", books);
            req.setAttribute("search", search); // To preserve text in search bar

            req.getRequestDispatcher("/viewBooks.jsp").forward(req, resp);
        }
    }
}
