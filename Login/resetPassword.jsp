<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Feane</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .reset-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 450px;
            width: 90%;
            animation: slideUp 0.5s ease;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .reset-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        
        .reset-header i {
            font-size: 50px;
            margin-bottom: 15px;
        }
        
        .reset-header h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }
        
        .reset-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
            font-size: 14px;
        }
        
        .reset-body {
            padding: 40px 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            z-index: 10;
        }
        
        .input-group .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #999;
            z-index: 10;
        }
        
        .input-group .toggle-password:hover {
            color: #667eea;
        }
        
        .form-control {
            padding: 12px 45px 12px 45px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            transition: all 0.3s;
            font-size: 15px;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .password-strength {
            margin-top: 10px;
            height: 4px;
            background: #e0e0e0;
            border-radius: 2px;
            overflow: hidden;
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s;
        }
        
        .strength-weak { background: #dc3545; width: 33%; }
        .strength-medium { background: #ffc107; width: 66%; }
        .strength-strong { background: #28a745; width: 100%; }
        
        .password-requirements {
            margin-top: 15px;
            font-size: 13px;
            color: #666;
        }
        
        .requirement {
            padding: 5px 0;
        }
        
        .requirement i {
            margin-right: 8px;
            color: #ccc;
        }
        
        .requirement.met i {
            color: #28a745;
        }
        
        .btn-reset {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .btn-reset:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }
        
        .alert {
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            border: none;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
        }
        
        .alert-danger {
            background: #f8d7da;
            color: #721c24;
        }
        
        .alert i {
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <div class="reset-header">
            <i class="fas fa-shield-alt"></i>
            <h2>Reset Password</h2>
            <p>Create a new strong password for your account</p>
        </div>
        
        <div class="reset-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <form action="<%=request.getContextPath()%>/ResetPassword" method="post" id="resetForm">
                <input type="hidden" name="email" value="${email}">
                
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" class="form-control" id="newPassword" 
                               name="newPassword" placeholder="Enter new password" required>
                        <i class="fas fa-eye toggle-password" data-target="newPassword"></i>
                    </div>
                    <div class="password-strength">
                        <div class="password-strength-bar" id="strengthBar"></div>
                    </div>
                    <div class="password-requirements">
                        <div class="requirement" id="req-length">
                            <i class="fas fa-circle"></i>
                            At least 8 characters
                        </div>
                        <div class="requirement" id="req-upper">
                            <i class="fas fa-circle"></i>
                            One uppercase letter
                        </div>
                        <div class="requirement" id="req-lower">
                            <i class="fas fa-circle"></i>
                            One lowercase letter
                        </div>
                        <div class="requirement" id="req-number">
                            <i class="fas fa-circle"></i>
                            One number
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" class="form-control" id="confirmPassword" 
                               name="confirmPassword" placeholder="Confirm new password" required>
                        <i class="fas fa-eye toggle-password" data-target="confirmPassword"></i>
                    </div>
                    <small id="matchMessage" style="display: none; margin-top: 5px;"></small>
                </div>
                
                <button type="submit" class="btn-reset" id="submitBtn" disabled>
                    <i class="fas fa-check"></i> Reset Password
                </button>
            </form>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        $(document).ready(function() {
            var requirements = {
                length: false,
                upper: false,
                lower: false,
                number: false
            };
            
            // Toggle password visibility
            $('.toggle-password').click(function() {
                var target = $(this).data('target');
                var input = $('#' + target);
                var icon = $(this);
                
                if (input.attr('type') === 'password') {
                    input.attr('type', 'text');
                    icon.removeClass('fa-eye').addClass('fa-eye-slash');
                } else {
                    input.attr('type', 'password');
                    icon.removeClass('fa-eye-slash').addClass('fa-eye');
                }
            });
            
            // Check password strength
            $('#newPassword').on('input', function() {
                var password = $(this).val();
                var strength = 0;
                
                // Check length
                if (password.length >= 8) {
                    requirements.length = true;
                    $('#req-length').addClass('met');
                    strength++;
                } else {
                    requirements.length = false;
                    $('#req-length').removeClass('met');
                }
                
                // Check uppercase
                if (/[A-Z]/.test(password)) {
                    requirements.upper = true;
                    $('#req-upper').addClass('met');
                    strength++;
                } else {
                    requirements.upper = false;
                    $('#req-upper').removeClass('met');
                }
                
                // Check lowercase
                if (/[a-z]/.test(password)) {
                    requirements.lower = true;
                    $('#req-lower').addClass('met');
                    strength++;
                } else {
                    requirements.lower = false;
                    $('#req-lower').removeClass('met');
                }
                
                // Check number
                if (/[0-9]/.test(password)) {
                    requirements.number = true;
                    $('#req-number').addClass('met');
                    strength++;
                } else {
                    requirements.number = false;
                    $('#req-number').removeClass('met');
                }
                
                // Update strength bar
                var strengthBar = $('#strengthBar');
                strengthBar.removeClass('strength-weak strength-medium strength-strong');
                
                if (strength <= 2) {
                    strengthBar.addClass('strength-weak');
                } else if (strength === 3) {
                    strengthBar.addClass('strength-medium');
                } else if (strength === 4) {
                    strengthBar.addClass('strength-strong');
                }
                
                checkForm();
            });
            
            // Check confirm password
            $('#confirmPassword').on('input', function() {
                checkForm();
            });
            
            function checkForm() {
                var newPass = $('#newPassword').val();
                var confirmPass = $('#confirmPassword').val();
                var matchMsg = $('#matchMessage');
                
                var allRequirementsMet = requirements.length && 
                                        requirements.upper && 
                                        requirements.lower && 
                                        requirements.number;
                
                if (confirmPass.length > 0) {
                    if (newPass === confirmPass) {
                        matchMsg.text('Passwords match').css('color', '#28a745').show();
                    } else {
                        matchMsg.text('Passwords do not match').css('color', '#dc3545').show();
                    }
                } else {
                    matchMsg.hide();
                }
                
                if (allRequirementsMet && newPass === confirmPass && newPass.length > 0) {
                    $('#submitBtn').prop('disabled', false);
                } else {
                    $('#submitBtn').prop('disabled', true);
                }
            }
            
            // Auto dismiss alerts
            setTimeout(function() {
                $('.alert').fadeOut();
            }, 5000);
        });
    </script>
</body>
</html>