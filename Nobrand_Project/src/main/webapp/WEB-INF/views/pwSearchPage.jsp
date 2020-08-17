<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 페이지</title>
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
function pwSearchChk(){
	var id = document.getElementById("id").value;
	var phone= document.getElementById("phone").value;
// 	alert("아이디 : "+id+"폰번호 : "+phone)
	if(id==null||id.trim()==""){
		alert("아이디를 입력해주세요");
		return false;
	}else if(phone==null||phone.trim()==""){
		alert("핸드폰 번호를 입력해주세요.");
	return false;
	}else{
		location.href="./pwSearch.do?id="+id+"&phone="+phone;
	}
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
						<h2 class="sub_title">비밀번호 찾기</h2>
						<form action="./pwSearch.do" method="post" onsubmit="return pwSearchChk()">
								<div class="nobrand_Login_form">
									<div class="input_area">
									<input type="text" id="id" name="id" placeholder="아이디">
									<input type="text" id="phone" name="phone" placeholder="핸드폰 번호"> 
									</div>
								</div>
									<!-- 비번 사용 버튼 -->
							<input type="submit" class="btn_submit" value="찾기">
						</form>
					</div>
				</article>
			</section>
			</div>
			</div>
</body>
</html>