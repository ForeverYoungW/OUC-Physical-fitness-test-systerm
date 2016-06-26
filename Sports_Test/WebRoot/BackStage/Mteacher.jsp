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

<title>教师管理</title>

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
	TeacherDaoProxy tdp = new TeacherDaoProxy();
	List<Teacher> all = tdp.findAll();
	pageContext.setAttribute("ref", all);
%>
<body>
	<div class="section">
	<form action="MteacherServlet" method="post">
		<table>
			<c:forEach items="${ref}" var="teacher">
				<tr>
					<td>${teacher.teaNumber}&nbsp;</td>
					<td>${teacher.teaName}&nbsp;</td>
					<td><button value="${teacher.id}" name="detail">详情</button></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	</div>
	<div class="section">
	<form name="insertForm" action="MteacherServlet" method="post">
		<h3>单条添加教师信息</h3>
		教师工号：<input type="text" name="teaNumber" /><br /> <p>教师密码默认为教师工号，此处不予填写</p><br />
		教师姓名：<input type="text" name="teaName" /><br /> 教师性别：<select
			name="teaSex">
			<option value="男">男</option>
			<option value="女">女</option>
		</select><br /> 教师职称：<input type="text" name="teaPosition" /><br /> 教师电话：<input
			type="text" name="teaPhone" /><br /> 教师邮箱：<input type="text"
			name="teaEmail" /><br /> <input type="hidden" name="hid"
			value="create" /> 
			<button type="submit" value="增加教师" >添加教师</button>
	</form>
	</div>
	<br />
	<br />
	<div class="section">
	<form name="detailForm" action="MteacherServlet" method="post">
		<h3>教师信息详情</h3>
		教师工号：<input type="text" name="teaNumberDetail"
			value="${singleTea.teaNumber}" /><br /> 教师姓名：<input type="text"
			name="teaNameDetail" value="${singleTea.teaName}" /><br /> 教师性别：<select
			name="teaSexDetail">
			<option value="${singleTea.teaSex}" selected>${singleTea.teaSex}</option>
			<option value="男">男</option>
			<option value="女">女</option>
		</select><br />
		<!-- 下拉框无法绑定具体数据 -->
		教师职称：<input type="text" name="teaPositionDetail"
			value="${singleTea.teaPosition}" /><br /> 教师电话：<input type="text"
			name="teaPhoneDetail" value="${singleTea.teaPhone}" /><br /> 教师邮箱：<input
			type="text" name="teaEmailDetail" value="${singleTea.teaEmail}" /><br />
		<button value="${singleTea.id}" name="delete"
			onclick="return window.confirm('确定要删除吗？')">删除</button>
		<button value="${singleTea.id}" name="update"
			onclick="return window.confirm('确定要更新吗？')">更新</button>
		<button value="${singleTea.id}" name="queryOrganize">查询参与的测试学期</button>
	</form>
	</div>
	<div class="section">
	<h3>该教师参与过的测试学期</h3>
	<form action="MteacherServlet" method="post">
		<table>
			<c:forEach items="${queryList1}" var="testTerm">
				<tr>
					<td>${testTerm.testTermName}&nbsp;</td>
					<td><button value="${testTerm.id}" name="queryTestClass">查看此学期下的测试班级</button></td>
					<td><input type="hidden" name="queryList1TeaId"
						value="${queryList1TeaId}" /></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<h3>该老师组织的测试班级</h3>
	<table>
		<c:forEach items="${queryList2}" var="testClassView">
			<tr>
				<td>${testClassView.testClassName}</td>
				<td>${testClassView.termName}</td>
				<td>${testClassView.schoolArea}</td>
				<td>${testClassView.teaName}</td>
				<td>${testClassView.limitNum}</td>
				<td>${testClassView.nowNum}</td>
			</tr>
		</c:forEach>
	</table>
	</div>
</body>
</html>
