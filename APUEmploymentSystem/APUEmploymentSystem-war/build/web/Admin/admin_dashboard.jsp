<%-- 
    Document   : admin_dashboard
    Author     : aisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <%@ include file="../header.jsp" %>

        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>Admin Dashboard</h2>
                    <hr>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Edit Admin Profile</h5>
                            <p class="card-text">Edit and Update your Admin information.</p>
                            <a href="${pageContext.request.contextPath}/edit_profile.jsp" class="btn btn-primary">Go to Admin Profile</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Manage All Accounts</h5>
                            <p class="card-text">Approve, delete, search, and update account information.</p>
                            <a href="${pageContext.request.contextPath}/Admin/manage_corporate.jsp" class="btn btn-primary">Go to Manage Customers</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Feedback Management</h5>
                            <p class="card-text">Receive feedback from corporate customers and send warnings to jobseekers.</p>
                            <a href="${pageContext.request.contextPath}/Admin/admin_feedback_management.jsp" class="btn btn-primary">Go to Notifications</a>
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