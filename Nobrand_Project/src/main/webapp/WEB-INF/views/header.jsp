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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>헤더</title>
<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/sweetalert.css">
<link rel="stylesheet" href="./css/board.css">
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/jejuhallasan.css);

h2{
	font-family: 'Jeju Hallasan', serif;
}
.table>thead>tr>th{
	text-align: center;
}
 /* Remove the navbar's default margin-bottom and rounded borders */ 
 .navbar {
   margin-bottom: 0;
   border-radius: 0;
 }
 
 
 /* Set gray background color and 100% height */
 .sidenav {
   padding-top: 20px;
   background-color: #f1f1f1;
   height: 100%;
 }
 
 /* On small screens, set height to 'auto' for sidenav and grid */
 @media screen and (max-width: 767px) {
   .sidenav {
     height: auto;
     padding: 15px;
   }
   .row.content {height:auto;} 
 }
 li>a{
 	color: white;
 	font-size: 12pt;
 }
#log{	
     box-shadow: 1px 2px 5px #000000;
     width: 150px;
     margin-bottom: 10px;  
}
#info{	
     box-shadow: 1px 2px 5px #000000;
     width: 150px;
     margin-bottom: 10px;  
}

button>a{
	color: black;
	text-decoration: none;
}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/sweetalert.min.js"></script>
<script type="text/javascript" src="./js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="./js/board.js"></script>
<script type="text/javascript">

function myInfo(){
	window.open('./myInfo.do','window2','width=800,height=650,scrollbars=no,resizable=yes, toolbars=no, menubar=no');
}

function logout(){
	location.href="./logout.do";
}
function userPage(){
	window.open('./userList.do','window2','width=800,height=650,scrollbars=no,resizable=yes, toolbars=no, menubar=no');
}
function searchBoard(){
	var searchType = document.getElementsByName("searchType")[0].value;
	var keyword = document.getElementsByName("keyword")[0].value;
//  	alert("searchType="+searchType+"keyword="+keyword);
	if(keyword==""){
		alert("검색 내용을 입력해주세요.");
		return
	}
	location.href="./boardSearch.do?searchType="+searchType+"&keyword="+keyword;
 }
</script>
<body>

<div>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="./loginChk.do">NOBRAND</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a>목록</a></li>
      </ul>
      <div style="margin-left: 360px;">
      <form action="./boardSearch.do" class="navbar-form navbar-left">
<!--       <select name="searchType"> -->
<!--       	<option value="title">제목</option> -->
<!--       	<option value="content">내용</option> -->
<!--       </select> -->
      <input type="hidden" name="searchType" value="title">
      <input type="hidden" name="searchType" value="content">
        <div class="form-group input-group">
          <input  type="text" name="keyword" class="form-control" style="width: 600px; margin-rigth: 30px;" placeholder="제목 또는 내용을 검색해주세요">
          <span class="input-group-btn">
            <button class="btn btn-default" style="margin-left: 10px;" type="button" onclick="searchBoard()">
              <span>검색</span>
            </button>
          </span>   
        </div>
      </form>
      </div>
    </div>
  </div>
</nav>
	<!-- 검색 버튼 선택한 값을 가져오기-->
	     <script type="text/javascript">

	     </script>
  
    <div class="col-sm-2 sidenav" style="width: 15%; height: 900px; background-color: #101010; float: left;">
        <ul class="nav navbar-nav">
	      <li class="active"><a href="./allBoardList.do">전체 게시판</a></li>
	      <li class=""><a href="./boardGList.do">공지 사항</a></li>
	      <li class=""><a href="./boardJList.do">자유 게시판</a></li>
	      <li class=""><a href="./boardRList.do">리뷰 게시판</a></li>
   		 </ul>
      </div>
      
      
	<sec:authentication property="principal.username" var="id"/>
	
	
	<sec:authorize access="hasRole('ROLE_Admin')" var="admin"/>
	<sec:authorize access="hasRole('ROLE_User')" var="user"/>
	
	
	<c:if test="${admin}">
   <div style="width: 14%; height: auto; border: 3px double #777; float: right; margin-top: 30px; margin-right: 5px; 
   							background: linear-gradient(white, black);  text-align: center;  border-radius: 10px;">
		<div class="container" style=" width: 100%">
			<h4><Strong>[${id}]</Strong>님<br></h4>
				<p>
					등급 : 관리자
				</p>
			<button id="log" type="button" name="info" class="btn btn-default" onclick="myInfo()">내 정보</button><br>
			<button id="log" type="button" class="btn btn-default" onclick="userPage()">회원 관리</button><br>
			<button type="button" id="log" class="btn btn-default">
				<a href="./myBoardList.do?id=${id}">내 게시물</a>
			</button><br>
			<div class="dropdown">
				<button type="button" id="log" class="btn btn-default" data-toggle="dropdown">
					글 작성 하러가기
				<span class="caret"></span></button>
				<ul class="dropdown-menu" >
					<li><a href="./boardGWritePage.do">[공지]글 작성</a></li>
					<li><a href="./boardJWritePage.do">[자유]글 작성</a></li>
					<li><a href="./boardRWritePage.do">[리뷰]글 작성</a></li>
				</ul>				
			<br>	
			</div>
			<button id="log" type="button" class="btn btn-default" onclick="logout()">로그아웃</button>
		</div>
  	</div>
	</c:if>
	<c:if test="${user}">
   <div style="width: 14%; height: auto; border: 3px double #777; float: right; margin-top: 30px; margin-right: 5px; 
   							background: linear-gradient(white, black);  text-align: center;  border-radius: 10px;">
		<div class="container" style=" width: 100%">
			<h4><Strong>[${id}]</Strong>님<br></h4>
			<p>
				등급 : 유저
			</p>
			<button id="info" type="button" class="btn btn-default" onclick="myInfo()">내 정보
			</button><br>

			
			<button type="button" id="log" class="btn btn-default">
				<a href="./myBoardList.do?id=${id}">내 게시물</a>
			</button><br>
			<div class="dropdown">
				<button type="button" id="log" class="btn btn-default" data-toggle="dropdown">
					글 작성 하러가기
				<span class="caret"></span></button>
				<ul class="dropdown-menu" >
					<li><a href="./boardJWritePage.do">[자유]글 작성</a></li>
					<li><a href="./boardRWritePage.do">[리뷰]글 작성</a></li>
				</ul>				
			<br>	
			</div>
			<button id="log" type="button" class="btn btn-default" onclick="logout()">로그아웃</button>
		</div>
  	</div>
  	</c:if>
</div>
</body>
</html>