<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 게시판 글 작성</title>
<style type="text/css">
.nbr_input_button{
    padding: 0;
    width: 100%;
    height: auto;
    display: block;
}
div.gallery {
  border: 6px double #gray;
  height: 250px;
  overflow: hidden;
  border-radius: 10px; 
  background-color: #e7e7e7;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 75%;
  height: auto;
}

div.desc {
  padding: 15px;
  text-align: center;
}

* {
  box-sizing: border-box;
}
.thumbnail { position: relative; padding-top: 100%; /* 1:1 ratio */ overflow: hidden; }

.responsive {
  padding: 0 6px;
  float: left;
  width: 24.99999%;
}
.thumbnail { position: relative; padding-top: 100%; /* 1:1 ratio */ overflow: hidden; }
</style>
</head>
<body>
<%@include file="/WEB-INF/views/header.jsp"%>
<div class="container"  style="margin-top: 50px; width: 70%;">
<form action="#" method="post" id="frmWrite" enctype="multipart/form-data">
	<div class="col-sm-4" style="width: 70%">
	 <table class="table" style="width: 100%">
		<colgroup>
			<col width="20%">
			<col width="80%">
		</colgroup>
	      <tr>
	      	<th>작성자</th><td><input type="hidden" id="id" name="id" value="${bDto.id}">${bDto.id}</td>
	      </tr>
	      <tr>
	      	<th>제목</th><td colspan="2">	<input class="nbr_input_button" type="text" id="title" name="title" placeholder="제목을 입력해주세요(40자 내)"></td>
	      </tr>
     		<tr>
				<th>분류</th>
				<td>리뷰 게시판</td>
			</tr>
		  </table>
	  	<div style="width: 100%; height: auto; text-align: center; background-color: #e7e7e7; line-height: 150px;"> 
			<span>썸네일 등록은 필수입니다.</span>
	  	</div>
	  </div>
<!-- 	  	썸네일 이미지 영역 -->
		<div class="responsive" style="width: 30%; height: 300px; border: 1px solid black;  overflow: auto">
			<div id="gallery">
				<input type="file" id="nbrimg" name="filename" >
					<p>썸네일 미리보기</p>
				<div id="thumbnail" class="select_img">
				<img src="" name="nbrimg" class="img-rounded" border="1px solid black">
						
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
			</div>
		</div>
	<div id="editor" style="width: 100%;">
		<textarea id="content" name="content"></textarea>
			<script type="text/javascript">
			 var ckeditor_config = {
					   resize_enaleb : false,
					   enterMode : CKEDITOR.ENTER_BR,
					   shiftEnterMode : CKEDITOR.ENTER_P,
					   filebrowserUploadUrl : "./ckUpload.do"
					 };
				 CKEDITOR.replace("content", ckeditor_config);
			</script>
		</div>
		<div style="margin: 10px 0px 80px 0px;">
			<input id="nbr_button" class="btn btn-default"  type="button"  value="등록" onclick="boardRWrite()">
			<input id="nbr_button" type="button" class="btn btn-default" value="목록" onclick="boardRListPage()">
		</div>
	</form>
</div>
</body>
</html>