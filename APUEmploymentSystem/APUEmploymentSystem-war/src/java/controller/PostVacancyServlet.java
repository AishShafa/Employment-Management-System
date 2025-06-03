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
@WebServlet(name = "PostVacancyServlet", urlPatterns = {"/PostVacancyServlet"})
public class PostVacancyServlet extends HttpServlet {

    @EJB
    private VacancyFacade vacancyFacade;

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
        String companyName = request.getParameter("companyName");
        String jobTitle = request.getParameter("jobTitle");
        String salaryRange = request.getParameter("salaryRange");
        String jobType = request.getParameter("jobType");
        String qualification = request.getParameter("qualification");
        String location = request.getParameter("location");
        String experience = request.getParameter("experience");
        String sector = request.getParameter("sector");
        String jobDescription = request.getParameter("jobDescription");
        String closingDate = request.getParameter("closingDate");
        String employerEmail = (String) request.getSession().getAttribute("email");


        // Create a new Vacancy object
        Vacancy vacancy = new Vacancy();
        vacancy.setCompanyName(companyName);
        vacancy.setJobTitle(jobTitle);
        vacancy.setSalaryRange(salaryRange);
        vacancy.setJobType(jobType);
        vacancy.setQualification(qualification);
        vacancy.setLocation(location);
        vacancy.setExperience(experience);
        vacancy.setSector(sector);
        vacancy.setJobDescription(jobDescription);
        vacancy.setClosingDate(closingDate);
        vacancy.setEmployerEmail(employerEmail);


        // Persist the vacancy object
        vacancyFacade.create(vacancy);

        // Redirect to a confirmation page or back to the dashboard
        response.sendRedirect("Employer/employer_dashboard.jsp?success=Vacancy%20posted%20successfully");
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
