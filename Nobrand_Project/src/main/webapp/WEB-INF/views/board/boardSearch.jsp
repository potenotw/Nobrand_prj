<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 페이지</title>
<link rel="stylesheet" href="./css/board.css">
<style>
.imgswap img:last-child {
	display: none
}

.imgswap:hover img:first-child {
	display: none
}

.imgswap:hover img:last-child {
	display: inline-block;
	width: 200px;
	height: 200px;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/header.jsp"%>
	<div class="notice_wrap">
			<h2><img src="./img/Search.png"></img>[${paging.keyword}] 검색 결과</h2>
			<input type="hidden" id="keyword" name="keyword" value="${paging.keyword}">
			<input type="hidden" id="searchType" name="searchType" value="${paging.searchType}">
			<table summary="전체 게시판" class="notice_tb">
				<colgroup>
					<col width="5.45454%">
					<col width="5.24251%">
					<col width="55%">
					<col width="5.24251%">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">분류</th>
						<th scope="col">제목</th>
						<th scope="col">아이디</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody id="notice">
					<c:forEach var="bdto" items="${lists}" varStatus="vs">
						<tr>
							<td>${bdto.seq}</td>
							<c:choose>
								<c:when test="${bdto.gubun eq 'G'}"> 
								<td style="color: red;">[공지]</td>
									<c:if test="${fn:length(bdto.title)>20}">
										<td>
									<a href="#" onclick="window.open('./boardGSelect.do?seq=${bdto.seq}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=800,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,20)}...</a></td>
									</c:if>
									<c:if test="${fn:length(bdto.title)<20}">
										<td>
										<a href="#" onclick="window.open('./boardGSelect.do?seq=${bdto.seq}','window','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=800,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}</a></td>	
									</c:if>
								</c:when>
								
								<c:when test="${bdto.gubun eq 'J'}">
									<td style="color: blue;">[자유]</td>
									<c:choose>
										<c:when test="${bdto.file_seq eq 0}">
											<c:if test="${bdto.c_count eq null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>20}">
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,20)}...</a>
														</td>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}</a>
														</td>
													</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${bdto.c_count ne null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>20}">
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,20)}...</a>
															<strong>[${bdto.c_count}]</strong></td>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}</a>
															<strong>[${bdto.c_count}]</strong></td>
													</c:otherwise>
												</c:choose>
											</c:if>
		
										</c:when>
		
										<c:otherwise>
		
											<c:if test="${bdto.c_count eq null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>20}">
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,20)}...</a>
															<img alt="파일" src="./img/diskIcon.jpg"></td>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}</a>
															<img alt="파일" src="./img/diskIcon.jpg"></td>
													</c:otherwise>
												</c:choose>
											</c:if>
		
		
											<c:if test="${bdto.c_count ne null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>20}">
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,20)}...</a>
															<strong>[${bdto.c_count}]</strong> <img alt="파일"
															src="./img/diskIcon.jpg"></td>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardJSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}</a>
															<strong>[${bdto.c_count}]</strong> <img alt="파일"
															src="./img/diskIcon.jpg"></td>
													</c:otherwise>
												</c:choose>
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:when>
								
								<c:otherwise>
									<td style="color: green">[리뷰]</td>
									<c:choose>
										<c:when test="${bdto.thumbimg eq null}">
											<c:if test="${bdto.c_count eq null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>14}">
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,14)}...</a>
														</td>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}
														</a>
														</td>
													</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${bdto.c_count ne null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>14}">
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,14)}...
															<strong>[${bdto.c_count}]</strong></a></td>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq}','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}
															<strong>[${bdto.c_count}]</strong></a></td>
													</c:otherwise>
												</c:choose>
											</c:if>
		
										</c:when>
		
										<c:otherwise>
		
											<c:if test="${bdto.c_count eq null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>14}">
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq} ','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,14)}...
															<span class="imgswap" > 
																<img src="./img/imgIcon.jpg" /> <img src="${bdto.thumbimg}" />
															</span></a>
													</td>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq} ','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}
															<span class="imgswap" > 
																<img src="./img/imgIcon.jpg" /> <img src="${bdto.thumbimg}" />
															</span></a>
														</td>
													</c:otherwise>
												</c:choose>
											</c:if>
		
		
											<c:if test="${bdto.c_count ne null}">
												<c:choose>
													<c:when test="${fn:length(bdto.title)>14}">
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq} ','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${fn:substring(bdto.title,0,14)}...
															<strong>[${bdto.c_count}]</strong> 
															<span class="imgswap" > 
																<img src="./img/imgIcon.jpg" /> <img src="${bdto.thumbimg}" />
															</span></a>
													</c:when>
													<c:otherwise>
														<td><a href="#" onclick="window.open('./boardRSelect.do?seq=${bdto.seq} ','window1','location=no, directories=no,resizable=no,status=no,toolbar=no,menubar=no, width=1000,height=600,left=0, top=0, scrollbars=yes');return false">${bdto.title}
															<strong>[${bdto.c_count}]</strong>
																<span class="imgswap" > 
																	<img src="./img/imgIcon.jpg" /> <img src="${bdto.thumbimg}" />
																</span></a>
															</td>
													</c:otherwise>
												</c:choose>
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							
							<c:choose>
								<c:when test="${bdto.id eq 'nobrand'}">
									<td>관리자</td>
								</c:when>
								<c:otherwise>
									<td><a href="./myBoardList.do?id=${bdto.id}">${bdto.id}</a></td>
								</c:otherwise>
							</c:choose>
							<td>
								<!-- regdate의 문자열의 형태가 Date타입을 변환이 가능한 형태로 변환 --> <fmt:parseDate
									var="StringToDate" value="${bdto.regdate}"
									pattern="yyyy-MM-dd HH:mm:ss" /> <!-- 설정된 Date 타입을 필요한 형태로 변경해서 출력 -->
								<fmt:formatDate value="${StringToDate}" pattern="yyyy-MM-dd" />
							</td>
							<td>&nbsp;&nbsp;${bdto.readcount}&nbsp;&nbsp;</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
			<div class="news_pagination">
				<ul class="pager">
					<li class="">
						<c:if test="${paging.startPage != 1 }">
						<a href="./boardSearch.do?nowPage=${paging.startPage - 1}&cntPerPage=${paging.cntPerPage}&keyword=${paging.keyword}">
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
									<a href="./boardSearch.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}&keyword=${paging.keyword}">${p}</a>
								</c:when>
							</c:choose>
					</li>
				</c:forEach>
				<li class="">
					<c:if test="${paging.endPage != paging.lastPage}">
						<a href="./boardSearch.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&keyword=${paging.keyword}">
								<img alt="앞으로" src="./img/right.jpg">
						</a>
					</c:if>
				</li>
			</ul>
			</div>
	</div>
</body>
</html>