<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 게시판 상세보기</title>
<style type="text/css">
#title{
/* 	width: 100px; */
	height: auto;
}
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
div.gallery {
  border: 6px double #gray;
  height: 300px;
  overflow: hidden;
  border-radius: 10px; 
}


div.gallery img {
  width: 100%;
  height: auto;
}

div.desc {
  padding: 15px;
  text-align: center;
/*   bottom-border-readius : 10px double #f0f0f0; */
  border-radius: 5px;
  border-bottom: 2px double black;
}

* {
  box-sizing: border-box;
}
.thumbnail { position: relative; padding-top: 100%; /* 1:1 ratio */ overflow: hidden; }

.responsive {
  padding: 0 6px 0px 5px;
  float: left;
  width: auto;
  height: auto;
  margin-left: 10px;
}

</style>
</head>
<script type="text/javascript">
//글삭제 영역
function boardDel() {
	var con = confirm("삭제 하시겠습니까?");
	if (con == true) {
	  //delete
		alert('삭제 되었습니다.');
		location.href = "./boardRDelete.do?seq="+${bDto.seq};
		window.opener.location.reload();
		window.close();
		} else {
	  return false;
	}
}
function unload(){
	 window.opener.document.location.href = window.opener.document.URL;
}
</script>
<body onunload="unload()">
<%@include file="/WEB-INF/views/nHeader.jsp"%>

<div class="container"  style="margin-top: 80px; width: 800px; margin-left: 0px;">
 <table class="table" style="width: 70%">
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
      	<th id="title">제목</th><td colspan="2">${bDto.title}</td>
      </tr>
      <tr>
      	<th>조회수</th><td>${bDto.readcount}</td>
      </tr>
  </table>
	<div class="responsive" style="position: absolute; width:290px; top: 60px; left: 485px; background-color: white;  ">
		<div class="gallery">
				<img src="${bDto.nbrimg}">
		</div>
	</div>
	<div style="width: 100%; min-height:300px; border: 1px double black; scrollbars=yes; margin-top: 110px;" >
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
							<a href="./commentsRDel.do?seq=${cdto.seq}&board_seq=${cdto.board_seq}" onclick="commentDel()">
									<img alt="삭제" src="./img/delete.jpg"></a>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${user}">
								<c:if test="${id eq bDto.id || id eq cdto.id}">
									<a href="./commentsRDel.do?seq=${cdto.seq}&board_seq=${cdto.board_seq}" onclick="commentDel()">
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
				<button type="button" class="btn btn-default" value="등록" onclick="commentRWrite()">등록</button>
			</td>
	  	</tr>
		</table>
	</form>
		<c:choose>
			<c:when test="${user}">
				<c:if test="${id eq bDto.id}">
					<div style="margin: 10px 0px 80px 0px; float: right;">
						<button type="button"  class="btn btn-default" value="삭제" onclick='boardDel("+${bDto.seq}+")'>삭제</button>
					  	<button " class="btn btn-default"><a style="color: black;" href="./boardRModifyPage.do?seq=${bDto.seq}">수정</a></button>
					</div>
				</c:if>
				<div style="margin-bottom: 80px;"></div>
			</c:when>
		</c:choose>
		<c:if test="${admin}">
			<div style="margin: 10px 0px 80px 0px; float: right;">
				<button type="button"  class="btn btn-default" value="삭제" onclick='boardDel("+${bDto.seq}+")'>삭제</button>
			  	<button " class="btn btn-default"><a style="color: black;" href="./boardRModifyPage.do?seq=${bDto.seq}">수정</a></button>
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

