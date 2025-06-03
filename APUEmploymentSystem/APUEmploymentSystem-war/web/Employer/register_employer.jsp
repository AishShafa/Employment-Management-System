<%-- 
    Document   : register_employer
    Author     : aisha
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employer Registration Page</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
        <%@ include file="../includes.jsp" %> <!-- Include external stylesheets and scripts -->
    </head>
    <body>
        <%@ include file="../header.jsp" %> <!-- Include the header -->
        <br><br><br><br><br><br><br>
        <div class="employer-link" > <a href="../Admin/register_admin.jsp">Are you an Admin?</a></div>
        <br>
    <div class="form-container">
        
        <h2 class="text-center">Employer Sign up</h2>
        <p class="text-center">Fill in the following details below</p>
        <form action="${pageContext.request.contextPath}/Register" method="POST">
            <input type="hidden" name="role" value="Employer">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="gender">Gender</label>
                <input type="text" class="form-control" id="gender" name="gender" required>
            </div>
            <div class="form-group">
                <label for="birthdate">Birthdate</label>
                <input type="date" class="form-control" id="birthdate" name="birthdate" required>
            </div>
            <div class="form-group">
                <label for="email">Company Email address</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <%-- 
            <div class="form-group"> 
                <label for="resume">Resumé (PDF only)</label>
                <input type="file" class="form-control" id="resume" name="resume" accept="application/pdf" required>
            </div>
            --%>
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="privacyPolicy" required>
                <label class="form-check-label" for="privacyPolicy">By registering, I agree to the Privacy Policy and consent to the collection, storage, and use of my personal data as described in that policy.</label>
            </div> 
            
            <button type="submit" value="Register" class="btn btn-primary btn-block">Sign up</button>
            <button type="reset" class="btn btn-primary btn-block">Reset</button>
            <div class="text-center">
                <p>Already have an account? <a href="../login.jsp">Login</a></p>
            </div>
        </form>
    </div>
            <footer class="text-center mt-5">
        <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
    </footer>
    </body>
</html>