<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		th{	
			height: 29px;
			border-top: 0px;
			background-color: #424343;
			color: white;
			font-weight: normal;
		}
		td{
			border-top: 0px;
			border-bottom: 1px solid #424343;
			background-color: #FCFCFC;
		}
		#logoutBtn{
			font-family: "나눔스퀘어라운드B";
			font-size: 13px;
			padding: 5px 5px;
			color: white;
			background-color: 424343;
			border: none;
			margin: 5px 8px;
			border-radius: 5px;
			cursor: pointer;
			width: 65px;
			height: 30px;
		}
		#writeBtn{
			font-family: "나눔스퀘어라운드B";
			font-size: 15px;
			padding: 3px 3px;
			color: white;
			background-color: 4795DA;
			border: none;
			margin: 0px 5px;
			border-radius: 5px;
			cursor: pointer;
			width: 90px;
			height: 40px;
		}
		#writeBtn:hover{
			color: white;
			background-color: 549FE1;
		}
		#btn{
			font-family: "나눔스퀘어라운드B";
			font-size: 13px;
			padding: 5px 5px;
			color: white;
			border: none;
			margin: 5px 8px;
			border-radius: 5px;
			cursor: pointer;
			width: 65px;
			height: 30px;
			background-color: #3D7DB5;
		}
		.note-frame card{
			postion:realtive;
			margin:0 auto;
		}
		.note-editor{
			postion:realtive;
			margin:0 auto;
		}
		#commentBox{
			width: 850px;
			border: 3px solid #F8F8F8;
			text-align: left;
			position: relative;
			margin: 0 auto;
		}
		#replyList{
			height: auto;
			width: auto;
			text-align: left;
			position: relative;
			margin: 5px;
			padding: 15px 25px 15px 25px;
			background-color: #F8F8F8;
		}
		#replyBox{
			height: 140px;
			width: 840px;
			border: 3px solid #F8F8F8;
		 	position: relative;
		 	margin: 0 auto;
		 	background-color: #F8F8F8;
		}
		#replyWrite{
			height: 100px;
			width: 600px;
			text-align: left;
			position: relative;
			margin: 0 auto;
			padding: 10px 0px;
		}
		#replyBtn{
			font-family: "나눔스퀘어라운드R";
			font-size: 12px;
			padding: 2px 3px;
			color: white;
			border: none;
			margin: 1px 3px;
			border-radius: 5px;
			cursor: pointer;
			width: 50px;
			height: 25px;
			background-color: #C3A50E;
		}
	</style>
	
	<title>View</title>
</head>

<body>
<div class="form">
	<h1>게시판</h1>
	<P> 현재 시간 : ${serverTime} </P>
	${sessionScope.userId}님이 로그인 되어있습니다.
	<input type="button" value="로그아웃" id="logoutBtn" onclick="location.href='${pageContext.request.contextPath}/logout.do'">
	<hr>
	<input type="button" value="글쓰기" id="writeBtn" onclick="location.href='${pageContext.request.contextPath}/writePage.do'">
	<hr>
	<table style="margin-left: auto; margin-right: auto;">
		<tr>
			<th width="80">No.</th>
			<th width="400">제목</th>
			<th width="150">작성자</th>
			<th width="200">작성날짜</th>
		</tr>
		<tr>
			<td height="40" align=center>${content.boardNo}</td>
			<td>&nbsp;${content.boardTitle}</td>
			<td align=center>${content.userId}</td>
			<td align=center><fmt:formatDate pattern="YYYY-MM-dd HH:mm" value="${content.boardDate}"/></td>
		</tr>
		<tr>
			<th colspan="4" height="30"><b>내용</b></th>
		</tr>
		<tr>
			<td colspan="4" height="auto" valign="top" class="summernote"><br>${content.boardContent}<br></td>
		</tr>
		<tr>
			<td colspan="1" align=center> 첨부파일 </td>
			<td colspan="3" height="60px"><a href="${pageContext.request.contextPath}/fileDownload.do?fileName=${content.boardFile1}">${content.boardFile1}</a><br>
							<a href="${pageContext.request.contextPath}/fileDownload.do?fileName=${content.boardFile2}">${content.boardFile2}</a>
			</td>
		</tr>
	</table>
	<br>
	<c:if test="${sessionScope.userId == content.userId}">
		<input type="button" value="수정" id="btn" onclick="location.href='${pageContext.request.contextPath}/updateContent.do?boardNo=${content.boardNo}'">
		<input type="button" value="삭제" id="btn" onclick="location.href='${pageContext.request.contextPath}/deleteProcess.do?boardNo=${content.boardNo}'">
	</c:if>
	<input type="button" value="목록" id="btn" onclick="location.href='${pageContext.request.contextPath}/main.do'">
	<hr>
	
	<c:if test="${not empty requestScope.reply}">
		<div id="commentBox">
			<h2>&emsp; Comment</h2>
			<c:forEach items="${requestScope.reply}" var="reply">
				<div id="replyList">
					<form action="${pageContext.request.contextPath}/updateReplyPro.do" method="post" onsubmit="return doAlert()">
						<input type="hidden" value="${reply.replyNo}" name="replyNo">
						<input type="hidden" value="${content.boardNo}" name="boardNo">
						&nbsp;<font style="font-weight:bold; font-size: 20px;">${reply.replyWriter}</font> &emsp;
						<font style="color:grey;"><fmt:formatDate pattern="YYYY-MM-dd HH:mm" value="${reply.replyDate}"/></font>
						&emsp;
						<c:choose>
							<c:when test="${reply.replyNo == update}">
								<input type="submit" id="replyBtn" value="완료">
								<br><br>
								<input type="text" style="width:500px; height:100px;" name="updateReply" value="${reply.replyContent}">
							</c:when>
							<c:when test="${reply.replyNo != update}">
								<br><br>
								${reply.replyContent}
							</c:when>
						</c:choose>	
					</form>
				</div>
			</c:forEach>
		</div>
	</c:if>
	<br>
	<form action="${pageContext.request.contextPath}/writeReply.do?boardNo=${content.boardNo}" method="post">
		<div id="replyBox">
			<div id="replyWrite">
				<b>&emsp;Add | </b><br> 
				<input type="text" name="replyContent" style="width:500px; height:80px; margin:15px 10px 20px 20px;">
				<input type="submit" id="replyBtn" style="width:50px; height:80px;" value="등록">
			</div>
		</div>
	</form>
</div>
<script>
	function doAlert(){
		alert("수정이 완료되었습니다");
	}
</script>
</body>
</html>
