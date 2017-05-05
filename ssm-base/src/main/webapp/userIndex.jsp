<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common_header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${APP_PATH}/static/js/common/commonList.js"></script>
<title>用户列表</title>
</head>
<body>
	<!-- 新增界面 start-->
	<div class="modal fade" tabindex="-1" role="dialog" id="ui_add">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">新增</h4>
	      </div>
	      <div class="modal-body">
	      		<!-- 表单 -->
	        	<form class="form-horizontal">
				  <div class="form-group">
				    <label for="userName" class="col-sm-2 control-label">用户名</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="ui_add_input_userName" name="userName" placeholder="请输入用户名">
				      <span  class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="password" class="col-sm-2 control-label">密码</label>
				    <div class="col-sm-10">
				      <input type="password" class="form-control" id="ui_add_input_password" name="password" placeholder="请输入密码">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="性别" class="col-sm-2 control-label">性别</label>
				    <div class="col-sm-10">
					      <div class="radio-inline">
							  <label><input type="radio" name="gendar" id="gendar" value="M" checked>男</label>
						  </div>
						  <div class="radio-inline">
							  <label><input type="radio" name="gendar" id="gendar" value="F">女</label>
						  </div>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="mail" class="col-sm-2 control-label">邮箱</label>
				    <div class="col-sm-10">
				      <input type="text" class="form-control" id="ui_add_input_email" name="email" placeholder="test@abc.com">
				      <span  class="help-block"></span>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="所属部门" class="col-sm-2 control-label">所属部门</label>
				    <div class="col-sm-4">
					      <select class="form-control" name="deptId" id="ui_add_select_deptId">
							  
						  </select>
				    </div>
				  </div>
				  
				  
				  
				</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="ui_add_btn_ok">确定</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	<!-- 新增界面end -->


	<div class="container">
		<div class="row">
			<div class="col-md-12"><h1>用户列表</h1></div>
		</div>
		
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="btn_add">新增</button>
				<button class="btn btn-danger" id="btn_delete">删除</button>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="table_list">
					<thead>
						<tr id="grid-header">
							<!--  
							<th>
								 <label class="checkbox-inline"><input type="checkbox" id="checkAll">全选</label>
							</th>
							<th>#</th>
							<th>用户名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>创建时间</th>
							<th>操作</th>
							-->
						</tr>
					</thead>
					<tbody>
					</tbody>
					
				</table>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-6" id="page_info">
				<!-- 分页结果信息 -->
			</div>
			<div class="col-md-6" id="page_nav">
				<!-- 分页导航栏 -->
			
			</div>
		</div>
	
	</div>
	
	<script type="text/javascript">
	    
		$(function(){
			initPage(1);
			bindEvent();
		});	
		
		
		
		function open_ui_add(){
			//清空表单内容及样式
			$("#ui_add form")[0].reset();
			$("#ui_add form").find("*").removeClass("has-success has-error");
			$("#ui_add form").find(".help-block").text("");
			
			
			
			//初始化部门
			$.ajax({
				url:'${APP_PATH}/sysmgr/dept/service/listWithNoPage',
				type:'GET',
				cache:false,
				success:function(result){
					var deptList = result.dataMap.list;
					$("#ui_add_select_deptId").empty();
					$("#ui_add_select_deptId").append($("<option></option>").append('-请选择-').attr("value",-1));
					$.each(deptList,function(index, item){
						$("#ui_add_select_deptId").append($("<option></option>").append(item.name).attr("value",item.id));
					});
				}
				
			});
			
			$("#ui_add").modal({backdrop:'static'});
		}
		
		function save_and_close(){
			if(!validate_form()){
				return  false;
			}
			
			var formData = $("#ui_add form").serialize();
			$.ajax({
				url:'${APP_PATH}/sysmgr/user/service/add',
				type:'POST',
				cache:false,
				data:formData,
				success:function(result){
					alert(result.desc);
					$("#ui_add").modal('hide');
					initPage(totalRecord);
				}
			});
			
		}
		
		function validate_form(){
			var userName = $("#ui_add_input_userName").val();
			var email = $("#ui_add_input_email").val();
			if(userName.length>6 || userName.length<3){
				show_validate_msg("#ui_add_input_userName", false, "用户名最少3位最长6位！");
				return false;
			}else{
				show_validate_msg("#ui_add_input_userName", true, "");
			}
			
			return true;
		}
		function show_validate_msg(ele, status, msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if(!status){
				$(ele).parent().addClass("has-error");
			}else{
				$(ele).parent().addClass("has-success");
			}
			$(ele).next("span").text(msg);
		}
		
		/* function initPage(pageNo){
			$.ajax({
				url:'${APP_PATH}/sysmgr/user/service/list',
				type:'GET',
				cache:false,        
				data: {'pageNo':pageNo},
				dataType:'json',
			    success:function(result){
			    	buildPage(result);
				}
				
			});
		} */
		function initPage(pageNo){
			getRequest('${APP_PATH}/sysmgr/user/service/list',{'pageNo':pageNo},buildPage);
			currentPage = pageNo;
		}
		
		
		
		function buildPage(result){
			buildPageListHeader(result);
			buildPageList(result);
			buildPageNav(result);
		}
		
		function buildPageListHeader(result){
			
			var gridConfig = result.dataMap.listConfig.gridConfig;
			
			var header = $("#grid-header");
			header.empty();
			
			var checkAllTh = $("<th><label class='checkbox-inline'><input type='checkbox' id='checkAll'>全选</label></th>");
			header.append(checkAllTh);
			$.each(gridConfig.nCols, function(index,item){
				
				var colTh = $("<th></th>").append(item);
				header.append(colTh);
			});
			var operTh = $("<th></th>").append("操作");
			header.append(operTh);
		}
		
		function colProcFunForGendar(colValue){
			return colValue=='M'?'男':'女';
		}
		
		function buildPageList(result){
			var users = result.dataMap.pageInfo.list;
			var gridConfig = result.dataMap.listConfig.gridConfig;
			var gridConfig_colProcFuns = gridConfig.colProcFuns;
			//先清空数据
			$("#table_list tbody").empty();
			
			$.each(users, function(index, item){
				var tr = $("<tr></tr>");
				
				var checkTd = $("<td></td>").append("<input type='checkbox' value='"+ item.id + "' class='checkItem'/>");
				tr.append(checkTd);
				
				/* var idTd = $("<td></td>").append(item.id);
				var userNameTd = $("<td></td>").append(item['userName']);
				var gendar = item.gendar=="M"?"男":"女";
				var gendarTd = $("<td></td>").append(gendar);
				var emailTd = $("<td></td>").append(item.email);
				var createTimeTd = $("<td></td>").append(item.createTime); */
				$.each(gridConfig.pCols,function(index,pName){
					var jsStr = "var colValue = " + gridConfig_colProcFuns[index] +"('" + item[pName] + "')";
					$.globalEval(jsStr);
					var colTd = $("<td></td>").append(colValue);
					tr.append(colTd);
				});
				
				
				/**
				<td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
							</button>
				*/
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
							  .append($("<span></span>").addClass("glyphicon glyphicon-pencil").attr("aria-hidden","true"))
							  .append("编辑");
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
							  .append($("<span></span>").addClass("glyphicon glyphicon-trash").attr("aria-hidden","true"))
							  .append("删除");
				var btnTd = $("<td></td>").append(editBtn).append("  ").append(delBtn);
				
				
				tr.append(btnTd);
				tr.attr("id","trId_" + item.id);
				tr.appendTo("#table_list tbody");
				/* tr.append(checkTd)
				.append(idTd)
				.append(userNameTd)
				.append(gendarTd)
				.append(emailTd)
				.append(createTimeTd)
				.append(btnTd)
				.appendTo("#table_list tbody"); */
				
				
				//每行删除按钮绑定事件
				delBtn.click(function(){
					initSelectRowData(item.id);
					deleteRequest('${APP_PATH}/sysmgr/user/service/delete',{ids:item.id},function(result){
						alert(result.desc);
						initPage(currentPage);
					});
				});
				
				//每行记录单击绑定事件
				tr.click(function(){
					initSelectRowData(item.id);
				});
				//每行记录双击绑定事件
				tr.dblclick(function(){
					var rowData = getSelectRow();
					alert(rowData[0] + '==' + rowData[1] + '==' + rowData[2] + '==' + rowData[3]);
				});
						
			});
			
			
			//全选绑定事件
			$("#checkAll").click(function(){
				$(".checkItem").prop("checked",$(this).prop("checked"));
			});
		}
		
		function initSelectRowData(dataId){
			selectRowId ="trId_" + dataId;
			var tds = $('#' + selectRowId).children("td");
			for(var i=0;i<tds.length;i++){
				selectRowData[i] = tds.eq(i).text();
			}
		}
		
		function getSelectRow(){
			return selectRowData;
		}
		
		
		function buildPageNav(result){
			var pageInfo = result.dataMap.pageInfo;
			/**
			<div class="col-md-6">
				第${pageInfo.pageNum }页，共${pageInfo.pages }页，共${pageInfo.total }条记录
			</div>
			*/
			//先清空数据
			$("#page_info").empty();
			$("#page_info").append("第"+pageInfo.pageNum+"页，共"+pageInfo.pages+"页，共"+pageInfo.total+"条记录");
			
			totalRecord = pageInfo.total;
			
			/**
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li><a href="">首页</a></li>
					    
						<li>
						  <a href="" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						  </a>
						</li>
					   
					    <li class="active"><a href="#">1</a></li>
					    <li><a href="">1</a></li>


					    <li>
						      <a href="" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
					    </li>

					    <li><a href="">末页</a></li>
					  </ul>
					</nav>
			*/
			//先清空数据
			$("#page_nav").empty();
			
			var nav = $("<nav></nav>").attr("aria-label","Page navigation");
			var ul = $("<ul></ul>").addClass("pagination");
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append(
								$("<span></span").attr("aria-hidden","true").append("&laquo;")	
							).attr("aria-label","Previous").attr("href","#"));
			if(!pageInfo.hasPreviousPage){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){initPage(1);});
				prePageLi.click(function(){initPage(pageInfo.pageNum - 1);});
			}
			
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append(
								$("<span></span").attr("aria-hidden","true").append("&raquo;")	
							).attr("aria-label","Next").attr("href","#"));
			var lastPageLi =  $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(!pageInfo.hasNextPage){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){initPage(pageInfo.pageNum+1);});
				lastPageLi.click(function(){initPage(pageInfo.pages);});
			}
			
			
			
			ul.append(firstPageLi).append(prePageLi);
			$.each(pageInfo.navigatepageNums, function(index, item){
				var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
				if(item == pageInfo.pageNum){
					numLi.addClass("active");
				}
				numLi.click(function(){
					initPage(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			
			nav.append(ul);
			
			$("#page_nav").append(nav);
		}
		
	
	</script>
</body>
</html>