<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <style type="text/css">
        html{height:100%;}
        body{height:100%; background:url(${pageContext.request.contextPath}/resources/images/bg.jpg) no-repeat;
            background-size:100% 100%;}
        h3{font-family:"微软雅黑"; margin:0 0 25px; text-align:center;}
        .login{margin:190px auto 0; padding:20px 20px 5px; width:460px; background-color:#fff;
            background:rgba(255,255,255,0.6);}
    </style>
</head>
<body>
    <div class="container">
    	<div class="login">
    	    <h3>hotel management</h3>
    		<form id="login_form" class="form-horizontal" style="">
    		  <div class="form-group">
    		    <label for="inputName" class="col-lg-3 control-label">UserName</label>
    		    <div class="col-lg-9">
    		      <input type="text" class="form-control" id="inputName" placeholder="Name" name="inputName">
    		    </div>
    		  </div>
    		  <div class="form-group">
    		    <label for="inputPassword" class="col-lg-3 control-label">Password</label>
    		    <div class="col-lg-9">
    		      <input type="password" class="form-control" id="inputPassword" placeholder="Password" name="inputPassword">
    		    </div>
    		  </div>
    		  <div class="form-group">
    		    <div class="col-lg-offset-3 col-lg-9">
    		      <button type="submit" class="btn btn-default">Sign in</button>
    		    </div>
    		  </div>
    		</form>
    	</div>
    </div>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrapValidator.min.js"></script>

    <script>

        $(function() {
            validatorInit();
        });

        function validatorInit() {
            $('#login_form').bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    inputName: {
                        validators: {
                            notEmpty: {
                                message: '用户名不能为空'
                            },
                            callback: {}
                        }
                    },
                    inputPassword: {
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
                            },
                            callback: {}
                        }
                    }
                }
            })
            .on('success.form.bv', function(e) {
                // 禁止默认表单提交
                e.preventDefault();
                // 获取 form 实例
                var $form = $(e.target);
                // 获取 bootstrapValidator 实例
                var bv = $form.data('bootstrapValidator');
                // 发送数据到后端进行验证
                var name = $('#inputName').val();
                var password = $('#inputPassword').val();

                var data = {
                    "name": name,
                    "password": password,
                }

                $.ajax({
                    type: "POST",
                    url: "account/login",
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(data),
                    success: function(response) {
                        // 接收到后端响应

                        // 分析返回的 JSON 数据
                        if (response.result == 'error') {
                            var errormsg;
                            var field;
                            if (response.msg == 'unknownAccount') {
                                errormsg = "用户名错误";
                                field = "inputName";
                            } else if (response.msg == "wrongPassword") {
                                errormsg = "密码错误";
                                field = "inputPassword";
                                $('#inputPassword').val("");
                            } else {
                                errormsg = "服务器错误";
                                field = "inputPassword";
                                $('#inputPassword').val("");
                            }

                            // 更新 callback 错误信息，以及为错误对应的字段添加 错误信息
                            bv.updateMessage(field, 'callback', errormsg);
                            bv.updateStatus(field, 'INVALID', 'callback');
                        } else {
                            // 页面跳转
                            window.location.href = "/hotel/main";
                        }
                    },
                    error: function(data) {
                        // 处理错误
                    }
                });
            });
        }

    </script>

</body>
</html>