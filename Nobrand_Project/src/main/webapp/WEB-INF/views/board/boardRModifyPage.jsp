<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 게시판 글 수정</title>
<style type="text/css">
.nbr_input_button{
    padding: 0;
    width: 100%;
    height: auto;
    display: block;
}
div#gallery {
  border: 6px double #gray;
  height: 300px;
  overflow: hidden;
  border-radius: 10px; 
}


div#gallery img {
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
<body>
<%@include file="/WEB-INF/views/nHeader.jsp"%>
<div class="container" style="margin-top: 50px;">
	<form action="#" method="post" id="boardRModify" enctype="multipart/form-data">
	<table class="table" style="width: 65%">
	<colgroup>
		<col width="20%">
		<col width="80%">
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
      	<th>썸네일 변경</th>
      	<td>
      		<input type="file" id="nbrimg" name="filename" />
      	</td>
      </tr>
      <tr>
      	<th>분류</th>
      	<td>리뷰</td>
      </tr>
      <tr>
      	<th>제목</th>
      	<td>
      		<input type="text" id="title" name="title" style="padding: 0; height: auto;" class="nbr_input_button" value="${dto.title}">
      	</td>
      </tr>
	  </table>
	  		<div class="responsive" style="position: absolute; top: 60px; left: 700px; width:300px; background-color: white; ">
				<div id="gallery" class="select_img">
				<p>이미지 미리보기</p>
					<img id="selectImg" style="width: 100%;" src="${dto.nbrimg}">
					<input type="hidden" name="nbrimg" value="${dto.nbrimg}">
					<input type="hidden" name="thumbimg" value="${dto.thumbimg}">
				</div>
			</div>
			<script type="text/javascript">
			 $("#nbrimg").change(function(){
				if(this.files && this.files[0]) {
				    var reader = new FileReader;
				    reader.onload = function(data) {
				     $(".select_img img").attr("src", data.target.result);   	     
				}
					reader.readAsDataURL(this.files[0]);
				}
				if($(this).val != ""){
					var ext = $(this).val().split('.').pop().toLowerCase();
					if($.inArray(ext, ['jpg','gif','png','bmp'])==-1){
						alert('이미지만 등록이 가능합니다.');
						$(this).val(""); //파일명을 다시 지워줌
						return
					}
				}
			});
		 </script>
			 <script>
// 			 $("#nbrimg").change(function(){
// 			   if(this.files && this.files[0]) {
// 			    var reader = new FileReader;
// 			    reader.onload = function(data) {
// 			     $(".select_img img").attr("src", data.target.result).width(180);        
// 			    }
// 			    reader.readAsDataURL(this.files[0]);
// 			   }
// 			  });
			 </script>
		<div id="editor"  style="margin-top: 85px;">
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
		<button type="button" class="btn btn-default" value="등록" onclick="boardRModify()">등록</button>	
	</div>
  </form>
</div>
</body>
</html>