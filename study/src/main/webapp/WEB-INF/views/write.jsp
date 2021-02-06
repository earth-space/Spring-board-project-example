<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="../../resources/font.css" rel="stylesheet" type="text/css" />
	<style>
		.write{
			margin: 30px;
			text-align: center;
			font-family: "나눔스퀘어라운드R";
		}
		h1{
			font-family: "나눔바른고딕" !important;
			font-size: 40px !important;
			font-weight: bold !important; 
		}
		h2{
			font-size: 30px;
			font-family: "나눔스퀘어라운드B" !important; 
		}
		.note-frame card{
			postion: realtive;
			margin: 0 auto;
		}
		.note-editor{
			postion: realtive;
			margin: 0 auto;
		}
		.p{
			padding: 5px 0px 5px 0px;
			font-weight: bold;
			font-size: 18px;
			color: #337AB7;
		}
		.button{
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
	</style>
	
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>

	
	<title>Write</title>
</head>
<body>
	<div class="write">
		<form action="${pageContext.request.contextPath}/writeProcess.do" onsubmit="return doAlert()" method="post" enctype="multipart/form-data">
			<h1> 게시판 </h1>
			<hr>
			<h2> 게시글 작성 </h2>
			<br><br>
			<a style="font-size:17px; font-weight:bold;">작성자 |&emsp;</a> <b>${sessionScope.userId}</b>&emsp;
			<br>
			<input type='text' style="width:500px; margin:10px 0px 10px 0px;" placeholder="제목" name='boardTitle'>
			<br>
			<div>
			<textarea id='summernote' name='boardContent'></textarea>
			</div>
			<br>
			<div style="height:120px; width: 804px; border: 3px solid #F8F8F8; text-align: left; position:relative; margin: 0 auto; background-color:#F8F8F8;">
				<p class="p">&ensp;첨부파일 |</p>
				<input type="file" multiple name="file1" style="position:relative; margin:10px 0px 0px 20px" >
				<input type="file" multiple name="file2" style="position:relative; margin:8px 0px 0px 20px" >
			</div>
			<br><br>
			<input type="submit" value="완료" class="button">&emsp;
			<input type="button" value="취소" class="button" id="cancelBtn" onclick="location.href='${pageContext.request.contextPath}/main.do'">
		</form>
	</div>

<script>
	function doAlert(){
		alert("작성이 완료되었습니다");
	}
	
	$(function() {
		$('#summernote').summernote({
		        height: 300,
		        width: 800,
			    minHeight: 370,
			    maxHeight: null,
			    focus: true, 
		        lang: 'ko-KR',
		        toolbar: [
				    ['fontname', ['fontname']],
				    ['fontsize', ['fontsize']],
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    ['color', ['forecolor','color']],
				    ['table', ['table']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']],
				    ['insert',['picture','link','video']],
				    ['view', ['fullscreen', 'help']]
				  ],
				fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
				fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		        callbacks: {
		        	onImageUpload: function(files, editor, welEditable) {
		        		for(var i = files.length -1; i>=0; i--) {
		        			sendFile(files[i], this);
		        		}
		        	}
		        }
		 });
	});
	
</script>
</body>
</html>