<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<a href="${pageContext.request.contextPath}/getBoardTitle.do">타이틀 가져오기</a>
<table>
	<thead>
		<tr>
			<th>제목</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${requestScope.board}" var="board">
		<tr>
			<td>${board.boardTitle}</td>
		</tr>
	</c:forEach>
	</tbody>
</table>

</body>
</html>
