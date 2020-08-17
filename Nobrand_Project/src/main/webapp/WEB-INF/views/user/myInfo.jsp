<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보</title>
<link rel="stylesheet" href="./css/common-pc.css">
<link rel="stylesheet" href="./css/login.css">
</head>
<script type="text/javascript">
function modify(){
	location.href="./userModify.do";
}

function signDownPage(){
	location.href="./signDownPage.do";
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
						<h2 class="sub_title">내 정보</h2>
							<div class="nobrand_Login_form">
								<div class="input_area">
									<input type="text" name="name" value="${mdto.name}" readonly="readonly">
									<input type="text" name="nickname" value="${mdto.nickname}">
									<sec:authorize access="hasRole('ROLE_Admin')" var="admin"/>	
									<sec:authorize access="hasRole('ROLE_User')" var="user"/>
									<c:if test="${admin}">
									<input type="text" name="auth" value=관리자 readonly="readonly">
									</c:if> 
									<c:if test="${user}">
									<input type="text" name="auth" value=유저 readonly="readonly">
									</c:if> 
									<input type="text" name="phone" value="${mdto.phone}">
									<input type="text" name="birthday" value="${mdto.birthday}" readonly="readonly">
									<input type="text" name="address" value="${mdto.address}"> 
									
									<fmt:parseDate
											var="StringToDate" value="${mdto.regdate}"
											pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
									<fmt:formatDate value="${StringToDate}" var="regdate" pattern="yyyy-MM-dd" />
									
									<input type="text" name="regdate" value="${regdate}" readonly="readonly">
								</div>
							</div>
								<input type="submit" class="btn_submit" value="정보 수정" onclick="modify()">
								<input  type="submit" class="btn_submit" value="회원 탈퇴" onclick="signDownPage()">
					</div>
				</article>
			</section>
			<!-- 메인콘텐츠 끝 -->
		</div>
	</div>
</body>
</html>