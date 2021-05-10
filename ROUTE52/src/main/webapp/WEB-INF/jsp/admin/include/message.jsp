<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="<c:url value='/js/jquery.eislideshow.js'/>"></script> 

<script type="text/javascript">

	var mMessage;
	var mMessageBenner;
	var mMessageAlert;

	function onLoadMessage() {
		doSearchMessage();
	}
	
	function doSearchMessage() {
		var sUrl = "<c:url value='/admin/getMessage.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = mCoDiv == "61" ? "valley" : mCoDiv == "65" ? "hills" : "clubd";
				
				mMessage = data.rows.mList;
				mMessageBenner = data.rows.bList;
				mMessageAlert = data.rows.aList;

				var m_tbody = $("#hompage-message-grid");
				var b_tbody = $("#hompage-message-benner-grid");
				
				m_tbody.empty();
				b_tbody.empty();
				    
				for(i=0; i<mMessage.length; i++) {
					var row = $("<tr></tr>"); 
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><textarea id='contents_msg_{0}'>{1}</textarea></td>", (i + 1), mMessage[i].HP_CONTENTS));  
				    var col3 = $(String.format("<td>#<input type='text' id='color_msg_{0}' value='{1}'></td>", (i + 1), mMessage[i].HP_COLOR)); 
				    var col4 = $(String.format("<td><input type='number' id='size_msg_{0}' value='{1}'></td>", (i + 1), mMessage[i].HP_FONT_SIZE)); 
				    var col5 = $(String.format("<td><input type='checkbox' id='bold_msg_{0}'></td>", (i + 1))); 
				    var col6 = $(String.format("<td><input type='number' id='no_msg_{0}' value='{1}'></td>", (i + 1), mMessage[i].HP_NO)); 
				    var col7 = $(String.format("<td><a href='javascript:updateMessage({0})' class='orangeBtn'>수정</a></td>", i));
				    var col8 = $(String.format("<td><a href='javascript:deleteMessage(\"m\", {0})' class='grayBtn'>삭제</a></td>", i));
				    
					row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(m_tbody); 
					
				    $("input:checkbox[id='bold_msg_" + (i + 1) + "']").prop("checked", mMessage[i].HP_FONT_BOLDYN == "Y" ? true : false);
				}
				    
				for(i=0; i<mMessageBenner.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mMessageBenner[i].HP_FILE_NAME;    
					var originName = mMessageBenner[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=message&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='link_benner_{0}' id='link_benner_{0}' value='{1}'></td>", (i + 1), mMessageBenner[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='no_benner_{0}' id='no_benner_{0}' value='{1}'></td>", (i + 1), mMessageBenner[i].HP_NO)); 
				    var col5 = $(String.format("<td><a href='javascript:updateMessageBenner({0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteMessage(\"b\", {0})' class='grayBtn'>삭제</a></td>", i));
				    
					row.append(col1,col2,col3,col4,col5,col6).appendTo(b_tbody); 
				}
				    
				for(i=0; i<mMessageAlert.length; i++) {
					var type = mMessageAlert[i].HP_TYPE;
					
					$("#contents_alert_" + type).val(mMessageAlert[i].HP_CONTENTS);
					$("input:checkbox[id='use_alert_" + type + "']").prop("checked", mMessageAlert[i].HP_USEYN == "Y" ? true : false);
					if(type == 1) {
						$("#st_date_alert_" + type).val(mMessageAlert[i].HP_ST_DATE);
						$("#ed_date_alert_" + type).val(mMessageAlert[i].HP_ED_DATE);						
					}
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function updateMessage(idx) {
		var sUrl = "<c:url value='/admin/updateMessage.do'/>";
		var sParams = "";

		var contents = $(String.format("{0}contents_msg_{1}", "#", (idx + 1))).val();
		var color = $(String.format("{0}color_msg_{1}", "#", (idx + 1))).val();
		var no = $(String.format("{0}no_msg_{1}", "#", (idx + 1))).val();    
		var size = $(String.format("{0}size_msg_{1}", "#", (idx + 1))).val();
		var bold = $(String.format("input:checkbox[id='bold_msg_{0}']", (idx + 1))).is(":checked") ? "Y" : "N";
		
		sParams += String.format("&coDiv={0}", mMessage[idx].CO_DIV);
		sParams += String.format("&hpDiv={0}", mMessage[idx].HP_DIV);
		sParams += String.format("&hpIdx={0}", mMessage[idx].HP_IDX);
		sParams += String.format("&contents={0}", contents);
		sParams += String.format("&color={0}", color);
		sParams += String.format("&fontSize={0}", size);
		sParams += String.format("&boldYn={0}", bold);
		sParams += String.format("&no={0}", no);
		
		if(contents == null || contents == "") {
			alert("내용을 입력하세요.");
			return;
		}
		
		if(color == null || color == "") {
			alert("색상을 입력하세요.");
			return;
		}
		
		if(size == null || size == "") {
			alert("글자 크기를 입력하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("변경 되었습니다.");
				
				doSearchMessage();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function updateMessageBenner(idx) {
		var sUrl = "<c:url value='/admin/updateMessageBenner.do'/>";
		var sParams = "";
		
		var link = $(String.format("{0}link_benner_{1}", "#", (idx + 1))).val();
		var no = $(String.format("{0}no_benner_{1}", "#", (idx + 1))).val();    
		
		sParams += String.format("&coDiv={0}", mMessageBenner[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", mMessageBenner[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", mMessageBenner[idx].HP_DIV);
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
				
				doSearchMessage();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function deleteMessage(div, idx) {
		var sUrl = "<c:url value='/admin/deleteMessage.do'/>";
		var sParams = "";
		var target;
		
		if(div == "m") {
			target = mMessage
		} else if(div == "b") {
			target = mMessageBenner
		} else if(div == "a") {
			target = mMessageAlert
		}
		
		sParams += String.format("&coDiv={0}", target[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target[idx].HP_DIV);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("삭제 되었습니다.");
				
				doSearchMessage();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addMessageRow() {
		var selector = "#hompage-message-grid";
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
	    var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><textarea id='contents_msg_{0}'></textarea></td>", rowCnt));  
	    var col3 = $(String.format("<td>#<input type='text' id='color_msg_{0}'></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='number' id='size_msg_{0}'></td>", rowCnt)); 
	    var col5 = $(String.format("<td><input type='checkbox' id='bold_msg_{0}'></td>", rowCnt)); 
	    var col6 = $(String.format("<td><input type='number' id='no_msg_{0}'></td>", rowCnt)); 
	    var col7 = $(String.format("<td><a href='javascript:saveMessage({0})' class='blueBtn'>등록</a></td>", rowCnt));
	    var col8 = $("<td></td>");
	   
	    row.append(col1,col2,col3,col4,col5,col6,col7,col8).appendTo(tBody);
	}
	
	function addMessageBennerRow() {
		var selector = "#hompage-message-benner-grid";
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
	    var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><input type='file' name='file_benner_{0}' id='file_benner_{0}'></td>", rowCnt)); 
	    var col3 = $(String.format("<td><input type='text' name='link_benner_{0}' id='link_benner_{0}'></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='number' name='no_benner_{0}' id='no_benner_{0}'></td>", rowCnt)); 
	    var col5 = $(String.format("<td><a href='javascript:saveMessageBenner({0})' class='blueBtn'>등록</a></td>", rowCnt));
	    var col6 = $("<td></td>");
	   
	    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody);
	}
	
	function saveMessage(idx) {
		var sUrl = "<c:url value='/admin/saveMessage.do'/>";
		var sParams = "";
		
		var contents = $(String.format("{0}contents_msg_{1}", "#", idx)).val();  
		var color = $(String.format("{0}color_msg_{1}", "#", idx)).val();
		var no = $(String.format("{0}no_msg_{1}", "#", idx)).val();
		var size = $(String.format("{0}size_msg_{1}", "#", idx)).val();
		var bold = $(String.format("input:checkbox[id='bold_msg_{0}']", idx)).is(":checked") ? "Y" : "N";
		
		if(contents == null || contents == "") {
			alert("내용을 입력하세요.");
			return;
		}
		
		if(color == null || color == "") {
			alert("색상을 입력하세요.");
			return;
		}
		
		if(size == null || size == "") {
			alert("글자 크기를 입력하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}

		sParams = String.format("&coDiv={0}", mCoDiv);
		sParams += String.format("&contents={0}", contents);
		sParams += String.format("&color={0}", color);
		sParams += String.format("&fontSize={0}", size);
		sParams += String.format("&boldYn={0}", bold);
		sParams += String.format("&no={0}", no);

        progressStart();
		
        mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("등록 되었습니다.");
				
				doSearchMessage();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function saveMessageBenner(idx) {
		var sUrl = "<c:url value='/admin/saveMessageBenner.do'/>";
		
		var file = $(String.format("{0}file_benner_{1}", "#", idx)).val();
		var no = $(String.format("{0}no_benner_{1}", "#", idx)).val();
		
		if(file == null || file == "") {
			alert("파일을 선택하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}
		
		$("#message_benner_coDiv").val(mCoDiv);
		$("#message_benner_idx").val(idx);
		
        var formData = new FormData($("#message_benner_form")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchMessage();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
	
	function saveMessageAlert() {
		var sUrl = "<c:url value='/admin/saveMessageAlert.do'/>";		
		var sParams = "";
		
		var div = "3";

		sParams = String.format("coDiv={0}", mCoDiv);
		sParams += String.format("&hpDiv={0}", div);
		
		for(i=1; i<=6; i++) {			
			var type = i;
			var contents = $(String.format("{0}contents_alert_{1}", "#", i)).val();
			var stDate, edDate
			if(i == 1) {
				stDate = $(String.format("{0}st_date_alert_{1}", "#", i)).val();
				edDate = $(String.format("{0}ed_date_alert_{1}", "#", i)).val();
			} else {
				stDate = "";
				edDate = "";
			}
			var useYn = $(String.format("input:checkbox[id='use_alert_{0}']", i)).is(":checked") ? "Y" : "N";			

			sParams += String.format("&type{0}={1}", i, type);
			sParams += String.format("&contents{0}={1}", i, contents);
			sParams += String.format("&stDate{0}={1}", i, stDate);
			sParams += String.format("&edDate{0}={1}", i, edDate);
			sParams += String.format("&useYn{0}={1}", i, useYn);
		}
		
		progressStart();
		
        mAjax(sUrl, sParams, function(data) {				
			if(data.resultCode == "0000") {
				alert("등록 되었습니다.");
				
				doSearchMessage();
			} else {
				alert(data.resultMessage);
			}
		});
	}

</script>

<div class="admin_wrap">
	<div class="subTitle">
		<span>예약화면 문구</span>
	</div>

	<table class="commonTable2">    
		<caption>배너</caption>
		<colgroup>
			<col width="5%">
			<col width="30%">
			<col width="15%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="10%">       
		</colgroup>
		<tr>
			<th>번호</th>
			<th>내용</th>
			<th>색상</th>
			<th>글자 크기</th>
			<th>글자 굵게</th>
			<th>순번</th>
			<th>등록</th>
			<th>삭제</th>
		</tr>
		<tbody id="hompage-message-grid"></tbody>
		<tr>
			<td colspan="8"><span class="grayBtn" onclick="addMessageRow()">+ 추가</span></td>
		</tr>
	</table>
</div>
	
<hr class="bar">

<form id='message_benner_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="message_benner_coDiv" name="coDiv">
	<input type="hidden" id="message_benner_idx" name="idx">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>예약화면 배너</span>
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
				<th>파일 (권장사이즈 - 560 * 130)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="hompage-message-benner-grid"></tbody>
			<tr>
				<td colspan="6"><span class="grayBtn" onclick="addMessageBennerRow()">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
</form>
	
<hr class="bar">

<div class="admin_wrap">
	<div class="subTitle">
		<span>예약확인 Alert 문구</span>
	</div>

	<table class="commonTable3">    
		<caption>배너</caption>
		<colgroup>
			<col width="10%">
			<col width="50%">
			<col width="30%">
			<col width="10%">
		</colgroup>
		<tr>
			<th>구분</th>
			<th>내용</th>
			<th>기간</th>     
			<th>사용여부</th>
		</tr>
		<tbody>
			<tr>
				<td>일반</td>
				<td><input type='text' id='contents_alert_1'></td>
				<td><input type='text' id='st_date_alert_1' placeholder="YYYYMMDD"> ~ <input type='text' id='ed_date_alert_1' placeholder="YYYYMMDD"></td>
				<td><input type="checkbox" id='use_alert_1'></td>
			</tr>
			<tr>
				<td>특가</td>
				<td><input type='text' id='contents_alert_2'></td>
				<td></td>
				<td><input type='checkbox' id='use_alert_2'></td>
			</tr>
			<tr>
				<td>맞춤</td>
				<td><input type='text' id='contents_alert_3'></td>
				<td></td>
				<td><input type='checkbox' id='use_alert_3'></td>
			</tr>
			<tr>
				<td>조기</td>
				<td><input type='text' id='contents_alert_4'></td>
				<td></td>
				<td><input type='checkbox' id='use_alert_4'></td>
			</tr>
			<tr>
				<td>식사</td>
				<td><input type='text' id='contents_alert_5'></td>
				<td></td>
				<td><input type='checkbox' id='use_alert_5'></td>
			</tr>
			<tr>
				<td>로얄</td>
				<td><input type='text' id='contents_alert_6'></td>
				<td></td>
				<td><input type='checkbox' id='use_alert_6'></td>
			</tr>
			<tr>
				<td colspan="4"><span class="orangeBtn" onclick="saveMessageAlert()">저장</span></td>
			</tr>
		</tbody>      
	</table>
</div>
