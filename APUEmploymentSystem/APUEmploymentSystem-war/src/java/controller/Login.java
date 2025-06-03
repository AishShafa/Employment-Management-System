/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.MyCustomer;
import model.MyCustomerFacade;

/**
 *
 * @author aisha
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @EJB
    private MyCustomerFacade myCustomerFacade;
    
    

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            // Find the user by email
            MyCustomer customer = myCustomerFacade.find(email);

            if (customer != null) {
            // Check if the password matches
            if (customer.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("email", email);
                String role = customer.getRole();
                session.setAttribute("role", role);

                switch (role) {
                    case "Admin":
                        request.getRequestDispatcher("Admin/admin_dashboard.jsp").forward(request, response);
                        break;
                    case "Employee":
                        request.getRequestDispatcher("Employee/employee_dashboard.jsp").forward(request, response);
                        break;
                    case "Employer":
                        request.getRequestDispatcher("Employer/employer_dashboard.jsp").forward(request, response);
                        break;                   
                    default:
                        response.sendRedirect("login.jsp?error=Unknown%20role");
                        break;
                }
                } else {
                    // Password does not match
                    request.setAttribute("errorMessage", "Invalid password.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Customer not found
                request.setAttribute("errorMessage", "Account does not exist. If you previously had an account, it may have been deleted after receiving 3 warnings.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred, please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
