<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 관리 페이지</title>
<link rel="stylesheet" href="./css/board.css">
</head>
<script type="text/javascript">
function userDelete(){
	alert("탈퇴 시켰습니다.");
	;
}
</script>
<body>
<%@include file="/WEB-INF/views/nHeader.jsp"%>
	<div class="notice_wrap">

	<form action="./userDelete.do" method="post">
		<table summary="공지사항" class="notice_tb">
			<colgroup>
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
				<col width="*">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">닉네임</th>
					<th scope="col">등급</th>
					<th scope="col">주소</th>
					<th scope="col">가입일</th>
					<th scope="col">관리</th>
				</tr>
			</thead>
		<tbody id="notice">
		<c:forEach var="mdto" items="${lists}" varStatus="vs">
			<tr>
				<td>${vs.count}</td>
				<td>${mdto.id}</td>
				<td>${mdto.nickname}</td>
				<td>${mdto.auth}</td>
				<td>${mdto.address}</td>
				<td>
					<!-- regdate의 문자열의 형태가 Date타입을 변환이 가능한 형태로 변환 --> <fmt:parseDate
						var="StringToDate" value="${mdto.regdate}"
						pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
					<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" />
				</td>
				<td>
					<c:if test="${mdto.delflag eq 'Y'}">
						<span style="color: red;">이미 탈퇴했습니다.</span>
					</c:if>
					<c:if test="${mdto.delflag eq 'N'}">
						<a href="./userDelete.do?id=${mdto.id}"><Strong>탈퇴</Strong></a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
			</tbody>
		</table>
		</form>
	</div>
</body>
</html>