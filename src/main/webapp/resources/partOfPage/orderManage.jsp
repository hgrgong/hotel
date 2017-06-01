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
        bootstrapValidatorInit();
		editOrder();

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
			} else if (type == "房间ID") {
				$("#search_input").removeAttr("readOnly");
				search_type = "searchByRoomID";
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
                            field : 'orderId',
                            title : '订单编号'
                        //sortable: true
                        },
                        {
                            field : 'userId',
                            title : '用户编号'
                        },
                        {
                            field : 'roomId',
                            title : '房间编号'
                        },
                        {
                            field : 'liveDays',
                            title : '入住天数'
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
                                    selectID = row.orderId;
                                    rowEditOperation(row);
                                },
                                'click .delete' : function(e,
                                        value, row, index) {
                                    selectID = row.orderId;
                                    $('#deleteWarning_modal').modal(
                                            'show');
                                }
                            }
                        } ],
                    url : 'order/showList',
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

	// 行编辑操作
	function rowEditOperation(row) {
		$('#edit_modal').modal("show");

		// 信息加载
        $('#order_form_edit').bootstrapValidator("resetForm", true);
        $('#orderId').val(row.orderId);
        $('#changeRoom').val(row.roomId);
        $('#livingTime_edit').val(row.liveDays);
	}

    // 按钮的禁用与否
    function buttonOnOrOff() {
        if (!$('#order_form_edit').data('bootstrapValidator').isValid()) {
            $("#edit_modal_submit").attr({"disabled":"disabled"});
        } else {
            $("#edit_modal_submit").removeAttr("disabled");
        }
    }

	// 编辑货物信息
	function editOrder() {
		$('#edit_modal_submit').click(
			function() {
				$('#order_form_edit').data('bootstrapValidator')
						.validate();
				if (!$('#order_form_edit').data('bootstrapValidator')
						.isValid()) {
					return;
				}

				var data = {
					orderId : selectID,
					roomId : $('#changeRoom').val(),
					livingDays : $('#livingTime_edit').val(),
				}

				// ajax
				$.ajax({
					type : "POST",
					url : 'order/updateOrder',
					dataType : "json",
					contentType : "application/json",
					data : JSON.stringify(data),
					success : function(response) {
						$('#edit_modal').modal("hide");
						var type;
						var msg;
						var append = '';
						if (response.result == "success") {
							type = "success";
							msg = "订单更新成功";
						} else if (response.result == "error") {
							type = "error";
							msg = "订单更新失败";
						}
						showMsg(type, msg, append);
						alert(msg);
						tableRefresh();
					},
					error : function(xhr, textStatus, errorThrow) {
						$('#edit_modal').modal("hide");
						// handler error
						handleAjaxError(xhr.status);
					}
				});
			});
	}


	// 添加供应商模态框数据校验
	function bootstrapValidatorInit() {
		$("#order_form_edit").bootstrapValidator({
			message: 'This value is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			fields: {
				roomId: {
					validators: {
						notEmpty: {
							message: '房间号不能为空'
						}
					}
				},
				liveDays: {
					validators: {
						notEmpty: {
							message: '居住天数不能为空'
						}
					}
				}
			}
		})
		buttonOnOrOff();
	}

</script>
<div class="panel panel-default">
	<ol class="breadcrumb">
		<li>订单管理</li>
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
						<li><a href="javascript:void(0)" class="dropOption">房间ID</a></li>
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

<!-- 编辑订单信息模态框 -->
<div id="edit_modal" class="modal fade" table-index="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">编辑账单信息</h4>
			</div>
			<div class="modal-body">
				<!-- 模态框的内容 -->
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-8 col-sm-8">
						<form class="form-horizontal" role="form" id="order_form_edit"
							style="margin-top: 25px">
							<div class="form-group">
                                <label for="" class="control-label col-md-4 col-sm-4"> <span>订单编号：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
									<input type="text" class="form-control" id="orderId"
										name="orderId" readOnly="true">
                                </div>
                            </div>
							<div class="form-group">
								<label for="" class="control-label col-md-4 col-sm-4"> <span>房间编号：</span>
								</label>
								<div class="col-md-8 col-sm-8">
									<input type="text" class="form-control" id="changeRoom"
										name="roomId" placeholder="房间编号">
								</div>
							</div>
							<div class="form-group">
								<label for="" class="control-label col-md-4 col-sm-4"> <span>居住天数：</span>
								</label>
								<div class="col-md-8 col-sm-8">
									<input type="text" class="form-control"
										id="livingTime_edit" name="liveDays"
										placeholder="居住天数">
								</div>
							</div>
						</form>
					</div>
					<div class="col-md-1 col-sm-1"></div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal">
					<span>取消</span>
				</button>
				<button class="btn btn-success" type="button" id="edit_modal_submit">
					<span>确认更改</span>
				</button>
			</div>
		</div>
	</div>
</div>