package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/OpenIssueBook")
public class OpenIssueBook extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Map<String, Object>> students = new ArrayList<>();
        List<Map<String, Object>> books = new ArrayList<>();

        // Fetch students
        String stuSql = "SELECT studId, studName, year FROM student";
        // Fetch books
        String bookSql = "SELECT bookId, bookName, noOfCopies FROM book";

        try (Connection con = DBConnection.getConnection()) {

            // Load students
            PreparedStatement ps1 = con.prepareStatement(stuSql);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                Map<String, Object> s = new HashMap<>();
                s.put("studId", rs1.getInt("studId"));
                s.put("studName", rs1.getString("studName"));
                s.put("year", rs1.getString("year"));
                students.add(s);
            }

            // Load books
            PreparedStatement ps2 = con.prepareStatement(bookSql);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                Map<String, Object> b = new HashMap<>();
                b.put("bookId", rs2.getInt("bookId"));
                b.put("bookName", rs2.getString("bookName"));
                b.put("noOfCopies", rs2.getInt("noOfCopies"));
                books.add(b);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("students", students);
        req.setAttribute("books", books);

        req.getRequestDispatcher("issueBook.jsp").forward(req, resp);
    }
}
