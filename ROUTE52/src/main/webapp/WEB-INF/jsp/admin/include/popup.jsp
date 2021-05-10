<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="<c:url value='/js/jquery.eislideshow.js'/>"></script> 

<script type="text/javascript">

	var mPopupWeb;
	var mPopupMobile;

	function onLoadPopup() {
		doSearchPopup();
	}
	
	function doSearchPopup() {
		var sUrl = "<c:url value='/admin/getPopup.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = mCoDiv == "61" ? "valley" : mCoDiv == "65" ? "hills" : "clubd";
				
				mPopupWeb = data.rows.list1;
				mPopupMobile = data.rows.list2;

				var tbody = $("#popup-web-grid");
				
				tbody.empty();
				    
				for(i=0; i<mPopupWeb.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mPopupWeb[i].HP_FILE_NAME;    
					var originName = mPopupWeb[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=popup&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=popup&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='link_popup_{0}' id='link_popup_{0}' value='{1}'></td>", (i + 1), mPopupWeb[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='no_popup_{0}' id='no_popup_{0}' value='{1}'></td>", (i + 1), mPopupWeb[i].HP_NO));
				    var col5 = $(String.format("<td><input type='number' name='point_x_popup_{0}' id='point_x_popup_{0}' value='{1}'></td>", (i + 1), mPopupWeb[i].HP_POINT_X));
				    var col6 = $(String.format("<td><input type='number' name='point_y_popup_{0}' id='point_y_popup_{0}' value='{1}'></td>", (i + 1), mPopupWeb[i].HP_POINT_Y));
				    var col7 = $(String.format("<td><a href='javascript:updatePopup(1, {0})' class='orangeBtn'>수정</a></td>", i));
				    var col8 = $(String.format("<td><a href='javascript:deleteMessage4(1, {0})' class='grayBtn'>삭제</a></td>", i));
				        
					row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tbody); 
				}
				
				tbody = $("#popup-mobile-grid");
				
				tbody.empty();
				    
				for(i=0; i<mPopupMobile.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mPopupMobile[i].HP_FILE_NAME;    
					var originName = mPopupMobile[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=popup&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=popup&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='link_popup_{0}' id='link_popup_{0}' value='{1}'></td>", (i + 1), mPopupMobile[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='no_popup_{0}' id='no_popup_{0}' value='{1}'></td>", (i + 1), mPopupMobile[i].HP_NO));
				    var col5 = $(String.format("<td hidden><input type='number' name='point_x_popup_{0}' id='point_x_popup_{0}' value='0'></td>", (i + 1)));
				    var col6 = $(String.format("<td hidden><input type='number' name='point_y_popup_{0}' id='point_y_popup_{0}' value='0'></td>", (i + 1)));
				    var col7 = $(String.format("<td><a href='javascript:updatePopup(2, {0})' class='orangeBtn'>수정</a></td>", i));
				    var col8 = $(String.format("<td><a href='javascript:deleteMessage4(2, {0})' class='grayBtn'>삭제</a></td>", i));
				        
				    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tbody); 
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addPopupRow(type) {
		var selector;
		if(type == 1) {
			selector = "#popup-web-grid";
		} else if(type == 2) {
			selector = "#popup-mobile-grid";
		}
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
		var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><input type='file' name='file_popup_{0}' id='file_popup_{0}'></td>", rowCnt)); 
	    var col3 = $(String.format("<td><input type='text' name='link_popup_{0}' id='link_popup_{0}'></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='number' name='no_popup_{0}' id='no_popup_{0}'></td>", rowCnt));
	    var col5 = $(String.format("<td {1}><input type='number' value='0' name='point_x_popup_{0}' id='point_x_popup_{0}'></td>", rowCnt, (type == 1 ? "" : "hidden")));
	    var col6 = $(String.format("<td {1}><input type='number' value='0' name='point_y_popup_{0}' id='point_y_popup_{0}'></td>", rowCnt, (type == 1 ? "" : "hidden")));
	    var col7 = $(String.format("<td><a href='javascript:savePopup({0}, {1})' class='blueBtn'>등록</a></td>", type, rowCnt));
	    var col8 = $("<td></td>");
		
	    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBody);
	}
	
	function savePopup(type, idx) {
		var sUrl = "<c:url value='/admin/savePopup.do'/>";
		var target;
		if(type == 1) {
			target = "#popup_web_form";
		} else if(type == 2) {
			target = "#popup_mobile_form";
		}
		
		var file = $(String.format("{0} {1}file_popup_{2}", target, "#", idx)).val();
		var no = $(String.format("{0} {1}no_popup_{2}", target, "#", idx)).val();
		var pointX = $(String.format("{0} {1}point_x_popup_{2}", target, "#", idx)).val();
		var pointY = $(String.format("{0} {1}point_y_popup_{2}", target, "#", idx)).val();
		
		if(file == null || file == "") {
			alert("파일을 선택하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}
		
		if(pointX == null || pointX == "" || pointY == null || pointY == "") {
			alert("좌표를 입력하세요.");
			return;
		}
		
		$(target + " #popup_coDiv").val(mCoDiv);
		$(target + " #popup_idx").val(idx);
		$(target + " #popup_type").val(type)
		
        var formData = new FormData($(target)[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchPopup();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
	
	function deleteMessage4(type, idx) {
		var sUrl = "<c:url value='/admin/deleteMessage.do'/>";
		var sParams = "";
		var target;
		
		if(type == 1) {
			target = mPopupWeb
		} else if(type == 2) {
			target = mPopupMobile
		}
		
		sParams += String.format("&coDiv={0}", target[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target[idx].HP_DIV);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("삭제 되었습니다.");
				
				doSearchPopup();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function updatePopup(type, idx) {
		var sUrl = "<c:url value='/admin/updateMessageBenner.do'/>";
		var sParams = "";
		
		var target, target2;
		if(type == 1) {
			target = "#popup_web_form";
			target2 = mPopupWeb;
		} else if(type == 2) {
			target = "#popup_mobile_form";
			target2 = mPopupMobile;
		}
		
		var link = $(String.format("{0} {1}link_popup_{2}", target, "#", (idx + 1))).val();
		var no = $(String.format("{0} {1}no_popup_{2}", target, "#", (idx + 1))).val();
		var pointX = $(String.format("{0} {1}point_x_popup_{2}", target, "#", (idx + 1))).val();
		var pointY = $(String.format("{0} {1}point_y_popup_{2}", target, "#", (idx + 1))).val();
		
		sParams += String.format("&coDiv={0}", target2[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target2[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target2[idx].HP_DIV);
		sParams += String.format("&hpLink={0}", replaceAll(link, "&", "[AND]"));
		
		if(no != "") {
			sParams += String.format("&hpNo={0}", no);
		} else {
			alert("순번을 입력하세요.");
			return;
		}
		
		if(pointX != "" && pointY != "") {
			sParams += String.format("&hpPointX={0}", pointX);
			sParams += String.format("&hpPointY={0}", pointY);
		} else {
			alert("좌표를 입력하세요.");
			return;
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("변경 되었습니다.");
				
				doSearchPopup();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
</script>

<form id='popup_web_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="popup_coDiv" name="coDiv">
	<input type="hidden" id="popup_idx" name="idx">
	<input type="hidden" id="popup_type" name="type">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>홈페이지 팝업</span>
		</div>
	
		<table class="commonTable5">
			<caption>팝업</caption>
			<colgroup>
				<col width="10%">
				<col width="30%">
				<col width="20%">
				<col width="8%">
				<col width="6%">
				<col width="6%">
				<col width="10%">
				<col width="10%">
			</colgroup>  
			<tr>
				<th>번호</th>
				<th>파일 (권장사이즈 - 400 * 400)</th>
				<th>링크</th>
				<th>순번</th>
				<th>좌표(X)</th>
				<th>좌표(Y)</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="popup-web-grid"></tbody>
			<tr>
				<td colspan="8"><span class="grayBtn" onclick="addPopupRow(1)">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
</form>
	
<hr class="bar">

<form id='popup_mobile_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="popup_coDiv" name="coDiv">
	<input type="hidden" id="popup_idx" name="idx">
	<input type="hidden" id="popup_type" name="type">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>모바일 팝업</span>
		</div>
	
		<table class="commonTable5">
			<caption>팝업</caption>
			<colgroup>
				<col width="10%">
				<col width="30%">
				<col width="20%">
				<col width="10%">
				<col width="15%">
				<col width="15%">
			</colgroup>  
			<tr>
				<th>번호</th>
				<th>파일 (권장사이즈 - 400 * 400)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="popup-mobile-grid"></tbody>
			<tr>
				<td colspan="6"><span class="grayBtn" onclick="addPopupRow(2)">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
</form>