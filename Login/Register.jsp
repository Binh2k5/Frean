<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register | Feane</title>
  <link rel="shortcut icon" href="../images/favicon.png" type="image/png">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
  <link href="<%=request.getContextPath()%>/css/responsive.css" rel="stylesheet" />

  <style>
    body {
      background: url('<%=request.getContextPath()%>/images/hero-bg.jpg') center/cover no-repeat;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      backdrop-filter: brightness(0.6);
    }

    .register-container {
      background: rgba(255, 255, 255, 0.95);
      padding: 40px 50px;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      width: 100%;
      max-width: 500px;
      animation: fadeIn 0.6s ease-in-out;
    }

    .register-container h2 {
      font-weight: 700;
      color: #ff6347;
      text-align: center;
      margin-bottom: 25px;
    }

    .register-container .form-group {
      margin-bottom: 15px;
    }

    .register-container .form-control {
      border-radius: 25px;
      padding: 12px 20px;
      border: 1px solid #ccc;
      transition: all 0.3s;
    }

    .register-container .form-control:focus {
      border-color: #ff6347;
      box-shadow: 0 0 8px rgba(255,99,71,0.4);
    }

    .register-container button {
      background: #ff6347;
      color: white;
      border: none;
      width: 100%;
      padding: 12px;
      font-size: 16px;
      border-radius: 25px;
      transition: all 0.3s;
    }

    .register-container button:hover {
      background: #ff3c20;
      transform: scale(1.03);
    }

    .register-container p {
      margin-top: 15px;
      text-align: center;
      font-size: 14px;
    }

    .register-container a {
      color: #ff6347;
      font-weight: 600;
      text-decoration: none;
    }

    .register-container a:hover {
      text-decoration: underline;
    }

    .logo {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 8px;
      margin-bottom: 15px;
    }

    .logo i {
      color: #ff6347;
      font-size: 28px;
    }
    
    .error-message {
        color: #cc0000; /* Màu chữ đỏ đậm */
        font-weight: 600;
        font-size: 14px;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @media (min-width: 768px) {
      .form-row {
        display: flex;
        gap: 10px;
      }
      .form-row .form-group {
        flex: 1;
      }
    }
  </style>
</head>

<body>
  <div class="register-container">
    <div class="logo">
      <i class="fa-solid fa-utensils"></i>
      <h3 style="margin: 0;">Feane</h3>
    </div>

    <h2>Create Account</h2>

    <form action="<%=request.getContextPath()%>/Register" method="post" id="registerForm">
      <div class="form-row">
        <div class="form-group">
          <input type="text" name="txtFirstName" class="form-control" placeholder="First Name" required>
        </div>
        <div class="form-group">
          <input type="text" name="txtLastName" class="form-control" placeholder="Last Name" required>
        </div>
      </div>
       
        
      <div class="form-group">
        <input type="email" name="txtEmail" class="form-control" placeholder="Email" required>
        <c:if test="${err!=null}">
            <div class="error-message">
                ${err}
            </div>
        </c:if>
      </div>

      <div class="form-group">
        <input type="password" name="txtPassword" class="form-control" placeholder="Password" required>
      </div>

      <div class="form-group">
        <input type="password" name="txtConfirmPassword" class="form-control" placeholder="Confirm Password" required>
        <c:if test="${conErr!=null}">
            <div class="error-message">
                ${conErr}
            </div>
        </c:if>
      </div>
      
      <div class="form-group">
        <input type="text" name="txtPhone" class="form-control" placeholder="Phone (optional)">
      </div>

      <div class="form-group">
        <input type="text" name="txtAddress" class="form-control" placeholder="Address (optional)">
      </div>
        
      <div class="terms">
        <input type="checkbox" id="agree">
        <label for="agree">I agree all statements in
            <a href="terms.html" target="_blank">Terms of service</a>.
        </label>
      </div>

      <button type="submit" id="registerBtn">Register</button>
    </form>

    <p>Already have an account? <a href="<%=request.getContextPath()%>/Login">Login here</a></p>
  </div>
<script>
    const agreeCheckbox = document.getElementById("agree");
    const registerBtn = document.getElementById("registerBtn");

    // Chặn submit nếu chưa đồng ý
    document.getElementById("registerForm").addEventListener("submit", function(e) {
        if (!agreeCheckbox.checked) {
            e.preventDefault();
            alert("You must agree to the Terms of Service before registering!");
        }
    });
</script>
</body>
</html>
