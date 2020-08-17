<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과(비밀번호 변경)</title>
<link rel="stylesheet" href="./css/common-pc.css">
<link rel="stylesheet" href="./css/login.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
function pwChk(){
	var newPw = document.getElementById("newPassword").value;
	
	var newPwChk = document.getElementById("newPasswordChk").value;
	
	
	if(newPw.trim()==""||newPw==null){
// 		var np = document.getElementById("newPassword").focus();
// 		alert(newPw.trim()+"/"+newPw);
// 		$("#newPassword").val();
		alert("비밀번호를 입력해주세요");
		return false;
	}else if(newPwChk.trim()==""||newPwChk==null){
// 		document.getElementById("newPasswordChk").focus();
		alert("비밀번호 확인을 해주세요");
		return false;
	}else if(newPw!=newPwChk){
		alert("비밀번호가 같지 않습니다."); 
		return false;
	}else{
		var con = confirm("변경 하시겠습니까?");
		if(con==true){
			alert("변경 되었습니다.");
			document.forms[0].submit();
			window.close();
		}else{
			return false;
		}
	}
	return false
}
</script>
<body>
	<div id="container" class="nobrandCon_wrapping max_width_area">
		<div class="top_area">
			<h1 class="nobrand_Logo">
				<a href="./loginPage.do"><img
					src="./img/header_logo.jpg"
					alt="NOBRNAD"></a>
			</h1>
		</div>
		<div class="main_area">
			<!-- 메인콘텐츠 시작 -->
			<section class="main_nobrandCon">
				<article class="tab member active">
					<div class="tab_nobrandCon">
						<h2 class="sub_title">비밀번호 변경</h2>
							<form action="./pwUse.do" method="post">
								<div class="nobrand_Login_form">
									<div class="input_area">
									<input type="hidden" id="id" name="id" value="${id}">
									<input type="password" id="newPassword" name="pw" placeholder="새 비밀번호">
									<input type="password" id="newPasswordChk" placeholder="새 비밀번호 확인">
									</div>
								</div>
									<!-- 비번 사용 버튼 -->
							<input style="color:white;" type="button" class="btn_submit" value="변경" onclick="pwChk()">
						</form>
						</div>
				</article>
			</section>
			</div>
			</div>
</body>
</html>