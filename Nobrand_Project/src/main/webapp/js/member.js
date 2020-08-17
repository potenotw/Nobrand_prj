

//회원 가입 유효성
function signCheck(){
	var id = document.getElementById("id").value;
	var pwId= document.getElementById("pwId").value;
	var pwChk = document.getElementById("pwChk").value;
	var name = document.getElementById("name").value;
	var nickname = document.getElementById("nickname").value;
	var phone = document.getElementById("phone").value;
	var birthday = document.getElementById("birthday").value;
	var address = document.getElementById("address").value;
	var agree = document.getElementById("agree").checked;
	var chkId = document.getElementById("chkval").value;
	
	if(pwId==""){
		alert("비밀번호를 입력해주세요");
		return false;
	}
	else if(pwId!=pwChk||pwChk==""){	
		alert("비밀번호가 맞지 않습니다.");
		return false;
	}
	else if(chkId=="0"){
		alert("아이디 중복검사를 확인해주세요");
	}
	else if(name ==""){
		alert("이름을 입력해주세요.");
		return false;
	}
	else if(nickname ==""){
		alert("닉네임을 입력해주세요.");
		return false;
	}
	else if(phone ==""){
		alert("핸드폰 번호를 입력해주세요.");
		return false;
	}
	else if(birthday ==""){
		alert("생년월일을 입력해주세요.");
		return false;
	}
	else if(address==""){
		alert("주소를 입력해주세요.");
		return false;
	}
	else if(agree==false){
		alert("개인정보 수집 동의를 해주세요.");
		return false;
	}else{
		alert("가입 되었습니다.")
	}
}

//아이디에 한글 입력이 안되도록 처리
//$(document).ready(function(){
//	  $("input[name=id]").keyup(function(event){ 
//	   if (!(event.keyCode >=37 && event.keyCode<=40)) {
//	    var inputVal = $(this).val();
//	    $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
//	   }
//	});
//});


//회원 가입 아이디 유효성
$(document).ready(function(){
//	alert("작동");
	$("#id").keyup(function(){
//		alert("키");	
//		alert($(this).val());
		var idLength = $(this).val().length;
		var id = $(this).val();
		//아이디에 공백이 들어갔을때의 유효성
		if(id.indexOf(" ") != -1){
			$("#idResult").css("color","red");
			$("#idResult").html("공백은 사용할 수 없습니다.");
			$("#chkval").val("0");
		}
		//6자리 이상 입력만 가능
		else if(idLength<5){
			$("#idResult").css("color","red");
			$("#idResult").html("6자리 이상의 아이디를 입력해주세요");
			$("#chkval").val("0");
		}
		else if(idLength>5){
			$.ajax({
				url: "./idChk.do",
				method: "POST",
				data: {'id':$(this).val()},
				success : function(msg){
					//가입되어있는 아이디가 없을때 
					if(msg.isc=="false"){
						$("#idResult").css("color","blue");
						$("#idResult").html("사용 가능");
						$("#chkval").val("1");
					}
					//가입되어있는 아이디가 있을때 
					else{
						$("#idResult").css("color","red");
						$("#idResult").html("사용 불가능");
						$("#chkval").val("");
						$(this).val("");
					}
				},
				error:function(){
					alert("이미 가입한 아이디가 있습니다.");
				}
			});
		}
	});
});

//아이디에 한글 입력이 안되도록 처리
$(document).ready(function(){
	  $("input[name=id]").keyup(function(event){ 
	   if (!(event.keyCode >=37 && event.keyCode<=40)) {
	    var inputVal = $(this).val();
	    $(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
	   }
	});
});


function bBack(){
	var con = confirm("가입을 취소하시겠습니까?");
	if (con == true) {
		location.href="javascript:history.back(-1)";
	}else{
		return false;
	}
	
}



