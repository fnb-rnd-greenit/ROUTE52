<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
    .overlay{display: none;position:fixed;top: 0%;left: 0%;width:100%;height:100%;background:#777777;z-index:1004;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}	
    .white_content {display: none;position: fixed;width: 98%;height:60%;overflow-y:scroll;background:#fff;z-index:1005;min-width:320px;}
	.white_content .agreeyText{width:100%;padding:1.5em;overflow-y:scroll;font-size:0.75em;line-height:23px;}
	.white_content .agreeyText .title{padding:0.5em 0;font:1.2em 'Nanum GothicB';}

@media (min-width: 420px) {
	.white_content {display:none;position:fixed;width:98%;height:50%;background:#fff;z-index:1005;margin-top:30px;}
	.white_content .agreeyText{width:100%;padding:1.5em;overflow-y:scroll;font-size:1em;line-height:25px;}
	.white_content .agreeyText .title{padding:0.5em 0;font:1.2em 'Nanum GothicB';}
	.closeBtn{display:block;width:20%;margin:1em auto;padding:0.6em 0;font:1.2em 'Manum GothicB';color:#fff;text-align:center;}

}
</style>
<script>
	var openIdx = -1;

    function popupOpen(i) {
        initPopup(i);
    }

    function initPopup(i) {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#agreey" + i).css("width").replace("px", "")) / 2;
        var cH = Number($("#agreey" + i).css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#agreey" + i).css("left", mW);
        $("#agreey" + i).css("top", mH);

        $("#agreey" + i).css("display", "block");
        $("#overlay").css("display", "block");

		openIdx = i;
    }

    function popupClose(i) {
        $("#agreey" + i).css("display", "none");
        $("#overlay").css("display", "none");
    }

    function popupOverlayClicked() {
		if(openIdx > 0){
			$("#agreey" + openIdx).css("display", "none");
			$("#overlay").css("display", "none");
		}
    }
</script>
<div id="agreey1" class="white_content">	

	<div class="agreeyText">
		<p class="title">이용약관</p>
		<p class="title">제 1조 (목적)</p>
		이 약관은 ㈜신세계건설(이하 "회사")가 제공하는 서원컨트리 클럽 웹사이트 관련 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다. 
		<p class="title">제 2 조 (정의)</p> 
		이 약관에서 사용하는 용어의 정의는 다음과 같습니다. <br>
		1. "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 자유컨트리클럽 웹사이트 관련 서비스를 의미합니다. <br>
		2. "회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다. <br>
		3. "아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다. <br>
		4. "비밀번호"라 함은 "회원"이 부여 받은 "아이디와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 의미합니다. <br>
		5. “골프회원”이라 함은 “회원”이 “회사”의 오프라인에서 클럽을 이용할 수 있는 골프이용권을 유료로 구입한 아이디와 회원권의 주민번호가 일치하는 회원”을 의미합니다. <br>
		6. "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다. <br>
	</div>
	<div onclick="popupClose(1)" class="motion closeBtn">확 인</div>
</div>
<div id="agreey2" class="white_content">	
	<div class="agreeyText">
		<p class="title">인터넷서비스 이용약관</p>
		<p class="title">제 1조 (목적)</p>
		이 약관은 ㈜신세계건설(이하 "회사")가 제공하는 서원컨트리 클럽 웹사이트 관련 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다. 
		<p class="title">제 2 조 (정의)</p> 
		이 약관에서 사용하는 용어의 정의는 다음과 같습니다. <br>
		1. "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 자유컨트리클럽 웹사이트 관련 서비스를 의미합니다. <br>
		2. "회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다. <br>
		3. "아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다. <br>
		4. "비밀번호"라 함은 "회원"이 부여 받은 "아이디와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 의미합니다. <br>
		5. “골프회원”이라 함은 “회원”이 “회사”의 오프라인에서 클럽을 이용할 수 있는 골프이용권을 유료로 구입한 아이디와 회원권의 주민번호가 일치하는 회원”을 의미합니다. <br>
		6. "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다. <br>
	</div>
	<div onclick="popupClose(2)" class="motion closeBtn">확 인</div>
</div>
<div id="agreey3" class="white_content">	
	<div class="agreeyText">
		<p class="title">개인정보 취급방침</p>
		<p class="title">제 1조 (목적)</p>
		이 약관은 ㈜신세계건설(이하 "회사")가 제공하는 서원컨트리 클럽 웹사이트 관련 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다. 
		<p class="title">제 2 조 (정의)</p> 
		이 약관에서 사용하는 용어의 정의는 다음과 같습니다. <br>
		1. "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 자유컨트리클럽 웹사이트 관련 서비스를 의미합니다. <br>
		2. "회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다. <br>
		3. "아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다. <br>
		4. "비밀번호"라 함은 "회원"이 부여 받은 "아이디와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 의미합니다. <br>
		5. “골프회원”이라 함은 “회원”이 “회사”의 오프라인에서 클럽을 이용할 수 있는 골프이용권을 유료로 구입한 아이디와 회원권의 주민번호가 일치하는 회원”을 의미합니다. <br>
		6. "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다. <br>
	</div>
	<div onclick="popupClose(3)" class="motion closeBtn">확 인</div>	
</div>
<div id="agreey4" class="white_content">	
	<div class="agreeyText">
		<p class="title">개인정보수집 이용 제공 취급위탁 동의</p>
		<p class="title">제 1조 (목적)</p>
		이 약관은 ㈜신세계건설(이하 "회사")가 제공하는 서원컨트리 클럽 웹사이트 관련 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다. 
		<p class="title">제 2 조 (정의)</p> 
		이 약관에서 사용하는 용어의 정의는 다음과 같습니다. <br>
		1. "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 자유컨트리클럽 웹사이트 관련 서비스를 의미합니다. <br>
		2. "회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다. <br>
		3. "아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다. <br>
		4. "비밀번호"라 함은 "회원"이 부여 받은 "아이디와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 의미합니다. <br>
		5. “골프회원”이라 함은 “회원”이 “회사”의 오프라인에서 클럽을 이용할 수 있는 골프이용권을 유료로 구입한 아이디와 회원권의 주민번호가 일치하는 회원”을 의미합니다. <br>
		6. "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다. <br>
	</div>
	<div onclick="popupClose(4)" class="motion closeBtn">확 인</div>
</div>
<div id="agreey5" class="white_content">	
	<div class="agreeyText">
		<p class="title">개인정보 수집이용 제공</p>
		<p class="title">제 1조 (목적)</p>
		이 약관은 ㈜신세계건설(이하 "회사")가 제공하는 서원컨트리 클럽 웹사이트 관련 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다. 
		<p class="title">제 2 조 (정의)</p> 
		이 약관에서 사용하는 용어의 정의는 다음과 같습니다. <br>
		1. "서비스"라 함은 구현되는 단말기(PC, TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 자유컨트리클럽 웹사이트 관련 서비스를 의미합니다. <br>
		2. "회원"이라 함은 회사의 "서비스"에 접속하여 이 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다. <br>
		3. "아이디(ID)"라 함은 "회원"의 식별과 "서비스" 이용을 위하여 "회원"이 정하고 "회사"가 승인하는 문자와 숫자의 조합을 의미합니다. <br>
		4. "비밀번호"라 함은 "회원"이 부여 받은 "아이디와 일치되는 "회원"임을 확인하고 비밀보호를 위해 "회원" 자신이 정한 문자 또는 숫자의 조합을 의미합니다. <br>
		5. “골프회원”이라 함은 “회원”이 “회사”의 오프라인에서 클럽을 이용할 수 있는 골프이용권을 유료로 구입한 아이디와 회원권의 주민번호가 일치하는 회원”을 의미합니다. <br>
		6. "게시물"이라 함은 "회원"이 "서비스"를 이용함에 있어 "서비스상"에 게시한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다. <br>
	</div>
	<div onclick="popupClose(5)" class="motion closeBtn">확 인</div>
</div>
<div id="overlay" class="overlay" onclick="popupOverlayClicked()">	
</div>