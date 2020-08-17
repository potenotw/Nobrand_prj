

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
		swal("가입오류","비밀번호를 입력해주세요");
		return false;
	}
	else if(pwId!=pwChk||pwChk==""){	
		swal("가입오류","비밀번호가 맞지 않습니다.");
		return false;
	}
	else if(chkId=="0"){
		swal("가입오류","아이디 중복검사를 확인해주세요");
	}
	else if(name ==""){
		swal("가입오류","이름을 입력해주세요.");
		return false;
	}
	else if(nickname ==""){
		swal("가입오류","닉네임을 입력해주세요.");
		return false;
	}
	else if(phone ==""){
		swal("가입오류","핸드폰 번호를 입력해주세요.");
		return false;
	}
	else if(birthday ==""){
		swal("가입오류","생년월일을 입력해주세요.");
		return false;
	}
	else if(address==""){
		swal("가입오류","주소를 입력해주세요.");
		return false;
	}
	else if(agree==false){
		swal("가입오류","개인정보 수집 동의를 해주세요.");
		return false;
	}
	else{
		return true;
	}
	return false;
}

//회원 가입 아이디 유효성
$(document).ready(function(){
//	alert("작동");
	$("#id").keyup(function(){
//		alert("키");	
		var idLength = $(this).val().length;
		var id = $(this).val();
		if(id.indexOf(" ") != -1){
			$("#idResult").css("color","red");
			$("#idResult").html("공백이 포함되면 안됌");
			$("#chkval").val("0");
		}
		else if(idLength<5){
			$("#idResult").css("color","red");
			$("#idResult").html("6자리 이상의 아이디를 입력해주세요");
			$("#chkval").val("0");
		}
		else if(idLength>5){
			$.ajax({
				url: "./idChk.do",
				method: "POST",
				data: 'id='+$(this).val(),
				success : function(msg){
//					alert(msg.isc);
					if(msg.isc=="false"){
						$("#idResult").css("color","blue");
						$("#idResult").html("사용 가능");
						$("#chkval").val("1");
					}else{
						$("#idResult").css("color","red");
						$("#idResult").html("사용 불가능");
						$("#chkval").val("");
						$(this).val("");
					}
				},
				error:function(){
					swal("로그인 오류","잘못된 요청값입니다.");
				}
			});
		}
	});
});