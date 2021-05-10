<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="<c:url value='/js/jquery.eislideshow.js'/>"></script> 

<script type="text/javascript">

	var mFunAndJoyEvent;
	var mFunAndJoyAd;
	var mFunAndJoyHole;

	function onLoadFunAndJoy() {
		doSearchFunAndJoy();
	}
	
	function doSearchFunAndJoy() {
		var sUrl = "<c:url value='/admin/getFunAndJoy.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = mCoDiv == "61" ? "valley" : mCoDiv == "65" ? "hills" : "clubd";
				
				mFunAndJoyEvent = data.rows.list1;
				mFunAndJoyAd = data.rows.list2;
				mFunAndJoyHole = data.rows.list3;

				var tbody = $("#funandjoy-event-grid");
				
				tbody.empty();
				    
				for(i=0; i<mFunAndJoyEvent.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mFunAndJoyEvent[i].HP_FILE_NAME;    
					var originName = mFunAndJoyEvent[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=message&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='link_funandjoy_event_{0}' id='link_funandjoy_event_{0}' value='{1}'></td>", (i + 1), mFunAndJoyEvent[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='no_funandjoy_event_{0}' id='no_funandjoy_event_{0}' value='{1}'></td>", (i + 1), mFunAndJoyEvent[i].HP_NO)); 
				    var col5 = $(String.format("<td><a href='javascript:updateFunAndJoyEvent({0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteMessage2(\"5\", {0})' class='grayBtn'>삭제</a></td>", i));
				        
					row.append(col1,col2,col3,col4,col5,col6).appendTo(tbody); 
				}
				
				tbody = $("#funandjoy-ad-grid");
				
				tbody.empty();
				    
				for(i=0; i<mFunAndJoyAd.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mFunAndJoyAd[i].HP_FILE_NAME;    
					var originName = mFunAndJoyAd[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=message&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='link_funandjoy_ad_{0}' id='link_funandjoy_ad_{0}' value='{1}'></td>", (i + 1), mFunAndJoyAd[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='no_funandjoy_ad_{0}' id='no_funandjoy_ad_{0}' value='{1}'></td>", (i + 1), mFunAndJoyAd[i].HP_NO)); 
				    var col5 = $(String.format("<td><a href='javascript:updateFunAndJoyAd({0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteMessage2(\"6\", {0})' class='grayBtn'>삭제</a></td>", i));
				        
					row.append(col1,col2,col3,col4,col5,col6).appendTo(tbody); 
				}
				
				tbody = $("#funandjoy-hole-grid");
				
				tbody.empty();
				    
				for(i=0; i<mFunAndJoyHole.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mFunAndJoyHole[i].HP_FILE_NAME;    
					var originName = mFunAndJoyHole[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=message&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='contents_funandjoy_hole_{0}' id='contents_funandjoy_hole_{0}' value='{1}' class='iStyle'></td>", (i + 1), mFunAndJoyHole[i].HP_CONTENTS));  
				    var col4 = $(String.format("<td><input type='text' name='link_funandjoy_hole_{0}' id='link_funandjoy_hole_{0}' value='{1}' class='iStyle'></td>", (i + 1), mFunAndJoyHole[i].HP_LINK)); 
				    var col5 = $(String.format("<td><select id='cos_funandjoy_hole_{0}' name='cos_funandjoy_hole_{0}' class='iStyle2'><option value='A'>EAST</option><option value='B'>WEST</option><option value='C'>SOUTH</option></select>" +
				    		"<select id='hole_funandjoy_hole_{0}' name='hole_funandjoy_hole_{0}' class='iStyle2'><option value='2'>2홀</option><option value='4'>4홀</option><option value='5'>5홀</option><option value='7'>7홀</option><option value='8'>8홀</option></select></td>", (i + 1))); 
				    var col6 = $(String.format("<td><a href='javascript:updateFunAndJoyHole({0})' class='orangeBtn'>수정</a></td>", i));
				    var col7 = $(String.format("<td><a href='javascript:deleteMessage2(\"7\", {0})' class='grayBtn'>삭제</a></td>", i));    
				        
					row.append(col1,col2,col3,col4,col5,col6,col7).appendTo(tbody); 

					$("#cos_funandjoy_hole_" + (i + 1)).val(mFunAndJoyHole[i].HP_COS);
					$("#hole_funandjoy_hole_" + (i + 1)).val(mFunAndJoyHole[i].HP_HOLE);
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addFunAndJoyEventRow() {
		var selector = "#funandjoy-event-grid";
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
	    var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><input type='file' name='file_funandjoy_event_{0}' id='file_funandjoy_event_{0}'></td>", rowCnt)); 
	    var col3 = $(String.format("<td><input type='text' name='link_funandjoy_event_{0}' id='link_funandjoy_event_{0}'></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='number' name='no_funandjoy_event_{0}' id='no_funandjoy_event_{0}'></td>", rowCnt)); 
	    var col5 = $(String.format("<td><a href='javascript:saveFunAndJoyEvent({0})' class='blueBtn'>등록</a></td>", rowCnt));
	    var col6 = $("<td></td>");
	   
	    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody);
	}
	
	function saveFunAndJoyEvent(idx) {
		var sUrl = "<c:url value='/admin/saveFunAndJoyEvent.do'/>";
		
		var file = $(String.format("{0}file_funandjoy_event_{1}", "#", idx)).val();
		var no = $(String.format("{0}no_funandjoy_event_{1}", "#", idx)).val();
		
		if(file == null || file == "") {
			alert("파일을 선택하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}
		
		$("#funandjoy_event_coDiv").val(mCoDiv);
		$("#funandjoy_event_idx").val(idx);
		
        var formData = new FormData($("#funandjoy_event_form")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchFunAndJoy();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
	
	function updateFunAndJoyEvent(idx) {
		var sUrl = "<c:url value='/admin/updateMessageBenner.do'/>";
		var sParams = "";
		
		var link = $(String.format("{0}link_funandjoy_event_{1}", "#", (idx + 1))).val();
		var no = $(String.format("{0}no_funandjoy_event_{1}", "#", (idx + 1))).val();    
		
		sParams += String.format("&coDiv={0}", mFunAndJoyEvent[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", mFunAndJoyEvent[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", mFunAndJoyEvent[idx].HP_DIV);
		sParams += String.format("&hpLink={0}", replaceAll(link, "&", "[AND]"));
		
		if(no != "") {
			sParams += String.format("&hpNo={0}", no);
		} else {
			alert("순번을 입력하세요.");
			return;
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("변경 되었습니다.");
				
				doSearchFunAndJoy();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addFunAndJoyAdRow() {
		var selector = "#funandjoy-ad-grid";
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
	    var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><input type='file' name='file_funandjoy_ad_{0}' id='file_funandjoy_ad_{0}'></td>", rowCnt)); 
	    var col3 = $(String.format("<td><input type='text' name='link_funandjoy_ad_{0}' id='link_funandjoy_ad_{0}'></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='number' name='no_funandjoy_ad_{0}' id='no_funandjoy_ad_{0}'></td>", rowCnt)); 
	    var col5 = $(String.format("<td><a href='javascript:saveFunAndJoyAd({0})' class='blueBtn'>등록</a></td>", rowCnt));
	    var col6 = $("<td></td>");
	   
	    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody);
	}
	
	function saveFunAndJoyAd(idx) {
		var sUrl = "<c:url value='/admin/saveFunAndJoyAd.do'/>";
		
		var file = $(String.format("{0}file_funandjoy_ad_{1}", "#", idx)).val();
		var no = $(String.format("{0}no_funandjoy_ad_{1}", "#", idx)).val();
		
		if(file == null || file == "") {
			alert("파일을 선택하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}
		
		$("#funandjoy_ad_coDiv").val(mCoDiv);
		$("#funandjoy_ad_idx").val(idx);
		
        var formData = new FormData($("#funandjoy_ad_form")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchFunAndJoy();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
	
	function updateFunAndJoyAd(idx) {
		var sUrl = "<c:url value='/admin/updateMessageBenner.do'/>";
		var sParams = "";
		
		var link = $(String.format("{0}link_funandjoy_ad_{1}", "#", (idx + 1))).val();
		var no = $(String.format("{0}no_funandjoy_ad_{1}", "#", (idx + 1))).val();    
		
		sParams += String.format("&coDiv={0}", mFunAndJoyAd[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", mFunAndJoyAd[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", mFunAndJoyAd[idx].HP_DIV);
		sParams += String.format("&hpLink={0}", replaceAll(link, "&", "[AND]"));
		
		if(no != "") {
			sParams += String.format("&hpNo={0}", no);
		} else {
			alert("순번을 입력하세요.");
			return;
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("변경 되었습니다.");
				
				doSearchFunAndJoy();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function deleteMessage2(div, idx) {
		var sUrl = "<c:url value='/admin/deleteMessage.do'/>";
		var sParams = "";
		var target;
		
		if(div == "5") {
			target = mFunAndJoyEvent
		} else if(div == "6") {
			target = mFunAndJoyAd
		} else if(div == "7") {
			target = mFunAndJoyHole
		}
		
		sParams += String.format("&coDiv={0}", target[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target[idx].HP_DIV);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("삭제 되었습니다.");
				
				doSearchFunAndJoy();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addFunAndJoyHoleRow() {
		var selector = "#funandjoy-hole-grid";
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
	    var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><input type='file' name='file_funandjoy_hole_{0}' id='file_funandjoy_hole_{0}'></td>", rowCnt)); 
	    var col3 = $(String.format("<td><input type='text' name='contents_funandjoy_hole_{0}' id='contents_funandjoy_hole_{0}' class='iStyle'></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='text' name='link_funandjoy_hole_{0}' id='link_funandjoy_hole_{0}' class='iStyle'></td>", rowCnt)); 
	    var col5 = $(String.format("<td><select id='cos_funandjoy_hole_{0}' name='cos_funandjoy_hole_{0}' class='iStyle2'><option value='A' selected>EAST</option><option value='B'>WEST</option><option value='C'>SOUTH</option></select>" +
	    		"<select id='hole_funandjoy_hole_{0}' name='hole_funandjoy_hole_{0}' class='iStyle2'><option value='2'>2홀</option><option value='4'>4홀</option><option value='5'>5홀</option><option value='7'>7홀</option><option value='8'>8홀</option></select></td>", rowCnt)); 
	    var col6 = $(String.format("<td><a href='javascript:saveFunAndJoyHole({0})' class='blueBtn'>등록</a></td>", rowCnt));
	    var col7 = $("<td></td>");
	   
	    row.append(col1,col2,col3,col4,col5,col6,col7).appendTo(tBody);      
	}
	
	function saveFunAndJoyHole(idx) {
		var sUrl = "<c:url value='/admin/saveFunAndJoyHole.do'/>";
		
		var file = $(String.format("{0}file_funandjoy_hole_{1}", "#", idx)).val();
		var contents = $(String.format("{0}contents_funandjoy_hole_{1}", "#", idx)).val();
		
		if(file == null || file == "") {
			alert("파일을 선택하세요.");
			return;
		}
		
		if(contents == null || contents == "") {
			alert("내용을 입력하세요.");
			return;
		}
		
		$("#funandjoy_hole_coDiv").val(mCoDiv);
		$("#funandjoy_hole_idx").val(idx);
		
        var formData = new FormData($("#funandjoy_hole_form")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchFunAndJoy();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
	
	function updateFunAndJoyHole(idx) {
		var sUrl = "<c:url value='/admin/updateMessageBenner.do'/>";
		var sParams = "";
		
		var link = $(String.format("{0}link_funandjoy_hole_{1}", "#", (idx + 1))).val();
		var contents = $(String.format("{0}contents_funandjoy_hole_{1}", "#", (idx + 1))).val();    
		var cos = $(String.format("{0}cos_funandjoy_hole_{1}", "#", (idx + 1))).val();    
		var hole = $(String.format("{0}hole_funandjoy_hole_{1}", "#", (idx + 1))).val();    
		
		sParams += String.format("&coDiv={0}", mFunAndJoyHole[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", mFunAndJoyHole[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", mFunAndJoyHole[idx].HP_DIV);
		sParams += String.format("&contents={0}", contents);
		sParams += String.format("&cos={0}", cos);
		sParams += String.format("&hole={0}", hole);
		sParams += String.format("&hpLink={0}", replaceAll(link, "&", "[AND]"));
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("변경 되었습니다.");
				
				doSearchFunAndJoy();
			} else {
				alert(data.resultMessage);
			}
		});
	}

</script>

<form id='funandjoy_event_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="funandjoy_event_coDiv" name="coDiv">
	<input type="hidden" id="funandjoy_event_idx" name="idx">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>진행중인 이벤트 배너</span>
		</div>
	
		<table class="commonTable1">
			<caption>배너</caption>
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
				<th>파일 (권장사이즈 - 400 * 300)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="funandjoy-event-grid"></tbody>
			<tr>
				<td colspan="6"><span class="grayBtn" onclick="addFunAndJoyEventRow()">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
</form>
	
<hr class="bar">

<form id='funandjoy_ad_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="funandjoy_ad_coDiv" name="coDiv">
	<input type="hidden" id="funandjoy_ad_idx" name="idx">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>제휴배너</span>
		</div>
	
		<table class="commonTable1">
			<caption>배너</caption>
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
				<th>파일 (권장사이즈 - 270 * 230)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="funandjoy-ad-grid"></tbody>
			<tr>
				<td colspan="6"><span class="grayBtn" onclick="addFunAndJoyAdRow()">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
</form>
	
<hr class="bar">

<form id='funandjoy_hole_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="funandjoy_hole_coDiv" name="coDiv">
	<input type="hidden" id="funandjoy_hole_idx" name="idx">

	<div class="admin_wrap">
		<div class="subTitle">
			<span>홀별 상품 배너</span>
		</div>
	
		<table class="commonTable">
			<caption>홀별 상품 배너</caption>
			<colgroup>
				<col width="5%">
				<col width="20%">
				<col width="25%">
				<col width="20%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<tr>
				<th>번호</th>
				<th>로고파일 (권장사이즈 - 25 * 18)</th>
				<th>내용</th>
				<th>링크</th>
				<th>코스(홀)</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="funandjoy-hole-grid"></tbody>
			<tr>
				<td colspan="7"><span class="grayBtn" onclick="addFunAndJoyHoleRow()">+ 추가</span></td>
			</tr>
		</table>
	</div>

</form>