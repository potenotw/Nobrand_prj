<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글 작성</title>
<style type="text/css">
.nbr_input_button{
    padding: 0;
    width: 100%;
    height: 25px;
    display: block;
}
</style>
</head>
<body>
   <%@include file="/WEB-INF/views/header.jsp"%>
	<div class="container"  style="margin-top: 50px; width: 80%; ">
		<form action="#" method="post" id="frmWrite">
			<table class="table" style="width: 80%; margin-left: 70px;">
				<colgroup>
					<col width="10%">
					<col width="90%">
				</colgroup>
				<tr>
					<th>작성자</th>
					<td><input type="hidden" id="id" name="id"  value="${bDto.id}">관리자</td>
				</tr>
				<!--       파일 추가 제거   -->
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" name="title" class="nbr_input_button" placeholder="글 제목을 작성해주세요(40자 내)"></td>
				</tr>
			</table>
			<div style="width: 85%; margin-left: 70px;">
				<textarea id="content" name="content"></textarea>
				<script type="text/javascript">
// 				var con = ;
				var ckeditor_config = {
						   resize_enaleb : false,
						   enterMode : CKEDITOR.ENTER_BR,
						   shiftEnterMode : CKEDITOR.ENTER_P,
						   filebrowserUploadUrl : "./ckUpload.do"
						 };
					 CKEDITOR.replace("content", ckeditor_config);
				</script>
				<div style="margin: 10px 0px 80px 0px;">
					<input id="nbr_button" class="btn btn-default"  type="button"  value="등록" onclick="boardGWrite()">
					<input id="nbr_button" type="button" class="btn btn-default" value="목록" onclick="boardGListPage()">
				</div>
			</div>
		</form>
	</div>
</body>
</html>