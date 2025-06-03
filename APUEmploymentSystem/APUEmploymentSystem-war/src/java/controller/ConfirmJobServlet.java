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
import model.Notifications;
import model.NotificationsFacade;

/**
 *
 * @author aisha
 */
@WebServlet(name = "ConfirmJobServlet", urlPatterns = {"/ConfirmJobServlet"})
public class ConfirmJobServlet extends HttpServlet {

    @EJB
    private NotificationsFacade notificationsFacade;

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
        String email = request.getParameter("email");

        // Create a notification for the confirmed applicant
        Notifications notification = new Notifications();
        notification.setMessage("Congratulations! You have been offered the job. You will receive an email with further details.");
        notification.setFromwho("Employer");
        notification.setTowho(email); // Set the applicant's email in the 'towho' column
        notification.setWhatdate(new Date());

        try {
            notificationsFacade.create(notification);
            request.setAttribute("successMessage", "Notification sent to " + email);
        } catch (Exception e) {
            e.printStackTrace(); // Log any exception
            request.setAttribute("errorMessage", "Failed to send notification to " + email);
        }

        // Forward back to the applicants list JSP
        request.getRequestDispatcher("applicants_list.jsp").forward(request, response);
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
