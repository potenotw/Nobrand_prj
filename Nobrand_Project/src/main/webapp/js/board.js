
//공지게시판 영역 -----------------------------------------------------------------

//전체 체크
function chkGAll(bool){
//	alert(bool);
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		chkVals[i].checked = bool;
	}
}
function chkGbox() {
	var n = 0;
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
	if (chkVals[i].checked) {
		n++;
		}
	}
	if (n != 0) {
		document.getElementById("chk").action="./boardGDeleteMul.do";
		alert("삭제 되었습니다.");
	}else{
		alert("삭제할 게시물을 선택해주세요.");
		return false;
	}
}

function selGChange() {
	var sel = document.getElementById('cntPerPage').value;
	location.href="./boardGList.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
}


//전체 체크
function chkJAll(bool){
//	alert(bool);
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		chkVals[i].checked = bool;
	}
}

function chkJbox() {
	var n = 0;
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		if (chkVals[i].checked) {
			n++;
		}
	}
	if (n != 0) {
		document.getElementById("chk").action="./boardJDeleteMul.do";
		alert("삭제 되었습니다.");
	}else{
		alert("삭제할 게시물을 선택해주세요.");
		return false;
	}
}

function selJChange() {
	var sel = document.getElementById('cntPerPage').value;
	location.href="./boardJList.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
}


//전체 체크
function chkRAll(bool){
//	alert(bool);
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		chkVals[i].checked = bool;
	}
}

function chkRbox() {
	var n = 0;
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		if (chkVals[i].checked) {
			n++;
		}
	}
	if (n != 0) {
		document.getElementById("chk").action="./boardRDeleteMul.do";
		alert("삭제 되었습니다.");
	}else{
		alert("삭제할 게시물을 선택해주세요.");
		return false;
	}
}

function selRChange() {
	var sel = document.getElementById('cntPerPage').value;
	location.href="./boardRList.do?nowPage=${paging.nowPage}&cntPerPage="+sel;
}


//전체 체크
function chkMyAll(bool){
//	alert(bool);
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		chkVals[i].checked = bool;
	}
}

function chkMybox() {
	var n = 0;
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		if (chkVals[i].checked) {
			n++;
		}
	}
	if (n != 0) {
		document.getElementById("chk").action="./myBoardDel.do";
		alert("삭제 되었습니다.");
	}else{
		alert("삭제할 게시물을 선택해주세요.");
		return false;
	}
}

//전체 게시물 -------------------------------------------

//전체 체크
function chkBoardAll(bool){
//	alert(bool);
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		chkVals[i].checked = bool;
	}
}

function chkBoardbox() {
	var n = 0;
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		if (chkVals[i].checked) {
			n++;
		}
	}
	if (n != 0) {
		document.getElementById("chk").action="./allBoardDel.do";
		alert("삭제 되었습니다.");
	}else{
		alert("삭제할 게시물을 선택해주세요.");
		return false;
	}
}

//검색 페이지 삭제기능
//전체 체크
function chkSearchAll(bool){
//	alert(bool);
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		chkVals[i].checked = bool;
	}
}

function chkSearchbox() {
	var n = 0;
	var keyword = document.getElementById("keyword").value;
	var searchType = document.getElementById("searchType").value;
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		if (chkVals[i].checked) {
			n++;
		}
	}
	if (n != 0) {
		document.getElementById("chk").action="./boardSearchDel.do?searchType="+searchType+"&keyword="+keyword;
		alert("삭제 되었습니다.");
	}else{
		alert("삭제할 게시물을 선택해주세요.");
		return false;
	}
}




//공지게시판의 글수정 유효성
function boardGWrite(){
	var frm = document.getElementById("frmWrite");
	var title = $("#title").val();
	var content = CKEDITOR.instances['content'].getData();
	frm.action="./boardGWrite.do"
	if(title==""){
		alert("제목을 입력해주세요");
	}else if(title.length>40){
		alert("제목을 40자 이내로 입력해주세요");
	}else if(content==""){
		alert("내용을 입력해주세요");
	}else{
		var con = confirm("글을 등록하시겠습니까?");
		if (con == true) {
			frm.submit();
		}else{
			return false;
			}
		}
}


function boardGModify(){
	var frm = document.getElementById("frmModify");
	var title = $("#title").val();
	var content = CKEDITOR.instances['content'].getData();
	frm.action = "./boardGModify.do";
	if(title==""){
		alert("제목을 입력해주세요");
	}else if(title.length>40){
		alert("제목을 40자 이내로 작성해주세요");
	}else if(content==""){
		alert("내용을 입력해주세요")
	}
	else{
		var con = confirm("글을 수정하시겠습니까?");
		if (con == true) {
			frm.submit();
		}else{
			return false;
		}
	}
}


//자유게시판 글수정 유효성
function boardJWrite(){
	var frm = document.getElementById("frmWrite");
	var title = $("#title").val();
	var content = CKEDITOR.instances['content'].getData();
	frm.action="./boardJWrite.do";
		if(title==""){
			alert("제목을 입력해주세요");
		}else if(title.length>40){
			alert("제목을 40자 이내로 입력해주세요");
		}else if(content==""){
			alert("내용을 입력해주세요");
		}
		else{
			var con = confirm("글을 등록하시겠습니까?");
			if (con == true) {
				frm.submit();
			}else{
				return false;
			}
		}
}



//댓글입력 유효성
function commentJWrite(){
	var frm = document.getElementById("comments");
	var content = $("#c_content").val();
	frm.action = "./boardJCommentsIn.do";
	if(content==""){
		alert("댓글을 작성해주세요");
	}else if(content.length>50){
		alert("댓글을 50자 이내로 작성해주세요");
	}
	else{
		var con = confirm("댓글을 등록하시겠습니까?");
		if (con == true) {
			frm.submit();
		}else{
			return false;
		}
	}
}


function boardJModify(){
	var frm = document.getElementById("frmModify");
	var title = $("#title").val();
	var content = CKEDITOR.instances['content'].getData();
	frm.action = "./boardJModify.do";
	if(title==""){
		alert("제목을 입력해주세요");
	}else if(title.length>40){
		alert("제목을 40자 이내로 작성해주세요");
	}else if(content==""){
		alert("내용을 입력해주세요");
	}
	else{
		var con = confirm("글을 수정하시겠습니까?");
		if (con == true) {
			frm.submit();
		}else{
			return false;
		}
	}
}

//댓글입력 유효성
function commentRWrite(){
	var frm = document.getElementById("comments");
	var content = $("#c_content").val();
	frm.action = "./boardRCommentsIn.do";
	if(content==""){
		alert("댓글을 작성해주세요");
	}else if(content.length>50){
		alert("댓글을 50자 이내로 작성해주세요");
	}
	else{
		var con = confirm("댓글을 등록하시겠습니까?");
		if (con == true) {
			frm.submit();
		}else{
			return false;
		}
	}
}

//리뷰게시판 글수정 유효성
function boardRWrite(){
	var frm = document.getElementById("frmWrite");
	var title = $("#title").val();
	var content = CKEDITOR.instances['content'].getData();
	var file = $("#nbrimg").val();
	frm.action="./boardRWrite.do";
		if(title==""){
			alert("제목을 입력해주세요");
		}else if(title.length>40){
			alert("제목을 40자 이내로 입력해주세요");
	}else if(file==""||file==null){
		alert("이미지 등록은 필수입니다.");
	}else if(content ==""){
		alert("내용을 입력해주세요");
	}
	else{
		var con = confirm("글을 등록하시겠습니까?");
		if (con == true) {
			frm.submit();
		}else{
			return false;
		}
	}
}



function boardRModify(){
//	alert("작동");
	var frm = document.getElementById("boardRModify");
	var title = $("#title").val();
	var content = CKEDITOR.instances['content'].getData();
	var selectImg = $("#selectImg").val();
	frm.action = "./boardRModify.do";
	if(title==""){
		alert("제목을 입력해주세요");
	}else if(title.length>40){
		alert("제목을 40자 이내로 작성해주세요");
	}else if(nbrimg==""){
		alert("이미지는 필수 입니다.")
	}else if(content==""){
		alert("내용을 입력해주세요");
	}
	else{
		var con = confirm("글을 수정하시겠습니까?");
		if (con == true) {
			frm.submit();
		}else{
			return false;
		}
	}
}

//글작성에서 목록으로 이동
function boardGListPage(){
	var con = confirm("작성을 취소하시겠습니까?");
	if (con == true) {
	  //delete
		location.href="./boardGList.do";
	}else{
		return false;
	}
}


function boardJListPage(){
	var con = confirm("작성을 취소하시겠습니까?");
	if (con == true) {
		  //delete
		location.href="./boardJList.do";
	}else{
		return false;
	}
}


function boardRListPage(){
	var con = confirm("작성을 취소하시겠습니까?");
	if (con == true) {
		location.href="./boardRList.do";
	}else{
		return false;
	}
}

function bBack(){
	var con = confirm("작성을 취소하시겠습니까?");
	if (con == true) {
		location.href="javascript:history.back(-1)";
	}else{
		return false;
	}
	
}

function commentDel(){
	alert("삭제되었습니다.");
}



//파일 추가 add
$(document).ready(function(){
	var fName = 
		document.getElementsByName("filename").length;
	var button = 
		"<input type='button' id='addbutton' value='추가' onclick='addinput()'>";
	$("#file_td").append(button);
});

function addinput(){
	var fName = 
		document.getElementsByName("filename").length;
	var input = 
		 "<input type='file' name='filename' onchange='fileChk(this)'>";
	$("#file_td").append(input);
}


function fileChk(f){
//	alert('ㅇㅇ');
	//파일 확장자 유효성
	if($(f).val != ""){
		var ext = $(f).val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['java','war','jar','html','jpg','gif',
							'png','txt','zip','alz','egg',
							'rar','7z','apk','ppt','xlsx','hwp'])==-1){
			alert('등록할 수 없는 파일입니다');
			$(f).val(""); //파일명을 다시 지워줌
			return
		}
		//화면에서 파일 용량 제한 
		if(f.value !=""){
			var size = f.files[0].size;
			var maxSize = 1*1024*1024 // 1mb
			if(size>maxSize){
				alert("108MB이내 파일을 등록해주세요");
				$(f).val("");
				return
			}
		}
	}
}










