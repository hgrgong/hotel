<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	var search_type = "none";
	var search_keyWord = "";
	var selectID;

	$(function() {
		optionAction();
		searchUser();
		userListInit();
        deleteUser();
	})

	// 下拉框选择动作
	function optionAction() {
		$(".dropOption").click(function() {
			var type = $(this).text();
			$("#search_input").val("");
			if (type == "所有") {
				$("#search_input").attr("readOnly", "true");
				search_type = "searchAll";
			} else if (type == "用户ID") {
				$("#search_input").removeAttr("readOnly");
				search_type = "searchByUserID";
			} else if (type == "用户名") {
				$("#search_input").removeAttr("readOnly");
				search_type = "searchByUserName";
			} else {
				$("#search_input").removeAttr("readOnly");
			}

			$("#search_type").text(type);
			$("#search_input").attr("placeholder", type);
		})
	}

	// 搜索动作
	function searchUser() {
		$('#search_button').click(function() {
			search_keyWord = $('#search_input').val();
			tableRefresh();
		})
	}

	// 分页查询参数
	function queryParams(params) {
		var temp = {
			limit : params.limit,
			offset : params.offset,
			searchType : search_type,
			keyWord : search_keyWord
		}
		return temp;
	}

	// 表格初始化
	function userListInit() {
		$('#goodsList')
				.bootstrapTable(
						{
							columns : [
									{
										field : 'id',
										title : '用户编号'
									//sortable: true
									},
									{
										field : 'name',
										title : '用户名'
									},
									{
										field : 'gender',
										title : '性别'
									},
									{
										field : 'password',
										title : '密码'
									},
									{
                                        field : 'mobile',
                                        title : '联系电话'
                                    },
                                    {
										field : 'email',
										title : '电子邮件'
									},
									{
										field : 'operation',
										title : '操作',
										formatter : function(value, row, index) {
											var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
											return d;
										},
										events : {
											// 操作列中编辑按钮的动作
											'click .delete' : function(e,
													value, row, index) {
												selectID = row.id;
                                                $('#deleteWarning_modal').modal(
                                                        'show');
											}
										}
									} ],
							url : 'user/showList',
							onLoadError:function(status){
								handleAjaxError(status);
							},
							method : 'GET',
							queryParams : queryParams,
							sidePagination : "server",
							dataType : 'json',
							pagination : true,
							pageNumber : 1,
							pageSize : 10,
							pageList : [ 5, 10, 25 ],
							clickToSelect : true
						});
	}

	// 表格刷新
	function tableRefresh() {
		$('#goodsList').bootstrapTable('refresh', {
			query : {}
		});
	}

	// 刪除用户
	function deleteUser(){
		$('#delete_confirm').click(function(){
			var data = {
				"userID" : selectID
			}
            // alert(data.userID);
			// ajax
			$.ajax({
				type : "GET",
				url : "user/deleteUser",
				dataType : "json",
				contentType : "application/json",
				data : data,
				success : function(response){
					$('#deleteWarning_modal').modal("hide");
					var type;
					var msg;
					var append = '';
					if(response.result == "success"){
						type = "success";
						msg = "用户删除成功";
					}else{
						type = "error";
						msg = "用户尚有订单，删除失败";
					}
					showMsg(type, msg, append);
					// alert(msg);
					tableRefresh();
				},error : function(xhr, textStatus, errorThrow){
					$('#deleteWarning_modal').modal("hide");
					// handler error
					handleAjaxError(xhr.status);
				}
			})

			$('#deleteWarning_modal').modal('hide');
		})
	}

</script>
<div class="panel panel-default">
	<ol class="breadcrumb">
		<li>用户管理</li>
	</ol>
	<div class="panel-body">
		<div class="row">
			<div class="col-md-1 col-sm-2">
				<div class="btn-group">
					<button class="btn btn-default dropdown-toggle"
						data-toggle="dropdown">
						<span id="search_type">查询方式</span> <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="javascript:void(0)" class="dropOption">所有</a></li>
						<li><a href="javascript:void(0)" class="dropOption">用户ID</a></li>
						<li><a href="javascript:void(0)" class="dropOption">用户名</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-9 col-sm-9">
				<div>
					<div class="col-md-3 col-sm-4">
						<input id="search_input" type="text" class="form-control"
							placeholder="关键字">
					</div>
					<div class="col-md-2 col-sm-2">
						<button id="search_button" class="btn btn-success">
							<span class="glyphicon glyphicon-search"></span> <span>查询</span>
						</button>
					</div>
				</div>
			</div>
		</div>

		<div class="row" style="margin-top: 15px">
			<div class="col-md-12">
				<table id="goodsList" class="table table-striped"></table>
			</div>
		</div>
	</div>
</div>

<!-- 删除提示模态框 -->
<div class="modal fade" id="deleteWarning_modal" table-index="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">警告</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-3 col-sm-3" style="text-align: center;">
						<img src="resources/images/warning-icon.png" alt=""
							style="width: 70px; height: 70px; margin-top: 20px;">
					</div>
					<div class="col-md-8 col-sm-8">
						<h3>是否确认删除该用户</h3>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal">
					<span>取消</span>
				</button>
				<button class="btn btn-danger" type="button" id="delete_confirm">
					<span>确认删除</span>
				</button>
			</div>
		</div>
	</div>
</div>