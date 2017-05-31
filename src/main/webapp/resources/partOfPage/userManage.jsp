<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	var search_type = "none";
	var search_keyWord = "";
	var selectID;

	$(function() {
		optionAction();
		searchAction();
		goodsListInit();

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
	function searchAction() {
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
	function goodsListInit() {
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
											var s = '<button class="btn btn-info btn-sm edit"><span>编辑</span></button>';
											var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
											var fun = '';
											return s + ' ' + d;
										},
										events : {
											// 操作列中编辑按钮的动作
											'click .edit' : function(e, value,
													row, index) {
												selectID = row.id;
												rowEditOperation(row);
											},
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