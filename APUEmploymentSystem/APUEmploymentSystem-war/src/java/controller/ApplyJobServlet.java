/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Applicants;
import model.ApplicantsFacade;
import model.MyCustomer;
import model.MyCustomerFacade;

/**
 *
 * @author aisha
 */
@WebServlet(name = "ApplyJobServlet", urlPatterns = {"/ApplyJobServlet"})
public class ApplyJobServlet extends HttpServlet {

    @EJB
    private MyCustomerFacade myCustomerFacade;

    @EJB
    private ApplicantsFacade applicantsFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long jobId = Long.parseLong(request.getParameter("jobId"));
        String email = (String) request.getSession().getAttribute("email");

        // Retrieve user information from MyCustomer table
        MyCustomer customer = myCustomerFacade.findByEmail(email);

        if (customer != null) {
            // Create new Applicant
            Applicants applicant = new Applicants();
            applicant.setJobId(jobId);
            applicant.setEmail(email);
            applicant.setApplicantName(customer.getUsername());
            applicant.setGender(customer.getGender());
            applicant.setBirthdate(customer.getBirthdate());
            applicant.setApplicationDate(new Date());

            // Persist the applicant
            applicantsFacade.create(applicant);

            // Set success message
            request.setAttribute("successMessage", "Application submitted successfully!");
        } else {
            // Set error message
            request.setAttribute("errorMessage", "Unable to find customer details!");
        }

        // Forward to the same page to display the message
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
        return "Servlet for submitting job applications";
    }// </editor-fold>

}
