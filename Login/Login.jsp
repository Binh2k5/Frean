<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | Feane</title>
  <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.png" type="image/png">
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

    .login-container {
      background: rgba(255, 255, 255, 0.95);
      padding: 40px 50px;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      width: 100%;
      max-width: 400px;
      text-align: center;
      animation: fadeIn 0.6s ease-in-out;
    }

    .login-container h2 {
      font-weight: 700;
      color: #ff6347;
      margin-bottom: 25px;
    }

    .login-container .form-control {
      border-radius: 25px;
      padding: 12px 20px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      transition: all 0.3s;
    }

    .login-container .form-control:focus {
      border-color: #ff6347;
      box-shadow: 0 0 8px rgba(255,99,71,0.4);
    }

    .login-container button {
      background: #ff6347;
      color: white;
      border: none;
      width: 100%;
      padding: 12px;
      font-size: 16px;
      border-radius: 25px;
      transition: all 0.3s;
    }

    .login-container button:hover {
      background: #ff3c20;
      transform: scale(1.03);
    }

    .login-container p {
      margin-top: 15px;
      font-size: 14px;
    }

    .login-container a {
      color: #ff6347;
      font-weight: 600;
      text-decoration: none;
    }

    .login-container a:hover {
      text-decoration: underline;
    }

    .logo {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 8px;
      margin-bottom: 20px;
    }

    .logo i {
      color: #ff6347;
      font-size: 28px;
    }
    
    .error-message {
        background-color: #ffe0e0; /* Màu nền đỏ nhạt */
        color: #cc0000; /* Màu chữ đỏ đậm */
        padding: 10px 15px;
        margin-bottom: 15px;
        border: 1px solid #cc0000;
        border-radius: 5px; 
        font-weight: 600;
        font-size: 14px;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>

<body>
  <div class="login-container">
    <div class="logo">
      <i class="fa-solid fa-utensils"></i>
      <h3 style="margin: 0;">Feane</h3>
    </div>

    <h2>Welcome Back!</h2>

    
    <c:if test="${err != null}">
        <div class="error-message">
            ${err} 
        </div>
    </c:if>
    <form action="<%=request.getContextPath()%>/Login" method="post">
      <input type="email" name="txtEmail" class="form-control" placeholder="Email" required>
      <input type="password" name="txtPassword" class="form-control" placeholder="Password" required>
      <button type="submit">Login</button>
    </form>
    
    <p>Don’t have an account? <a href="<%=request.getContextPath()%>/Register">Register here</a></p>
    <p><a href="<%=request.getContextPath()%>/ForgotPassword">Forgot your password?</a></p>
  </div>
</body>
</html>