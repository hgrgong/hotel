<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>
	var search_type = "none";
	var search_keyWord = "none";
	var selectID;

	$(function() {
	    searchAction();
		goodsListInit();
		optionAction();
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
		$('#goodsList').bootstrapTable('refresh', {
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
                        } else {
                            search_keyWord = "notNull";
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
		$('#goodsList').bootstrapTable('refresh', {
			query : {}
		});
	}

	// 房间列表
	function goodsListInit() {
		$('#goodsList')
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
                                } else {
                                    return "已住";
                                }
                            }
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
			<div class="col-md-5">
				<button class="btn btn-sm btn-default" id="add_goods">
					<span class="glyphicon glyphicon-plus"></span> <span>添加货物信息</span>
				</button>
			</div>
			<div class="col-md-5"></div>
		</div>

		<div class="row" style="margin-top: 15px">
			<div class="col-md-12">
				<table id="goodsList" class="table table-striped"></table>
			</div>
		</div>
	</div>
</div>