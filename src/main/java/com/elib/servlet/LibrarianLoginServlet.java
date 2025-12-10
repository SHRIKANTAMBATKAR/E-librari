package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/LibrarianLoginServlet")
public class LibrarianLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String sql = "SELECT librarianId FROM librarianDetails WHERE username=? AND password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("librarian", username);
                resp.sendRedirect("librarianDashboard.jsp");
                return;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }

        resp.sendRedirect("librarianLogin.jsp?error=Invalid Credentials");
    }
}
