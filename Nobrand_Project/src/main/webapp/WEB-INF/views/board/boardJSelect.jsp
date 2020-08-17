<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판 상세보기</title>
<style type="text/css">
#side{
	padding: 8px; 
	font-weight: 2px; 
	font-style: italic;
}
#sideList{
	position: fixed;
	bottom: 0px;
	left : 800px;
	top: 80px;
	width: 280px;
	z-index: 99;
}
</style>
</head>
<script type="text/javascript">
//글삭제 영역
function boardDel() {
	//alert yes/no
	var con = confirm("삭제 하시겠습니까?");
	if (con == true) {
		alert('삭제 되었습니다.'); 
		location.href = "./boardJDelete.do?seq="+${bDto.seq};
		window.opener.location.reload();
		//삭제되었을때 자동으로 창 닫으면서 부모창 새로고침
		window.close();
		} else {
	  return false;
	}
}
//자식창 닫을때 부모창 새로고침
function unload(){
	 window.opener.document.location.href = window.opener.document.URL;
}
</script>
<body onunload="unload()">
<%@include file="/WEB-INF/views/nHeader.jsp"%>

<div class="container"  style="margin-top: 80px; width: 800px; margin-left: 0px;">
 <table class="table" style="width: 100%">
	<colgroup>
		<col width="20%">
		<col width="80%">
	</colgroup>
      <tr>
        <th>글번호</th><td>${bDto.seq}</td>
      </tr>
      <tr>
      	<th>작성자</th><td>${bDto.id}</td>
      </tr>
      <tr>
        <th>작성일</th>
        <td>
			<fmt:parseDate
				var="StringToDate" value="${bDto.regdate}"
				pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
			<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" />
		<td>
		</tr>
      <tr>
      	<th>제목</th><td colspan="2">${bDto.title}</td>
      </tr>
	  <tr>
      	<th>조회수</th><td>${bDto.readcount}</td>
      </tr>
      <!-- 파일다운로드 -->
      <tr>
      	<th>파일</th>
  	 	<td>
  	 	<c:forEach var="fDto" items="${fDto}">
			<a href="./fileDownLoad.do?stored_name=${fDto.stored_name}&origin_name=${fDto.origin_name}">${fDto.origin_name}</a>
							[${fDto.filesize} byte]<br>
		</c:forEach>
		</td>
      </tr>
  </table>
  	
	<div style="width: 100%; min-height:300px; border: 1px double black; scrollbars=yes;" >
<!-- 		<textarea id="content" name="content" class="materialize-textarea"></textarea> -->
		<textarea name="content" id="content" readonly="readonly">${bDto.content}</textarea>
	</div>
	
	<script type="text/javascript">
		CKEDITOR.replace( 'content');
		var ckValue = CKEDITOR.instances["content"].getData();
	</script>
	
	<!-- 댓글 영역 --> 
	<h4>댓글</h4>
  <table class="table">
		<colgroup>
			<col width="10%">
			<col width="80%">
			<col width="10%">
		</colgroup>
		<thead>
	  		<tr>
	  			<th>작성자</th>
	  			<th  colspan="6">내용</th>
	  		</tr>
  		</thead>
		<c:forEach var="cdto" items="${lists}" varStatus="vs">
				<tr>
					<td>${cdto.id}</td>
					<td>${cdto.content}</td>
					<td>
						<c:choose>
							<c:when test="${admin}">
							<a href="./commentsJDel.do?seq=${cdto.seq}&board_seq=${cdto.board_seq}" onclick="commentDel()">
									<img alt="삭제" src="./img/delete.jpg"></a>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${user}">
								<c:if test="${id eq bDto.id || id eq cdto.id}">
							<a href="./commentsJDel.do?seq=${cdto.seq}&board_seq=${cdto.board_seq}" onclick="commentDel()">
									<img alt="삭제" src="./img/delete.jpg"></a>
								</c:if>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
		</c:forEach>
	</table>

	
	<h4>댓글 작성</h4>
	<sec:authentication property="principal.username" var="username"/>
	<!-- 댓글 작성 form -->
	<form action="#" method="post" id="comments">
	  <table class="table" style="width: 100%">
	  	<tr>
	  		<td>
	  			${username}
				<input type="hidden" id="id" name="id" value="${username}">
				<input type="hidden" id="board_seq" name="board_seq" value="${bDto.seq}">
	  		</td>
	  		<td>
	  			<textarea rows="2" cols="80" id="c_content" name="content" placeholder="댓글을 입력해주세요"></textarea>
			</td>
			<td>
				<button type="button" class="btn btn-default" value="등록" onclick="commentJWrite()">등록</button>
			</td>
	  	</tr>
		</table>
	</form>
<!-- 	<div class="news_sch_wrap" style=""> -->
	<c:choose>
		<c:when test="${user}">
			<c:if test="${id eq bDto.id}">
				<div style="margin: 10px 0px 80px 0px; float: right;">
					<button type="button"  class="btn btn-default" value="삭제" onclick='boardDel("+${bDto.seq}+")'>삭제</button>
				  	<button " class="btn btn-default"><a style="color: black;" href="./boardJModifyPage.do?seq=${bDto.seq}">수정</a></button>
				</div>
			</c:if>
			<div style="margin-bottom: 80px;"></div>
		</c:when>
	</c:choose>
		<c:if test="${admin}">
				<div style="margin: 10px 0px 80px 0px; float: right;">
					<button type="button"  class="btn btn-default" value="삭제" onclick='boardDel("+${bDto.seq}+")'>삭제</button>
				  	<button " class="btn btn-default"><a style="color: black;" href="./boardJModifyPage.do?seq=${bDto.seq}">수정</a></button>
				</div>
		</c:if>
	</div>
<div id="sideList">
	<h2 style="text-align: center; font-size: 15pt;"><strong>작성자의 다른 게시글</strong></h2>
		<div style="width: 100%; border: 1px double black;">
			<table summary="사이드" class="notice_tb" style="margin: auto;">
				<tr >
					<th style="padding: 5px; font: 12px;">분류</th>
					<th style="padding: 5px; font: 12px;">제목</th>
				</tr>
				<c:forEach var="lists" items="${selList}">
				<tr style="padding: 0 0 0 0px;">
						<c:if test="${lists.gubun eq 'J'}">
						<td id="side" style="color: blue;">자유</td>
						<td id="side">
								<c:choose>
									<c:when test="${fn:length(lists.title)>6}">
										 <a href="./boardJSelect.do?seq=${lists.seq}">${fn:substring(lists.title,0,6)}...</a>
									</c:when>
									<c:otherwise>
										<a href="./boardJSelect.do?seq=${lists.seq}">${lists.title}</a>
									</c:otherwise>
								</c:choose>
						</td>
						</c:if>
						<c:if test="${lists.gubun eq 'R'}">
						<td id="side" style="color: green;">리뷰</td>
						<td id="side">
								<c:choose>
									<c:when test="${fn:length(lists.title)>6}">
										 <a href="./boardRSelect.do?seq=${lists.seq}">${fn:substring(lists.title,0,6)}...</a>
									</c:when>
									<c:otherwise>
										<a href="./boardRSelect.do?seq=${lists.seq}">${lists.title}</a>
									</c:otherwise>
								</c:choose>
						</td>
						</c:if>
				</tr>
				</c:forEach>
			</table>
		</div>
</div>
</body>
</html>

