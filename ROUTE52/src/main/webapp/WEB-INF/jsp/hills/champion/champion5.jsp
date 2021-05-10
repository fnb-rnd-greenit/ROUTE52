<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header5.jsp" />

<script type="text/javascript">
	function onClickTabs(i) {
		var isOdd = i % 2 == 1 ? true : false; // 홀수인지 판단
		idx1 = i; // 보여줄 친구 인덱스
		idx2 = isOdd ? i + 1 : i - 1; // 가릴친구 인덱스 (홀수면 + 1 , 짝수면 - 1)
	
		$("#tab" + idx1).show();
		$("#tab" + idx2).hide();z
	}	
	
	$(document).ready(function() {
		initHeaderTab(1);   
	});
	
	function moveBoard() {
		var birth = "${sessionScope.msMember.msBirth}";
		
		if(birth.length == 8) {
			location.href = "<c:url value='/hills/champion/ladyPassport2.do'/>";
		} else {
			alert("리더보드 확인을 위해서는\n로그인 후 ‘회원정보’란에 생년월일을\n입력하셔야만 확인이 가능합니다.")
			location.href = "<c:url value='/hills/member/memModify.do'/>";
		}
	}
</script>
<style>
 	*:focus { outline: none; }
	.ladysWrap{ width:980px; margin:0 auto; text-align: center;}
	.ladysWrap p{ width: 980px;}
	.ladysWrap p img{ vertical-align:top; display:block;}
	.pointer{ cursor: pointer;}
	.bn{ position:fixed; top:50%; left:50%; margin-left:490px; background-color:#ff8800;padding:10px; color:#fff; line-height:22px; font-size: 14px;text-align:center;cursor:pointer;}
</style>

<div id="wrap">
	<div id="championCon">
		<div class="chConBox">
			<div class="ladysWrap" style="position: relative;">
				<p><img src="<c:url value='/images/hills/champion/lady/lady_210428.jpg?v=2'/>" usemap="#Map" >
					<map name="Map">
					  <area shape="rect" coords="817,1951,924,2151" href="javascript:alert('5/4일 부터 참가신청이 가능합니다.');">
					  <area shape="rect" coords="819,2451,926,2601" href="https://www.clubd.com/championship/2021/main.do" target="_blank">
					</map>
				</p>							
				<div class="bn" onclick="moveBoard()">
				예선전<br>우선시드<br>리더보드
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" flush="true" />