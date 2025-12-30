<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Monthly Expense Report</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">

            <div class="card shadow-lg rounded-4">
                <div class="card-body p-4">

                    <h3 class="text-center text-primary mb-4">
                        Monthly Expense Report (${month})
                    </h3>

                    <!-- ================= DATE-WISE PDF ================= -->
                    <form action="/expenses/export-pdf-date" method="get"
                          class="row g-2 mb-3">

                        <div class="col-md-4 col-12">
                            <input type="date" name="from"
                                   class="form-control" required>
                        </div>

                        <div class="col-md-4 col-12">
                            <input type="date" name="to"
                                   class="form-control" required>
                        </div>

                        <div class="col-md-4 col-12">
                            <button class="btn btn-primary w-100">
                                Download Date-wise PDF
                            </button>
                        </div>
                    </form>

                    <!-- ================= MONTH-WISE PDF ================= -->
                    <form action="/expenses/export-pdf-month" method="get"
                          class="row g-2 mb-4">

                        <div class="col-md-8 col-12">
                            <input type="month" name="month"
                                   class="form-control" required>
                        </div>

                        <div class="col-md-4 col-12">
                            <button class="btn btn-primary w-100">
                                Download Monthly PDF
                            </button>
                        </div>
                    </form>

                    <!-- ================= EXPENSE TABLE ================= -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead class="table-primary">
                                <tr>
                                    <th>Date</th>
                                    <th>Category</th>
                                    <th>Amount (₹)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="e" items="${expenses}">
                                    <tr>
                                        <td>${e.date}</td>
                                        <td>${e.category}</td>
                                        <td class="fw-semibold">₹ ${e.amount}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- ================= TOTAL ================= -->
                    <div class="text-end mt-3">
                        <h5 class="fw-bold text-success">
                            Total Expense: ₹ ${total}
                        </h5>
                    </div>

                    <!-- ================= ACTION BUTTONS ================= -->
                    <div class="d-flex justify-content-between mt-4">
                        <a href="/dashboard" class="btn btn-outline-secondary px-4">
                            Back
                        </a>

                        <a href="/expenses/export-pdf" class="btn btn-primary px-4">
                            Download All PDF
                        </a>
                    </div>

                </div>
            </div>

        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
