<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/pop_main.css'/>">
<script>
    
    function TpopupOpen() {
        var openFlag = getCookie('TPopupArea');
		if(openFlag != null && openFlag == 'Y') {
			return;
		}
		
        TinitPopup();
    }

    function TinitPopup(i) {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#TPopupArea").css("width").replace("px", "")) / 2;
        var cH = Number($("#TPopupArea").css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#TPopupArea").css("left", mW);
        $("#TPopupArea").css("top", mH);

        $("#TPopupArea").css("display", "block");
        $("#TPopupOverlay").css("display", "block");

		TopenIdx = i;
    }

    function TpopupClose(i) {
        $("#TPopupArea").css("display", "none");
        $("#TPopupOverlay").css("display", "none");
    }

    function TpopupOverlayClicked() {
    	$("#TPopupArea").css("display", "none");
		$("#TPopupOverlay").css("display", "none");
    }

	function onChecked() {
		$("#TPopupArea").css("display", "none");
		$("#TPopupOverlay").css("display", "none");
		setCookie("TPopupArea", "Y", 1);
	}
</script>

<div id="TPopupArea" class="MLWrap1">
    <div class="Tpop">
        <div class="Tpop_left">
            <form class="myForm" action="#">
                <input type="checkbox" name="myCheckBox" id="checkbox" class="checkbox" onclick="onChecked()">
                <label for="checkbox"><span>오늘 하루 안보기</span></label>
            </form>
        </div>
        <div class="Tpop_right" onclick="javascript:TpopupClose()"><img src="<c:url value='/images/m_hills/popup_x.png'/>"></div>
    </div>
    <p><a href="javascript:void(0)" onclick="TpopupOpen()" ><img src="<c:url value='/images/m_hills/main/popup.png'/>"></a></p>
</div>
<div id="TPopupOverlay" class="TPopupOverlay" onclick="TpopupOverlayClicked()"></div>
