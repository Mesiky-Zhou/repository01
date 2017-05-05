<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common_header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12"><h1>用户列表</h1></div>
		</div>
		
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>用户名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>创建时间</th>
						<th>操作</th>
					</tr>
					<c:forEach var="user" items="${pageInfo.list}" varStatus="status">
					<tr>
						<td>${user.id }</td>
						<td>${user.userName }</td>
						<td>${user.gendar }</td>
						<td>${user.email }</td>
						<td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td>
							<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
							</button>
						</td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-6">
				第${pageInfo.pageNum }页，共${pageInfo.pages }页，共${pageInfo.total }条记录
			</div>
			<div class="col-md-6">
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					    <li><a href="${APP_PATH}/user/list?pageNo=1">首页</a></li>
					    <c:if test="${pageInfo.hasPreviousPage }">
						    <li>
						      <a href="${APP_PATH}/user/list?pageNo=${pageInfo.pageNum-1 }" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
					    </c:if>
					    
					    <c:forEach items="${pageInfo.navigatepageNums }" var="np">
					    	<c:if test="${np == pageInfo.pageNum }">
					    		<li class="active"><a href="#">${np }</a></li>
					    	</c:if>
					    	<c:if test="${np != pageInfo.pageNum }">
					    		<li><a href="${APP_PATH}/user/list?pageNo=${np }">${np }</a></li>
					    	</c:if>
					    </c:forEach>
					    
					    <c:if test="${pageInfo.hasNextPage }">
					    	<li>
						      <a href="${APP_PATH}/user/list?pageNo=${pageInfo.pageNum+1 }" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
					    	</li>
					    </c:if>
					    <li><a href="${APP_PATH}/user/list?pageNo=${pageInfo.pages }">末页</a></li>
					  </ul>
					</nav>
			</div>
		</div>
	
	</div>
</body>
</html>