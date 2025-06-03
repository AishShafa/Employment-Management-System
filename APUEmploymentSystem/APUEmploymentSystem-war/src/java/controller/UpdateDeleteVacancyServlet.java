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
import model.Vacancy;
import model.VacancyFacade;

/**
 *
 * @author aisha
 */
@WebServlet(name = "UpdateDeleteVacancyServlet", urlPatterns = {"/UpdateDeleteVacancyServlet"})
public class UpdateDeleteVacancyServlet extends HttpServlet {

    @EJB
    private VacancyFacade vacancyFacade;

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
        String action = request.getParameter("action");
        
        String vacancyId = request.getParameter("vacancyId");  // Change to String
        
        if ("update".equals(action)) {
            // Fetch the existing vacancy from the database using vacancyId
            Vacancy vacancy = vacancyFacade.find(vacancyId);
            if (vacancy != null) {
                // Update the vacancy with the new values
                vacancy.setJobTitle(request.getParameter("jobTitle"));
                vacancy.setCompanyName(request.getParameter("companyName"));
                vacancy.setSalaryRange(request.getParameter("salaryRange"));
                vacancy.setJobType(request.getParameter("jobType"));
                vacancy.setQualification(request.getParameter("qualification"));
                vacancy.setLocation(request.getParameter("location"));
                vacancy.setExperience(request.getParameter("experience"));
                vacancy.setSector(request.getParameter("sector"));
                vacancy.setJobDescription(request.getParameter("jobDescription"));
                vacancy.setClosingDate(request.getParameter("closingDate"));

                // Persist the changes
                vacancyFacade.edit(vacancy);
            }
            response.sendRedirect("Employer/post_history.jsp?success=Vacancy%20updated%20successfully");
            System.out.println("Action: " + action);
            System.out.println("Vacancy ID: " + vacancyId);
            if (vacancy == null) {
                System.out.println("Vacancy not found for ID: " + vacancyId);
            } else {
                System.out.println("Vacancy found: " + vacancy.getJobTitle());
            }
        } else if ("delete".equals(action)) {
            // Handle deletion of the vacancy
            Vacancy vacancy = vacancyFacade.find(vacancyId);
            if (vacancy != null) {
                vacancyFacade.remove(vacancy);
                response.sendRedirect("Employer/post_history.jsp?success=Vacancy%20deleted%20successfully");
                System.out.println("Vacancy deleted: " + vacancy.getJobTitle());
            } else {
                response.sendRedirect("Employer/post_history.jsp?error=Vacancy%20not%20found");
                System.out.println("Vacancy not found for ID: " + vacancyId);
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
        return "Servlet for updating and deleting vacancies";
    }// </editor-fold>

}
