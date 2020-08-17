<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
  <link rel="stylesheet" href="./css/common-pc.css">
<style type="text/css">
.ol-sm-8 text-left{
	margin: auto;
	border: 3px double black; 
	width: 37%; text-align: center;
}
#side{
	padding: 3px;
	font-style: italic;
	background-color: black;
	color : white;
	font-weight: bolder;
}
j_title{
	padding: 3px;
	font-style: italic;
}
div.gallery {
  border: 6px double #gray;
  height: 300px;
  overflow: hidden;
  border-radius: 10px; 
    background-color: #e7e7e7;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 100%;
  height: auto;
}

div.desc {
  padding: 15px;
  text-align: center;
/*   bottom-border-readius : 10px double #f0f0f0; */
  border-radius: 5px;
  border-bottom: 2px double black;
}

* {
  box-sizing: border-box;
}
.thumbnail { position: relative; padding-top: 100%; /* 1:1 ratio */ overflow: hidden; }

.responsive {
  padding: 0 6px 0px 5px;
  float: left;
  width: auto;
  height: auto;
  margin-left: 10px;
}

.announcement {
    float: left;
    margin-right: 13px;
    width: 49px;
    height: 49px;
    line-height: 49px;
/*     text-align: center; */
/*     background: url(https://ssl.nx.com/s2/game/maplestory/renewal/common/notice_radius.png) center top no-repeat; */
    font-size: 16px;
    color: #fff;
}
.announcement_title {
    float: left;
    font-size: 25px;
    font-weight: bold;
    
    margin-top: 4px;
    position: relative;
}
.announcement_info {
    float: left;
    margin-top: 6px;
    width: 386px;
    font-size: 15px;
    color: #888;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
table.notice_tb td{
	padding: none;
}
td>a{
	color: white;
}
</style>
</head>
<body>
   <%@include file="/WEB-INF/views/header.jsp"%>

	<!-- 메인화면 이미지 넣는 공간 -->
<div class="Main content">
	<div class="notice_wrap" style="width: 70%; margin: auto;">
		   <div class="Main_Image_Container">
					<div class="Main_Image_Logo"
						style="width: 100%; height: 400px;">
						
						<div class="row" style="text-align: center; margin-top: 30px;">
							<c:forEach var="lists" items="${rList}" varStatus="vs">
							<div class="responsive" style="width:32%;  text-align: center;  margin: auto; border: 1px aqua black;">
								<div class="gallery">
								<p style="float: left;">
									no.${lists.seq}
								</p>
								<p style="float: right">
								<fmt:parseDate
									var="StringToDate" value="${lists.regdate}"
									pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
								<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" /><br>
									조회수 : ${lists.readcount}
								</p>
									<div class="thumbnail" style="margin-top: 50px;">
									<a href="#" onclick="window.open('./boardRSelect.do?seq=${lists.seq}&id=${lists.id}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">
										<img src="${lists.thumbimg}" name="thumbimg" class="img-rounded"
											width="150px;" height="150px;" border="1px solid black"></a>
									</div>
							</div>
							<div  class="desc">
								<c:choose>
									<c:when test="${fn:length(lists.title)>10}">
										${fn:substring(lists.title,0,10)}...
									</c:when>
									<c:otherwise>
										${lists.title}
									</c:otherwise>
								</c:choose>
								<span style="float: rigth;">
								<c:choose>
									<c:when test="${lists.c_count eq null}">
									</c:when>
									<c:otherwise>
										<img src="./img/count.jpg"> [ ${lists.c_count} ]
									</c:otherwise>
								</c:choose>
								</span>
							</div>						
						</div>
				</c:forEach>
			</div>
		</div>
	 </div>
  	</div>  
   
   <!-- 메인화면 공지사항 -->
   
      <div class="container-fluid text-center">
         <div class="row content">
				<div class="col-sm-8 text-left"
					style="margin: auto;  width: 35%; ">
						<h2><img src="./img/GmainImg.jpg">
						<span style="float: right; font-size: 5px; color: #888; line-height: 10px;">
<!-- 								<a href="./boardGList.do">[더 보기]</a></span> -->
						</h2>
					<c:forEach var="lists" items="${gList}">
						<div
							style="margin-bottom: 10px; border-radius: 50px; border-bottom:2px solid black;  width: 100%; height: 70px;">

							<div class="client_update" style="line-height: 30px;">
								<dl>
										<span style="float: right; margin-right: 20px; font-size: 5px;">조회수 : ${lists.readcount}</span>
									<dt class="announcement">
										<img src="./img/GIcon.png">
									</dt>
									<c:choose>
										<c:when test="${fn:length(lists.title)>10}">
											<dd class="announcement_title">
												<a href="#" style="color:black;"
													onclick="window.open('./boardGSelect.do?seq=${lists.seq}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=900,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(lists.title,0,10)}...</a>
											</dd>
										</c:when>
										<c:otherwise>
											<dd class="announcement_title">
												<a href="#" style="color:black;"
													onclick="window.open('./boardGSelect.do?seq=${lists.seq}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=900,height=600,left=0, top=0, scrollbars=yes');return false">${lists.title}</a>
											</dd>
										</c:otherwise>
									</c:choose>
									<dd class="announcement_info" style="float: left;">
										<fmt:parseDate
											var="StringToDate" value="${lists.regdate}"
											pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
										<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" />
									</dd>
								</dl>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 메인화면 자유게시판 -->
            <div class="col-sm-8 text-left" style="margin: auto; width: 35%;">
               <div class="Main_Container_Table" style="width: 35%;">
                  <table summary="자유" class="notice_tb" style="margin-top: 30px; width: 500px;">
                  <colgroup>
					<col width="*">
					<col width="80%">
					<col width="14%">
				</colgroup>
                     <tr>
                        <th style="text-align: left; margin-left: 10px;" colspan="2">&nbsp&nbsp자유 게시판</th>
                        <th></th>
<!--                         <th style="text-align: right;  font-size: 5px; color: #888;"><span><a href="./boardJList.do">[더 보기]&nbsp&nbsp</a></span></th> -->
                        <c:forEach var="lists" items="${jList}">
                           <tr style="border: none">
                              <td><img src="./img/one.jpg"></td>
                              <c:choose>
								<c:when test="${lists.file_seq eq 0}">
									<c:if test="${lists.c_count eq null}">
										<c:choose>
											<c:when test="${fn:length(lists.title)>20}">
												<td id="j_title">
													<a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(lists.title,0,20)}...
													</a>
												</td>
											</c:when>
											<c:otherwise>
												<td id="j_title">
													<a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${lists.title}
													</a>
												</td>
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${lists.c_count ne null}">
										<c:choose>
											<c:when test="${fn:length(lists.title)>20}">
												<td id="j_title"><a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(lists.title,0,20)}...
													<strong>[${lists.c_count}]</strong></a>
												</td>
											</c:when>
											<c:otherwise>
												<td id="j_title"><a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${lists.title}
													<strong>[${lists.c_count}]</strong></a>
												</td>
											</c:otherwise>
										</c:choose>
									</c:if>

								</c:when>

								<c:otherwise>

									<c:if test="${lists.c_count eq null}">
										<c:choose>
											<c:when test="${fn:length(lists.title)>20}">
												<td id="j_title"><a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(lists.title,0,20)}...
													<img alt="파일" src="./img/diskIcon.jpg"></a></td>
											</c:when>
											<c:otherwise>
												<td id="j_title"><a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${lists.title}
													<img alt="파일" src="./img/diskIcon.jpg"></a></td>
											</c:otherwise>
										</c:choose>
									</c:if>


									<c:if test="${lists.c_count ne null}">
										<c:choose>
											<c:when test="${fn:length(lists.title)>20}">
												<td id="j_title"><a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(lists.title,0,20)}...
													<strong>[${lists.c_count}]</strong> <img alt="파일"
													src="./img/diskIcon.jpg"></a></td>
											</c:when>
											<c:otherwise>
												<td id="j_title"><a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${lists.title}
													<strong>[${lists.c_count}]</strong> <img alt="파일"
													src="./img/diskIcon.jpg"></a></td>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:otherwise>
							</c:choose>
                              <td>조회수 : ${lists.readcount}</td>
                           </tr>
                        </c:forEach>
                     </tr>
                  </table>
               </div>
            </div>
            <!-- 조회수 많은 게시판 -->
			<div style="width: 15%; height: auto; float: right; margin-top:65px ; text-align: center;">
					<div style="width: 100%; border: 1px double black;">
						<table  class="table" style="margin: auto;">
							<tr>
								<th>Top 10</th>
							</tr>
							<c:forEach var="lists" items="${readList}">
							<tr style="padding: 3px 0px 3px 0px;">
									<c:if test="${lists.gubun eq 'J'}">
									<td id="side">
											<c:choose>
												<c:when test="${fn:length(lists.title)>6}">
													<a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(lists.title,0,6)}...</a>
												</c:when>
												<c:otherwise>
													<a href="#" onclick="window.open('./boardJSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${lists.title}</a>
												</c:otherwise>
											</c:choose>
											[${lists.readcount}]
									</td>
									</c:if>
									<c:if test="${lists.gubun eq 'R'}">
									<td id="side">
											<c:choose>
												<c:when test="${fn:length(lists.title)>6}">
													<a href="#" onclick="window.open('./boardRSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(lists.title,0,6)}...</a>
												</c:when>
												<c:otherwise>
													<a href="#" onclick="window.open('./boardRSelect.do?seq=${lists.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${lists.title}</a>
												</c:otherwise>
											</c:choose>
											[${lists.readcount}]
									</td>
									</c:if>
							</tr>
							</c:forEach>
						</table>
					</div>
			</div>
          </div>
   		</div>
       </div>
</body>
</html>