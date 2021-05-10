<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="<c:url value='/js/jquery.eislideshow.js'/>"></script> 

<script type="text/javascript">

	var mQNA;

	function onLoadQNA() {
		doSearchQNA();
	}
	
	function doSearchQNA() {
		var sUrl = "<c:url value='/admin/getQNA.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				mQNA = data.rows;

				var tbody = $("#qna-gird");
				
				tbody.empty();
				    
				for(i=0; i<mQNA.length; i++) {
					var row = $("<tr></tr>"); 
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
					var col2 = $(String.format("<td><input type='text' id='title_qna_{0}' value='{1}'></td>", (i + 1), mQNA[i].HP_TITLE)); 
				    var col3 = $(String.format("<td><textarea id='contents_qna_{0}'>{1}</textarea></td>", (i + 1), mQNA[i].HP_CONTENTS)); 
				    var col4 = $(String.format("<td><input type='number' id='no_qna_{0}' value='{1}'></td>", (i + 1), mQNA[i].HP_NO)); 
				    var col5 = $(String.format("<td><a href='javascript:updateQNA({0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteQNA({0})' class='grayBtn'>삭제</a></td>", i));
				    
					row.append(col1,col2,col3,col4,col5,col6).appendTo(tbody);        
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function deleteQNA(idx) {
		var sUrl = "<c:url value='/admin/deleteMessage.do'/>";
		var sParams = "";
		
		sParams += String.format("&coDiv={0}", mQNA[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", mQNA[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", mQNA[idx].HP_DIV);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("삭제 되었습니다.");
				
				doSearchQNA();
			} else {
				alert(data.resultMessage);
			}
		});
	} 
	
	function updateQNA(idx) {
		var sUrl = "<c:url value='/admin/saveQNA.do'/>";
		var sParams = "";

		var hpIdx = mQNA[idx].HP_IDX;
		var title = $(String.format("{0}title_qna_{1}", "#", (idx + 1))).val();
		var contents = $(String.format("{0}contents_qna_{1}", "#", idx + 1)).val();     
		var no = $(String.format("{0}no_qna_{1}", "#", idx + 1)).val();
		
		if(title == null || title == "") {
			alert("제목을 입력하세요.");
			return;
		}
		
		if(contents == null || contents == "") {
			alert("내용을 입력하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}

		sParams = String.format("&coDiv={0}", mCoDiv);
		sParams += String.format("&idx={0}", hpIdx);
		sParams += String.format("&title={0}", title);
		sParams += String.format("&contents={0}", contents);
		sParams += String.format("&no={0}", no);

        progressStart();
		
        mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("등록 되었습니다.");
				
				doSearchQNA();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function saveQNA(idx) {
		var sUrl = "<c:url value='/admin/saveQNA.do'/>";
		var sParams = "";

		var title = $(String.format("{0}title_qna_{1}", "#", idx)).val();
		var contents = $(String.format("{0}contents_qna_{1}", "#", idx)).val();     
		var no = $(String.format("{0}no_qna_{1}", "#", idx)).val();
		
		if(title == null || title == "") {
			alert("제목을 입력하세요.");
			return;
		}
		
		if(contents == null || contents == "") {
			alert("내용을 입력하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}

		sParams = String.format("&coDiv={0}", mCoDiv);
		sParams += String.format("&title={0}", title);
		sParams += String.format("&contents={0}", contents);
		sParams += String.format("&no={0}", no);

        progressStart();
		
        mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("등록 되었습니다.");
				
				doSearchQNA();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addQNARow() {
		var selector = "#qna-gird";
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
	    var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><input type='text' id='title_qna_{0}'></td>", rowCnt)); 
	    var col3 = $(String.format("<td><textarea id='contents_qna_{0}'></textarea></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='number' id='no_qna_{0}'></td>", rowCnt)); 
	    var col5 = $(String.format("<td><a href='javascript:saveQNA({0})' class='blueBtn'>등록</a></td>", rowCnt));
	    var col6 = $("<td></td>");
	   
	    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody);
	}

</script>

<div class="admin_wrap">
	<div class="subTitle">
		<span>Q &amp; A</span>
	</div>

	<table class="commonTable4">    
		<caption></caption>
		<colgroup>
			<col width="10%">
			<col width="20%">
			<col width="40%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>순번</th>
			<th>등록</th>
			<th>삭제</th>
		</tr>
		<tbody id="qna-gird"></tbody>
		<tr>
			<td colspan="6"><span class="grayBtn" onclick="addQNARow()">+ 추가</span></td>
		</tr>
	</table>
</div>
