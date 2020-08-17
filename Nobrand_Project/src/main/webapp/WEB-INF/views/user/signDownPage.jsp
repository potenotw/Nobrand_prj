<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 랕퇴 페이지</title>
<link rel="stylesheet" href="./css/common-pc.css">
<link rel="stylesheet" href="./css/login.css">
</head>
<script type="text/javascript">
function signDown(){
	var id = document.getElementById("id").value;
	var con = confirm("정말 탈퇴하시겠습니까?");
	if(con==true){
		location.href="./signDown.do?id="+id;
		alert("탈퇴했습니다.");
		opener.parent.location='./logout.do';
	}else{
		return false;
	}
	window.close();
}
</script>
<body>
	<%@include file="/WEB-INF/views/nHeader.jsp"%>
	<div class="nobrandCon_wrapping max_width_area" style="margin-top: 200px;">
		<div class="main_area">
			<!-- 메인콘텐츠 시작 -->
			<section class="main_nobrandCon">
				<article class="tab member active">
					<h1 class="title">회원 탈퇴</h1>
					<div class="tab_nobrandCon">
						<div  style="color: red; text-align: center;">
						<h2 class="sub_title">버튼 클릭 시 해당 아이디가 탈퇴 처리됩니다.</h2>
						</div>
							<div class="nobrand_Login_form">
								<div class="input_area">
									<sec:authentication property="principal.username" var="id"/>
									<input type="text" id="id" name="id" value="${id}" readonly="readonly"> 
								</div>
							</div>
								<input style="color: white;" type="button" class="btn_submit" value="회원 탈퇴" onclick="signDown()">
					</div>
				</article>
			</section>
			<!-- 메인콘텐츠 끝 -->
		</div>
	</div>
</body>
</html>