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
        $("#poEventEndDate").html(poData.CP_USE_END_DT);
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
		<img src="<c:url value='/images/m_valley/coupon_001.png'/>" alt="">	
		<p class="titleBox">서원힐스 회원 모두 2월 그린피 1만원 할인</p>
		<ul class="couponInfo">
			<li>이벤트명 : <span id="poEventName"></span></li>
			<li>쿠폰우효기간: <span id="poEventEndDate"></span></li>
			<li>문의전화 :</li>
		</ul>
		<ul class="useList">
			<li class="title">· 이용안내</li>
			<li>1. 본 쿠폰 혜택은 별도의 출력없이 프런트 내장등록 시 사용하실 수 있으나, 직원에게 
							쿠폰명 과 사용 의사를 밝혀주셔야 적용 가능합니다.</li>
			<li>2. 본 쿠폰 혜택은 유효기간까지 사용하지않을경우, 이월되지 않고 자동 소멸됩니다.</li>
			<li>3. 본 쿠폰은 상기 혜택중 택1하여 사용가능하며, 1일 1회만 사용가능합니다.</li>
			<li>4. 본 쿠폰 혜택은 기타 다른 할인 쿠폰 및 할인 이벤트와 중복적용되지 않습니다.</li>
			<li>5. 본 쿠폰 혜택은 본인이외의 제3자가 사용할수 없으며, 어떠한경우에도 양도양수 및 교환의 대상이 될 수 없습니다.</li>
		</ul>

	</div>
	<a href="javascript:couponPopupClose()" class="motion closeBtn">닫기</a>
</div>
    <div id="couponOverlay" class="couponOverlay" onclick="couponPopupClose()">		
</div>