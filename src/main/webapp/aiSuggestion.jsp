<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>AI Budget Suggestion</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="card shadow-lg p-4 w-100" style="max-width: 500px;">

        <h3 class="text-center text-primary mb-4">
            🤖 AI-Based Budget Suggestion
        </h3>

        <div class="mb-3">
            <p class="fw-bold mb-1">Total Spent</p>
            <p class="text-danger fs-5">₹ ${totalSpent}</p>
        </div>

        <div class="mb-3">
            <p class="fw-bold mb-1">Monthly Budget</p>
            <p class="text-success fs-5">₹ ${budget}</p>
        </div>

        <hr>

        <div class="mb-4">
            <p class="fw-bold">Suggestion</p>
            <div class="alert alert-info">
                ${suggestion}
            </div>
        </div>

        <div class="text-center">
            <a href="/dashboard" class="btn btn-outline-primary w-100">
                Back to Dashboard
            </a>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
