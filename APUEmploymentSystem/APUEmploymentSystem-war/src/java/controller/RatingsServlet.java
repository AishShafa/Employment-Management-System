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
import model.Ratings;
import model.RatingsFacade;

/**
 *
 * @author aisha
 */
@WebServlet(name = "RatingsServlet", urlPatterns = {"/RatingsServlet"})
public class RatingsServlet extends HttpServlet {

    @EJB
    private RatingsFacade ratingsFacade;

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
        response.setContentType("text/html;charset=UTF-8");

    // Retrieve form parameters
    String jobId = request.getParameter("jobId");
    String companyName = request.getParameter("companyName");
    int rating = Integer.parseInt(request.getParameter("rating"));
    String comment = request.getParameter("comment");
    String employeeEmail = (String) request.getSession().getAttribute("email");

    // Create a new Ratings entity and set its attributes
    Ratings newRating = new Ratings();
    newRating.setJobId(jobId);  // Using jobId as the identifier
    newRating.setRating(rating);
    newRating.setComment(comment);
    newRating.setTowho(companyName);  // The company being rated
    newRating.setFromwho(employeeEmail);  // The employee who is rating
    newRating.setWhatdate(new Date());  // Current date

    // Save the rating using the facade
    ratingsFacade.create(newRating);

    // Redirect to index.jsp with a success message
    response.sendRedirect(request.getContextPath() + "/index.jsp?successMessage=Rating submitted successfully!");
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
