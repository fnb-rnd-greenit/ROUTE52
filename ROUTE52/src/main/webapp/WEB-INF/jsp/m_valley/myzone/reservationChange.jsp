<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_reser_confirm.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">

<script type="text/javascript">

	var rowData;
	var mCos, mPart;

	$(document).ready(function() { 
		init();
		
		initTable();
	});
	
	function initTable() {
		var $table = $("#time-table");
		var $header = $table.children("tbody").first().children("tr");
		
		$header.children("th").each(function(index, element) {
			var selector = "time-grid";
			var imgAsc = "<c:url value='/images/m_valley/t_arw.png'/>";
			var imgDesc = "<c:url value='/images/m_valley/t_arw1.png'/>";
			
			if(index == 0 || index == 3) {
				var type = index == 3 ? "n" : "s";
				
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
			location.href = "<c:url value='/m_valley/member/login.do'/>";	
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
		var sUrl = "<c:url value='/valley/reservation/getTeeList.do'/>";
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
					var row = $("<tr></tr>"); 

					var bkDay = rowData[i].BK_DAY;
					bkDay = bkDay.substring(0, 4) + "/" + bkDay.substring(4, 6) + "/" + bkDay.substring(6, 8);
					var bkTime = rowData[i].BK_TIME;
					bkTime = bkTime.substring(0, 2) + ":" + bkTime.substring(2, 4);
					var bkCharge;
					if(rowData[i].BK_CHARGE != null && rowData[i].BK_CHARGE != ""){
						bkCharge = rowData[i].BK_CHARGE.split(",")	
					}
					
				    var col1 = $("<td>" + bkTime + "<br>" + rowData[i].BK_COS_NM + "</td>");
				    var col2 = $("<td>" + rowData[i].BK_ROUNDF_NM + "</td>");
				    var col3 = $("<td>" + globals.personCd.codeNm(rowData[i].BK_PERSON_CD) + "</td>");
				    var col4 = $("<td>" + numberWithCommas(bkCharge[1]) + "</td>");
				    var col5 = $("<td><input type='button' class='blueBtn' value='변경' onclick='onClickRow(" + i + ")'></td>"); 
				    
				    row.append(col1,col2,col3,col4,col5).appendTo(tBody); 
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
		} else if(cos == 'A') {
			$(".courseTabList #cosAll").removeClass("on");
			$(".courseTabList #cosA").addClass("on");
			$(".courseTabList #cosB").removeClass("on");
		} else if(cos == 'B') {
			$(".courseTabList #cosAll").removeClass("on");
			$(".courseTabList #cosA").removeClass("on");
			$(".courseTabList #cosB").addClass("on");
		} 
		
		mCos = cos;
		doSearch(); 
	}
	
	function onPartTapChange(part) {
		if(part == '') {
			$(".Mtable_Tab #partAll").addClass("on1");
			$(".Mtable_Tab #part1").removeClass("on1");
			$(".Mtable_Tab #part2").removeClass("on1");
		} else if(part == '1') {
			$(".Mtable_Tab #partAll").removeClass("on1");
			$(".Mtable_Tab #part1").addClass("on1");
			$(".Mtable_Tab #part2").removeClass("on1");
		} else if(part == '2') {
			$(".Mtable_Tab #partAll").removeClass("on1");
			$(".Mtable_Tab #part1").addClass("on1");
			$(".Mtable_Tab #part2").removeClass("on1");
		}
		
		mPart = part;              
		doSearch(); 
	}
	
	function doChangePerson() {
		var sUrl = "<c:url value='/valley/reservation/changeReservationPerson.do'/>";
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
		
		progressStart();		
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();

			alert(data.resultMessage);				
		});	
	}
	
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> MY ZONE <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList">			
		<li class="on"><a href="<c:url value='/m_valley/reservation/reservationCheck.do'/>">예약현황</a></li>
		<li class=""><a href="<c:url value='/m_valley/member/stateVisit.do'/>">내장현황</a></li>
		<li class=""><a href="<c:url value='/m_valley/member/score.do'/>">스코어카드</a></li>
	</ul>
	<div class="contents">
		<div class="commonDot"> 실시간예약 현황</div>
		<div class="borderBg">
			<ul class="infoList">
				<li>
					<span class="infoDot"></span><span class="title">신청자</span><span id="txtName"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">예약일자</span><span class="blue" id="txtDate"></span>
				</li>
				<li>
					<span class="infoDot"></span><span class="title">핸드폰</span><span id="txtPhone"></span>
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
			● 예약일자 : <span class="yellow" id="txtBkDate">2019년 01월 02일 (수요일)</span>
		</div>
		<div class="courseTabList">
			<li><a href="javascript:onCosTapChange('')" class="on" id="cosAll">전체코스</a></li>
			<li><a href="javascript:onCosTapChange('A')" class="" id="cosA">서원코스</a></li>
			<li><a href="javascript:onCosTapChange('B')" class="" id="cosB">밸리코스</a></li>
		</div>
		<div class="sectionList">
			<li><a href="javascript:onPartTapChange('')" class="on" id="partAll">전체</a></li>
			<li><a href="javascript:onPartTapChange('1')" class="" id="part1">1부</a></li>
			<li><a href="javascript:onPartTapChange('2')" class="" id="part2">2부</a></li>
		</div>
		<table class="grayTable bgBottom" id="time-table">
				<caption>실시간 현황</caption>
				<colgroup>
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
					<th>변경</th>
				</tr>
				<tbody id="time-grid">
				</tbody>
				<tr>
					<td colspan="5">
						<span class="txt"> ※ 당일 예약은 전화로만 가능하며 취소팀 발생시 예약 가능합니다.</span>
					</td>
				</tr>
			</table>
		
	</div><!-- contents End -->  
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>