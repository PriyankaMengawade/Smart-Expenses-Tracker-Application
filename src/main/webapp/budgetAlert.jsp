<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Budget Alert</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8 col-sm-12">

            <div class="card shadow rounded-4">
                <div class="card-body p-4 text-center">

                    <h2 class="text-primary mb-4">💰 Budget Alert</h2>

                    <div class="mb-3">
                        <p class="fs-5">
                            <b>Monthly Budget:</b>
                            <span class="text-success">₹ ${budget}</span>
                        </p>

                        <p class="fs-5">
                            <b>Spent This Month:</b>
                            <span class="text-danger">₹ ${totalSpent}</span>
                        </p>
                    </div>

                    <!-- ALERT MESSAGE -->
                    <c:if test="${alert}">
                        <div class="alert alert-danger fw-semibold">
                            ⚠ Warning: You have exceeded 80% of your budget!
                        </div>
                    </c:if>

                    <c:if test="${!alert}">
                        <div class="alert alert-success fw-semibold">
                            ✅ You are within budget 👍
                        </div>
                    </c:if>

                    <a href="/dashboard" class="btn btn-outline-primary px-4 mt-3">
                        Back
                    </a>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
