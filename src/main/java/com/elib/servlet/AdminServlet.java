package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ==========================
        // ADD LIBRARIAN
        // ==========================
        if ("addLibrarian".equals(action)) {

            String name = req.getParameter("librarianName");
            String years = req.getParameter("yearsOfExp");
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            String sql = "INSERT INTO librarianDetails (librarianName, yearsOfExp, username, password) VALUES (?, ?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, name);
                ps.setInt(2, Integer.parseInt(years));
                ps.setString(3, username);
                ps.setString(4, password);
                ps.executeUpdate();

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            resp.sendRedirect("AdminServlet?action=list");
            return;
        }

        // ==========================
        // UPDATE LIBRARIAN
        // ==========================
        if ("updateLibrarian".equals(action)) {

            int id = Integer.parseInt(req.getParameter("librarianId"));
            String name = req.getParameter("librarianName");
            String years = req.getParameter("yearsOfExp");
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            String sql = "UPDATE librarianDetails SET librarianName=?, yearsOfExp=?, username=?, password=? WHERE librarianId=?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, name);
                ps.setInt(2, Integer.parseInt(years));
                ps.setString(3, username);
                ps.setString(4, password);
                ps.setInt(5, id);

                ps.executeUpdate();

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            resp.sendRedirect("AdminServlet?action=list");
            return;
        }

        // ==========================
        // DELETE LIBRARIAN
        // ==========================
        if ("deleteLibrarian".equals(action)) {

            int id = Integer.parseInt(req.getParameter("librarianId"));

            String sql = "DELETE FROM librarianDetails WHERE librarianId = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);
                ps.executeUpdate();

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            resp.sendRedirect("AdminServlet?action=list");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ==========================
        // LOAD ALL LIBRARIANS
        // ==========================
        if (action == null || action.equals("list")) {

            List<Map<String, Object>> libs = new ArrayList<>();

            String sql = "SELECT * FROM librarianDetails";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("librarianId", rs.getInt("librarianId"));
                    m.put("librarianName", rs.getString("librarianName"));
                    m.put("yearsOfExp", rs.getInt("yearsOfExp"));
                    m.put("username", rs.getString("username"));
                    m.put("password", rs.getString("password"));
                    libs.add(m);
                }

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            req.setAttribute("librarians", libs);
            req.getRequestDispatcher("viewLibrarian.jsp").forward(req, resp);
            return;
        }

        // ==========================
        // LOAD EDIT FORM DATA
        // ==========================
        if (action.equals("editForm")) {

            int id = Integer.parseInt(req.getParameter("librarianId"));

            String sql = "SELECT * FROM librarianDetails WHERE librarianId=?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    req.setAttribute("librarianId", rs.getInt("librarianId"));
                    req.setAttribute("librarianName", rs.getString("librarianName"));
                    req.setAttribute("yearsOfExp", rs.getInt("yearsOfExp"));
                    req.setAttribute("username", rs.getString("username"));
                    req.setAttribute("password", rs.getString("password"));
                }

            } catch (SQLException e) {
                throw new ServletException(e);
            }

            req.getRequestDispatcher("editLibrarian.jsp").forward(req, resp);
        }
    }
}
