package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null || action.equals("view")) {
            viewStudents(req, resp);
        } else if (action.equals("editForm")) {
            openEditForm(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addStudent(req, resp);
        } else if ("update".equals(action)) {
            updateStudent(req, resp);
        } else if ("delete".equals(action)) {
            deleteStudent(req, resp);
        }
    }

    // --------------------------
    // VIEW STUDENTS
    // --------------------------
    private void viewStudents(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT studId, studName, year, noOfBooksIssued, domain FROM student";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("studId", rs.getInt("studId"));
                row.put("studName", rs.getString("studName"));
                row.put("year", rs.getString("year"));              // TEXT SUPPORT
                row.put("issued", rs.getInt("noOfBooksIssued"));
                row.put("domain", rs.getString("domain"));
                list.add(row);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.setAttribute("students", list);
        req.getRequestDispatcher("viewStudents.jsp").forward(req, resp);
    }

    // --------------------------
    // ADD STUDENT
    // --------------------------
    private void addStudent(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String name = req.getParameter("studName");
        String year = req.getParameter("year");        // TEXT
        String domain = req.getParameter("domain");

        String sql = "INSERT INTO student (studName, year, noOfBooksIssued, domain) VALUES (?, ?, 0, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, year);                     // TEXT
            ps.setString(3, domain);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        resp.sendRedirect("StudentServlet?action=view");
    }

    private void deleteStudent(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int studId = Integer.parseInt(req.getParameter("studId"));

        String deleteChild = "DELETE FROM libraryregister WHERE studId = ?";
        String deleteParent = "DELETE FROM student WHERE studId = ?";

        try (Connection con = DBConnection.getConnection()) {

            // Step 1, delete records from libraryregister
            try (PreparedStatement ps1 = con.prepareStatement(deleteChild)) {
                ps1.setInt(1, studId);
                ps1.executeUpdate();
            }

            // Step 2, now delete from student
            try (PreparedStatement ps2 = con.prepareStatement(deleteParent)) {
                ps2.setInt(1, studId);
                ps2.executeUpdate();
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        resp.sendRedirect("StudentServlet?action=view");
    }

    // --------------------------
    // OPEN EDIT FORM
    // --------------------------
    private void openEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("studId"));

        String sql = "SELECT * FROM student WHERE studId = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    req.setAttribute("studId", rs.getInt("studId"));
                    req.setAttribute("studName", rs.getString("studName"));
                    req.setAttribute("year", rs.getString("year"));   // TEXT
                    req.setAttribute("domain", rs.getString("domain"));
                }
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }

        req.getRequestDispatcher("editStudent.jsp").forward(req, resp);
    }

    // --------------------------
    // UPDATE STUDENT
    // --------------------------
    private void updateStudent(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int studId = Integer.parseInt(req.getParameter("studId"));
        String name = req.getParameter("studName");
        String year = req.getParameter("year");            // TEXT
        String domain = req.getParameter("domain");

        String sql = "UPDATE student SET studName=?, year=?, domain=? WHERE studId=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, year);                         // TEXT
            ps.setString(3, domain);
            ps.setInt(4, studId);

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        resp.sendRedirect("StudentServlet?action=view");
    }
}
