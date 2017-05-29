<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>hotel management</title>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/bootstrap-table.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/jquery-ui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/jquery.mloading.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/css/mainPage.css">
</head>
<body>
    <!-- 导航栏 -->
    <div id="navBar">
        <!-- 此处加载顶部导航栏 -->
        <!-- 导航栏 -->
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <!-- 导航栏标题 -->
                <div class="navbar-header">
                    <a href="javascript:void(0)" class="navbar-brand home" style="padding-left: 60px;">
                        宾馆管理系统</a>
                </div>

                <!-- 导航栏下拉菜单；用户信息与注销登陆 -->
                <div>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                               <span class="glyphicon glyphicon-user"></span>
                                <span>欢迎&nbsp;</span>
                                <span id="nav_userName">用户名:${sessionScope.userName}</span>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="javascript:void(0)" id="editInfo">
                                        <span class="glyphicon glyphicon-pencil"></span> &nbsp;&nbsp;修改密码
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)" id="signOut">
                                        <span class="glyphicon glyphicon-off"></span> &nbsp;&nbsp;注销登录
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>

<div class="container-fluid" style="padding-left: 15px;">
    <div class="row">
        <!-- 左侧导航栏 -->
        <div id="sideBar" class="col-md-2 col-sm-3">
            <!--  此处加载左侧导航栏 -->
            <!-- 左侧导航栏 -->
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a href="#collapse2" data-toggle="collapse" data-parent="#accordion"
                               class="parentMenuTitle collapseHead">各项管理</a>
                            <div class="pull-right">
                                <span class="caret"></span>
                            </div>
                        </h4>
                    </div>
                    <div id="collapse2" class="panel-collapse collapse collapseBody show">
                        <div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
									<a href="javascript:void(0)" id="" class="menu_item"
									   name="resources/partOfPage/roomManage.jsp">房间管理</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:void(0)" id="" class="menu_item"
									   name="resources/partOfPage/userManage.jsp">用户管理</a>
								</li>
								<li class="list-group-item">
									<a href="javascript:void(0)" id="" class="menu_item"
									   name="resources/partOfPage/orderManage.jsp">订单管理</a>
								</li>
							</ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 面板区域 -->
        <div id="panel" class="col-md-10 col-sm-9">
        </div>
    </div>
</div>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/jquery-2.2.3.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/bootstrap-table.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/bootstrap-table-zh-CN.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/jquery.md5.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/jquery.mloading.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/mainPage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/ajaxfileupload.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/js/bootstrap-datetimepicker.zh-CN.js"></script>

    <script>
        $(function(){
            homePage();
            welcomePageInit();
            signOut();
            changePassword();
            menuClickAction();
        })
    </script>
</body>
</html>