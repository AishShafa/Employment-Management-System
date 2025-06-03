<%-- 
    Document   : employee_dashboard
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jobseeker Dashboard</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <%@ include file="../header.jsp" %>

        <div class="container">
            <div class="col-md-12">
                <h2>Jobseeker Dashboard</h2>
                <hr>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Manage Profile</h5>
                            <p class="card-text">Edit your profile.</p>
                            <a href="${pageContext.request.contextPath}/edit_profile.jsp" class="btn btn-primary">Go to Profile</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">View Application History</h5>
                            <p class="card-text">Check the history of your job applications.</p>
                            <a href="${pageContext.request.contextPath}/Employee/application_history.jsp" class="btn btn-primary">Go to Application History</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">View Notifications</h5>
                            <p class="card-text">See all of your notifications here.</p>
                            <a href="${pageContext.request.contextPath}/Employee/view_notifications.jsp" class="btn btn-primary">Go to Notifications</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="text-center mt-5">
            <p>&copy; 2024 Asia Pacific University of Technology & Innovation (APU). All rights reserved.</p>
        </footer>
    </body>
</html>