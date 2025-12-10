package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/OpenReturnBook")
public class OpenReturnBook extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Map<String, Object>> records = new ArrayList<>();

        String sql = """
                SELECT r.id, s.studName, b.bookName, r.issuedDate, r.returningDate
                FROM libraryregister r
                JOIN student s ON r.studId = s.studId
                JOIN book b ON r.bookId = b.bookId
                WHERE r.status = 'issued'
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("id", rs.getInt("id"));
                m.put("studentName", rs.getString("studName"));
                m.put("bookName", rs.getString("bookName"));
                m.put("issuedDate", rs.getString("issuedDate"));
                m.put("returningDate", rs.getString("returningDate"));
                records.add(m);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("issuedRecords", records);
        req.getRequestDispatcher("returnBook.jsp").forward(req, resp);
    }
}
