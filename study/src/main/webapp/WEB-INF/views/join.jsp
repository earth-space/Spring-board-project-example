<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../../resources/font.css" rel="stylesheet" type="text/css" />
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
<style>
	.join{
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
	a{
		font-size: 13px;
		color: #424343;
	}
	p{
		font-size: 13px;
		color: #424343;
	}
	.formBox{
		background-color: #F7F7F7;
		width: 350px;
		height: auto;
		position: relative;
		margin: 0 auto;
		padding: 20px 0px;
		border-radius: 10px;
	}
	.inputBox{
		text-align: left;
		margin: 5px 0px 0px 80px;
	}
	.btn{
		font-family: "나눔스퀘어라운드B";
		font-size: 18px;
		padding: 5px 5px;
		color: white;
		background-color: #424343 !important;
		border: none;
		margin: 5px 5px;
		border-radius: 5px;
		cursor: pointer;
		width: 70px;
		height: 40px;
	}
	#cancelBtn{
		background-color: #CA3E3E !important;
	}
	#idCheckBtn{
		font-family: "나눔스퀘어라운드R";
		font-size: 12px;
		padding: 2px 3px;
		color: white;
		border: none;
		margin: 1px 3px;
		border-radius: 5px;
		cursor: pointer;
		width: 60px;
		height: 25px;
		background-color: #4795DA;
	}
</style>
<title>Join</title>
</head>

<body>
<div class="join">
	<form action="${pageContext.request.contextPath}/joinProcess.do" method="post" name="userInfo" onsubmit="checkValue()">
		<h1> 게시판 </h1>
		<hr>
		<h2> 회원 가입 </h2>
		<div class="formBox">
			<div class="inputBox">
				<b>이름&emsp;&emsp;</b>
				<input type='text' style="width:100px; margin:5px 0px 5px 0px;" name='name'>
				<br><br>
				<b>아이디&nbsp;&emsp;</b>
				<input type="text" id="userId" name="userId" style="width:100px; margin:5px 0px 5px 0px;">&ensp;
				<input type="button" id="idCheckBtn" class="idCheck" value="중복 확인">
				<p class="result">
					<span class="message">※ 아이디 중복 확인을 해주세요</span>
				</p>
				<a>※ 1자~10자의 영문으로 입력해주세요</a>
				<br><br>
				<b>비밀번호&nbsp;</b>
				<input type='password' style="width:100px; margin:5px 0px 5px 0px;" name='password'>
				<br>
				<a>※ 6자~10자의 영문/숫자로 입력해주세요</a>
			</div>
		</div>
		<br><br>
		<input type="submit" value="완료" class="btn">&emsp;
		<input type="button" value="취소" class="btn" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/home.do'">
	</form>
</div>
<script>
	$("#idCheckBtn.idCheck").click(function(){
		var query = {userId : $("#userId").val()};
		
		$.ajax({
			url : "${pageContext.request.contextPath}/idCheck.do",
			type : "post",
			data : query,
			success : function(data){
				if(data == 1){
					$(".result .message").text("이미 사용중인 아이디입니다");
					$(".result .message").attr("style", "color: #D82F2F");
				}else{
					$(".result .message").text("사용 가능한 아이디입니다");
					$(".result .message").attr("style", "color: #4795DA");
				}
			}
		});
	});
</script>
</body>
</html>