<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.search_overlay{display: none;position: fixed;top: 0%;left: 0%;width: 100%;height: 100%;background-color: #777777;z-index:1004;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}	
	.popup_people_search {display: none;position: fixed;width: 580px;height:460px;background-color:#fff;border: 4px solid #ff8800;z-index:1005; border-radius:15px; padding:20px;}
	.popup_people_search input{ height:30px; border:1px solid #ddd;}
	.popup_people_search h2{ padding: 0 0 15px 0;}
	.popup_people_search h2 a.GpList{ display: inline-block; padding:4px; background-color: #ff8800; border-radius: 10px; color: #fff; width:80px; text-align:center; margin-left:10px; font-weight:500;}
	
	.GpListT{ display:block; border-collapse: collapse; width:100%;}
	.GpListT thead th{ background-color:#444; color: #fff; font-weight:500; padding:8px 0;}
	.GpListT th:nth-of-type(1), .GpListT td:nth-of-type(1) { width: 150px; }
	.GpListT th:nth-of-type(2), .GpListT td:nth-of-type(2) { width: 232px; }
	.GpListT th:nth-of-type(3), .GpListT td:nth-of-type(3) { width: 150px; }
	.GpListT tbody td{ text-align:center; padding:5px 0; border-bottom:1px solid #aaa;}
	.GpListT tbody td a.choBtn{ display: inline-block; padding:2px 5px; background-color: #7d7d7d; border-radius: 10px; color: #fff; text-align:center; font-weight:500; font-size:12px; margin-left:20px;}
	.GpListT td:nth-of-type(2) { text-align:left; }
	.GpListT tbody{height:320px; overflow-y:auto; display:block;}
</style>
<script type="text/javascript">

	var poPeopleRows;

	function initSearchPopup() {
		var fW = $(window).width() / 2;
		var fH = $(window).height() / 2;
		var cW = Number(replaceAll($("#popup_people_search").css("width"), "px", "")) / 2;
		var cH = Number(replaceAll($("#popup_people_search").css("height"), "px", "")) / 2;
		var mW = fW - cW;
		var mH = fH - cH;
		 
		$("#popup_people_search").css("left", mW);
		$("#popup_people_search").css("top", mH);
		
		$("#popup_people_search").show();
		$("#search_overlay").show();
	}

	function searchPopupOpen() {
		initSearchPopup();
		
		var tbody = $("#tbody-search-people");
		tbody.empty();
		$("#poSearchKeyword").val("");
		
		if($("#txtSearchKeyword").val() != "") {
			$("#poSearchKeyword").val($("#txtSearchKeyword").val());
			doSearchTeams();
		}
	}
	
	function searchPopupClose() {
		$("#popup_people_search").hide();
		$("#search_overlay").hide();
	}
	
	function doSearchTeams() {
		mGpNum = "";
		$("#txtTeamName").val("");
		$("#txtTeamYear").val("");
		$("#txtTeamJuDiv").val("");
		$("#chkTeamPosition1").prop('checked', false);
		$("#chkTeamPosition2").prop('checked', false);
		
		var sUrl = "<c:url value='/hills/member/doSearchTeams.do'/>";
		var sParams = "";
		
		if($("#poSearchKeyword").val() == "") {
			alert("검색어를 입력하세요.");
			return;
		}
		
		sParams += "keyword=" + $("#poSearchKeyword").val();
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {
				poPeopleRows = data.rows;
				
				var tbody = $("#tbody-search-people");
				tbody.empty();
				
				for(i=0; i<poPeopleRows.length; i++) {
					var tr = $("<tr></tr>");

					var td1 = $("<td>" + poPeopleRows[i].GP_YEAR + "</td>");
					var td2 = $("<td>" + poPeopleRows[i].GP_NAME + "</td>");
					var td3 = $("<td><a href='javascript:onClickedTeam(" + i + ")' class='choBtn'>선택</a></td>");
					
					tbody.append(tr.append(td1, td2, td3));
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function onClickedTeam(i) {
		mGpNum = poPeopleRows[i].GP_NUM;
		$("#txtGpName").val(poPeopleRows[i].GP_NAME);
		$("#txtTeamYear").val(poPeopleRows[i].GP_YEAR);
		$("#txtTeamJuDiv").val(poPeopleRows[i].GP_JUDIV);
		$("#chkTeamPosition1").attr('checked', poPeopleRows[i].GD_YN == "Y");
		$("#chkTeamPosition2").prop('checked', poPeopleRows[i].MG_YN == "Y");
		
		if($("#chkTeamPosition1").is(":checked") || $("#chkTeamPosition2").is(":checked")) {
			$("#btnTeamPeoplesPlus").show();
			$("#btnTeamPeoplesSave").show();
			
			doSearchTeamPeople();
		} else {
			$("#btnTeamPeoplesPlus").hide();
			$("#btnTeamPeoplesSave").hide();
			
			var tbody = $("#tbody-people");
			tbody.empty();        
		}

		searchPopupClose();
	}	
	
</script>
<div id="popup_people_search" class="popup_people_search">	
	<h2>
	단체명 <input type="text" id="poSearchKeyword" onKeypress="javascript:if(event.keyCode==13) {doSearchTeams()}"> <a href="javascript:void(0)" onclick="doSearchTeams()" class="GpList">검색</a>
	</h2>

	<table class="GpListT">
		<colgroup>
			<col width="30%">
			<col width="40%">
			<col width="30%">
		</colgroup>
		<thead>
			<tr>
				<th>연도</th>
				<th>단체명</th>
				<th>선택</th>
			</tr>
		</thead>					
		<tbody id="tbody-search-people">
		</tbody>
	</table>
	
</div>
<div id="search_overlay" class="search_overlay" onclick="javascript:searchPopupClose()"></div>