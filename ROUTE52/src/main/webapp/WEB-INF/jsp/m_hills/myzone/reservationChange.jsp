<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_reser_confirm.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<script type="text/javascript">

	var rowData;
	var mCos;
	var mPart;

	$(document).ready(function() { 
		init();
		
		initTable();
	});
	
	function initTable() {
		var $table = $("#time-table");
		var $header = $table.children("tbody").first().children("tr");
		
		$header.children("th").each(function(index, element) {
			var selector = "time-grid";
			var imgAsc = "<c:url value='/images/m_hills/t_arw.png'/>";
			var imgDesc = "<c:url value='/images/m_hills/t_arw1.png'/>";
			
			if(index == 0 || index == 5) {
				var type = index == 5 ? "n" : "s";
				
				$(this).css("background-image", "url(" + imgAsc + "), url(" + imgDesc + ")");
				$(this).css("background-position", "50% 10%, 50% 90%");
				$(this).css("background-size", "12px 7px, 12px 7px");
				$(this).css("background-repeat", "no-repeat");
				
				$(this).data("order", "asc");
				
				$(this).on("click", function() {
					sortTable(selector, type, $(this).data("order"), index);
					if($(this).data("order") == "asc") {
						$(this).css("background-image", "url(" + imgAsc + ")");
						$(this).css("background-position", "50% 10%");
						$(this).data("order", "desc");
					} else {
						$(this).css("background-image", "url(" + imgDesc + ")");
						$(this).css("background-position", "50% 90%");
						$(this).data("order", "asc");
					}
					$(this).css("background-size", "12px 7px");
				});
			}
		});
	}
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/m_hills/member/login.do'/>";	
		}
		
		var bkName = "${bkName}";
		var bkDay = getDateFormat("${bkDay}");
		bkDay = String.format("{0}년 {1}월 {2}일 &#40;{3}요일&#41;", bkDay.yyyy(), bkDay.mm(), bkDay.dd(), bkDay.week());
		var bkPhone = String.format("{0}-{1}-{2}", "${phone1}", "${phone2}", "${phone3}");
		var bkCos = "${bkCosNm}";
		var bkRoundf = "${bkRoundfNm}";
		var bkTime = "${bkTime}";
		bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
		var bkPerson = "${person}";
		var bhChargeNm = "${bkChargeNm}";

		if("${agencyYn}" == "Y"){
			$("#txtName").val(bkName);
			$("#txtPhone").val(bkPhone);
		} else {
			$("#txtName").html(bkName);
			$("#txtPhone").html(bkPhone);
		}
		$("#txtName").html(bkName);
		$("#txtDate").html(bkDay);
		$("#txtPhone").html(bkPhone);
		$("#txtCos").html(String.format("{0}코스 / {1} / {2}", bkCos, bkRoundf, bkTime));
		$("#selPerson").val(bkPerson);
		$("#txtCost").html(numberWithCommas(bhChargeNm));
		$("#txtBkDate").html(bkDay);	
		
		if(globals.personCd.three != "${personCd}") {
			$("#selPerson").prop("disabled", true);
		} 	
		
		doSearch();
	}
	
	function doSearch() {	
		var sUrl = "<c:url value='/hills/reservation/getTeeList.do'/>";
		var sParams = "";
		
		sParams += String.format("&date={0}", "${bkDay}");
		
		if(mCos != null && mCos != "") {
			sParams += String.format("&cos={0}", mCos);
		}
		
		if(mPart != null && mPart != "") {
			sParams += String.format("&part={0}", mPart);
		}
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {
				var tBody = $("#time-grid");				
				tBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					progressStop();
					
					return;
				}
				
				for(i=0; i<rowData.length; i++) {
					var row = $("<tr onclick='onClickRow(" + i + ")'></tr>"); 
					
					var bkTime = rowData[i].BK_TIME;
					bkTime = (Number(bkTime) < 1200 ? "오전" : "오후") + " " + bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
					var bkCharge;
					if(rowData[i].BK_CHARGE != null && rowData[i].BK_CHARGE != ""){
						bkCharge = rowData[i].BK_CHARGE.split(",")	
					}
					var proDcGu = rowData[i].PRO_DC_GU;
					var proDcVal = rowData[i].PRO_DC_VALUE;				    
				    var bkChargeNm = bkCharge[1];
				    var rGu = rowData[i].R_GU;
					
				    var col1 = $("<td>" + bkTime + "<br>" + rowData[i].BK_COS_NM + "</td>");
				    var col2 = $("<td>" + rowData[i].BK_ROUNDF_NM + "</td>");				    
				    var col3 = $("<td>" + globals.personCd.codeNm(rowData[i].BK_PERSON_CD) + "</td>");
				    var col4 = $("<td>" + numberWithCommas(rowData[i].BK_BASIC_CHARGE) + "</td>");			
				    var col5;
				    if(bkCharge[2] == "M") {
				    	col5 = $("<td><span class='event_ss'>특가</span></td>");
					    col4.css("text-decoration", "line-through");
				    } else if(bkCharge[2] == "S") {
				    	if(rowData[i].MN_COST_YN == "Y") {
				    		col4 = $("<td>" + numberWithCommas(bkCharge[1]) + "</td>");	
				    		col5 = $("<td></td>");
				    	} else {
						    col4.css("text-decoration", "line-through");
						    col5 = $("<td><span class='event_ss'>특가</span></td>");
				    	}
				    } else if(bkCharge[2] == "R") {
				    	col5 = $("<td><span class='event_ss'>특가</span></td>");
					    col4.css("text-decoration", "line-through");
				    } else {
				    	col5 = $("<td></td>");
				    }
				    
				    if(rGu != "X") {
				    	if(rGu == "1") {
				    		continue;
				    	} else if(rGu == "2") {
				    		col5 = $("<td><span class='event_se'>조기</span></td>");
				    	} 
				    	else if(rGu == "3") {
				    		col5 = $("<td><span class='event_sf'>식사</span></td>");		
				    	}				    	
					    col4.css("text-decoration", "line-through");
					    
					    bkChargeNm = Number(rowData[i].R_GREEN_AMT) + Number(rowData[i].R_CART_AMT) + Number(rowData[i].R_FOOD_AMT) + Number(rowData[i].R_ROUND_B_AMT) + Number(rowData[i].R_ROUND_A_AMT);
				    }
				    
				    if(proDcGu != "X") {
				    	var basicCharge = rowData[i].BK_BASIC_CHARGE;
				    	var defaultCharge = bkChargeNm;
					    
				    	if(proDcGu == "1") {					    	
						    bkChargeNm = Number(proDcVal) / 4;
					    } else if(proDcGu == "2") {	
						    bkChargeNm = Number(basicCharge) - (Number(basicCharge) * Number(proDcVal) / 100);					    	
					    } else if(proDcGu == "3") {
					    	bkChargeNm = Number(basicCharge) - Number(proDcVal);   
					    } 
				    	
					    if(Number(bkChargeNm) <= Number(defaultCharge)) {
				    		var advYn = rowData[i].PRO_ADV_YN;
				    		var foodYn = rowData[i].PRO_FOOD_YN;
				    		var sTag = ""			    		
				    		if(advYn == "Y") {
				    			sTag = "조기맞춤";
				    		} else {
				    			sTag = "맞춤";
				    		}
				    		if(foodYn == "Y") {
				    			if(sTag.length > 2) sTag += "<br>+<br>식사";
				    			else sTag += "+식사";
				    		}
				    		
					    	col5 = $("<td><span class='event_sc'>" + sTag + "</span></td>");
						    col4.css("text-decoration", "line-through");
				    	} else {
				    		bkChargeNm = defaultCharge;
				    	}
				    }

				    var col6 = $("<td class='last'>" + numberWithCommas(bkChargeNm) + "</td>");				    
				    
				    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody); 
				}
			}
			
			progressStop();
		});
	}
	
	function onClickRow(i) {
		var beforeData = {
			bkDay : "${bkDay}",
			bkCos : "${bkCos}",
			bkTime : "${bkTime}"
		}
		
		confirmPopupOpen("U", rowData[i], beforeData);
	}
	
	function onCosTapChange(cos) {
		if(cos == '') {
			$(".courseTabList #cosAll").addClass("on");
			$(".courseTabList #cosA").removeClass("on");
			$(".courseTabList #cosB").removeClass("on");
			$(".courseTabList #cosC").removeClass("on");
		} else if(cos == 'A') {
			$(".courseTabList #cosAll").removeClass("on");
			$(".courseTabList #cosA").addClass("on");
			$(".courseTabList #cosB").removeClass("on");
			$(".courseTabList #cosC").removeClass("on");			
		} else if(cos == 'B') {
			$(".courseTabList #cosAll").removeClass("on");
			$(".courseTabList #cosA").removeClass("on");
			$(".courseTabList #cosB").addClass("on");
			$(".courseTabList #cosC").removeClass("on");
		} else if(cos == 'C') {
			$(".courseTabList #cosAll").removeClass("on");
			$(".courseTabList #cosA").removeClass("on");
			$(".courseTabList #cosB").removeClass("on");	
			$(".courseTabList #cosC").addClass("on");
		}
		
		mCos = cos;
		doSearch(); 
	}
	
	function onPartTapChange(part) {
		if(part == '') {
			$(".sectionList #partAll").addClass("on");
			$(".sectionList #part1").removeClass("on");
			$(".sectionList #part2").removeClass("on");
			$(".sectionList #part3").removeClass("on");
		} else if(part == '1') {
			$(".sectionList #partAll").removeClass("on");
			$(".sectionList #part1").addClass("on");
			$(".sectionList #part2").removeClass("on");
			$(".sectionList #part3").removeClass("on");
		} else if(part == '2') {
			$(".sectionList #partAll").removeClass("on");
			$(".sectionList #part1").removeClass("on");
			$(".sectionList #part2").addClass("on");
			$(".sectionList #part3").removeClass("on");
		} else if(part == '3') {
			$(".sectionList #partAll").removeClass("on");
			$(".sectionList #part1").removeClass("on");
			$(".sectionList #part2").removeClass("on");
			$(".sectionList #part3").addClass("on");
		}
		
		mPart = part;              
		doSearch(); 
	}
	
	function doChangePerson() {
		var sUrl = "<c:url value='/hills/reservation/changeReservationPerson.do'/>";
		var sParams = "";
		
		var bkDay = "${bkDay}";
		var bkCos = "${bkCos}";
		var bkTime = "${bkTime}";
		var bkRsvNo = "${bkRsvNo}";
		var bkPerson = $("#selPerson").val();

		sParams += String.format("&bkDay={0}", bkDay);
		sParams += String.format("&bkCos={0}", bkCos);
		sParams += String.format("&bkTime={0}", bkTime);
		sParams += String.format("&bkRsvNo={0}", bkRsvNo);		
		sParams += String.format("&bkPerson={0}", bkPerson);
		
		if("${agencyYn}" == "Y") {
			bkName = $("#txtName").val();
			bkPhone = $("#txtPhone").val();
			bkPhone = replaceAll(bkPhone, " ", "");
			bkPhone = replaceAll(bkPhone, "-", "");
			sParams += String.format("&bkName={0}", bkName);
			sParams += String.format("&bkPhone={0}", bkPhone);
		}
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);				
		});	
	}
	
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> MY ZONE <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList">			
		<!-- <li class=""><a href="javascript:alert('준비중입니다')">추천예약</a></li> -->
		<li class="on"><a href="<c:url value='/m_hills/reservation/reservationCheck.do'/>">예약현황</a></li>
		<li class=""><a href="<c:url value='/m_hills/member/coupon.do'/>">쿠폰함</a></li>
		<li class=""><a href="<c:url value='/m_hills/member/score.do'/>">스코어카드</a></li>
		<li class=""><a href="javascript:alert('준비중입니다')">MY연단체</a></li>
	</ul>
	<div class="contents">
		<div class="commonDot"> 실시간예약 현황</div>
		<div class="borderBg">
			<ul class="infoList">
				<li>
					<span class="infoDot"></span><span class="title">신청자</span>
					<c:if test="${agencyYn eq 'Y'}">
						<input type="text" id="txtName" style="width:150px;height:30px; border:1px solid #ddd;"> 
					</c:if>
					<c:if test="${agencyYn eq 'N'}">
						<span id="txtName"></span>
					</c:if>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">예약일자</span><span class="orange" id="txtDate"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">핸드폰</span>
					<c:if test="${agencyYn eq 'Y'}">
						<input type="text" id="txtPhone" style="width:150px;height:30px; border:1px solid #ddd;"> 
					</c:if>
					<c:if test="${agencyYn eq 'N'}">
						<span id="txtPhone"></span>
					</c:if>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">코스/홀/시간</span><span  id="txtCos"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">인원</span>
					<select name="" id="selPerson" class="select-arrow">
						<option value="3">3명</option>
						<option value="4">4명</option>
					</select>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">인터넷회원가</span><span class="orangeRed" id="txtCost"></span>
				</li>
			</ul>
			<div class="dotLine"></div>
			<a class="cancel" href="javascript:doChangePerson()">정보변경</a>			
		</div>	
		<div class="roundBgBox purple">
			● 예약일자 : <span class="yellow" id="txtBkDate"></span>
		</div>
		<div class="courseTabList">
		<ul>
			<li><a href="javascript:onCosTapChange('')" class="on" id="cosAll">전체코스</a></li>
			<li><a href="javascript:onCosTapChange('A')" class="" id="cosA">이스트코스</a></li>
			<li><a href="javascript:onCosTapChange('B')" class="" id="cosB">웨스트코스</a></li>
			<li><a href="javascript:onCosTapChange('C')" class="" id="cosC">사우스코스</a></li>
		</ul>
		</div>
		
		<div class="sectionList">
		<ul>
			<li><a href="javascript:onPartTapChange('')" class="on" id="partAll">전체</a></li>
			<li><a href="javascript:onPartTapChange('1')" class="" id="part1">1부</a></li>
			<li><a href="javascript:onPartTapChange('2')" class="" id="part2">2부</a></li>
			<li><a href="javascript:onPartTapChange('3')" class="" id="part3">3부</a></li>
		</ul>
		</div>
		<table class="grayTable bgBottom" id="time-table">
				<caption>실시간 현황</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tr>
					<th>시간</th>
					<th>홀</th>
					<th>인원</th>
					<th>일반그린피</th>
					<th>이벤트</th>
					<th>최종그린피</th>
				</tr>
				<tbody id="time-grid">
				</tbody>
				<tr>
					<td colspan="6">
						<span class="txt"> ※ 당일 예약은 전화로만 가능하며 취소팀 발생시 예약 가능합니다.</span>
					</td>
				</tr>
			</table>
		
	</div><!-- contents End -->  
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>