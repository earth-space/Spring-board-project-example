<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="../../resources/font.css" rel="stylesheet" type="text/css" />
	<style>
		.login{
			text-align: center;
			font-family: "나눔스퀘어라운드R";
		}
		h1{
			font-family: "나눔바른고딕";
			font-size: 40px;
		}
		h2{
			font-size: 30px;
		}
		.loginBtn{
			font-family: "나눔스퀘어라운드B";
			font-size: 15px;
			padding: 5px 5px;
			color: white;
			background-color: #424343 !important;
			border: none;
			margin: 5px 8px;
			border-radius: 5px;
			cursor: pointer;
			width: 70px;
			height: 40px;
		}
	</style>
	<title>Login</title>
</head>

<body>
<div class="login">
	<form action="${pageContext.request.contextPath}/loginProcess.do" method="post">
		<h1> 게시판 </h1>
		<hr>
		<h2> 로그인 </h2>
		<label>아이디&ensp;&ensp;</label>
		<input type='text' style="width:100px; margin:5px 0px 5px 0px;" name='userId'>
		<br>
		<label>비밀번호&nbsp;</label>
		<input type='password' style="width:100px; margin:5px 0px 5px 0px;" name='password'>
		<br><br>
		<input type="submit" value="로그인" class="loginBtn">&emsp;
	</form>
</div>
</body>
</html>