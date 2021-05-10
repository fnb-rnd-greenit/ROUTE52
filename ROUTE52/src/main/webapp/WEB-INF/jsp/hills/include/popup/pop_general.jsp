<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.general_overlay{display: none;position: fixed;top: 0%;left: 0%;width: 100%;height: 100%;background:#000;z-index:1004;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}
.general_content{display: none;position: fixed;width:545px;background:#fff;z-index:1005;margin:0 auto; border:5px solid #ff6600; padding:40px 60px; border-radius:10px;}
.general_content h1{ font-size:30px; padding:15px 0 20px;}
.general_content table{ width:100%; text-align:left;}
.general_content table th{ width:140px; padding: 10px 0; font-weight:400;}
.general_content table td{ padding: 10px 0;}
.general_content table td.last{ padding: 2px 0 10px;}
.generalEtc{font-size:14px; padding-top:20px;word-break: keep-all; line-height:26px;}
.red{ color:red;}
.selectBox2{ height:40px; border:1px solid #dedede; text-indent:12px;background: url('../../images/hills/select-arrow.png') no-repeat 90% 50%;}
.wp50{ width:50%;}
.wp100{ width:100%;}

.generalClose{ position:absolute;text-align:center; right:-21px; top:-21px; cursor:pointer;}

</style>
<script>

	var selectedTimeIndex;

    function general_popupOpen(i, idx) {
        initGeneralPopup(i);
        
        if(i == 1) {
        	if(mGpRow == null || mGpRow == "") {
				alert("해당 계정으로 신청할 수 없습니다. 전화로 문의 해주세요.");
				
				general_popupClose();
				
				return;
			}
			
        	selectedTimeIndex = idx;
        	
        	var container = $("#popGeneralTeamContainer").find("tr");
        	
        	var d = getDateFormat(mRows[selectedTimeIndex].EL_DAY);
        	
        	container.eq(0).children("td").html(String.format("{0}년 {1}월 {2}일({3}요일)", d.yyyy(), d.mm(), d.dd(), d.week()));
        	container.eq(1).children("td").html(String.format("팀당{0}인 / {1}홀 / {2}시대"
        			, mRows[selectedTimeIndex].EL_PERSON
        			, mRows[selectedTimeIndex].EL_HOLE
        			, Number(mRows[selectedTimeIndex].EL_TIME)));
        }
    }

    function initGeneralPopup(i) {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#general_popup" + i).css("width").replace("px", "")) / 2;
        var cH = Number($("#general_popup" + i).css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#general_popup" + i).css("left", mW);
        $("#general_popup" + i).css("top", mH);

        $("#general_popup" + i).css("display", "block");
        $(".general_overlay").css("display", "block");
    }

    function general_popupClose() {
        $(".general_content").css("display", "none");
        $(".general_overlay").css("display", "none");
    }
	
	function actionWaitGeneralTeam() {
		var sUrl = "<c:url value='/hills/reservation/actionWaitGeneralTeam.do'/>";
		var sParams = "";
		
		var teamCnt = $("#poSelTeamCnt").val();
		var optionCode = $("#poSelOption").val();
		
		if(teamCnt == "") {
			alert("팀수를 선택하세요.");
			return;
		}
				
		if(optionCode == "") {
			alert("식음을 선택하세요.");
			return;
		}

		sParams += String.format("&date={0}", mRows[selectedTimeIndex].EL_DAY);
		sParams += String.format("&time={0}", mRows[selectedTimeIndex].EL_TIME);
		sParams += String.format("&gpNum={0}", mGpRow.GP_NUM);
		sParams += String.format("&gpName={0}", mGpRow.GP_NAME);
		sParams += String.format("&teamCnt={0}", teamCnt);
		sParams += String.format("&optionCode={0}", optionCode);
		
		progressStart();	
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {	
				general_popupClose();
				general_popupOpen(2);
			} else {
				alert(data.resultMessage);
			}			
		});
	}
    
</script>
<div id="general_popup1" class="general_content">
	<div class="generalClose" onclick="general_popupClose()"><img src="<c:url value='/images/hills/x2.png'/>" alt=""></div>
	<p><img src="<c:url value='/images/hills/r_c_img2.png'/>" alt=""></p>
	<h1>단체 예약 신청</h1>
	
	<table id="popGeneralTeamContainer">
		<tr>
			<th>예약일</th>
			<td></td>
		</tr>
		<tr>
			<th>인원/홀/시간</th>
			<td class="red bold"></td>
		</tr>
		<tr>
			<th>팀수</th>
			<td>
				<select id="poSelTeamCnt" class="selectBox2 wp50">
					<option value="">선택</option>
					<option value="3">3팀</option>
					<option value="4">4팀</option>
					<option value="5">5팀</option>
				</select>			
			</td>
		</tr>
		<tr>
			<th>식음 이용<span class="red">(필수 선택)</span></th>
			<td>
				<select id="poSelOption" class="selectBox2 wp100">
				</select>
			</td>
		</tr>
		<tr>
			<th></th>
			<td class="last"><a href="https://kr.object.ncloudstorage.com/hills/document/21%EB%85%84%203%EC%9B%94%20%EB%8C%80%EC%8B%9D%EB%8B%B9%20%EB%A9%94%EB%89%B4.pdf" target='_blank'><img src="<c:url value='/images/hills/btn_generalMenu.jpg'/>" alt=""></a></td>
		</tr>		
	</table>
	
	<p class="generalEtc red">※ 매월 실적 (이용금액, 에티켓 등) 50% 상위 단체에게는 5~12월 
    단체 예약 신청 시 우선순위 혜택 적용됩니다.</p>
	
	<div class="btnBox" >
		<input type="button" class="motion" onclick="actionWaitGeneralTeam()" value="신 청">
		<input type="button" class="cancel" onclick="general_popupClose()" value="취 소">
	</div>
</div>

<div id="general_popup2" class="general_content">
	<div class="generalClose" onclick="general_popupClose()"><img src="<c:url value='/images/hills/x2.png'/>" alt=""></div>
	
	<h1>신청 접수 완료</h1>
	<p class="generalEtc">
		※ 단체 예약 신청 접수가 완료 되었습니다.<br>
    추첨 및 우선순위 혜택 기준을 통해 예약 대상 단체 선정 후 배정 관련해 별도 연락 드립니다.<br>
   ※ 신청 내역은 홈페이지 마이존 예약 현황에서 확인 가능합니다. <br>
	</p>
	
	<div class="btnBox" >
		<input type="button" class="motion" onclick="location.href='<c:url value="/hills/reservation/reservationCheck.do"/>'" value="확 인">
	</div>
</div>
<div class="general_overlay" onclick="general_popupClose()"></div>