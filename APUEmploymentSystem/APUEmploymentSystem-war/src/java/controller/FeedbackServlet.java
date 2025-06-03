/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Feedback;
import model.FeedbackFacade;

/**
 *
 * @author aisha
 */
@WebServlet(name = "FeedbackServlet", urlPatterns = {"/FeedbackServlet"})
public class FeedbackServlet extends HttpServlet {

    @EJB
    private FeedbackFacade feedbackFacade;

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
        String employerEmail = (String) request.getSession().getAttribute("email");
        String aboutEmployee = request.getParameter("aboutEmployee");
        String feedbackType = request.getParameter("feedbackType");
        String message = request.getParameter("message");

        if (aboutEmployee != null && feedbackType != null && message != null) {
            try {
                // Create a new Feedback entity
                Feedback feedback = new Feedback();
                feedback.setFromEmployer(employerEmail);  // Set the logged-in user's email
                feedback.setAboutEmployee(aboutEmployee);
                feedback.setFeedbackDate(new Date());
                feedback.setFeedbackType(feedbackType);
                feedback.setMessage(message);
                feedback.setStatus("Pending");

                // Save the feedback using the facade
                feedbackFacade.create(feedback);

                request.setAttribute("successMessage", "Feedback submitted successfully!");
            } catch (Exception e) {
                request.setAttribute("errorMessage", "An error occurred while submitting the feedback. Please try again.");
            }
        }

        request.getRequestDispatcher("/Employer/feedback_complaints.jsp").forward(request, response);
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
