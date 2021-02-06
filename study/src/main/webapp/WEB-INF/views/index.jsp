<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="UTF-8">
	<link href="../../resources/font.css" rel="stylesheet" type="text/css" />
	<style>
		.form{
			margin: 30px;
			text-align: center;
			font-family: "나눔스퀘어라운드R";
		}
		h1{
			font-family: "나눔바른고딕";
			font-size: 40px;
		}
		#button{
			font-family: "나눔스퀘어라운드R";
			font-size: 20px;
			padding: 15px 25px;
			color: white;
			border: none;
			background-color: 424343;
			margin: 150px 30px;
			border-radius: 5px;
			cursor: pointer;
		}
		#button:hover{
			color: 424343;
			background-color: white;
		}
	</style>
	<title>Home</title>
</head>

<body>
<div class="form">
	<h1>게시판</h1>
	<P> 현재 시간 : ${serverTime} </P>
	<hr>
	<c:if test="${request.getSession()==null}">
		<input type="button" id="button" value="로그인" onclick="location.href='${pageContext.request.contextPath}/login.do'">
		<input type="button" id="button" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/join.do'">
	</c:if>
	<hr>
</div>
</body>
</html>
