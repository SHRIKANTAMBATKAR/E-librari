package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AdminLogin")
public class AdminLoginServlet extends HttpServlet {

    
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String sql = "SELECT adminId FROM admin WHERE username=? AND password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = req.getSession();
                    session.setAttribute("admin", username);
                    req.getRequestDispatcher("/adminDashboard.jsp").forward(req, resp);
                    return;
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // invalid

        resp.sendRedirect("OpenAdminLogin?error=Invalid+credentials");
    }
}
