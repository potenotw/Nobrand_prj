<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 페이지</title>
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
function idSearchChk(){
	var name = document.getElementById("name").value;
	var birthday = document.getElementById("birthday").value;
// 	alert("이름은 : "+name+"생일은 : "+birthday)
	if(name==null||name.trim()==""){
		alert("이름을 입력해주세요");
		return false;
	}else if(birthday==null||birthday.trim()==""){
		alert("생일을 입력해주세요.");
	return false;
	}else{
		location.href="./idSearch.do?name="+name+"&birthday="+birthday;
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
					<h1 class="title">아이디 찾기</h1>
					<div class="tab_nobrandCon">
						<h2 class="sub_title">아이디 찾기</h2>
							<div class="nobrand_Login_form">
								<div class="input_area">
									<input type="text" id="name" class="name" name="name" placeholder="이름" >
									<input type="text" id="birthday" class="birthday" name="birthday" placeholder="생년월일">
								</div>
								<input type="button" style="color: white" id="idSearch" class="btn_submit" value="찾기" onclick="idSearchChk()">
                                <ul class="check_area">
                                    <li class="find"><a href="./pwSearchPage.do">비밀번호찾기</a></li>
                                </ul>
							</div>
					</div>
				</article>
			</section>
		</div>
	</div>
	
</body>

</html>





