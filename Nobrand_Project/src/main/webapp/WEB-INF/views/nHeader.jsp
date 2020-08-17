<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새창 헤더</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/sweetalert.css">
<link rel="stylesheet" href="./css/board.css">
<link rel="stylesheet" href="./css/common-pc.css">
<link rel="stylesheet" href="./css/login.css">
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);

h2{
	font-family: 'Jeju Hallasan', serif;
}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
<script type="text/javascript" src="./js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="./js/board.js"></script>
<script type="text/javascript">
//동작 이벤트
// window.addEventListener("beforeunload", function (event) {
//     event.returnValue = "\\o/";
//   });
</script>
<body>
<sec:authentication property="principal.username" var="id"/>
<sec:authorize access="hasRole('ROLE_Admin')" var="admin"/>
<sec:authorize access="hasRole('ROLE_User')" var="user"/>
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
<!--     <div class="navbar-header"> -->
<!--       <a class="navbar-brand" href="javascript:history.back(-1)"><img alt="뒤로가기" src="./img/back.jpg"> -->
<!--       </a> -->
<!--     </div> -->
     <ul class="nav navbar-nav navbar-right">
      <li><a><span>${id}님 환영합니다.</span></a></li>
      <c:if test="${admin}">
	      <li><a><span><strong>[관리자]</strong></span></a></li>
      </c:if>
      <c:if test="${user}">
	      <li><a><span><strong>[유저]</strong></span></a></li>
      </c:if>
    </ul>
  </div>
</nav>
</body>
</html>