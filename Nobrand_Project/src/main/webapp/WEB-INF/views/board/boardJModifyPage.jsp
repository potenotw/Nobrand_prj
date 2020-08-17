<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판 글 수정</title>
<style type="text/css">
.nbr_input_button{
    
    width: 100%;
    display: block;
}
#addbutton:not(.disabled) {

}
</style>
</head>
<script type="text/javascript">
function unload(){
	alert("?");
	 window.opener.document.location.href = window.opener.document.URL;
}





</script>
<body onunload="unload()">
   <%@include file="/WEB-INF/views/bHeader.jsp"%>
<div class="container" style="margin-top: 50px;">
	<form action="#" method="post" id="frmModify" enctype="multipart/form-data">
	<table class="table" style="width: 100%">
	<colgroup>
		<col width="10%">
		<col width="90%">
	</colgroup>
      <tr>
        <th colspan="1">글번호</th>
      	 <td><input type="hidden" id="seq" name="seq" value="${dto.seq}">${dto.seq}</td>
      </tr>
      <tr>
      	<th>작성자</th><td>${dto.id}</td>
      </tr>
      <tr>
        <th>작성일</th>
        <td>
			<fmt:parseDate
				var="StringToDate" value="${dto.regdate}"
				pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
			<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" />
		<td>
		</tr>
<!--       파일 추가 제거   -->
      <tr>
      	<th>파일</th>
      		<td id="file_td"></td>
      </tr>
      <tr>
      	<th></th>
      </tr>
      <tr>
      	<th>등록된 파일</th>
      	<td style="padding: none;">
      	<c:forEach items="${fDto}" var="fDto">
      		<input type="text" name="files" value="${fDto.origin_name}" readonly="readonly"> [${fDto.filesize} byte] 
      			<a href="./fileDelete.do?seq=${fDto.seq}&board_seq=${fDto.board_seq}"><img alt="제거" src="./img/delete.jpg"></a><br>
		</c:forEach>
      	</td>
      </tr>
      <tr>
      	<th>제목</th>
      	<td><input type="text" id="title" class="nbr_input_button" name="title" style="padding: 0; height: auto;" value="${dto.title}"></td>
      </tr>
	  </table>
		<div id="editor">
		<textarea id="content" name="content" placeholder="글 내용을 작성해주세요">${dto.content}</textarea>
			<script type="text/javascript">
			 var ckeditor_config = {
					   resize_enaleb : false,
					   enterMode : CKEDITOR.ENTER_BR,
					   shiftEnterMode : CKEDITOR.ENTER_P,
					   filebrowserUploadUrl : "./ckUpload.do"
					 };
			 CKEDITOR.replace("content", ckeditor_config);
			 CKEDITOR.instances["content"].getData()
			</script>
		</div>
	<div style="margin: 10px 0px 80px 0px; float: right;">
		<button type="button"  class="btn btn-default" value="뒤로가기" onclick='bBack()'>취소</button>
		<button type="button" class="btn btn-default" value="등록" onclick="boardJModify()">등록</button>	
	</div>
  </form>
</div>
</body>
</html>