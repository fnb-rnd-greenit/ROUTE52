<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="<c:url value='/js/jquery.eislideshow.js'/>"></script> 

<script type="text/javascript">

	var hBenner;
	var mBenner;

	function onLoadBenner() {
		doSearchBenner();
	}
	
	function doSearchBenner() {
		var sUrl = "<c:url value='/admin/getBenner.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var bucket = mCoDiv == "61" ? "valley" : mCoDiv == "65" ? "hills" : "clubd";
				
				hBenner = data.rows.homepage;
				mBenner = data.rows.mobile;
				
				var h_tbody = $("#hompage-benner-grid");
				var m_tbody = $("#mobile-benner-grid");
				
				h_tbody.empty();
				m_tbody.empty();
				
				var slideContainer1 = $("#slideContainer1");
				var slideContainer2 = $("#slideContainer2");
				
				slideContainer1.empty();
				slideContainer2.empty();
				
				var slide1 = $("<div id='ei-slider' class='ei-slider'></div>")
				var slide2 = $("<div id='ei-slider2' class='ei-slider2' style='margin-top:10px'></div>")
				
				var h_slider_large = $("<ul class='ei-slider-large' id='ei-slider-large'></ul>");
				var h_slider_thumbs = $("<ul class='ei-slider-thumbs' id='ei-slider-thumbs'></ul>");
				var m_slider_large = $("<ul class='ei-slider-large' id='ei-slider-large2' style='height:223px'></ul>");
				var m_slider_thumbs = $("<ul class='ei-slider-thumbs' id='ei-slider-thumbs2'></ul>");				
				
				h_slider_thumbs.append("<li class='ei-slider-element'>Current</li>");
				m_slider_thumbs.append("<li class='ei-slider-element'>Current</li>");
				
				for(i=0; i<hBenner.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = hBenner[i].HP_FILE_NAME;
					var originName = hBenner[i].HP_ORIGIN_FILE_NAME;
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><span>{0}</span></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='{0}_link_{1}' id='{0}_link_{1}' value='{2}'></td>", "h", (i + 1), hBenner[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='{0}_no_{1}' id='{0}_no_{1}' value='{2}'></td>", "h", (i + 1), hBenner[i].HP_NO)); 
				    var col5 = $(String.format("<td><a href='javascript:updateBenner(\"h\", {0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteBenner(\"h\", {0})' class='grayBtn'>삭제</a></td>", i));
				    
					row.append(col1,col2,col3,col4,col5,col6).appendTo(h_tbody); 
					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName);
					
					h_slider_large.append(String.format("<li><a href='javascript:void(0)'><img src='{0}'/></a></li>", image));
					h_slider_thumbs.append(String.format("<li><a href='#'>Slide {0}</a><img src='{1}' alt='' /></li>", (i + 1), image));
				}
				
				for(i=0; i<mBenner.length; i++) {
					var row = $("<tr></tr>"); 
					
					var fileName = mBenner[i].HP_FILE_NAME;
					var originName = mBenner[i].HP_ORIGIN_FILE_NAME;
					
					var col1 = $(String.format("<td>{0}</td>", (i + 1))); 
				    var col2 = $(String.format("<td><span>{0}</span></td>", originName)); 
				    var col3 = $(String.format("<td><input type='text' name='{0}_link_{1}' id='{0}_link_{1}' value='{2}'></td>", "m", (i + 1), mBenner[i].HP_LINK)); 
				    var col4 = $(String.format("<td><input type='number' name='{0}_no_{1}' id='{0}_no_{1}' value='{2}'></td>", "m", (i + 1), mBenner[i].HP_NO)); 
				    var col5 = $(String.format("<td><a href='javascript:updateBenner(\"m\", {0})' class='orangeBtn'>수정</a></td>", i));
				    var col6 = $(String.format("<td><a href='javascript:deleteBenner(\"m\", {0})' class='grayBtn'>삭제</a></td>", i));
				    
					row.append(col1,col2,col3,col4,col5,col6).appendTo(m_tbody); 
					
					var image = String.format("<c:url value='/common/downloadImage.do?division={0}&folderName=benner&fileName={1}'/>", bucket, fileName);
					
					m_slider_large.append(String.format("<li><a href='javascript:void(0)'><img src='{0}'/>' alt='' /></a></li>", image));
					m_slider_thumbs.append(String.format("<li><a href='#'>Slide {0}</a><img src='{1}' alt='' /></li>", (i + 1), image));
				}
				
				slide1.append(h_slider_large, h_slider_thumbs).appendTo(slideContainer1);
				slide2.append(m_slider_large, m_slider_thumbs).appendTo(slideContainer2);
				
				if(hBenner.length > 0) {
					$('#ei-slider').eislideshow({
						slideshow_interval : 4000,
						titlesFactor : 0
					});
				}
				
				if(mBenner.length > 0) {
					$('#ei-slider2').eislideshow({
						slideshow_interval : 4000,
						titlesFactor : 0
					});
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function updateBenner(div, idx) {
		var sUrl = "<c:url value='/admin/updateBenner.do'/>";
		var sParams = "";
		
		var target = div == "h" ? hBenner : mBenner;
		
		var link = $(String.format("{0}{1}_link_{2}", "#", div, (idx + 1))).val();
		var no = $(String.format("{0}{1}_no_{2}", "#", div, (idx + 1))).val();
		
		sParams += String.format("&coDiv={0}", target[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target[idx].HP_DIV);
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
				
				doSearchBenner();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function deleteBenner(div, idx) {
		var sUrl = "<c:url value='/admin/deleteBenner.do'/>";
		var sParams = "";
		
		var target = div == "h" ? hBenner : mBenner;
		
		sParams += String.format("&coDiv={0}", target[idx].CO_DIV);
		sParams += String.format("&hpIdx={0}", target[idx].HP_IDX);
		sParams += String.format("&hpDiv={0}", target[idx].HP_DIV);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("삭제 되었습니다.");
				
				doSearchBenner();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addBennerRow(div) {
		var selector = div == "h" ? "#hompage-benner-grid" : "#mobile-benner-grid";
		var tBody = $(selector);
		var rowCnt = tBody.children("tr").length + 1;
		
		var row = $("<tr></tr>"); 
		
	    var col1 = $(String.format("<td>{0}</td>", rowCnt)); 
	    var col2 = $(String.format("<td><input type='file' name='{0}_file_{1}' id='{0}_file_{1}'></td>", div, rowCnt)); 
	    var col3 = $(String.format("<td><input type='text' name='{0}_link_{1}' id='{0}_link_{1}'></td>", div, rowCnt)); 
	    var col4 = $(String.format("<td><input type='number' name='{0}_no_{1}' id='{0}_no_{1}'></td>", div, rowCnt)); 
	    var col5 = $(String.format("<td><a href='javascript:saveBenner(\"{0}\", {1})' class='blueBtn'>등록</a></td>", div, rowCnt));
	    var col6 = $("<td></td>");
	   
	    row.append(col1,col2,col3,col4,col5,col6).appendTo(tBody);
	}
	
	function saveBenner(div, idx) {
		var sUrl = "<c:url value='/admin/saveBenner.do'/>";
		
		var file = $(String.format("{0}{1}_file_{2}", "#", div, idx)).val();
		var no = $(String.format("{0}{1}_no_{2}", "#", div, idx)).val();
		
		if(file == null || file == "") {
			alert("파일을 선택하세요.");
			return;
		}
		
		if(no == null || no == "") {
			alert("순번을 입력하세요.");
			return;
		}
		
		$("#coDiv").val(mCoDiv);
		$("#div").val(div);
		$("#idx").val(idx);
		
        var formData = new FormData($("#benner_form")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchBenner();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}

</script>

<form id='benner_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
	<input type="hidden" id="coDiv" name="coDiv">
	<input type="hidden" id="div" name="div">
	<input type="hidden" id="idx" name="idx">
	
	
	<div id="slideContainer1">
	</div>
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span>홈페이지 메인 배너</span>
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
				<th>파일 (권장사이즈 - 1920 * 400)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="hompage-benner-grid"></tbody>
			<tr>
				<td colspan="6"><span class="grayBtn" onclick="addBennerRow('h')">+ 추가</span></td>
			</tr>
		</table>
	</div>
	
	<hr class="bar">
	<div id="slideContainer2">
	</div>
	
	<div class="admin_wrap">
		<div class="subTitle">
			<span> 모바일 메인 배너</span>
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
				<th>파일 (권장사이즈 - 640 * 347)</th>
				<th>링크</th>
				<th>순번</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="mobile-benner-grid"></tbody>
			<tr>
				<td colspan="6" onclick="addBennerRow('m')"><span class="grayBtn">+ 추가</span></td>
			</tr>
		</table>
	</div>
</form>
