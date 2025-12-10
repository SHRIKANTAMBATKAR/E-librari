package com.elib.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/OpenLibrarianLogin")
public class OpenLibrarianLogin extends HttpServlet {
   
	private static final long serialVersionUID = 133276180130694700L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/librarianLogin.jsp").forward(req, resp);
    }
}
