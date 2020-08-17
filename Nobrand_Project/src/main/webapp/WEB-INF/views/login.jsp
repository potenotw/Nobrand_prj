<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link rel="stylesheet" href="./css/common-pc.css">
<link rel="stylesheet" href="./css/login.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="./css/sweetalert.css">
</head>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
<script type="text/javascript">
function loginChk(){
	var id = document.getElementById("id").value;
	var pw = document.getElementById("password").value;
	var error = '${error}';
// 	alert(id+"/"+pw+"/"+error);
	
	if(id==null||id.trim()==""){
		document.getElementById("id").focus();
		$("#id").val();
		alert("아이디를 입력해주세요.");
		return false;
	}else if(pw==null||pw.trim()==""){
		document.getElementById("password").focus();
		$("#password").val();
		alert("비밀번호를 입력해주세요.");
	return false;
	}
}

</script>
<body>
<!-- 시큘리티를 사용하기 위해서는 반드시 POST여야만 한다. -->
    <!-- wrapping -->
    <div class="nobrandCon_wrapping max_width_area">
        <div class="top_area">
			<h1 class="nobrand_Logo">
				<a href="./loginPage.do">
				<img
				src="./img/header_logo.jpg"
					alt="NOBRNAD"></a>
			</h1>
        </div>
        <div class="main_area">
            <!-- 메인콘텐츠 시작 -->
            <section class="main_nobrandCon">
                <h1 class="hidden">로그인</h1>
                <!-- 회원 로그인 시작 -->
                <article class="tab member active">
                    <h1 class="title">로그인</h1>
                    <div class="tab_nobrandCon">
                        <h2 class="sub_title">Enjoy With</h2>
                        <form action="./login.do" method="post" id="loginForm" onsubmit="return loginChk()"> 
                            <div class="nobrand_Login_form">
                                <div class="input_area">
                                    <input type="text" id="id" class="id" name="id" placeholder="아이디를 입력해 주세요">
                                    <input type="password" id="password" class="password" name="password" placeholder="비밀번호를 입력해 주세요.">
                                	<input type="hidden" id="delflag" class="delflag">
                                	<input type="hidden" id="error" value="${msg}">
                                </div>
                                		<input name ="remember-me" type = "checkbox"/>
                                		<span style="font-size:5pt; ">로그인 유지</span>
                                <ul class="check_area">
                                    <li class="join"><a href="./signUpPage.do">회원가입</a></li>
                                    <li class="find"><a href="#" onclick="window.open('./searchPage.do','window0','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=600,height=500,left=400, top=100, scrollbars=no');return false">아이디 / 비밀번호찾기</a></li>
                                </ul>
                                <p class="error_msg">
                                <input type="submit" class="btn_submit" value="로그인">
                            </div>
                        </form>
                    </div>
                </article>
                <!-- 회원 로그인 끝 -->
            </section>
            <!-- 메인콘텐츠 끝 -->
        </div>
    </div>
</body>
</html>















