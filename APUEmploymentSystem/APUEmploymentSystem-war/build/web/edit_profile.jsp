<%-- 
    Document   : edit_profile
    Author     : aisha
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.MyCustomer"%>
<%@page import="model.MyCustomerFacade"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingException"%>

<%
    // Initialize variables
    MyCustomerFacade myCustomerFacade = null;
    String successMessage = "";
    String errorMessage = "";
    String currentUserEmail = (String) session.getAttribute("email");

    try {
        Context context = new InitialContext();
        myCustomerFacade = (MyCustomerFacade) context.lookup("java:global/APUEmploymentSystem/APUEmploymentSystem-ejb/MyCustomerFacade!model.MyCustomerFacade");
    } catch (NamingException e) {
        e.printStackTrace();
    }

    // Load the current user's profile information
    MyCustomer currentUser = null;
    if (myCustomerFacade != null && currentUserEmail != null) {
        currentUser = myCustomerFacade.find(currentUserEmail);
    }

    // Handle profile update
    String action = request.getParameter("action");
    if ("update".equals(action) && currentUser != null) {
        String updatedUsername = request.getParameter("username");
        String updatedGender = request.getParameter("gender");
        String updatedBirthdateStr = request.getParameter("birthdate");
        String updatedPassword = request.getParameter("password");

        try {
            // Parse the birthdate string to Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date updatedBirthdate = sdf.parse(updatedBirthdateStr);

            // Update user information
            currentUser.setUsername(updatedUsername);
            currentUser.setGender(updatedGender);
            currentUser.setBirthdate(new java.sql.Date(updatedBirthdate.getTime()));

            if (updatedPassword != null && !updatedPassword.isEmpty()) {
                currentUser.setPassword(updatedPassword);
            }

            myCustomerFacade.edit(currentUser);
            successMessage = "Profile updated successfully!";
        } catch (Exception e) {
            errorMessage = "Failed to update profile. Please try again.";
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Account Profile</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <br>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h2>Edit Profile</h2>

        <%-- Display success or error messages --%>
        <% if (!successMessage.isEmpty()) { %>
            <div class="alert alert-success" role="alert">
                <%= successMessage %>
            </div>
        <% } else if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage %>
            </div>
        <% } %>

        <%-- Profile Form --%>
        <form method="POST" action="edit_profile.jsp">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" class="form-control" name="username" id="username" value="<%= currentUser != null ? currentUser.getUsername() : "" %>" required>
            </div>

            <div class="form-group">
                <label for="gender">Gender:</label>
                <select class="form-control" name="gender" id="gender">
                    <option value="Male" <%= currentUser != null && "Male".equals(currentUser.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= currentUser != null && "Female".equals(currentUser.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= currentUser != null && "Other".equals(currentUser.getGender()) ? "selected" : "" %>>Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="birthdate">Birthdate:</label>
                <%
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String birthdate = currentUser != null && currentUser.getBirthdate() != null ? sdf.format(currentUser.getBirthdate()) : "";
                %>
                <input type="date" class="form-control" name="birthdate" id="birthdate" value="<%= birthdate %>" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="Enter new password (optional)">
                <small class="form-text text-muted">Leave blank if you don't want to change your password.</small>
            </div>

            <button type="submit" class="btn btn-primary" name="action" value="update">Update Profile</button>
        </form>
    </div>

</body>
</html>