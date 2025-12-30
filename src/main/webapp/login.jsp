<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <!-- Required for mobile responsiveness -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="background: url('https://thumbs.dreamstime.com/b/stacks-coins-rising-financial-graph-backgroundcoin-euro-background-percentage-symbol-showing-idea-interest-rates-value-401125121.jpg') no-repeat center center fixed; background-size: cover;">


<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-11 col-sm-9 col-md-6 col-lg-4">

            <div class="card shadow-lg border-0 rounded-4 p-4">

                <h3 class="text-center mb-4 fw-bold text-primary">
                    Login
                </h3>

                <form action="loginUser" method="post">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <input type="email" name="email"
                               class="form-control form-control-lg"
                               placeholder="Enter email"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Password</label>
                        <input type="password" name="password"
                               class="form-control form-control-lg"
                               placeholder="Enter password"
                               required>
                    </div>

                    <button type="submit"
                            class="btn btn-primary btn-lg w-100">
                        Login
                    </button>
                </form>

                <p class="text-danger text-center mt-3 fw-semibold">
                    ${msg}
                </p>

                <div class="text-center mt-3">
                    <a href="register" class="text-decoration-none fw-semibold">
                        New User? Register
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
