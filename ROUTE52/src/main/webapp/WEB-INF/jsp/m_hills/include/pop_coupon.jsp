<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.couponOverlay{
display: none;position: fixed;top: 0%;left: 0%;width: 100%;height: 100%;background:#777777;z-index:1004;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}	
@media (max-width: 420px) {
	.coupon_content {display: none;position: fixed;width:98%;height:80%;background:#fff;z-index:1005;margin:0 auto;overflow-y:scroll;min-width:320px;}

	.coupon_content .couponBox{padding:1.5em;}
	.coupon_content .couponBox img{width:100%;margin:0 auto;text-align:center;}
	.coupon_content .couponBox .titleBox{background:#0f004e;color:#fff;text-align:center;border-radius:10px;width:100%;font-size:0.9em;margin:0.9em 0;height:20px;line-height:20px;}
	.coupon_content .couponBox .couponInfo{width:100%;padding:0 0 0.9em;}
	.coupon_content .couponBox .couponInfo > li{font-size:0.85em;padding:0.3em 0;}
	.coupon_content .couponBox .useList{padding:0 0.3em;}
	.coupon_content .couponBox .useList .title{color:#45454f;font:0.9em 'Nanum GothicB';}
	.coupon_content .couponBox .useList > li{font-size:0.8em;color:#9f9f9f;padding:0.2em 0;line-height:1.9em;}
	
}
@media (min-width: 421px) {
	.coupon_content {display: none;position: fixed;width:98%;height:80%;background:#fff;z-index:1005;margin:0 auto;overflow-y:scroll;}

	.coupon_content .couponBox{padding:1.5em;}
	.coupon_content .couponBox img{width:100%;margin:0 auto;text-align:center;}
	.coupon_content .couponBox .titleBox{background:#0f004e;color:#fff;text-align:center;border-radius:10px;width:100%;font-size:1.2em;margin:0.9em 0;height:30px;line-height:30px;}
	.coupon_content .couponBox .couponInfo{width:100%;padding:0 0 0.9em;}
	.coupon_content .couponBox .couponInfo > li{font-size:1.1em;padding:0.3em 0;}
	.coupon_content .couponBox .useList{padding:0 0.3em;}
	.coupon_content .couponBox .useList .title{color:#45454f;font:1.2em 'Nanum GothicB';}
	.coupon_content .couponBox .useList > li{font-size:0.9em;color:#9f9f9f;padding:0.2em 0;line-height:1.9em;}
	
}
</style>
<script>
    function couponPopupOpen(poData) {
        initCouponPopup();

        $("#poEventName").html(poData.CP_NAME);
        $("#poEventName2").html(poData.CP_NAME);
        $("#poEventEndDate").html(poData.CP_USE_END_DT);
        //$("#poEventImage").attr("src", "data:image/png;base64," + poData.image);
        
        var commentContainer = $("#poEventComment");
        commentContainer.empty();
        
        if(poData.CP_REMARK != null && poData.CP_REMARK != "") {
            var comment = poData.CP_REMARK.split("\r\n");
            
            commentContainer.append("<li class='title'>· 이용안내</li>");
            
            for(i=0; i<comment.length; i++) {
            	commentContainer.append(String.format("<li>{0}</li>", comment[i]));
            }
        } else {
        	commentContainer.append("<li class='title'>· 이용안내</li>");
  			commentContainer.append("<li>1.본 쿠폰은 별도 출력없이 프론트 내장등록 시 사용하실 수 있으나, 접수 시 직원에게 쿠폰명과 사용 의사를 밝혀주셔야 적용 가능합니다.</li>");
  			commentContainer.append("<li>2.본 쿠폰은 유효기간까지 사용하지 않을경우, 이월되지 않고 자동 소멸됩니다.</li>");
  			commentContainer.append("<li>3.본 쿠폰은 1팀 4인기준 이며, ★소지자 본인이 서원힐스 홈페이지 또는 모바일(웹or웹) 예약 후 내장까지 해주셔야 적용 가능합니다.</li>");
  			commentContainer.append("<li>4.본 쿠폰은 연단체, 일반단체, 외부업체(대행사,에이전시) 예약팀 내장시 적용불가하며, 타 이벤트 및 혜택(지역할인,특가타임,연회원 혜택포함), 쿠폰 중복적용 불가입니다. </li>");
  			commentContainer.append("<li>5.본 쿠폰 혜택은 본인이외의 제3자가 사용할수 없으며, 어떠한경우에도 양도양수 및 교환의 대상이 될 수 없습니다.</li>");
        }
    }

    function initCouponPopup() {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#couponPopup").css("width").replace("px", "")) / 2;
        var cH = Number($("#couponPopup").css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#couponPopup").css("left", mW);
        $("#couponPopup").css("top", mH);

        $("#couponPopup").css("display", "block");
        $("#couponOverlay").css("display", "block");
    }

    function couponPopupClose() {
        $("#couponPopup").css("display", "none");
        $("#couponOverlay").css("display", "none");
    }
</script>
<div id="couponPopup" class="coupon_content">	
	<div class="couponBox">
		<img src="<c:url value='/images/m_hills/coupon_001.png'/>" id="poEventImage" alt="">	
		<p class="titleBox" id="poEventName"></p>
		<ul class="couponInfo">
			<li>이벤트명 : <span id="poEventName2"></span></li>
			<li>쿠폰우효기간: <span id="poEventEndDate"></span></li>
			<li>문의전화 :</li>
		</ul>
		<ul class="useList" id="poEventComment">
			<li class="title">· 이용안내</li>
			<li>1.본 쿠폰은 별도 출력없이 프론트 내장등록 시 사용하실 수 있으나, 접수 시 직원에게 쿠폰명과 사용 의사를 밝혀주셔야 적용 가능합니다.</li>
			<li>2.본 쿠폰은 유효기간까지 사용하지 않을경우, 이월되지 않고 자동 소멸됩니다.</li>
			<li>3.본 쿠폰은 1팀 4인기준 이며, ★소지자 본인이 서원힐스 홈페이지 또는 모바일(웹or웹) 예약 후 내장까지 해주셔야 적용 가능합니다.</li>
			<li>4.본 쿠폰은 연단체, 일반단체, 외부업체(대행사,에이전시) 예약팀 내장시 적용불가하며, 타 이벤트 및 혜택(지역할인,특가타임,연회원 혜택포함), 쿠폰 중복적용 불가입니다. </li>
			<li>5.본 쿠폰 혜택은 본인이외의 제3자가 사용할수 없으며, 어떠한경우에도 양도양수 및 교환의 대상이 될 수 없습니다.</li>
		</ul>

	</div>
	<a href="javascript:couponPopupClose()" class="motion closeBtn">닫기</a>
</div>
    <div id="couponOverlay" class="couponOverlay" onclick="couponPopupClose()">		
</div>