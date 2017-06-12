<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>
	var search_type = "none";
	var update_type = "none";
	var add_type = "none";
	var search_keyWord = "none";
	var selectID;

	$(function() {
	    searchAction();
		roomListInit();
		bootstrapValidatorInit();
		// buttonOff();
		optionAction();
		optionAction2();
		optionAction3();
		editRoomStatus();
		updatePrice();
		addRoom();
	})

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

	// 搜索动作
	function searchAction() {
		$('#search_button').click(function() {
			tableRefresh();
		})
	}

	// 表格刷新
	function tableRefresh() {
		$('#roomList').bootstrapTable('refresh', {
			query : {}
		});
	}

	// 下拉框选项动作
	function optionAction() {
		$(".dropOption").click(function() {
			var type = $(this).text();
			var condition = $(".dropOption2").text();
			if (type == "所有") {
				search_type = "searchAll";
				$(".buttdis").attr("disabled", "disabled");
			} else if (type == "房间大小") {
			    $(".buttdis").removeAttr("disabled");
				$(".option").each(function(i) {
					if (i <= 2) {
						$(this).show();
					} else {
					    $(this).hide();
					}
					$(".dropOption2").click(function() {
					    condition = $(this).text();
					    $("#search_condition").text(condition);
                        if (condition == "单人房") {
							search_keyWord = "single";
						} else if (condition == "双人房") {
							search_keyWord = "double";
						} else {
							search_keyWord = "family";
						}
					})
				})
				search_type = "searchByCategory";
			} else if (type == "房间状态") {
			    $(".buttdis").removeAttr("disabled");
				$(".option").each(function(i) {
					if (i > 2) {
						$(this).show();
					} else {
                        $(this).hide();
                    }
					$(".dropOption2").click(function() {
					    condition = $(this).text();
					    $("#search_condition").text(condition);
					    if (condition == "空房") {
                            search_keyWord = "null";
                        } else if (condition == "已住") {
                            search_keyWord = "notNull";
                        } else {
                            search_keyWord = "noRent";
                        }
					})
				})
				search_type = "searchByStatus";
			} else {
			    $(".buttdis").attr("disabled", "disabled");
			}

			$("#search_type").text(type);
		})
	}

	// 搜索动作
	function searchAction() {
		$('#search_button').click(function() {
			tableRefresh();
		})
	}

	// 表格刷新
	function tableRefresh() {
		$('#roomList').bootstrapTable('refresh', {
			query : {}
		});
	}

	// 房间列表
	function roomListInit() {
		$('#roomList')
            .bootstrapTable(
                {
                    columns : [
                        {
                            field : 'roomId',
                            title : '房间号'
                        //sortable: true
                        },
                        {
                            field : 'category',
                            title : '房间类型',
                            formatter : function(value, row, index) {
                                if (value == 'single') {
                                    return "单人房";
                                } else if (value == 'double'){
                                    return "双人房";
                                } else {
                                    return "家庭房";
                                }
                            }
                        },
                        {
                            field : 'price',
                            title : '房间价格'
                        },
                        {
                            field : 'status',
                            title : '房间状态',
                            formatter : function(value, row, index) {
                                if (value == 0) {
                                    return "空房";
                                } else if (value == 1) {
                                    return "已住";
                                } else {
                                    return "暂不出租";
                                }
                            }
                        },
                        {
                            field : 'operation',
                            title : '操作',
                            formatter : function(value, row, index) {
                                var s = '<button class="btn btn-info btn-sm edit"><span>编辑</span></button>';
                                return s;
                            },
                            events : {
                                // 操作列中编辑按钮的动作
                                'click .edit' : function(e, value,
                                        row, index) {
                                    selectID = row.id;
                                    rowEditOperation(row);
                                }
                            }
                        } ],
                        url : 'room/list',
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

	// 行编辑操作
	function rowEditOperation(row) {
		$('#edit_modal').modal("show");
		// 信息加载
        $('#room_form_edit').bootstrapValidator("resetForm", true);
        $('#roomID').val(row.roomId);
        $('#roomStatus').val(row.status);
	}

	// 编辑模态框数据校验
	function bootstrapValidatorInit() {
		$("#room_form_edit").bootstrapValidator({
			message: 'This is not valid',
			feedbackIcons: {
				valid: 'glyphicon glyphicon-ok',
				invalid: 'glyphicon glyphicon-remove',
				validating: 'glyphicon glyphicon-refresh'
			},
			excluded : [ ':disabled' ],
			fields: {
				roomStatus: {
					validators: {
						notEmpty: {
							message: '房间状态不能为空'
						},
                        regexp: {
                            regexp: /^[2]$/,
                            message: '只能是2(代表赞不出租)'
                        }
					}
				}
			}
		})
	}

	// 编辑货物信息
	function editRoomStatus() {
		$('#edit_modal_submit').click(
			function() {
				$('#room_form_edit').data('bootstrapValidator')
						.validate();
				if (!$('#room_form_edit').data('bootstrapValidator')
						.isValid()) {
					return;
				}

				var data = {
					"roomID" : $("#roomID").val()
				}
                // alert(data.roomID);
				// ajax
				$.ajax({
					type : "GET",
					url : 'room/updateRoom',
					dataType : "json",
					contentType : "application/json",
					data : data,
					success : function(response) {
						$('#edit_modal').modal("hide");
						var type;
						var msg;
						var append = '';
						if (response.result == "success") {
							type = "success";
							msg = "房间状态更新成功";
						} else if (response.result == "error") {
							type = "error";
							msg = "房间有人住，不能更新";
						}
						showMsg(type, msg, append);
						// alert(msg);
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

	// 第二个下拉框选择动作
	function optionAction2() {
		$(".dropOption3").click(function() {
			var type = $(this).text();
			$("#price_input").val("");
			if (type == "单人房") {
				update_type = "single";
				$("#price_input").removeAttr("readOnly");
				// $("#update_button").removeAttr("disabled");
			} else if (type == "双人房") {
				update_type = "double";
				$("#price_input").removeAttr("readOnly");
				// $("#update_button").removeAttr("disabled");
			} else {
				update_type = "family";
				$("#price_input").removeAttr("readOnly");
				// $("#update_button").removeAttr("disabled");
			}

			$("#room_type").text(type);
			$("#price_input").attr("placeholder", "更改" + type + "价格");
		})
	}
	// 禁止按钮的提交
	function buttonOff() {
        var value = $("#price_input").val();
        // alert(value);
        if (value != "") {
            $("#update_button").removeAttr("disabled");
        }
	}

    // 发出更新房价请求
	function updatePrice() {
	    $("#update_button").click(function() {
	        var data = {
	            "roomType": update_type,
	            "price": $("#price_input").val(),
	        }
	        // alert(data.roomType + ": " + data.price);
	        $.ajax({
	            type: "POST",
	            url: "room/updatePrice",
	            dataType: "json",
	            contentType: "application/json",
                data: JSON.stringify(data),
                success : function(response) {
                    // 接收并处理后端返回的响应
					if(response.result == "error"){
						var errorMessage;
						if(response.msg == "priceNoChange"){
							errorMessage = "房价不变，更新个屁";
						}else if(response.msg == "priceUnreasonable"){
							errorMessage = "房价设置不合理";
						}
                        showMsg('error', errorMessage, '');
					} else {
						showMsg('success', '房价更新成功', '');
					}
                    tableRefresh();
                },
                error : function(xhr, textStatus, errorThrow) {
                    // handler error
                    handleAjaxError(xhr.status);
                }
	        })
	    })
	}

    // 添加房间
    function addRoom() {
        $("#add_room").click(function() {
            $('#add_modal').modal("show");
        });

		$('#add_modal_submit').click(
            function() {
                var data = {
                    "roomType": add_type,
                }

                // ajax
                $.ajax({
                    type : "GET",
                    url : "room/addRoom",
                    dataType : "json",
                    contentType : "application/json",
                    data : data,
                    success : function(response) {
                        $('#add_modal').modal("hide");
                        var msg;
                        var type;
                        var append = '';
                        if (response.result == "success") {
                            type = "success";
                            msg = "房间添加成功";
                        } else if (response.result == "error") {
                            type = "error";
                            msg = "房间添加失败";
                        }
                        showMsg(type, msg, append);
                        // alert(msg);
                        tableRefresh();
                    },
                    error : function(xhr, textStatus, errorThrow) {
                        $('#add_modal').modal("hide");
                        // handler error
                        handleAjaxError(xhr.status);
                    }
                });
		    });
    }

	// 第三个下拉框选择动作
	function optionAction3() {
		$(".dropOption4").click(function() {
			var type = $(this).text();
			if (type == "单人房") {
				add_type = "single";
				$("#add_modal_submit").removeAttr("disabled");
			} else if (type == "双人房") {
				add_type = "double";
				$("#add_modal_submit").removeAttr("disabled");
			} else {
				add_type = "family";
				$("#add_modal_submit").removeAttr("disabled");
			}
			$("#add_type").text(type);
		})
	}

</script>

<div class="panel panel-default">
	<ol class="breadcrumb">
		<li>房间管理</li>
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
                        <li><a href="javascript:void(0)" class="dropOption">房间状态</a></li>
                        <li><a href="javascript:void(0)" class="dropOption">房间大小</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-6 col-sm-6">
                <div>
                    <div class="col-md-3 col-sm-4">
                        <div class="btn-group">
                            <button class="btn btn-default dropdown-toggle buttdis" disabled="disabled"
                                data-toggle="dropdown">
                                <span id="search_condition">查询条件</span> <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li class="option"><a href="javascript:void(0)" class="dropOption2">单人房</a></li>
                                <li class="option"><a href="javascript:void(0)" class="dropOption2">双人房</a></li>
                                <li class="option"><a href="javascript:void(0)" class="dropOption2">家庭房</a></li>
                                <li class="option"><a href="javascript:void(0)" class="dropOption2">空房</a></li>
                                <li class="option"><a href="javascript:void(0)" class="dropOption2">已住</a></li>
                                <li class="option"><a href="javascript:void(0)" class="dropOption2">暂不出租</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2">
                        <button id="search_button" class="btn btn-success">
                            <span class="glyphicon glyphicon-search"></span> <span>查询</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

		<div class="row" style="margin-top: 25px">
			<div class="col-md-1 col-sm-2">
				<div class="btn-group">
					<button class="btn btn-default dropdown-toggle"
						data-toggle="dropdown">
						<span id="room_type">调整房价</span> <span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="javascript:void(0)" class="dropOption3">单人房</a></li>
						<li><a href="javascript:void(0)" class="dropOption3">双人房</a></li>
						<li><a href="javascript:void(0)" class="dropOption3">家庭房</a></li>
					</ul>
				</div>
			</div>
			<div class="col-md-9 col-sm-9">
				<div>
					<div class="col-md-3 col-sm-4">
						<input id="price_input" type="text" class="form-control"
							placeholder="价格" readOnly="true" oninput="buttonOff()">
					</div>
					<div class="col-md-2 col-sm-2">
						<button id="update_button" class="btn btn-success" disabled="disabled">
							<span class="glyphicon glyphicon-refresh"></span> <span>更改</span>
						</button>
					</div>
				</div>
			</div>
		</div>

		<div class="row" style="margin-top: 25px">
			<div class="col-md-5">
				<button class="btn btn-sm btn-default" id="add_room">
					<span class="glyphicon glyphicon-plus"></span> <span>添加房间</span>
				</button>
			</div>
			<div class="col-md-5"></div>
		</div>

		<div class="row" style="margin-top: 15px">
			<div class="col-md-12">
				<table id="roomList" class="table table-striped"></table>
			</div>
		</div>
	</div>
</div>

<!-- 编辑房间状态模态框 -->
<div id="edit_modal" class="modal fade" table-index="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">编辑房间状态，将空房置为暂不出租</h4>
			</div>
			<div class="modal-body">
				<!-- 模态框的内容 -->
				<div class="row">
					<div class="col-md-1 col-sm-1"></div>
					<div class="col-md-8 col-sm-8">
						<form class="form-horizontal" role="form" id="room_form_edit"
							style="margin-top: 25px">
                            <div class="form-group">
								<label for="" class="control-label col-xs-6 col-md-4 col-sm-4"> <span>房间编号：</span>
								</label>
								<div class="col-md-8 col-sm-8">
									<input type="text" class="form-control" id="roomID"
										name="roomID" readOnly="true">
								</div>
							</div>
							<div class="form-group">
                                <label for="" class="control-label col-xs-6 col-md-4 col-sm-4"> <span>房间状态：</span>
                                </label>
                                <div class="col-md-8 col-sm-8">
									<input type="text" class="form-control" id="roomStatus"
										name="roomStatus" placeholder="房间状态">
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

<!-- 添加货物信息模态框 -->
<div id="add_modal" class="modal fade" table-index="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"
	data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">添加房间，选择房间类型即可</h4>
			</div>
			<div class="modal-body">
				<!-- 模态框的内容 -->
				<div class="row">
					<div class="col-xs-6 col-md-4"></div>
                    <div class="col-xs-6 col-md-4">
                        <div class="btn-group">
                            <button class="btn btn-default dropdown-toggle"
                                data-toggle="dropdown">
                                <span id="add_type">房间类型</span> <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="javascript:void(0)" class="dropOption4">单人房</a></li>
                                <li><a href="javascript:void(0)" class="dropOption4">双人房</a></li>
                                <li><a href="javascript:void(0)" class="dropOption4">家庭房</a></li>
                            </ul>
                        </div>
					</div>
					<div class="col-xs-6 col-md-4"></div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" type="button" data-dismiss="modal">
					<span>取消</span>
				</button>
				<button class="btn btn-success" type="button" id="add_modal_submit" disabled="disabled">
					<span>提交</span>
				</button>
			</div>
		</div>
	</div>
</div>