<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.sports.dao.proxy.*"%>
<%@ page import="com.sports.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>专业管理</title>

<meta http-equiv="X-UA-Compatible" content="IE=11/10/9/8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- <meta charset="utf-8">
<link rel="stylesheet" href="BackStage.css"> -->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<jsp:include page="demo.jsp"></jsp:include>
</head>
<%
	String inf = (String) request.getAttribute("inf");
%>
<h3>${inf}</h3>
<%
	DepartmentDaoProxy ddp = new DepartmentDaoProxy();
	List<Department> allDep = ddp.findAll();
	pageContext.setAttribute("department", allDep);
%>
<%
	MajorClassDaoProxy mcdp = new MajorClassDaoProxy();
	List<MajorClassView> all = null;
	if (session.getAttribute("queryList") != null) {
		all = (ArrayList<MajorClassView>) session
				.getAttribute("queryList");
	} else {
		all = mcdp.findAllV();
	}
	pageContext.setAttribute("ref", all);
%>
<body>
	<div class="section">
	<form action="MmajorClassServlet" method="post">
		<table>
			<c:forEach items="${ref}" var="majorClassView">
				<tr>
					<td><span>${majorClassView.majorClassName}</span></td>
				</tr>
				<tr>
					<td><button value="${majorClassView.id}" name="update"
							onClick="return window.confirm('确定要修改吗')">修改</button></td>
					<td><button value="${majorClassView.id}" name="delete"
							onClick="return window.confirm('确定要删除吗')">删除</button></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	</div>
	<div class="section">
	<form action="MmajorClassServlet" method="post">
	<input type="hidden" name="hid" value="create" />
	专业班级名称：<input type="text" name="majorClassName" required="required"/>(请填写完整，名称中必须包含年级，如14计算机3班)<br/>
	<button type="submit" value="增加专业班级"
			onclick="return window.confirm('确认要增加吗？');" >增加专业班级</button>
	</form>
	</div>
	<div class="section">
	<form action="MmajorClassServlet" method="post">
	<input type="hidden" name="hid" value="update" />
	<input type="hidden" name="updateMajorClassId" value="${single.id}" />
	专业班级名称：<input type="text" name="updateMajorClassName" value="${single.majorClassName}" required="required"/><br/>
	<button type="submit" value="修改专业班级"
			onclick="return window.confirm('确认要修改吗？');">修改专业班级</button>
	</form>
	</div>
</body>
</html>
