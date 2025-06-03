/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.MyCustomer;
import model.MyCustomerFacade;

/**
 *
 * @author aisha
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

   
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String birthdateStr = request.getParameter("birthdate"); // Get the birthdate as a string

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Define the date format
        Date birthdate = null;
        try {
            birthdate = sdf.parse(birthdateStr); // Convert string to date
        } catch (ParseException e) {
            e.printStackTrace(); // Handle parsing error
        }

        String role = request.getParameter("role");
        
        try (PrintWriter out = response.getWriter()) {
            try {
                // Check if the customer already exists using email
                MyCustomer found = myCustomerFacade.find(email);
                if (found != null) {
                    // If a user with this email already exists, handle the error
                    out.println("<br><br><br>Sorry " + email + ", an account with this email already exists!");
                    request.getRequestDispatcher("Employee/register_employee.jsp").include(request, response);
                    return; // Exit the method early if there's a logical error
                }
                // Create a new MyCustomer object with all the parameters
                MyCustomer newCustomer = new MyCustomer(email, password, username, gender, birthdate, role);
                myCustomerFacade.create(newCustomer);

                // If successful, redirect to login.jsp
                out.println("<br><br><br>Hi "+ role + ","+ username + ", your registration is done!");
                request.getRequestDispatcher("login.jsp").include(request, response);
            } catch (IOException | ServletException e) {
                // Handle any technical errors here
                out.println("<br><br><br>Sorry " + email + ", invalid input! Please try again.");
                request.getRequestDispatcher("Employee/register_employee.jsp").include(request, response);
            }
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
