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
			font-family: "나눔스퀘어라운드R";
			text-align: center;
		}
		.login{
			font-size: 20px;
			padding: 10px 10px;
			color: white;
			background-color: 424343;
			margin: 4px 2px;
			border-radius: 5px;	
		}
		.join{
			font-size: 20px;
			padding: 10px 10px;
			color: white;
			background-color: 424343;
			margin: 4px 2px;
			border-radius: 5px;	
		}
		h1{
			font-family: "나눔바른고딕";
			font-size: 40px;
		}
		th{
			border-top: 0px;
			border-bottom: 2px solid #424343;
			background-color: 424343;
			color: white;
			font-weight: normal;
		}
		tr{
			border-top: 0px;
			border-bottom: 1px solid #424343;
			background-color: #FCFCFC;
		}
		td{
			border-top: 0px;
			border-bottom: 1px solid #424343
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
		a:link{
			font-size: 16px;
			text-decoration: none;
			color: black;
		}
		a:visited{
			color: black;
		}
	</style>
	<title>Main</title>
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
	<br>
		<c:if test="${not empty requestScope.board}">
		<table style="margin-left: auto; margin-right: auto;">
			<thead>
				<tr>
					<th width="30" height="30">No.</th>
					<th width="500">제목</th>
					<th width="100" align="center">작성자</th>
					<th width="180">작성시간</th>
				</tr>
			</thead>
			<c:forEach items="${requestScope.board}" var="board">
			<tbody>
				<tr>
					<td align=center height="30">${board.boardNo}</td>
		    		<td>
		    			&nbsp;<a href="${pageContext.request.contextPath}/viewContent.do?boardNo=${board.boardNo}">${board.boardTitle}</a>
		    			<font style="font-size:14px; color:grey;">[${board.replyCount}]</font>
		    		</td>
					<td align=center>${board.userId}</td>
					<td align=center><fmt:formatDate pattern="YYYY-MM-dd HH:mm" value="${board.boardDate}"/></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>	
		<br>
		<c:if test="${paging.startPage != 1}">
			<a href="${pageContext.request.contextPath}/main.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">◀ </a>
		</c:if>
		
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pageNum">
			<c:choose>
				<c:when test="${pageNum == paging.nowPage }">
					<a><font size="4">${pageNum}</font></a>
				</c:when>
				
				<c:when test="${pageNum != paging.nowPage }">
					<a href="${pageContext.request.contextPath}/main.do?nowPage=${pageNum}&cntPerPage=${paging.cntPerPage}"><font color="666666">${pageNum}</font></a>
				</c:when>
			</c:choose>
		</c:forEach>
		
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="${pageContext.request.contextPath}/main.do?nowPage=${paging.endPage + 1}&cntPerPage=${paging.cntPerPage}"> ▶</a>
		</c:if>
		</c:if>
</div>
</body>
</html>
</html>
