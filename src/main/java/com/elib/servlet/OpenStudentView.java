package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/OpenStudentView")
public class OpenStudentView extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Map<String, Object>> books = new ArrayList<>();

        // Read search keyword from JSP
        String search = req.getParameter("search");

        // SQL with optional search filter
        String sql;

        if (search != null && !search.trim().isEmpty()) {
            sql = "SELECT * FROM book WHERE bookName LIKE ? OR author LIKE ? OR publishedYear LIKE ?";
        } else {
            sql = "SELECT * FROM book";
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Add search parameters only if user typed something
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
        req.setAttribute("search", search); // Keeps input text in search bar

        req.getRequestDispatcher("studentViewBooks.jsp").forward(req, resp);
    }
}
