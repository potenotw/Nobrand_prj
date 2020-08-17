<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 게시판</title>
<link rel="stylesheet" href="./css/board.css">
</head>
<body>
	<%@include file="/WEB-INF/views/header.jsp"%>
	<div class="notice_wrap" style="margin-top:50px">
	<h2>공지사항 게시판</h2>
		<form action="./boardGDeleteMul.do" method="post" id="chk" name="chk"
			onsubmit="chkGbox()">
			<table summary="공지사항" class="notice_tb">
				<colgroup>
					<c:if test="${admin}">
					<col width="5.45454%">
					</c:if>
					<col width="5.24251%">
					<col width="50%">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<sec:authorize access="hasRole('ROLE_Admin')" var="admin"/>
						<c:if test="${admin}">
						<th><input type="checkbox" onclick="chkGAll(this.checked)"></th>
						</c:if>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">아이디</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody id="notice">
					<c:forEach var="bdto" items="${lists}" varStatus="vs">
						<tr>
							<c:if test="${admin}">
							<td><input type="checkbox" name="chkval" value="${bdto.seq}"></td>
							</c:if>
							<td>${bdto.seq}</td>
							
							<c:choose>
									<c:when test="${fn:length(bdto.title)>20}">
										 <td>
										 	<a href="#" onclick="window.open('./boardGSelect.do?seq=${bdto.seq}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=800,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,20)}...</a></td>
									</c:when>
									<c:otherwise>
										<td><a href="#" onclick="window.open('./boardGSelect.do?seq=${bdto.seq}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=800,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}</a></td>
									</c:otherwise>
							</c:choose>
							<td>관리자</td>
							<td>
								<!-- regdate의 문자열의 형태가 Date타입을 변환이 가능한 형태로 변환 --> <fmt:parseDate
									var="StringToDate" value="${bdto.regdate}"
									pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
								<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" />
							</td>
							<td>&nbsp;&nbsp;${bdto.readcount}&nbsp;&nbsp;</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
			<c:if test="${admin}">
				<div class="news_sch_wrap">
					<p>
						<label for="sch_bar" class="a11y">
							<a href="./boardGWritePage.do">글 작성</a>
							<input type="submit" value="삭제">
						</label>
					</p>
				</div>
			</c:if>
			<div>
				
			</div>
			<div class="news_pagination">
				<ul class="pager">
					<li class="">
						<c:if test="${paging.startPage != 1 }">
						<a href="./boardGList.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">
								<img alt="앞으로" src="./img/left.jpg">
						</a>
					</c:if>
				</li>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p">
					<li class="active">						
						<c:choose>
							<c:when test="${p == paging.nowPage }">
							<b>${p}</b>
								</c:when>
									<c:when test="${p != paging.nowPage }">
									<a href="./boardGList.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p}</a>
								</c:when>
							</c:choose>
					</li>
				</c:forEach>
				<li class="">
					<c:if test="${paging.endPage != paging.lastPage}">
						<a href="./boardGList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">
								<img alt="앞으로" src="./img/right.jpg">
						</a>
					</c:if>
				</li>
			</ul>
			</div>
		</form>
	</div>
</body>
</html>








