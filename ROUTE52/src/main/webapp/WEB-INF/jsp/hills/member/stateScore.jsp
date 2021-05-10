<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	var smYear, smMonth, fmYear, fmMonth;
	var stDate, fnDate;	

	$(document).ready(function() { 
		init();

	    var offset = $(".myzoneTabList7").offset();   
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";	
		}
		
		var date = new Date();
		var date2 = new Date(date.yyyy(), date.mm() - 1, date.dd());
		date = addMonth2(date.yyyymmdd(), -1);
		smYear = fmYear = date.yyyy();
		smMonth = fmMonth = date.mm();
		
		$("#show_hideSub4").html(String.format("{0}/{1}/{2}", date.yyyy(), date.mm(), date.dd()));
		$("#show_hideSub5").html(String.format("{0}/{1}/{2}", date2.yyyy(), date2.mm(), date2.dd()));
		
		initSubCalendar("#subMonthBox1", smYear, smMonth);
		initSubCalendar("#subMonthBox2", fmYear, fmMonth);
		
		doSearch();
	}
	
	function doSearch() {
		var sContainer = $("#scoreContainer");
		
		var sUrl = "<c:url value='/hills/member/getScoreList.do'/>";
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
				sContainer.empty();
				
				rowData = data.rows.list;
				
				if(rowData.length == 0) {
					alert("조회 된 스코어현황이 없습니다.");
					progressStop();
					return;
				}
				
				var teamIdx = 1;
				var sData = "";
				var tDay = rowData[0].EN_DAY;
				var tCos = rowData[0].EN_COS;
				var tTime = rowData[0].EN_TIME;
				var totalCnt = 1;
				
				var sum = 0;
				var max = rowData[0].MS_TOTAL;
				var msNum = "${sessionScope.msMember.msNum}";
				
				for(i=0; i<rowData.length; i++) {
					if(msNum == rowData[i].MS_NUM) {
						if(max > rowData[i].MS_TOTAL) {
							max = rowData[i].MS_TOTAL;
					    }
					    
					    sum += rowData[i].MS_TOTAL;	
					}			
				    
					if(tDay != rowData[i].EN_DAY || tCos != rowData[i].EN_COS || tTime != rowData[i].EN_TIME) {
						teamIdx = 1;
						sData = "";
						tDay = rowData[i].EN_DAY;
						tCos = rowData[i].EN_COS;
						tTime = rowData[i].EN_TIME;
						totalCnt += 1;
					}
					
					if(teamIdx == 1) {
						sData += "<div class='scoreBox' id='scoreBox" + i + "'>                                          				";        
						sData += "	<div class='scoreImg'>                                                               				";
						sData += "		<img src='<c:url value='/images/hills/defaultImage.jpg'/>' alt=''>                 				";
						sData += "		<p>" + rowData[i].EN_DAY + "</p>                                                   				";               
						sData += "	</div>                                                                               				";
						sData += "	<div class='playerScore'>                                                            				";
						sData += "		<table class='commonTable2'>                                                       				";
						sData += "			<caption>스코어 현황</caption>                                                   	 			";
						sData += "			<colgroup>                                                                       			";
						sData += "				<col width='10%'>                                                              			";
						sData += "				<col width='8%'>                                                               			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='6%'>                                                               			";
						sData += "				<col width='8%'>                                                               			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                               			";
						sData += "				<col width='*'>                                                               			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='*'>                                                                			";
						sData += "				<col width='6%'>                                                               			";
						sData += "				<col width='8%'>                                                               			";
						sData += "			</colgroup>                                                                      			";
						sData += "			<tr>                                                                             			";
						sData += "				<th>플레이어</th>                                                              			";
						sData += "				<td>코스</td>                                                                  			";
						sData += "				<td>1</td>                                                                     			";
						sData += "				<td>2</td>                                                                     			";
						sData += "				<td>3</td>                                                                     			";
						sData += "				<td>4</td>                                                                     			";
						sData += "				<td>5</td>                                                                     			";
						sData += "				<td>6</td>                                                                     			";
						sData += "				<td>7</td>                                                                     			";
						sData += "				<td>8</td>                                                                     			";
						sData += "				<td>9</td>                                                                     			";
						sData += "				<th class='total'>계</th>                                                       			";
						sData += "				<td>코스</td>                                                                  			";
						sData += "				<td>1</td>                                                                     			";
						sData += "				<td>2</td>                                                                     			";
						sData += "				<td>3</td>                                                                     			";
						sData += "				<td>4</td>                                                                     			";
						sData += "				<td>5</td>                                                                     			";
						sData += "				<td>6</td>                                                                     			";
						sData += "				<td>7</td>                                                                     			";
						sData += "				<td>8</td>                                                                     			";
						sData += "				<td>9</td>                                                                    			";
						sData += "				<th class='total'>계</th>                                                      			";
						sData += "				<th class='total'>합계</th>                                                    			";
						sData += "			</tr>                                                                            			";
						sData += "			<tbody>						                                                               	";
						sData += "				<tr class='firstMem'>                                                          			";
						sData += "					<td>" + rowData[i].EN_NAME          + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_COS_A_NAME    + "</td>                              		    ";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A1      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A2      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A3      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A4      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A5      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A6      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A7      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A8      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A9      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_A_TOTAL + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_COS_B_NAME    + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B1      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B2      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B3      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B4      + "</td>                                		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B5      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B6      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B7      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B8      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B9      + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_POINT_B_TOTAL + "</td>                                 		";                                   
						sData += "					<td>" + rowData[i].MS_TOTAL         + "</td>                                 		";                                   
						sData += "				</tr>	                                                                         		";
						sData += "				<tr onclick='showMoreList(" + i + ")' id='moreData'>                           			";        
						sData += "					<td colspan='24'>                                                            		";
						sData += "						<div class='scBtnBox'>                                                     		";
						sData += "							<ul class='scBtn'>                                                       	";
						sData += "								<li>자세히보기</li>                                                    	";
						sData += "								<li><img src='<c:url value='/images/hills/sc_arrow.png'/>' alt=''></li> ";						
						sData += "							</ul>                                                                    	";
						sData += "						</div>                                                                     		";
						sData += "					</td>                                                                        		";
						sData += "				</tr>                                                                         			";
					}
					
					if(teamIdx == 2) {
						sData += "				<tr class='seconMem' id='mem2' style='display:none'>";                           
						sData += "					<td>" + rowData[i].EN_NAME          + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_COS_A_NAME    + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A1      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A2      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A3      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A4      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A5      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A6      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A7      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A8      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A9      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A_TOTAL + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_COS_B_NAME    + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B1      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B2      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B3      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B4      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B5      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B6      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B7      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B8      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B9      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B_TOTAL + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_TOTAL         + "</td>    ";                                                             
						sData += "				</tr>	                                            ";                           
					}
					
					if(teamIdx == 3) {
						sData += "				<tr class='thirdMem' id='mem3' style='display:none'>";                           
						sData += "					<td>" + rowData[i].EN_NAME          + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_COS_A_NAME    + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A1      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A2      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A3      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A4      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A5      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A6      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A7      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A8      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A9      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_A_TOTAL + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_COS_B_NAME    + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B1      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B2      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B3      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B4      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B5      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B6      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B7      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B8      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B9      + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_POINT_B_TOTAL + "</td>    ";                                                              
						sData += "					<td>" + rowData[i].MS_TOTAL         + "</td>    ";                                                             
						sData += "				</tr>	                                            ";                           
					}
					
					if(teamIdx == 4) {
						sData += "				<tr class='' id='mem4' style='display:none'>  	";                         
						sData += "					<td>" + rowData[i].EN_NAME          + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_COS_A_NAME    + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A1      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A2      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A3      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A4      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A5      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A6      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A7      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A8      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A9      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_A_TOTAL + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_COS_B_NAME    + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B1      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B2      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B3      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B4      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B5      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B6      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B7      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B8      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B9      + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_POINT_B_TOTAL + "</td>";                                                                    
						sData += "					<td>" + rowData[i].MS_TOTAL         + "</td>";                                                                   
						sData += "				</tr>	                                        ";                               
					}
					
					if(i + 1 == rowData.length) {
						sData += "			</tbody>";                                                                         
						sData += "		</table>    ";                                                                         
						sData += "	</div>      	";                                                                         
						sData += "</div>	      	";                                                                         
						sContainer.append(sData);
						break;
					}
					
					if(tDay == rowData[i + 1].EN_DAY && tCos == rowData[i + 1].EN_COS && tTime == rowData[i].EN_TIME) {
						teamIdx += 1;
					} else {
						sData += "			</tbody>";                                                                         
						sData += "		</table>  	";                                                                         
						sData += "	</div>      	";                                                                         
						sData += "</div>	      	";                                                                         
						sContainer.append(sData);						
					}
				} 
				
				$("#txtTotalCnt").html(totalCnt);
				$("#txtBest").html(max);
				$("#txtAvg").html(Math.round(sum / totalCnt));
				$("#txtYearMin").html(data.rows.total.MIN);
				$("#txtYearAvg").html(data.rows.total.AVG);
			} else {
				alert(data.resultMessage);	
			}
			
			progressStop();
		});
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
	
	function showMoreList(i) {
		var container = "#scoreBox" + i;

		$(container + " #moreData").hide();
		$(container + " #mem2").show();
		$(container + " #mem3").show();
		$(container + " #mem4").show();
	}
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>마이존 &nbsp;&nbsp;&nbsp; ＞ <span>스코어현황</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList7">
			<a href="<c:url value='/hills/reservation/reservationCheck.do'/>" class="">예약확인/취소</a>
			<a href="<c:url value='/hills/member/stateVisit.do'/>" class="">내장현황</a>
			<a href="<c:url value='/hills/member/statePenal.do'/>" class="">위약현황</a>
			<a href="<c:url value='/hills/member/stateScore.do'/>" class="on">스코어현황</a>
			<a href="<c:url value='/hills/member/coupon.do'/>" class="">쿠폰함</a>
			<!-- <a href="javascript:alert('준비중입니다.')" class="">마이포인트</a> -->
			<a href="<c:url value='/hills/board/list.do?bbsType=9'/>" class="">고객의소리</a>
			<a href="<c:url value='/hills/member/memModify.do'/>" class="">회원정보수정</a>
		</div>
		
		<div class="subTitle">
			<span class="title">스코어현황</span>
			<span class="titleDes">고객님의 스코어현황을 확인하실 수 있습니다.</span>
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

		<ul class="topScoreTitle">
			<li class="scoreTitle">베스트</li> 
			<li class="scoreNum" id="txtBest">0</li>
			<li class="scoreNum" id="txtAvg">0</li> 
			<li class="scoreTitle">평균</li>
		</ul>

		<div class="midTitleBox">
			<span class="commonDot"> TOTAL: <span class="orangeRed" id="txtTotalCnt"></span></span>
		</div>
		<div class="scoreLine">
			<span>최저타수 <span class="orangeRed" id="txtYearMin"></span></span>
			<span>최근 1년간 평균타수 <span class="orangeRed" id="txtYearAvg"></span></span>
		</div>
		<div id="scoreContainer">
				
		</div>
	<div class="dotLine"></div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />