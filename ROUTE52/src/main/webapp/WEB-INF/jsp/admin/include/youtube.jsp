<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="<c:url value='/js/jquery.eislideshow.js'/>"></script> 

<script type="text/javascript">

	var mYoutubeWeb;
	var mYoutubeMobile;
	var mYoutubeVideo;

	function onLoadYoutube() {
		doSearchYoutube();
	}
	
	function doSearchYoutube() {
		var sUrl = "<c:url value='/admin/getYoutube.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = mCoDiv == "61" ? "valley" : mCoDiv == "65" ? "hills" : "clubd";
				
				mYoutubeVideo = data.rows.list0;
				mYoutubeWeb = data.rows.list1;
				mYoutubeMobile = data.rows.list2;   
				
				var tbody = $("#youtube-video-grid");
				
				tbody.empty();
				    
				for(i=0; i<mYoutubeVideo.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mYoutubeVideo[i].HP_FILE_NAME;    
					var originName = mYoutubeVideo[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=youtube&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td>{0}</td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='link_youtube_{0}' id='link_youtube_{0}' value='{1}'></td>", (i + 1), mYoutubeVideo[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='no_youtube_{0}' id='no_youtube_{0}' value='{1}'></td>", (i + 1), mYoutubeVideo[i].HP_NO));
				    var col5 = $(String.format("<td><a href='javascript:updateYoutube(0, {0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteMessage3(0, {0})' class='grayBtn'>삭제</a></td>", i));
				    
				    row.append(col1,col2,col3,col4,col5).appendTo(tbody); 
				}
				
				if(mYoutubeVideo.length == 0) {
					addYoutubeRow(0);
				} 

				tbody = $("#youtube-web-grid");
				
				tbody.empty();
				    
				for(i=0; i<mYoutubeWeb.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mYoutubeWeb[i].HP_FILE_NAME;    
					var originName = mYoutubeWeb[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=youtube&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1)));
					var col2 = $(String.format("<td><input type='text' name='title_youtube_{0}' id='title_youtube_{0}' value='{1}'></td>", (i + 1), mYoutubeWeb[i].HP_TITLE));
				    var col3 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=youtube&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col4 = $(String.format("<td><input type='text' name='link_youtube_{0}' id='link_youtube_{0}' value='{1}'></td>", (i + 1), mYoutubeWeb[i].HP_LINK)); 
				    var col5 = $(String.format("<td><input type='number' name='no_youtube_{0}' id='no_youtube_{0}' value='{1}'></td>", (i + 1), mYoutubeWeb[i].HP_NO));
				    var col6 = $(String.format("<td><a href='javascript:updateYoutube(1, {0})' class='orangeBtn'>수정</a></td>", i));
				    var col7 = $(String.format("<td><a href='javascript:deleteMessage3(1, {0})' class='grayBtn'>삭제</a></td>", i));
				        
					row.append(col1,col2,col3,col4,col5,col6,col7).appendTo(tbody); 
				}
				
				tbody = $("#youtube-mobile-grid");
				
				tbody.empty();
				    
				for(i=0; i<mYoutubeMobile.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mYoutubeMobile[i].HP_FILE_NAME;    
					var originName = mYoutubeMobile[i].HP_ORIGIN_FILE_NAME;					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=youtube&fileName={1}'/>", bucket, fileName);
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><img style='width: 300px; margin: 10px;' src='" + String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=youtube&fileName={1}'/>", bucket, fileName) + "'></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='link_youtube_{0}' id='link_youtube_{0}' value='{1}'></td>", (i + 1), mYoutubeMobile[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='no_youtube_{0}' id='no_youtube_{0}' value='{1}'></td>", (i + 1), mYoutubeMobile[i].HP_NO));
				    var col5 = $(String.format("<td><a href='javascript:updateYoutube(2, {0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteMessage3(2, {0})' class='grayBtn'>삭제</a></td>", i));
				        
				    row.append(col1,col2,col3,col4,col5,col6).appendTo(tbody); 
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addYoutubeRow(type) {
		var selector;
		if(type == 0) {
			selector = "#youtube-video-grid";
		} else if(type == 1) {
			selector = "#youtube-web-grid";
		} else if(type == 2) {
			selector = "#youtube-mobile-grid";
		}
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
		var col1 = $(String.format("<td>{0}</td>", rowCnt));
		var col2 = $(String.format("<td {1}><input type='text' name='title_youtube_{0}' id='title_youtube_{0}'></td>", rowCnt, (type == 1 ? "" : "hidden")));
	    var col3 = $(String.format("<td><input type='file' name='file_youtube_{0}' id='file_youtube_{0}'></td>", rowCnt)); 
	    var col4 = $(String.format("<td><input type='text' name='link_youtube_{0}' id='link_youtube_{0}'></td>", rowCnt)); 
	    var col5 = $(String.format("<td><input type='number' name='no_youtube_{0}' id='no_youtube_{0}'></td>", rowCnt));
	    var col6 = $(String.format("<td><a href='javascript:saveYoutube({0}, {1})' class='blueBtn'>등록</a></td>", type, rowCnt));
	    var col7 = $("<td></td>");
		
	    row.append(col1,col2,col3,col4,col5,col6,col7).appendTo(tBody);
	}
	
	function saveYoutube(type, idx) {
		var sUrl = "<c:url value='/admin/saveYoutube.do'/>";
		var target;
		if(type == 0) {
			target = "#youtube_video_form";
		} else if(type == 1) {
			target = "#youtube_web_form";
		} else if(type == 2) {
			target = "#youtube_mobile_form";
		}
		
		var title = $(String.format("{0} {1}title_youtube_{2}", target, "#", idx)).val();
		var file = $(String.format("{0} {1}file_youtube_{2}", target, "#", idx)).val();
		var no = $(String.format("{0} {1}no_youtube_{2}", target, "#", idx)).val();
		
		if(file == null || file == "") {
			alert("파일을 선택하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}
		
		if(type == 1 && title == "") {
			alert("제목을 입력하세요.");
			return;
		}
		
		$(target + " #youtube_coDiv").val(mCoDiv);
		$(target + " #youtube_idx").val(idx);
		$(target + " #youtube_type").val(type)
		
        var formData = new FormData($(target)[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchYoutube();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}
	
	function deleteMessage3(type, idx) {
		var sUrl = "<c:url value='/admin/deleteMessage.do'/>";
		var sParams = "";
		var target;
		
		if(type == 0) {
			target = mYoutubeVideo;
		} else if(type == 1) {
			target = mYoutubeWeb;
		} else if(type == 2) {
			target = mYoutubeMobile;
		}
		
		sParams += String.format("&coDiv={0}", target[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target[idx].HP_DIV);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("삭제 되었습니다.");
				
				doSearchYoutube();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function updateYoutube(type, idx) {
		var sUrl = "<c:url value='/admin/updateMessageBenner.do'/>";
		var sParams = "";
		
		var target, target2;
		if(type == 0) {
			target = "#youtube_video_form";
			target2 = mYoutubeVideo;
		} else if(type == 1) {
			target = "#youtube_web_form";
			target2 = mYoutubeWeb;
		} else if(type == 2) {
			target = "#youtube_mobile_form";
			target2 = mYoutubeMobile;
		}
		
		var title = $(String.format("{0} {1}title_youtube_{2}", target, "#", (idx + 1))).val();
		var link = $(String.format("{0} {1}link_youtube_{2}", target, "#", (idx + 1))).val();
		var no = $(String.format("{0} {1}no_youtube_{2}", target, "#", (idx + 1))).val();
		
		sParams += String.format("&coDiv={0}", target2[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target2[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target2[idx].HP_DIV);
		sParams += String.format("&hpLink={0}", replaceAll(link, "&", "[AND]"));
		
		if(type == 1 && title == "") {
			alert("제목을 입력하세요.");
			return;
		} else {
			sParams += String.format("&title={0}", title);
		}
		
		if(no != "") {
			sParams += String.format("&hpNo={0}", no);
		} else {
			alert("순번을 입력하세요.");
			return;
		}
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("변경 되었습니다.");
				
				doSearchYoutube();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
</script>

<form id='youtube_video_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="youtube_coDiv" name="coDiv">
	<input type="hidden" id="youtube_idx" name="idx">
	<input type="hidden" id="youtube_type" name="type">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>홈페이지 메인 동영상</span>
		</div>
	
		<table class="commonTable1">   
			<caption>유튜브</caption>
			<colgroup>      
				<col width="14%">
				<col width="30%">
				<col width="31%">
				<col width="13%">
				<col width="12%">
			</colgroup>   
			<tr>
				<th>번호</th>
				<th>동영상 ( 크기제한 : 70MB, 확장자 : MP4 )</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
			</tr>
			<tbody id="youtube-video-grid"></tbody>
		</table>
	</div>
	
</form>
	
<hr class="bar">

<form id='youtube_web_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="youtube_coDiv" name="coDiv">
	<input type="hidden" id="youtube_idx" name="idx">
	<input type="hidden" id="youtube_type" name="type">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>홈페이지 유튜브</span>
		</div>
	
		<table class="commonTable6">
			<caption>유튜브</caption>
			<colgroup>      
				<col width="10%">
				<col width="25%">
				<col width="25%">
				<col width="15%">
				<col width="9%">
				<col width="8%">
				<col width="8%">
			</colgroup>   
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>파일 (권장사이즈 - 385 * 200)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="youtube-web-grid"></tbody>
			<tr>
				<td colspan="7"><span class="grayBtn" onclick="addYoutubeRow(1)">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
</form>
	
<hr class="bar">

<form id='youtube_mobile_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="youtube_coDiv" name="coDiv">
	<input type="hidden" id="youtube_idx" name="idx">
	<input type="hidden" id="youtube_type" name="type">
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>모바일 유튜브</span>
		</div>
	
		<table class="commonTable1">
			<caption>유튜브</caption>
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
				<th>파일 (권장사이즈 - 180 * 100)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="youtube-mobile-grid"></tbody>
			<tr>
				<td colspan="6"><span class="grayBtn" onclick="addYoutubeRow(2)">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
</form>