<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

    <!-- Mobile Responsive -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container-fluid px-3 px-md-5 mt-4">

    <!-- Header -->
    <div class="card shadow-sm mb-4">
        <div class="card-body d-flex flex-column flex-md-row
                    justify-content-between align-items-center gap-2">

            <h3 class="text-primary mb-0">
                Welcome, <span class="fw-bold">${user.name}</span>
            </h3>

            <a href="logout" class="btn btn-outline-danger btn-sm">
                Logout
            </a>
        </div>
    </div>

    <!-- Navigation Buttons -->
    <div class="row g-2 mb-4">
        <div class="col-6 col-md-auto">
            <a href="addExpense" class="btn btn-success w-100">Add Expense</a>
        </div>
        <div class="col-6 col-md-auto">
            <a href="monthly-report" class="btn btn-primary w-100">Monthly Report</a>
        </div>
        <div class="col-6 col-md-auto">
            <a href="aiSuggestion" class="btn btn-warning w-100">AI Suggestion</a>
        </div>
        <div class="col-6 col-md-auto">
            <a href="checkBudget" class="btn btn-info text-white w-100">Budget Alert</a>
        </div>
        <div class="col-12 col-md-auto">
            <a href="${pageContext.request.contextPath}/downloadPDF"
               class="btn btn-dark w-100">
                Download PDF
            </a>
        </div>
    </div>

    <!-- Total Expense -->
    <div class="card shadow-sm mb-4 text-center">
        <div class="card-body">
            <h4 class="mb-0">
                Total Expense :
                <span class="text-danger fw-bold">₹ ${total}</span>
            </h4>
        </div>
    </div>

    <!-- Expense Table -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3">Expense List</h5>

            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>Category</th>
                            <th>Amount</th>
                            <th>Note</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="e">
                            <tr>
                                <td>${e.category}</td>
                                <td class="fw-semibold">₹ ${e.amount}</td>
                                <td>${e.note}</td>
                                <td>${e.date}</td>
                                <td>
                                    <a href="editExpense/${e.id}"
                                       class="btn btn-sm btn-warning me-1">
                                        Edit
                                    </a>
                                    <a href="deleteExpense/${e.id}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Are you sure?')">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Set Budget -->
    <div class="card shadow-sm mb-5">
        <div class="card-body">
            <h5 class="card-title mb-3">Set Monthly Budget</h5>

            <form action="setBudget" method="post" class="row g-3">
                <div class="col-12 col-md-6">
                    <input type="number"
                           name="budget"
                           class="form-control form-control-lg"
                           placeholder="Enter Budget"
                           required>
                </div>
                <div class="col-12 col-md-3">
                    <button type="submit"
                            class="btn btn-primary btn-lg w-100">
                        Set Budget
                    </button>
                </div>
            </form>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
