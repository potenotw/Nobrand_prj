<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 페이지</title>
<link rel="stylesheet" href="./css/common-pc.css">
<link rel="stylesheet" href="./css/login.css">
</head>
<script type="text/javascript">
function modifyChk(){
	var con = confirm('수정 하시겠습니까?');
	if(con==true){
		alert('수정 되었습니다.');
	}else{
		return false;
	}
}
</script>
<body>
	<%@include file="/WEB-INF/views/nHeader.jsp"%>
	<div class="nobrandCon_wrapping max_width_area">
		<div class="main_area">
			<!-- 메인콘텐츠 시작 -->
			<section class="main_nobrandCon">
				<article class="tab member active">
					<h1 class="title">회원 정보 수정</h1>
					<div class="tab_nobrandCon">
						<h2 class="sub_title">내 정보 수정</h2>
						<form action="./modifyForm.do" method="post" onsubmit="return modifyChk();">
							<div class="nobrand_Login_form">
								<div class="input_area">
									<input style="background-color: #f0f0f0;" type="text" name="name" value="${name}" readonly="readonly">
									<input type="text" name="nickname" value="${nickname}">
<!-- 									<input type="hidden" id="pwChk"> -->
<!-- 									<input type="password" -->
<!-- 										class="passwordChk" name="password" placeholder="비밀번호 확인"> -->
									<input style="background-color: #f0f0f0;" type="text" name="auth" value="${auth}" readonly="readonly"> 
									<input type="text" name="phone" value="${phone}">
									<input style="background-color: #f0f0f0;" type="text" name="birthday" value="${birthday}" readonly="readonly">
									<input type="text" name="address" value="${address}"> 
									<fmt:parseDate
											var="StringToDate" value="${regdate}"
											pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
									<fmt:formatDate value="${StringToDate}" var="varRegdate" pattern="yyyy-MM-dd" />
									
									<input style="background-color: #f0f0f0;" type="text" name="regdate" value="${varRegdate}" readonly="readonly">
								</div>
							</div>
									<input type="submit" class="btn_submit" value="수정 완료">
									<input style="color: white" type="button" class="btn_submit" value="수정 취소" onclick="bBack()">
						</form>
					</div>
				</article>
			</section>
			<!-- 메인콘텐츠 끝 -->
		</div>
	</div>
</body>
</html>