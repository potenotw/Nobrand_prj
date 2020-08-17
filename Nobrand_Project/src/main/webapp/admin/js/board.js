function chkAll(bool){
//	alert(bool);
	var chkVals = document.getElementsByName("chkval");
	for (var i = 0; i < chkVals.length; i++) {
		chkVals[i].checked = bool;
	}
}

//체크 박스 
function chkbox() {
	var n = 0;
	var chkVals = document.getElementsByName("chkval");
	var title= $("#title").val();
	for (var i = 0; i < chkVals.length; i++) {
		if (chkVals[i].checked) {
			n++;
//			swal("삭제 완료","게시물이 삭제 되었습니다.");
		}
	}
	if (n != 0) {
		document.getElementById("chk").action="./boardDeleteMul.do";
	}else{
		swal("오류", "삭제 값이 없습니다.");
		return false;
	}
//글삭제
	function boardDel(val){
		alert(val);
		location.href="./boardDelete.do?seq="+val;
	}
	
}