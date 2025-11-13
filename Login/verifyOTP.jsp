<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP | Feane</title>
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
        
        .verify-container {
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
        
        .verify-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        
        .verify-header i {
            font-size: 50px;
            margin-bottom: 15px;
        }
        
        .verify-header h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }
        
        .verify-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
            font-size: 14px;
        }
        
        .verify-body {
            padding: 40px 30px;
        }
        
        .otp-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 30px 0;
        }
        
        .otp-input {
            width: 50px;
            height: 55px;
            text-align: center;
            font-size: 24px;
            font-weight: 600;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            transition: all 0.3s;
        }
        
        .otp-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            outline: none;
        }
        
        .btn-verify {
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
        
        .btn-verify:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .resend-section {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .resend-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            cursor: pointer;
        }
        
        .resend-link:hover {
            color: #764ba2;
        }
        
        .resend-link.disabled {
            color: #ccc;
            pointer-events: none;
        }
        
        .timer {
            font-weight: 600;
            color: #667eea;
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
        
        .back-to-login {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
        }
        
        .back-to-login a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-to-login a:hover {
            color: #764ba2;
        }
    </style>
</head>
<body>
    <div class="verify-container">
        <div class="verify-header">
            <i class="fas fa-key"></i>
            <h2>Verify OTP</h2>
            <p>Enter the 6-digit code sent to <strong>${email}</strong></p>
        </div>
        
        <div class="verify-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <form action="<%=request.getContextPath()%>/VerifyOTP" method="post" id="verifyForm">
                <input type="hidden" name="email" value="${email}">
                
                <div class="otp-container">
                    <input type="text" class="otp-input" maxlength="1" name="otp1" required>
                    <input type="text" class="otp-input" maxlength="1" name="otp2" required>
                    <input type="text" class="otp-input" maxlength="1" name="otp3" required>
                    <input type="text" class="otp-input" maxlength="1" name="otp4" required>
                    <input type="text" class="otp-input" maxlength="1" name="otp5" required>
                    <input type="text" class="otp-input" maxlength="1" name="otp6" required>
                </div>
                
                <button type="submit" class="btn-verify">
                    <i class="fas fa-check-circle"></i> Verify Code
                </button>
            </form>
            
            <div class="resend-section">
                <p>Didn't receive the code?</p>
                <a href="#" class="resend-link disabled" id="resendLink">
                    Resend Code <span class="timer" id="timer">(60s)</span>
                </a>
            </div>
            
            <div class="back-to-login">
                <i class="fas fa-arrow-left"></i>
                <a href="<%=request.getContextPath()%>/Login">Back to Login</a>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        $(document).ready(function() {
            var otpInputs = $('.otp-input');
            
            // Auto focus next input
            otpInputs.on('input', function() {
                var current = $(this);
                var value = current.val();
                
                if (value.length === 1) {
                    var next = current.next('.otp-input');
                    if (next.length) {
                        next.focus();
                    }
                }
            });
            
            // Backspace handling
            otpInputs.on('keydown', function(e) {
                if (e.keyCode === 8 && $(this).val() === '') {
                    var prev = $(this).prev('.otp-input');
                    if (prev.length) {
                        prev.focus();
                    }
                }
            });
            
            // Only allow numbers
            otpInputs.on('keypress', function(e) {
                var charCode = (e.which) ? e.which : e.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    e.preventDefault();
                }
            });
            
            // Paste handling
            otpInputs.first().on('paste', function(e) {
                e.preventDefault();
                var pastedData = e.originalEvent.clipboardData.getData('text');
                var digits = pastedData.match(/\d/g);
                
                if (digits) {
                    otpInputs.each(function(index) {
                        if (digits[index]) {
                            $(this).val(digits[index]);
                        }
                    });
                    otpInputs.last().focus();
                }
            });
            
            // Resend timer
            var timeLeft = 60;
            var timer = setInterval(function() {
                timeLeft--;
                $('#timer').text('(' + timeLeft + 's)');
                
                if (timeLeft <= 0) {
                    clearInterval(timer);
                    $('#resendLink').removeClass('disabled');
                    $('#timer').hide();
                }
            }, 1000);
            
            // Resend OTP
            $('#resendLink').click(function(e) {
                e.preventDefault();
                if (!$(this).hasClass('disabled')) {
                    $.post('<%=request.getContextPath()%>/ForgotPassword', 
                        { email: '${email}' },
                        function(data) {
                            alert('New code sent to your email!');
                            // Restart timer
                            timeLeft = 60;
                            $('#resendLink').addClass('disabled');
                            $('#timer').show().text('(60s)');
                            timer = setInterval(function() {
                                timeLeft--;
                                $('#timer').text('(' + timeLeft + 's)');
                                if (timeLeft <= 0) {
                                    clearInterval(timer);
                                    $('#resendLink').removeClass('disabled');
                                    $('#timer').hide();
                                }
                            }, 1000);
                        }
                    );
                }
            });
            
            // Auto dismiss alerts
            setTimeout(function() {
                $('.alert').fadeOut();
            }, 5000);
        });
    </script>
</body>
</html>