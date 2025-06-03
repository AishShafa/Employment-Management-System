<%-- 
    Document   : header
    Author     : aisha
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%
    // Check if the logout parameter is set in the URL
    if (request.getParameter("logout") != null) {
        // Invalidate the session
        session.invalidate();
        // Redirect to the login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String homeHref = request.getContextPath() + "/login.jsp";
    String role = null;

    // Check if the user is logged in and determine their role
    if (session != null && session.getAttribute("email") != null) {
        role = (String) session.getAttribute("role"); // Assuming 'role' is stored in session
        if ("Admin".equalsIgnoreCase(role)) {
            homeHref = request.getContextPath() + "/Admin/admin_dashboard.jsp";
        } else if ("Employee".equalsIgnoreCase(role)) {
            homeHref = request.getContextPath() + "/Employee/employee_dashboard.jsp";
        } else if ("Employer".equalsIgnoreCase(role)) {
            homeHref = request.getContextPath() + "/Employer/employer_dashboard.jsp";
        }
    }
%>
<!DOCTYPE html>
<div class="main-header">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/Images/logo.png" alt="APU Employment System Logo">
    </div>
    <nav class="main-nav">
        <a href="<%= homeHref %>">Home</a>
        <a href="${pageContext.request.contextPath}/index.jsp">Jobs</a>
        <a href="${pageContext.request.contextPath}/companies.jsp">Companies</a>

        <%
            // Show Logout link only if session is valid
            if (session != null && session.getAttribute("email") != null) {
        %>
            <a href="?logout=true">Logout</a>
        <%
            }
        %>
    </nav>
</div>