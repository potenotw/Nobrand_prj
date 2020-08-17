<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 게시판 페이지</title>
<style type="text/css">
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
   border-radius: 5px;
  border-bottom: 2px double black;
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
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/header.jsp"%>
	<div class="notice_wrap" style="">
	<h2>리뷰 게시판</h2>
		<form action="./boardRDeleteMul.do" method="post" id="chk" name="chk"
			onsubmit="chkRbox()">
		   <div class="Main_Image_Container">
					<div class="Main_Image_Logo"
						style="width: 100%; height: 340px;">
						<c:if test="${admin}">
							<input type="checkbox" onclick="chkRAll(this.checked)"> 전체체크
						</c:if>
						<div class="row" style="text-align: center;">
						<c:forEach var="bdto" items="${lists}" varStatus="vs">
							<div class="responsive"
								style="width: 33%; height: 340px; text-align: center; padding: 10px;">
								<div class="gallery">
									<c:if test="${admin}">
										<p style="float: left;">
											<input type="checkbox" name="chkval" value="${bdto.seq}">
											${bdto.seq}
										</p><br>
									</c:if>
									<p style="float: right">
										<fmt:parseDate var="StringToDate" value="${bdto.regdate}"
											pattern="yyyy-MM-dd HH:mm:ss" />
										<!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
										<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" />
										<br>
										조회수 : ${bdto.readcount}
									</p>
									<div class="thumbnail" style="margin-top: 50px;">
								<a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq}&id=${bdto.id}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">
										<img src="${bdto.thumbimg}" name="thumbimg" class="img-rounded"
											width="150px;" height="150px;" border="1px solid black"></a>
									</div>
								</div>
									<div  class="desc">
										<c:choose>
											<c:when test="${fn:length(bdto.title)>10}">
												${fn:substring(bdto.title,0,10)}...
											</c:when>
											<c:otherwise>
												${bdto.title}
											</c:otherwise>
										</c:choose>
										<span style="float: rigth;">
										<c:choose>
											<c:when test="${bdto.c_count eq null}">
											</c:when>
											<c:otherwise>
												<img src="./img/count.jpg"> [ ${bdto.c_count} ]
											</c:otherwise>
										</c:choose>
										</span>
									</div>
							<span >
							<c:choose>
								<c:when test="${bdto.id eq 'nobrand'}">
									<td><strong>관리자</strong></td>
								</c:when>
								<c:otherwise>
									<td><a style="color: black;" href="./myBoardList.do?id=${bdto.id}"><strong>ID : ${bdto.id}</strong></a></td>
								</c:otherwise>
							</c:choose>
							</span>
							</div>
						</c:forEach>
					</div>
			<div class="news_pagination" style="position: relative; bottom: 170px;">
				<div style="width: 100%; margin-right: 80px;">
					<div class="news_sch_wrap">
						<p>
						<c:if test="${admin}">
							<label for="sch_bar" class="a11y" style="top: 550px;">
								<a href="./boardRWritePage.do">글 작성</a>
								<input type="submit" value="삭제">
							</label>
						</c:if>
						<c:if test="${user}">
							<label for="sch_bar" class="a11y" style="top: 550px;">
								<a href="./boardRWritePage.do">글 작성</a>
							</label>
						</c:if>
						</p>
					</div>
				</div>
				<ul class="pager">
					<li class="">
						<c:if test="${paging.startPage != 1 }">
						<a href="./boardRList.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}">
								<img alt="앞으로" src="./img/left.jpg">
						</a>
					</c:if>
				</li>
				<c:forEach begin="${paging.startPage }" end="${paging.endPage}" var="p">
					<li class="active">						
						<c:choose>
							<c:when test="${p == paging.nowPage }">
							<b>${p}</b>
								</c:when>
									<c:when test="${p != paging.nowPage }">
									<a href="./boardRList.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p}</a>
								</c:when>
							</c:choose>
					</li>
				</c:forEach>
				<li class="">
					<c:if test="${paging.endPage != paging.lastPage}">
						<a href="./boardRList.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">
								<img alt="앞으로" src="./img/right.jpg">
						</a>
					</c:if>
				</li>
			</ul>
			</div>
			</div>
			</div><br>	
			<div style="width: auto; height: auto; ">
			
			</div>

		</form>
	</div>

</body>
</html>








