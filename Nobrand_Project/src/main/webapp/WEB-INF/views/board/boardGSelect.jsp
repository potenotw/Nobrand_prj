<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
</head>
<!-- /boardGDelete.do -->
<script type="text/javascript">
//글삭제 영역
function boardDel() {
	var con = confirm("삭제 하시겠습니까?");
	if (con == true) {
	  //delete
		alert('삭제 되었습니다.');
		location.href = "./boardGDelete.do?seq="+${bDto.seq};
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

<div class="container"  style="margin-top: 80px; width: 800px;">
 <table class="table" style="width: 100%">
	<colgroup>
		<col width="10%">
		<col width="80%">
	</colgroup>
      <tr>
        <th>글번호</th><td>${bDto.seq}</td>
      </tr>
      <tr>
      	<th>작성자</th><td>관리자</td>
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
      	<th>조회수</th>
      	<c:if test="${bDto.readcount eq null}">
      		<td>0</td>
      	</c:if>
      		<td>${bDto.readcount}</td>
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
	
	<!-- 수정 삭제 영역 -->
	<c:if test="${admin}">
		<div style="margin: 10px 0px 80px 0px; float: right;">
			<button type="button"  class="btn btn-default" value="삭제" onclick='boardDel("+${bDto.seq}+")'>삭제</button>
		  	<button class="btn btn-default"><a style="color: black;" href="./boardGModifyPage.do?seq=${bDto.seq}">수정</a></button>
		</div>
	</c:if>
	<c:if test="${user}">
		<div style="width: 100%; height: auto; text-align: center; margin-bottom:80px; background-color: #e7e7e7; line-height: 150px;"> 
			<h4>공지사항은 관리자만 작성 가능합니다.</h4>
		</div>
	</c:if>
</div>
</body>
</html>

