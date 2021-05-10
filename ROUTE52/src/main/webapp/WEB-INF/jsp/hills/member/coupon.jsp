<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<link type='text/css' href="<c:url value='/css/hills/modal_coupon.css'/>" rel='stylesheet' media='screen' />
<script type="text/javascript">

	var smYear, smMonth, fmYear, fmMonth;
	var stDate, fnDate;	
	var rowData;

	$(document).ready(function() { 
		init();

	    var offset = $(".myzoneTabList8").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";	
		}
		
		var date = new Date();
		var date2 = new Date(date.yyyy() + 1, date.mm(), date.dd());
		smYear = fmYear = date.yyyy();
		smMonth = date.mm();
		fmMonth = date2.mm();
		
		$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date2.yyyy(), date2.mm(), date2.dd()));
		
		initSubCalendar("#subMonthBox1", smYear, smMonth);
		initSubCalendar("#subMonthBox2", fmYear, fmMonth);
		
		doSearch();
	}
	
	function doSearch() {
		var tBody = $("#tbody");
		
		var sUrl = "<c:url value='/hills/member/getCouponList.do'/>";
		var sParams = "";
		
		var stDate, edDate;
		stDate = replaceAll($("#show_hideSub4").html(), "/", "");
		edDate = replaceAll($("#show_hideSub5").html(), "/", "");
		
		if(stDate == null || stDate == "") {
			alert("조회 시작일을 선택하세요.");
		}
		
		if(edDate == null || edDate == "") {
			alert("조회 종료일을 선택하세요.");
		}
		
		sParams += String.format("&stDate={0}", stDate);
		sParams += String.format("&edDate={0}", edDate);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				tBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					if(rowData.length == 0) {
						var row = $("<tr><td colspan='6'><span class='txt'> 등록된 쿠폰이이 없습니다. </span></td></tr>");
						row.appendTo(tBody); 
					}
				}
				
				for(i=0; i<rowData.length; i++) {
					var useYn = rowData[i].CP_USE_YN;
			
					var row = $("<tr></tr>"); 
				    var col1 = $("<td>" + (i + 1) + "</td>"); 
				    if(useYn == "N") {
					    var col2 = $("<td><a href='javascript:onClickCoupon(" + i + ")' class='coupon' id='basic-modal'><img class='basic' src='<c:url value='/images/hills/coupon.png'/>' alt=''></a></td>");
					    //var col2 = $("<td><a href='javascript:onClickCoupon(" + i + ")' class='coupon' id='basic-modal'><img class='basic' style='width:94px; height:45px' src='data:image/png;base64," + rowData[i].image + "' alt=''></a></td>");
					    var col3 = $("<td>" + rowData[i].CP_NAME + "</td>");
					    var col4 = $("<td>" + rowData[i].CP_USE_END_DT + "</td>"); 
					    var col5 = $("<td>" + rowData[i].CP_USE_YN_NM + "</td>");
					    var col6 = $("<td>" + rowData[i].CP_USE_DT + "</td>");
					    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody);
				    } else {
					    var col2 = $("<td><a href='javascript:void(0)' class='coupon' id='basic-modal'><img class='basic' src='<c:url value='/images/hills/coupon_end.png'/>' alt=''></a></td>");
					    var col3 = $("<td class='gray'>" + rowData[i].CP_NAME + "</td>");
					    var col4 = $("<td class='gray'>" + rowData[i].CP_USE_END_DT + "</td>"); 
					    var col5 = $("<td class='orangeRed'>" + rowData[i].CP_USE_YN_NM + "</td>");
					    var col6 = $("<td class='gray'>" + rowData[i].CP_USE_DT + "</td>");
					    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody); 				    	
				    }
				}
				
				$("#txtTotalCount").html(rowData.length);
 
			} else {
				alert(data.resultMessage);	
			}
			
			progressStop();
		});
	}
	
	function onClickCoupon(i) {
		$('#basic-modal-content').modal();

        $("#poEventName").html(rowData[i].CP_NAME);
        $("#poEventName2").html(rowData[i].CP_NAME);
        $("#poEventEndDate").html(rowData[i].CP_USE_END_DT);
        //$("#poEventImage").attr("src", "data:image/png;base64," + rowData[i].image);
        
        if(rowData[i].CP_REMARK != null && rowData[i].CP_REMARK != "") {
            var commentContainer = $("#poEventComment");
            var comment = rowData[i].CP_REMARK.split("\r\n");
            
            commentContainer.empty();
            commentContainer.append("<li class='title'>· 이용안내</li>");
            
            for(i=0; i<comment.length; i++) {
            	commentContainer.append(String.format("<li>{0}</li>", comment[i]));
            }
        }
	}
	
	function initSubCalendar(selector, year, month) {
		var rows = getCalendar(year, month);
			
		$(selector + " #calHeader").html(year + " / " + month);		
				
		var tBody = $(selector + " #calendar-body");				
		tBody.empty();
		
		var row = $("<tr></tr>");
		
		var fWeek = rows[0].week - 1;
		
		for(i=0; i<fWeek; i++) {
			row.append($("<td><div></div></td>"));
		}		
		
		for(i=0; i<rows.length; i++) {
			var td = $("<td><div>" + rows[i].day + "</div></td>");
			
			if(rows[i].date == new Date().yyyymmdd()) {
				td.addClass('today');
			}
			
			td.addClass('possible');
			td.data('date', rows[i].date);
			if(selector == "#subMonthBox1"){
				td.data("div", "start");
			} else {
				td.data("div", "finish");							
			}
			td.on('click', function() {
				onClickMiniDay($(this).data('div'), $(this).data('date')); 
			});
			
			row.append(td);
								
			if(rows[i].week == 7) {
				row.appendTo(tBody); 
				row = $("<tr></tr>");
			}					
		}			

		row.appendTo(tBody);     
	}
	
	function smNextMonth() {
	    if(smMonth == "12") {
	        smYear += 1;
	        smMonth = "01";
	    } else {
	        smMonth = Number(smMonth) + 1;
	        smMonth = (smMonth>9 ? '' : '0') + smMonth;
	    }

	    initSubCalendar("#subMonthBox1", smYear, smMonth);
	}

	function smPrevMonth() {
	    if(smMonth == "01") {
	        smYear -= 1;
	        smMonth = "11";
	    } else {
	        smMonth = Number(smMonth) - 1;
	        smMonth = (smMonth>9 ? '' : '0') + smMonth;
	    }

	    initSubCalendar("#subMonthBox1", smYear, smMonth);		
	}

	function fmNextMonth() {
	    if(fmMonth == "12") {
	        fmYear += 1;
	        fmMonth = "01";
	    } else {
	        fmMonth = Number(fmMonth) + 1;
	        fmMonth = (fmMonth>9 ? '' : '0') + fmMonth;
	    }

	    initSubCalendar("#subMonthBox2", fmYear, fmMonth);
	}

	function fmPrevMonth() {
	    if(fmMonth == "01") {
	        fmYear -= 1;
	        fmMonth = "11";
	    } else {
	        fmMonth = Number(fmMonth) - 1;
	        fmMonth = (fmMonth>9 ? '' : '0') + fmMonth;
	    }

	    initSubCalendar("#subMonthBox2", fmYear, fmMonth);
	}
	
	function onClickMiniDay(div, sDate) {
		var date = getDateFormat(sDate);
		
		if(div == "start") {
			stDate = sDate;
			$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox4").slideToggle();			
		} else if(div == "finish") {
			fnDate = sDate;
			$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
			$(".SubMonthBox5").slideToggle();			
		} 		
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>내장현황</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
			<a href="<c:url value='/hills/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/hills/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/hills/member/stateScore.do'/>" class="">스코어현황</a> 
			<a href="<c:url value='/hills/member/coupon.do'/>" class="on">쿠폰함</a>
			<!-- <a href="javascript:alert('준비중입니다.')" class="">마이포인트</a> -->
			<a href="<c:url value='/hills/board/list.do?bbsType=9'/>" class="">고객의소리</a>
			<a href="<c:url value='/hills/member/memModify.do'/>" class="">회원정보수정</a>
		</div>
		
		<div class="subTitle">
			<span class="title">내장현황</span>
			<span class="titleDes">고객님의 내장현황을 확인하실 수 있습니다.</span>
		</div>
		<div class="subLine"></div>

		<div class="grayCommonBox">
			<div class="inquiry">
				<span class="inquiryTitle">조회기간</span>
				<!--미니달력시작-->
					<div class="dayInput" id="show_hideSub4"></div>								                
                        <div class="SubMonthBox4" id="subMonthBox1">
						  <div class="monthChoice">
							<a href="javascript:smPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:smNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
						  </div>
																				
						  <table class="mainCalendar" summary="실시간 예약" cellspacing="5">
                                 <caption>
                                 실시간 예약
                                 </caption>
                                 <colgroup>
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 </colgroup>
                                 <tr>
                                    <th scope="col" class="sun">SUN</th>
                                    <th scope="col">MON</th>
                                    <th scope="col">TUE</th>
                                    <th scope="col">WEN</th>
                                    <th scope="col">THU</th>
                                    <th scope="col">FRI</th>
                                    <th scope="col">SAT</th>
                                  </tr>
                                 <tbody id="calendar-body">
									<tr><td colspan="7"><div></div></td></tr>
									<tr><td colspan="7"><div></div></td></tr>
									<tr><td colspan="7"><div></div></td></tr>
									<tr><td colspan="7"><div></div></td></tr>
									<tr><td colspan="7"><div></div></td></tr>
								</tbody>
                    		</table>
					</div><!--//미니달력 끝-->

				<img src="<c:url value='/images/hills/resCal_w.png'/>" alt="">
				<span>&nbsp;&nbsp; ~ &nbsp;&nbsp;</span>
				<!--미니달력시작-->
					<div class="dayInput" id="show_hideSub5"></div>								                
                        <div class="SubMonthBox5" id="subMonthBox2">
						  <div class="monthChoice">
							<a href="javascript:fmPrevMonth()"><img src="<c:url value='/images/hills/arrow_l.png'/>" alt="전 달" width="15" height="20"></a>
							<span class="month" id="calHeader"></span>
							<a href="javascript:fmNextMonth()"><img src="<c:url value='/images/hills/arrow_r.png'/>" alt="다음달" width="15" height="20"></a>
						  </div>
																				
						  <table class="mainCalendar" summary="실시간 예약" cellspacing="5">
                                 <caption>
                                 실시간 예약
                                 </caption>
                                 <colgroup>
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 <col width="*">
                                 </colgroup>
                                 <tr>
                                    <th scope="col" class="sun">SUN</th>
                                    <th scope="col">MON</th>
                                    <th scope="col">TUE</th>
                                    <th scope="col">WEN</th>
                                    <th scope="col">THU</th>
                                    <th scope="col">FRI</th>
                                    <th scope="col">SAT</th>
                                  </tr>
                                 <tbody id="calendar-body">
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
							<tr><td colspan="7"><div></div></td></tr>
						</tbody>
                    </table>
					</div><!--//미니달력 끝-->

				<img src="<c:url value='/images/hills/resCal_w.png'/>" alt="">
				<a href="javascript:doSearch()" class="inquiryBtn">검색</a>
			</div>
		</div>

		<div class="midTitleBox">
			<span class="commonDot"> TOTAL: <span class="blue" id="txtTotalCount"></span></span>
		</div>

		<table class="commonTable tableBottom">
			<caption> 실시간예약 현황</caption>
			<colgroup>
				<col width="10%">
				<col width="16%">
				<col width="35%">
				<col width="13%">
				<col width="13%">
				<col width="13%">
			</colgroup>
			<tr>
				<th>번호</th>
				<th></th>
				<th>쿠폰명</th>
				<th>유효기간</th>
				<th>사용여부</th>
				<th>사용일자</th>
			</tr>
			<tbody id="tbody">
				<!-- <tr>
					<td>1</td>
					<td><a href="" class="coupon" id='basic-modal'><img class="basic" src="../images/coupon.png" alt=""></a></td>
					<td>그린피 1만원쿠폰</td>
					<td>2019-02-28</td>
					<td class="blue">사용가능</td>
					<td>2019-02-01</td>
				</tr>
				<tr>
					<td>1</td>
					<td><a href="" class="coupon" id='basic-modal'><img class="basic" src="../images/coupon_end.png" alt="" class="end"></a></td>
					<td class="gray">그린피 1만원쿠폰</td>
					<td class="gray">2019-02-28</td>
					<td class="orangeRed">사용완료</td>
					<td class="gray">2019-02-01</td>
				</tr> -->
			</tbody>
			<tr>
				<td colspan="6">
					<span class="txt">※ 쿠폰 사용은 프론트에 문의하세요.</span>
				</td>
			</tr>
		</table>
		
		<script type='text/javascript' src="<c:url value='/js/hills/jquery.simplemodal.js'/>"></script>
		
		<!-- The Modal -->
		 <div id='container'>		
			<div id='content'>				
				<!-- modal content -->
				<div id="basic-modal-content">
					<div class="couponBox">
						<img src="<c:url value='/images/hills/coupon_001.png'/>" id="poEventImage" style="width: 530px; height:auto;" alt="">	
						<p class="titleBox" id="poEventName"></p>
						<ul class="couponInfo">
							<li>이벤트명 : <span id="poEventName2"></span></li>
							<li>쿠폰유효기간: <span id="poEventEndDate"></span></li>
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
					
					<div style='display:none'>
					</div>
				</div><!-- modal content End-->

			</div>
        <!-- Modal container End -->
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />