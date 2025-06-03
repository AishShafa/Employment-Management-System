<%-- 
    Document   : login
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
     <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
        <%@ include file="header.jsp" %> <!-- Include the header -->
        
     </head>
    <body>
        <br>
        <%@ include file="includes.jsp" %>
    <div class="form-container">
        <h2 class="text-center">Sign in</h2>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="alert alert-danger" role="alert">
                <%= errorMessage %>
            </div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/Login" method="POST">
            <div class="form-group">
                <label for="email">Email address</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="captcha">
                <label class="form-check-label" for="captcha">I'm not a robot</label>
            </div>
            <button type="submit" value="Login" class="btn btn-primary btn-block">Sign in</button>
            <button type="reset" value="Reset" class="btn btn-primary btn-block">Reset</button>
            <div class="text-right">
                <a href="#" class="small">Forgot password?</a>
            </div>
        </form>
        <div class="register-link">
            Don’t have an account? <a href="Employee/register_employee.jsp">Register</a>
        </div>
    </div>
                <footer class="text-center mt-5">
        <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
    </footer>
</body>
    
</html>

