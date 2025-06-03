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
import model.MyCustomerFacade;
import model.MyCustomer;
import model.NotificationsFacade;
import model.Notifications;


/**
 *
 * @author aisha
 */
@WebServlet(name = "SendWarningServlet", urlPatterns = {"/SendWarningServlet"})
public class SendWarningServlet extends HttpServlet {

    @EJB
    private MyCustomerFacade myCustomerFacade;

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
        String employeeEmail = request.getParameter("employeeEmail");
        String feedbackMessage = request.getParameter("feedbackMessage");

        try {
            // Create a new notification
            Notifications notification = new Notifications();
            notification.setTowho(employeeEmail);
            notification.setFromwho("Admin");
            notification.setWhatdate(new Date());
            notification.setMessage("Warning: " + feedbackMessage);

            // Save the notification using the facade
            notificationsFacade.create(notification);

            long warningCount = notificationsFacade.countWarningsForEmployee(employeeEmail);

            if (warningCount >= 3) {
                // Delete the employee's account
                MyCustomer employee = myCustomerFacade.findByEmail(employeeEmail);
                if (employee != null) {
                    myCustomerFacade.remove(employee);
                    request.setAttribute("successMessage", "Warning sent successfully! Employee account deleted after 3 warnings.");
                } else {
                    request.setAttribute("errorMessage", "Error: Employee not found.");
                }
            } else {
                request.setAttribute("successMessage", "Warning sent successfully!");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred while sending the warning. Please try again.");
        }

        request.getRequestDispatcher("/AdminFeedbackServlet").forward(request, response);
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
