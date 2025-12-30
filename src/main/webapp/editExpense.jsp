<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Expense</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8 col-sm-12">

            <div class="card shadow-lg rounded-4">
                <div class="card-body p-4">

                    <h3 class="text-center text-primary mb-4">Edit Expense</h3>

                    <form action="${pageContext.request.contextPath}/updateExpense" method="post">

                        <!-- ID -->
                        <input type="hidden" name="id" value="${exp.id}">

                        <!-- Category -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Category</label>
                            <select name="category" class="form-select" required>
                                <option value="Food" ${exp.category=='Food' ? 'selected' : ''}>Food</option>
                                <option value="Travel" ${exp.category=='Travel' ? 'selected' : ''}>Travel</option>
                                <option value="Shopping" ${exp.category=='Shopping' ? 'selected' : ''}>Shopping</option>
                                <option value="Rent" ${exp.category=='Rent' ? 'selected' : ''}>Rent</option>
                                <option value="Bills" ${exp.category=='Bills' ? 'selected' : ''}>Bills</option>
                                <option value="Entertainment" ${exp.category=='Entertainment' ? 'selected' : ''}>Entertainment</option>
                                <option value="Medical" ${exp.category=='Medical' ? 'selected' : ''}>Medical</option>
                                <option value="Education" ${exp.category=='Education' ? 'selected' : ''}>Education</option>
                                <option value="Other" ${exp.category=='Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>

                        <!-- Amount -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Amount</label>
                            <input type="number" step="0.01" name="amount"
                                   value="${exp.amount}" class="form-control" required>
                        </div>

                        <!-- Note -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Note</label>
                            <input type="text" name="description"
                                   value="${exp.note}" class="form-control">
                        </div>

                        <!-- Buttons -->
                        <div class="d-flex justify-content-between mt-4">
                            <a href="${pageContext.request.contextPath}/dashboard"
                               class="btn btn-outline-secondary px-4">
                                Back
                            </a>

                            <button type="submit" class="btn btn-primary px-4">
                                Update
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
