<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link type='text/css' href="<c:url value='/css/hills/reservation_popup.css'/>" rel='stylesheet' />
<script type="text/javascript">

	var poRow;
	var poAction;
	var poBeforeData;
	var matchYn = false;
	var realAmt = 0;

	function initPopup() {
		var fW = $(window).width() / 2;
		var fH = $(window).height() / 2;
		var cW = Number(replaceAll($("#reservationPopup").css("width"), "px", "")) / 2;
		var cH = Number(replaceAll($("#reservationPopup").css("height"), "px", "")) / 2;
		var mW = fW - cW;
		var mH = fH - cH;
		
		$("#reservationPopup").css("left", mW);
		$("#reservationPopup").css("top", mH);
		
		$("#reservationPopup").css("display", "block");
		$("#overlay").css("display", "block");
		
		if(poAction == "I") {
			$("#poAction").html("예 약");
		} else if(poAction == "U") {
			$("#poAction").html("변 경");			
		}
	}

	function popupOpen(action, row, beforeData) {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
    		location.href = "<c:url value='/hills/member/login.do'/>";
    		return;
		}
		
		matchYn = false;
		realAmt = 0;
		
		var phone1 = "<c:out value='${sessionScope.msMember.phone1}'/>";
		var phone2 = "<c:out value='${sessionScope.msMember.phone2}'/>";
		var phone3 = "<c:out value='${sessionScope.msMember.phone3}'/>";
		
		if(phone1 == "" || phone2 == "" || phone3 == "") {
			alert("연락처를 입력한 후 예약할 수 있습니다.");
			location.href = "<c:url value='/hills/member/memModify.do'/>";
			return;
		}
		
		poAction = action;
		poRow = row;
		if(poAction == "U") {
			poBeforeData = beforeData;
		}
		
		initPopup();		
		
		var bkDay, bkTime, bkCosNm, bkRoundfNm, bkPhone, bkCharge, proDcGu, proDcVal;
		bkDay = poRow.BK_DAY;
		bkTime = poRow.BK_TIME;
		bkCosNm = poRow.BK_COS_NM;
		bkRoundfNm = poRow.BK_ROUNDF_NM;
		proDcGu = poRow.PRO_DC_GU;
		proDcVal = poRow.PRO_DC_VALUE;
		var mType = "1";
		
		if(poRow.BK_CHARGE != null && poRow.BK_CHARGE != ""){			
			// && poRow.MN_COST_YN != "Y" 20200609 권순형 추가
			if(poRow.BK_CHARGE.split(",")[2] != null && poRow.BK_CHARGE.split(",")[2] != "B" && matchYn == false && poRow.MN_COST_YN != "Y") {
				mType = "2";
			}
			
			$("#foodContainer").hide();
			
			var bkChargeNm = poRow.BK_CHARGE.split(",")[1];
			var basicCarge = poRow.BK_BASIC_CHARGE;
	    	var defaultCharge = bkChargeNm;
			var rGu = poRow.R_GU;
	    	
	    	if(rGu != "X") {
				if(rGu == "2") {
					mType = "4";
				}
				if(rGu == "3") {
					mType = "5";
					$("#foodContainer").show();
					$("#poSelFood").val("Y");
					$("#poSelFood").unbind("change").bind("change", function() {
						if($(this).val() == "Y") {
							mType = "4";
							$("#poBkCharge").html(numberWithCommas(Number(poRow.R_GREEN_AMT) + Number(poRow.R_CART_AMT) + Number(poRow.R_FOOD_AMT)) + " 원");
						} else {
							mType = "1";
							$("#poBkCharge").html(numberWithCommas(poRow.BK_CHARGE.split(",")[1]) + " 원");
						}
					});
				}
			    
				bkChargeNm = Number(poRow.R_GREEN_AMT) + Number(poRow.R_CART_AMT) + Number(poRow.R_FOOD_AMT);
		    }
			
			if(proDcGu != null && proDcGu != "X") {				
				if(proDcGu == "1") {					    	
					bkChargeNm = Number(proDcVal) / 4;
			    } else if(proDcGu == "2") {	
			    	bkChargeNm = Number(basicCarge) - (Number(basicCarge) * Number(proDcVal) / 100);					    	
			    } else if(proDcGu == "3") {
			    	bkChargeNm = Number(basicCarge) - Number(proDcVal);
			    }
				
				matchYn = true;
				
				realAmt = bkChargeNm;
				
				mType = "3";
			}
			
			if(rGu == "X" && Number(bkChargeNm) > Number(defaultCharge)) {
	    		bkChargeNm = defaultCharge;
	    		matchYn = false;
	    		mType = "1";
	    	}
			
			bkCharge = numberWithCommas(bkChargeNm);
		}
		
		bkPhone = "${sessionScope.msMember.msPhone}";
		bkPhone = phoneNumberFormat(bkPhone, " - ");
		
		$("#poMsPhone").html(bkPhone);
		
		var date = getDateFormat(bkDay);
		$("#poBkDay").html(String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", date.yyyy(), date.mm(), date.dd(), date.week()));
		
		$("#poCosTime").html(String.format("{0} / {1}홀 / {2} {3}:{4}", bkCosNm, bkRoundfNm, (Number(bkTime) < 1200 ? "오전" : "오후"), bkTime.substring(0, 2), bkTime.substring(2, 4)));	
		
		$("#poBkCharge").html(bkCharge + " 원");
		
		if(globals.personCd.three != poRow.BK_PERSON_CD) {
			$("#poBkPerson").val(4);
			$("#poBkPerson").prop("disabled", true);
		}

		$("#poPersonMessage").empty();
		$("#poPersonMessage").append(" / 4인 필수 타임 예약 후 인원 미달시 3.5인 요금적용됩니다.");
		
		if(matchYn == true) {
			$("#poPersonMessage").empty();
			$("#poPersonMessage").append(" / 맞춤 타임예약은 4인 필수이며, 미달시 4인 요금적용됩니다.");
		}
		
		showAlertMessage(mType);
	}
	
	function showAlertMessage(type) {
		var sUrl = "<c:url value='/common/getMessage.do'/>";
		var sParams = "";
		
		sParams += String.format("&coDiv={0}", globals.coDiv.hills);
		sParams += String.format("&hpDiv={0}", "3");
		sParams += String.format("&type={0}", type);
		sParams += String.format("&date={0}", poRow.BK_DAY);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				var rows = data.rows;
				if(rows.length == 1) {
					if(rows[0].HP_CONTENTS != null && rows[0].HP_CONTENTS != "") {
						alert(rows[0].HP_CONTENTS);	
					}
				}
			} else {
				alert(data.resultMessage);	
			}
			
			progressStop();
		});
	}
	
	function reservationCheck() {
		if(poAction == "I") {
			var sUrl = "<c:url value='/hills/reservation/getReservationCount.do'/>";
			var sParams = String.format("bkDay={0}", poRow.BK_DAY);
			
			progressStart();		
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				if(data.resultCode == "0000") {					
					reservationCheck2();
				} else if(data.resultCode == "2000") {					
					if(confirm(data.resultMessage)) {			
						reservationCheck2();						
					}	
				} else {
					alert(data.resultMessage);
				}			
			});	
		} else {
			reservationCheck2();
		}
	}
	
	function reservationCheck2() {
		if(poAction == "I") {
			var sUrl = "<c:url value='/hills/reservation/cehckPlaceboPeriod.do'/>";
			var sParams = String.format("bkDay={0}", poRow.BK_DAY);
			
			progressStart();		
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				if(data.resultCode == "0000") {					
					reservationCheck3();
				} else {
					if(confirm(data.resultMessage)) {		
						reservationCheck3();					
					}	
				}			
			});	
		} else {
			reservationCheck3();
		}
	}
	
	function reservationCheck3() {
		if(poAction == "I") {
			var sUrl = "<c:url value='/hills/reservation/cehckLimitCount.do'/>";
			var sParams = String.format("bkDay={0}", poRow.BK_DAY);
			
			progressStart();		
			
			mAjax(sUrl, sParams, function(data) {
				progressStop();
				
				if(data.resultCode == "0000") {					
					actionReservation();
				} else {
					alert(data.resultMessage);
				}			
			});
		} else {
			actionReservation();
		}
	}
	
	function actionReservation() {
		var sUrl;
		var sParams = "";
		
		var bkDay, bkTime, bkCos, bkRoundf, bkPerson, charge, proDcGu, proDcVal, advYn, foodYn;
		bkDay = poRow.BK_DAY;
		bkTime = poRow.BK_TIME;
		bkCos = poRow.BK_COS;
		bkRoundf = poRow.BK_ROUNDF;
		bkPerson = $("#poBkPerson").val();
		charge = poRow.BK_CHARGE.split(",")[0];
		proCd = poRow.PRO_CD;	
		proChasu = poRow.PRO_CHASU;
		proDcGu = poRow.PRO_DC_GU;
		proDcVal = poRow.PRO_DC_VALUE;
		advYn = poRow.PRO_ADV_YN;
		foodYn = poRow.PRO_FOOD_YN;
		proCd = proCd == null || proCd == "" ? "" : proCd;
		proChasu = proChasu == null || proChasu == "" ? "0" : proChasu;	
		proDcGu = proDcGu == null || proDcGu == "" ? "" : proDcGu;
		proDcVal = proDcVal == null || proDcVal == "" ? "0" : proDcVal;		
		royalGu = poRow.R_GU;
		royalAmtGu = poRow.R_AMT_GU;
		greenAmt = poRow.R_GREEN_AMT;
		foodAmt = poRow.R_FOOD_AMT;
		cartAmt = poRow.R_CART_AMT;
		roundBAmt = poRow.R_ROUND_B_AMT;
		roundAAmt = poRow.R_ROUND_A_AMT;
		
		if(matchYn) {
			charge = "Z9999";
		}
		
		if(royalGu == "1") {
			charge = "Z9997";
		} else if(royalGu == "2") {
			charge = "Z9996";
		} else if(royalGu == "3") {
			if($("#poSelFood").val() == "Y") {
				charge = "Z9995";			
			} else {	
				royalGu = "";
				greenAmt = 0;
				foodAmt = 0;
				cartAmt = 0;
			}
		}
		
		if(royalGu == "X") {
			royalGu = "";
		}
		
		if(poAction == "I") {
			sUrl = "<c:url value='/hills/reservation/actionReservation.do'/>";
			sParams += String.format("&bkDay={0}", bkDay);
			sParams += String.format("&bkTime={0}", bkTime);
			sParams += String.format("&bkCos={0}", bkCos);
			sParams += String.format("&bkRoundf={0}", bkRoundf);
			sParams += String.format("&bkPerson={0}", bkPerson);
			sParams += String.format("&bkCharge={0}", charge);
			sParams += String.format("&proCd={0}", proCd);
			sParams += String.format("&proChasu={0}", proChasu);
			sParams += String.format("&proDcGu={0}", proDcGu);
			sParams += String.format("&proDcVal={0}", proDcVal);
			sParams += String.format("&advYn={0}", advYn);
			sParams += String.format("&foodYn={0}", foodYn);
			sParams += String.format("&realAmt={0}", realAmt);
			sParams += String.format("&royalGu={0}", royalGu);
			sParams += String.format("&royalAmtGu={0}", royalAmtGu);
			sParams += String.format("&greenAmt={0}", greenAmt);
			sParams += String.format("&foodAmt={0}", foodAmt);
			sParams += String.format("&cartAmt={0}", cartAmt);
			sParams += String.format("&roundBAmt={0}", roundBAmt);
			sParams += String.format("&roundAAmt={0}", roundAAmt);
			sParams += String.format("&media={0}", "R");
		} else if(poAction == "U") {
			sUrl = "<c:url value='/hills/reservation/actionReservationChange.do'/>";
			sParams += String.format("&bBkDay={0}", poBeforeData.bkDay);
			sParams += String.format("&bBkTime={0}", poBeforeData.bkTime);
			sParams += String.format("&bBkCos={0}", poBeforeData.bkCos);
			sParams += String.format("&aBkDay={0}", bkDay);
			sParams += String.format("&aBkTime={0}", bkTime);
			sParams += String.format("&aBkCos={0}", bkCos);
			sParams += String.format("&aBkRoundf={0}", bkRoundf);
			sParams += String.format("&aBkPerson={0}", bkPerson);
			sParams += String.format("&aBkCharge={0}", charge);
			sParams += String.format("&proCd={0}", proCd);
			sParams += String.format("&proChasu={0}", proChasu);
			sParams += String.format("&proDcGu={0}", proDcGu);
			sParams += String.format("&proDcVal={0}", proDcVal);
			sParams += String.format("&advYn={0}", advYn);
			sParams += String.format("&foodYn={0}", foodYn);
			sParams += String.format("&realAmt={0}", realAmt);
			sParams += String.format("&royalGu={0}", royalGu);
			sParams += String.format("&royalAmtGu={0}", royalAmtGu);
			sParams += String.format("&greenAmt={0}", greenAmt);
			sParams += String.format("&foodAmt={0}", foodAmt);
			sParams += String.format("&cartAmt={0}", cartAmt);
			sParams += String.format("&roundBAmt={0}", roundBAmt);
			sParams += String.format("&roundAAmt={0}", roundAAmt);
			sParams += String.format("&media={0}", "R");
		}
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);	
			
			if(data.resultCode == "0000") {					
				location.href = "<c:url value='/hills/reservation/reservationCheck.do'/>";
			}				
		});	
	}
	
	function popupClose() {
		$("#reservationPopup").css("display", "none");
		$("#overlay").css("display", "none");
	}
</script>
<div id="reservationPopup" class="white_content">	
	<a class="closeImg" href="javascript:popupClose()"></a>
	<div class="informBox">
		<h4><img src="<c:url value='/images/hills/r_c_img.png'/>" alt=""></h4>
		<p class="informTitle">예약정보 확인</p>
		<ul>
			<li><span class="title">신청자</span><span>${sessionScope.msMember.msName}</span></li>
			<li><span class="title">핸드폰</span><span id="poMsPhone"></span></li>
			<li><span class="title">예약일자</span><span class="blue" id="poBkDay"></span></li>
			<li><span class="title">코스/홀/시간</span><span id="poCosTime"></span></li>
			<li><span class="title">예약인원</span>
			<span>
				<select id="poBkPerson" class="select-arrow" style="width: 55px; height: 30px">
					<option value='3'>3명</option>
					<option value='4'>4명</option>
				</select>
			</span>
			<span style="font-size:12px;letter-spacing: -1px;" id="poPersonMessage"> / 4인 필수 타임 예약 후 인원 미달시 3.5인 요금적용됩니다.</span>
			<li id="foodContainer" hidden><span class="title">식사여부</span>
			<span>
				<select id="poSelFood" class="select-arrow" style="width: 100px; height: 30px">
					<option value='Y' selected>포함</option>
					<option value='N'>미포함</option>
				</select>
			</span>
			<!-- <span> / 내장인원 미달시 예약인원 요금적용</span> -->
			</li>
			<li><span class="title">최종그린피</span><span class="last" id="poBkCharge"></span></li>
			<li><span class="title">취소규정</span><span class="reserText">주중은 5일전,주말은 7일전 17:00까지 페널티없이 취소 가능합니다.</span></li>
		</ul>
	</div>
	<div class="btnBox" style="padding-top:10px;">
		<a href="javascript:reservationCheck()" class="motion" id="poAction">예 약</a>
		<a href="javascript:popupClose()" class="cancel">취 소</a>
	</div>
	<div class="notice_info">
		<p><span class="blackText">※ 알려드립니다.</span><br><br>        
		      당 클럽에서는 TEE-OFF 시간을 준수하고 있습니다.<br>
		      원활한 경기진행을 위해 <span class="redText">라운드 전 40분까지</span>내장하여 주시기 바랍니다.<br><br>     
		   TEE-OFF란?<br>
		     첫 홀 마지막분이 티샷을 마치고 티잉 그라운드를 벗어나는 것       
		   <!-- <span class="underline">TEE-OFF 시간 미준수</span> 라운드 불가 및 1개월 예약정지 <span class="underline">당일미내장 (Not-Show)</span> 예약 및 내장 불가 -->
		</p>
	 </div>
</div>
<div id="overlay" class="overlay">		
</div>