<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Expense</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card shadow p-4 w-100" style="max-width: 450px;">

        <h3 class="text-center mb-4 text-primary">Add New Expense</h3>

        <form action="${pageContext.request.contextPath}/saveExpense" method="post">
        
       
        

      <div class="mb-3">
    <label class="form-label">Category</label>
    <select name="category" class="form-select" required>
        <option value="">-- Select Category --</option>
        <option value="Food">Food</option>
        <option value="Travel">Travel</option>
        <option value="Shopping">Shopping</option>
        <option value="Rent">Rent</option>
        <option value="Bills">Bills</option>
        <option value="Entertainment">Entertainment</option>
        <option value="Medical">Medical</option>
        <option value="Education">Education</option>
        <option value="Other">Other</option>
    </select>
</div> 


            <div class="mb-3">
                <label class="form-label">Amount</label>
                <input type="number" name="amount" step="0.01" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <!-- ⭐ IMPORTANT FIX HERE -->
                <input type="text" name="description" class="form-control">
            </div>

            <button type="submit" class="btn btn-success w-100">Save Expense</button>
        </form>

        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>
        </div>

    </div>
</div>

</body>
</html>
