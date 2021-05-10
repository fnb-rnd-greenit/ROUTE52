<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script type="text/javascript">

	$(document).ready(function() { 
		var content = "${content}";
		
		content = convertSpecialCharacters(content);
		
		$("#txtContent").append(content);
		
		initImage();
		
		initAttachFiles();	
	});
	
	function initImage() {
		var imageName = "<c:out value='${upFileName1}'/>";
		var folderName = "<c:out value='${folderName}'/>";
		
		if(imageName != "") {
			$("#viewMainImage").attr("src", "<c:url value='/common/downloadImage.do?division=hills&folderName=" + folderName + "&fileName=" + imageName + "'/>");
		} else {
			$("#viewMainImage").attr("src", "<c:url value='/images/hills/boardDefaultImage.jpg'/>");
		}
	}
	
	function initAttachFiles() {
		var file1 = "<c:out value='${upOriginFile2}'/>";
		var file2 = "<c:out value='${upOriginFile3}'/>";
		var originFileName1 = "<c:out value='${upFileName2}'/>";
		var originFileName2 = "<c:out value='${upFileName3}'/>";
		var folderName = "<c:out value='${folderName}'/>";

		if(file1 != "" || file2 != "") {
			$("#viewAttach").show();
		}
		
		if(file1 != "") {
			$("#attachFile1 a").append(file1);
			$("#attachFile1 a").click(function() {
				downloadAttachFile(folderName, file1, originFileName1);
			});
		}
		
		if(file2 != "") {
			if(file1 != ""){
				$("#attachFile2").prepend(" ,  ");
			}
			$("#attachFile2 a").append(file2);
			$("#attachFile2 a").click(function() {
				downloadAttachFile(folderName, file2, originFileName2);
			});
		}
	}
	
	function downloadAttachFile(folderName, fileName, originFileName) {
		var sUrl = "<c:url value='/common/downloadFile.do'/>";
		var sParams = "";
		
		sParams += String.format("?fileName={0}", fileName);
		sParams += String.format("&originFileName={0}", originFileName);
		sParams += String.format("&folderName={0}", folderName);
		sParams += String.format("&division={0}", "hills");

		window.open(sUrl + sParams);
	}
	
	function doDelete() {
		var sUrl = "<c:url value='/hills/board/deleteBoard.do'/>";
		var sParams = "";
		
		var idx = "<c:out value='${idx}'/>";
		sParams += String.format("&idx={0}", idx);
		
		var deleteYn = confirm("글을 삭제하시겠습니까?");
		
		if(deleteYn) {
			mAjax(sUrl, sParams, function(data) {
	        	if(data.resultCode == "0000") {
	         		alert("글이 삭제되었습니다.");
	         	   
	         		location.href = "<c:url value='/hills/board/list.do?bbsType=${bbsType}'/>"
	            } else {
	         	   alert(data.resultMessage);
	            }
	        });	
		}
	}

</script>
<style>
	#attachFile1 a{ color:#0000ff}
	#attachFile2 a{ color:#0000ff}
	#attachFile1 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
	#attachFile2 a:hover{ color:#0000ff;  border-bottom-width: 1px; border-bottom-color: #0000ff; border-bottom-style: solid; }
</style>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<c:if test="${bbsType eq '1'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>공지사항</span></p>
		</c:if>
		<%-- <c:if test="${bbsType eq '2'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>뉴스</span></p>
		</c:if> --%>
		<c:if test="${bbsType eq '4'}">
			<p>정보안내 &nbsp;&nbsp;&nbsp; ＞ <span>이벤트</span></p>
		</c:if>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList3">
			<c:if test="${bbsType eq '1'}">
				<a href="<c:url value='/hills/board/list.do?bbsType=1'/>" class="on">공지사항</a>
			</c:if>
			<c:if test="${bbsType ne '1'}">
				<a href="<c:url value='/hills/board/list.do?bbsType=1'/>">공지사항</a>
			</c:if>
			<c:if test="${bbsType eq '6'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=6'/>" class="on">이벤트</a>
			</c:if>
			<c:if test="${bbsType ne '6'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=6'/>">이벤트</a>
			</c:if>
			<%-- <c:if test="${bbsType eq '2'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=2'/>" class="on">뉴스</a>
			</c:if>
			<c:if test="${bbsType ne '2'}">
			<a href="<c:url value='/hills/board/list.do?bbsType=2'/>">뉴스</a>
			</c:if> --%>
			<c:if test="${bbsType eq '3'}">		
			<a href="<c:url value='/hills/board/list.do?bbsType=3'/>" class="on">포토갤러리</a>
			</c:if>
			<c:if test="${bbsType ne '3'}">		
			<a href="<c:url value='/hills/board/list.do?bbsType=3'/>">포토갤러리</a>
			</c:if>				
			<!-- <a href="javascript:alert('준비중입니다.');">자료실</a> -->	
		</div>
		<div class="subTitle subBottom">
			<c:if test="${bbsType eq '1'}">
				<span class="title">공지사항</span>
				<span class="titleDes"></span>
			</c:if>
			<c:if test="${bbsType eq '2'}">
				<span class="title">뉴스</span>
				<span class="titleDes"></span>
			</c:if>
			<c:if test="${bbsType eq '4'}">
				<span class="title">이벤트</span>
				<span class="titleDes"></span>
			</c:if>
		</div>
		
		<div class="viewBox grayBgBox">
			<div class="viewTitleBox">
				<span class="viewTitle">${title}</span>
				<span class="viewDate">${regDate}</span>
			</div>		
			<!-- <img src="" id="viewMainImage" class="viewMainImage"  alt=""> -->
			<c:if test="${idx eq '57'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map" id="Map">
			  <area shape="rect" coords="60,1795,268,1863" href="https://www.seowongolf.co.kr/hills/board/view.do?bbsType=1&idx=59" />
			  <area shape="rect" coords="330,1791,539,1865" href="https://kr.object.ncloudstorage.com/contents/seowon-member/2019_%EC%9A%B0%EC%88%98%EC%97%B0%EB%8B%A8%EC%B2%B4_%EC%B1%94%ED%94%BC%EC%96%B8%EC%8B%AD_%EC%B0%B8%EA%B0%80_%EC%8B%A0%EC%B2%AD%EC%84%9C.doc" />
			  </map>
			</c:if>
			<c:if test="${idx eq '95'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map" id="Map">
			    <area shape="rect" coords="77,926,353,988" href="https://www.seowongolf.co.kr/hills/champion/champion.do" />
  				<area shape="rect" coords="647,926,925,990" href="https://www.seowongolf.co.kr/hills/champion/champion2.do" />
			  </map>
			</c:if>
			<c:if test="${idx eq '176'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map" id="Map">
				  <area shape="circle" coords="496,607,85" href="https://youtu.be/iHeSO-b7rnE" target="_blank" />
			</map>
			</c:if>
			<c:if test="${idx eq '152'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map" id="Map">
			      <area shape="rect" coords="44,1026,553,1080" href="https://www.seowongolf.co.kr/hills/board/view.do?bbsType=44&idx=153" />
			      <area shape="rect" coords="203,1322,392,1374" href="<c:url value='/hills/team/yearTeamJoin.do'/>" />
			  </map>
			</c:if>
			<c:if test="${idx eq '290'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map" id="Map">
				<area shape="rect" coords="241,538,558,587" href="https://www.seowongolf.co.kr/hills/reservation/reservation.do?part=R" />
			  </map>
			</c:if>
			<c:if test="${idx eq '295'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map">
				<area shape="rect" coords="116,2055,374,2124" href="https://kr.object.ncloudstorage.com/hills/document/2021%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%EC%97%B0%EB%8B%A8%EC%B2%B4%EC%9A%B4%EC%98%81%EA%B7%9C%EC%A0%95_%EC%B5%9C%EC%A2%85%EB%B3%80%EA%B2%BD%28201106%29.pdf" target="_blank">
				<!-- <area shape="rect" coords="429,2058,688,2122" href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%202021%EB%85%84%20%EC%97%B0%EB%8B%A8%EC%B2%B4%20%EC%8B%A0%EC%B2%AD%EC%84%9C.pdf" target="_blank"> -->
				<!-- <area shape="rect" coords="429,2058,688,2122" href="https://kr.object.ncloudstorage.com/hills/document/%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A42021%EB%85%84%EC%97%B0%EB%8B%A8%EC%B2%B4%EC%8B%A0%EC%B2%AD%EC%84%9C_06%EC%8B%9C%EB%8C%80%20%EC%A0%84%EC%9A%A9.pdf"> -->
			  </map>
			</c:if>
			<c:if test="${idx eq '305'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map">
				<area shape="rect" coords="113,1640,377,1709" href="https://kr.object.ncloudstorage.com/hills/document/2021%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%EC%97%B0%EB%8B%A8%EC%B2%B4%EC%9A%B4%EC%98%81%EA%B7%9C%EC%A0%95_%EC%B5%9C%EC%A2%85%EB%B3%80%EA%B2%BD%28201106%29.pdf" target="_blank">
				<!-- <area shape="rect" coords="427,1641,691,1710" href="https://kr.object.ncloudstorage.com/hills/document/%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A42021%EB%85%84%EC%97%B0%EB%8B%A8%EC%B2%B4%EC%8B%A0%EC%B2%AD%EC%84%9C_06%EC%8B%9C%EB%8C%80%20%EC%A0%84%EC%9A%A9.pdf" > -->
			  </map>
			</c:if>
			<c:if test="${idx eq '343'}">      
			  <img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			  <map name="Map">
			    <area shape="rect" coords="213,2137,580,2187" href="https://www.seowongolf.co.kr/hills/team/generalRequest.do">
			  </map>
			</c:if>
			<%-- <c:if test="${idx eq '319'}">      
				<img src="" id="viewMainImage" class="viewMainImage"  alt="" usemap="#Map" border="0"/>
			 	<map name="Map">
				  <area shape="rect" coords="244,1859,576,1922" href="https://kr.object.ncloudstorage.com/hills/document/21%EB%85%84%20%EC%96%BC%EB%A6%AC%EB%B2%84%EB%93%9C%20%EB%A9%A4%EB%B2%84%EC%8A%A4%28%EC%9D%BC%EB%B0%98%EB%8B%A8%EC%B2%B4%29%20%EC%8B%A0%EC%B2%AD%EC%84%9C%28%EC%B5%9C%EC%A2%85%29.pdf"  target="_blank">
				</map>
			</c:if> --%>
			<c:if test="${idx ne '57'}">      
			   <img src="" id="viewMainImage" class="viewMainImage"  alt="">
			</c:if>
			<div class="viewTxt" id="txtContent">
			</div>
			<div id="viewAttach" style="display: none">
				 <img class="attachImg" src="<c:url value='/images/hills/board_file.png'/>"/>
				 <span>첨부파일 : </span>
				 <span id="attachFile1"><a></a></span>
				 <span id="attachFile2"><a></a></span>	 
			</div>
		</div> 
		<div class="btnBox">  
			<a href="<c:url value='/hills/board/list.do?bbsType=${bbsType}'/>" class="grayBtn">목록</a>
			<c:if test="${sessionScope.msMember.webAdmin == 'Y'}">
				<a href="<c:url value='/hills/board/modify.do?bbsType=${bbsType}&idx=${idx}'/>" class="orangeBtn">수정</a>
				<a href="javascript:doDelete()" class="grayBtn">삭제</a>
			</c:if>
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />