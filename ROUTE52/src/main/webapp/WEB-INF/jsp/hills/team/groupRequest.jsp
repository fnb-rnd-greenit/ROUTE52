<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	var rowData;
	var startPage = 1;
	var endPage = 1;
	var currentPage = 1;
	var oOption = "";
	var oText = "";

	$(document).ready(function() { 
		alert("준비중입니다.");
		history.back();
		
	    var offset = $(".myzoneTabList6").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	    
	    onChangeGroupTab(1);
	    
	    $("#show_hideSub10").click(function () {
			$(".SubMonthBox10").slideToggle();
		});	
	    
	    $('.teamTerms' ).click( function() {
	    	$(".termsWrap").slideToggle();
		});
	});

	function doSearch() {
		var tBody = $("#board-grid");
		
		var sUrl = "<c:url value='/hills/board/getBoardData.do'/>";
		var sParams = "";
		
		sParams += String.format("bbsType={0}", "61");	
		
		var nOption = $("#searchOption").val();
		var nText = $("#searchText").val();
		
		if(nOption != oOption || nText != oText) {
			startPage = 1;
			currentPage = 1;
			oOption = nOption;
			oText = nText;
		}
		
		sParams += String.format("&startCnt={0}", (currentPage - 1) * 10);	
		
		if(nOption != "") {
			sParams += String.format("&searchOption={0}", nOption);
		}
		
		if(nText != "") {
			sParams += String.format("&searchText={0}", nText);
			
			if(nOption == "") {
				alert("조회 옵션을 선택해주세요.");
				return;
			}
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				tBody.empty();
				
				rowData = data.rows;
				
				if(rowData.length == 0) {
					return;
				}
				
				for(i=0; i<rowData.length; i++) {
					var row = $("<tr onclick='onClickRow(" + i + ")'></tr>"); 
				    var col1 = $("<td>" + rowData[i].IDX + "</td>"); 
				    var col2 = $("<td class='title'>" + rowData[i].TITLE + "</td>"); 
				    var col3 = $("<td>" + rowData[i].USERNAME + "</td>");
				    var col4 = $("<td>" + rowData[i].REGDATE + "</td>");
				    var col5 = $("<td>" + rowData[i].VIEWCOUNT + "</td>"); 
				    row.append(col1,col2,col3,col4,col5).appendTo(tBody); 
				}
				
				initPaging(rowData[0].TOTAL_CNT);
 
			} else {
				alert(data.resultMessage);	
			}
		});
	}
	
	function doSearchPaging(page) {
		currentPage = page;
		doSearch();
	}
	
	function doSearchPaging10(page) {
		currentPage = page;
		startPage = page;
		doSearch();
	}
	
	function initPaging(totalCnt) {
		var pageContainer = $("#paging ul");
		pageContainer.empty();
		var page = startPage;
		var prevBtn = "<li onclick='doSearchPaging10(" + (startPage - 10) + ")'><img src='<c:url value='/images/hills/prev.png'/>' alt=''></li>";
		var nextBtn = "<li onclick='doSearchPaging10(" + (startPage + 10) + ")'><img src='<c:url value='/images/hills/next.png'/>' alt=''></li>";
		
		if(startPage != 1){
			pageContainer.append(prevBtn);
		}
		
		endPage = Math.floor(totalCnt / 10);
		if(totalCnt % 10 != 0) {
			endPage += 1;
		}
		
		for(i=startPage; i<startPage+10; i++) {
			if(i > endPage) break;
			
			var li;
			
			if(currentPage == page) {
				li = String.format("<li class='on' onclick='doSearchPaging({0})'>{0}</li>", page);
			} else {
				li = String.format("<li onclick='doSearchPaging({0})'>{0}</li>", page);
			}
			
			pageContainer.append(li);
			page += 1;
		}
		
		if(endPage - startPage >= 10) {
			pageContainer.append(nextBtn);
		}
		
	}
	
	function onClickRow(i) {
		var sUrl = "<c:url value='/hills/board/view.do'/>";
		var sParams = "";
		
		sParams += "?bbsType=61";
		sParams += "&idx=" + rowData[i].IDX;
		
		location.href = sUrl + sParams;
	}
	
	function onChangeGroupTab(idx) {
		if(idx == 1) {
			$("#goupTab1").addClass("on");
			$("#goupTab2").removeClass("on");
			$("#noticeContainer").show();
			$("#groupContainer").hide();

			doSearch();
		} else {
			$("#goupTab1").removeClass("on");
			$("#goupTab2").addClass("on");
			$("#noticeContainer").hide();
			$("#groupContainer").show();
		}
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>(연)단체안내 &nbsp;&nbsp;&nbsp; ＞ <span>공지사항/조편성기입하기</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<!-- <a href="javascript:alert('준비중입니다.');" class="">MY연단체</a> -->
			<%-- <a href="<c:url value='/hills/team/myTeam.do'/>" class="">MY연단체</a> --%>
			<a href="<c:url value='/hills/team/yearTeam.do'/>" class="">연단체안내</a>	
			<a href="<c:url value='/hills/team/yearRequest.do'/>" class="">연단체신청</a>
			<%-- <a href="<c:url value='/hills/team/groupRequest.do'/>" class="on">공지사항/조편성기입하기</a> --%>
			<a href="<c:url value='/hills/team/generalTeam.do'/>" class="">일반단체안내</a>
			<a href="<c:url value='/hills/team/generalRequest.do'/>" class="">일반단체신청</a>
			<a href="<c:url value='/hills/team/lease.do'/>" class="">대관안내</a>
			<%-- <a href="<c:url value=''/>" class="">연단체공지사항</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">공지사항/조편성 기입하기</span>
		</div>
		<div class="subLine"></div>
		
		<div class="groupTab">
			<a id="goupTab1" href="javascript:onChangeGroupTab(1)">공지사항</a>
			<a id="goupTab2" href="javascript:onChangeGroupTab(2)">조편성 기입하기</a>
		</div>
		
		<div id="noticeContainer">
			<div class="listBox">
			<div class="findBox">
				<select name="" id="searchOption" class="select-arrow">
					<option value="">전체</option>
					<option value="1">제목</option>
					<option value="2">내용</option>
					<option value="3">작성자</option>
				</select>
				<input type="text" class="findTxt" id="searchText">
				<a href="javascript:doSearch()" class="orangeBtn">검색</a>
			</div>
			<table class="listTable">
				<caption>실시간 예약 코스,시간별 가격 안내</caption>
				<colgroup>
					<col width="5%">
					<col width="60%">
					<col width="10%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회</th>
				</tr>
				<tbody id="board-grid">
				</tbody>
			</table>
			<div class="paging" id="paging"><ul></ul></div>

			</div>
			<c:if test="${sessionScope.msMember.webAdmin == 'Y'}">
				<div class="btnBox">
					<a href="<c:url value='/hills/board/write.do?bbsType=61'/>" class="orangeBtn">글쓰기</a>
				</div>
			</c:if>
		</div>
		
		<div class="groupWrite" id="groupContainer">
			<dl>
				<dt>단체유형</dt>
				<dd><label><input type="radio" name="group"> 연단체</label><label><input type="radio" name="group"> 일반단체</label></dd>
			</dl>
			<dl>
				<dt>예약일</dt>
				<dd>
					<div class="groupMonth" id="show_hideSub10"> <img src="<c:url value='/images/hills/icon_gmonth.jpg'/>" >예약일자 선택</div>
					<div class="SubMonthBox10" id="" style="display: hidden;">
                    	<div class="monthChoice">
                        	<span><a href="javascript:poSmPrevMonth()"><img src="/images/hills/arrow_l.png" alt="전 달" width="15" height="20"></a></span>
                        	<span class="month" id="calHeader">2019 / 10</span>
                        	<span><a href="javascript:poSmNextMonth()"><img src="/images/hills/arrow_r.png" alt="다음달" width="15" height="20"></a></span>
                        </div>

						<table class="mainCalendar" summary="실시간 예약" cellspacing="5">
							<colgroup>
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th scope="col" class="sun">SUN</th>
									<th scope="col">MON</th>
									<th scope="col">TUE</th>
									<th scope="col">WEN</th>
									<th scope="col">THU</th>
									<th scope="col">FRI</th>
									<th scope="col">SAT</th>
								</tr>
							</tbody>
							<tbody id="calendar-body">
								<tr>
									<td><div></div></td>
									<td><div></div></td>
									<td><div>1</div></td>
									<td><div>2</div></td>
									<td><div>3</div></td>
									<td><div>4</div></td>
									<td><div>5</div></td>
								</tr>
								<tr>
									<td><div>6</div></td>
									<td><div>7</div></td>
									<td><div>8</div></td>
									<td><div>9</div></td>
									<td><div>10</div></td>
									<td><div>11</div></td>
									<td><div>12</div></td>
								</tr>
								<tr>
									<td><div>13</div></td>
									<td><div>14</div></td>
									<td><div>15</div></td>
									<td><div>16</div></td>
									<td class="today"><div>17</div></td>
									<td class="possible"><div>18</div></td>
									<td class="possible"><div>19</div></td>
								</tr>
								<tr>
									<td class="possible"><div>20</div></td>
									<td class="possible"><div>21</div></td>
									<td class="possible"><div>22</div></td>
									<td class="possible"><div>23</div></td>
									<td class="possible"><div>24</div></td>
									<td class="possible"><div>25</div></td>
									<td class="possible"><div>26</div></td>
								</tr>
								<tr>
									<td class="possible"><div>27</div></td>
									<td class="possible"><div>28</div></td>
									<td class="possible"><div>29</div></td>
									<td class="possible"><div>30</div></td>
									<td class="possible"><div>31</div></td>
								</tr>
							</tbody>
						</table>
					</div>
				</dd>
			</dl>
			<dl>
				<dt>단체명</dt>
				<dd><input type="text" name="" class="long"></dd>
			</dl>
			<dl>
				<dt>예약자</dt>
				<dd><input type="text" name="" class="short"><label><input type="checkbox" name="group"> 회장</label><label><input type="checkbox" name="group"> 총무</label><label><input type="checkbox" name="group"> 기타</label></dd>
			</dl>
			<dl>
				<dt>기입자</dt>
				<dd><input type="text" name="" class="short"><label><input type="checkbox" name="group1"> 상동</label><label><input type="checkbox" name="group1"> 회장</label><label><input type="checkbox" name="group1"> 총무</label><label><input type="checkbox" name="group1"> 기타</label></dd>
			</dl>
			
			<table class="groupT">
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="20%">
				</colgroup>
				<tr>
					<th>코스</th>
					<th>조</th>
					<th>내장1</th>
					<th>내장2</th>
					<th>내장3</th>
					<th>내장4</th>
				</tr>
				<tr>
					<td>
						<select class="select-arrow">
							<option selected>이스트</option>
							<option>웨스트</option>
							<option>사우스</option>
						</select>
					</td>
					<td><input type="text" class="short"></td>
					<td>
						<input type="text" class="long">
						<select class="select-arrow inline">
							<option selected>성별</option>
							<option>남자</option>
							<option>여자</option>
						</select>					
					</td>
					<td>
						<input type="text" class="long">
						<select class="select-arrow inline">
							<option selected>성별</option>
							<option>남자</option>
							<option>여자</option>
						</select>	
					</td>
					<td>
						<input type="text" class="long">
						<select class="select-arrow inline">
							<option selected>성별</option>
							<option>남자</option>
							<option>여자</option>
						</select>	
					</td>
					<td>
						<input type="text" class="long">
						<select class="select-arrow inline">
							<option selected>성별</option>
							<option>남자</option>
							<option>여자</option>
						</select>
					</td>
			</table>
			
			<div class="plusTd" onclick="">
				<img src="<c:url value='/images/hills/gplus.png'/>" >
				<h3>테이블 추가</h3>
			</div>
			
			<hr>
			
			<dl>
				<dt class="lastC">코멘트</dt>
				<dd><textarea style="resize:none;"></textarea></dd>
			</dl>
			
			<a href="" class="gsLink"><img src="<c:url value='/images/hills/groupAdd.jpg'/>" > 조편성 전송하기</a>
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />