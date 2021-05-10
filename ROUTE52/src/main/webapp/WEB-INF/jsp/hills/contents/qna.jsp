<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">

	var rows;

	$(document).ready(function() {
		doSearch();
	});
	
	function doSearch() {
		var sUrl = "<c:url value='/common/getMessage.do'/>";
		var sParams = "";
		
		sParams += String.format("&coDiv={0}", globals.coDiv.hills);
		sParams += String.format("&hpDiv={0}", "4");
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				var container = $("#qnaContainer");
				container.empty();
				
				rows = data.rows;
				
				for(i=0; i<rows.length; i++) {
					var template = "";
					
					template += "<div class='qnaList' id='n{0}' onclick='onTapChange({0})'>";
					template += "	<span>{1}</span> {2}";
					template += "</div>";
					template += "<ul id='s{0}'>";
					template += "	<li>{3}</li>";
					template += "</ul>";
					
					var num = (i + 1);
					num = num < 10 ? "0" + num : num;
					var title = rows[i].HP_TITLE;
					var contents = rows[i].HP_CONTENTS;
					contents = replaceAll(contents, "\n", "<br>");
					
					container.append(String.format(template, i, num, title, contents));
				}
				
				onTapChange(0);
			} else {
				alert(data.resultMessage);	
			}
			
			progressStop();
		});
	}
	
	function onTapChange(idx) {
		for(i=0; i<=rows.length; i++){
			if(i==idx) {
				$("#n" + i + " span").addClass("on");
				$("#s" + i).slideToggle(300);
			} else {
				$("#n" + i + " span").removeClass("on");
				$("#s" + i).slideUp(300);
			}
		}
	}

</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>고객센터 &nbsp;&nbsp;&nbsp; ＞ <span>Q&amp;A</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">Q&amp;A</span>    
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>	
		
		<%-- <div class="qnaBox">
			<div class="commonDot guideTitle"> 자주하는 질문 </div>
			<div class="textboxWrap">
				<input type="text" placeholder="질문 키워드 검색">
				<img src="<c:url value='/images/hills/icon_Search.png'/>" alt="">
			</div>
			<h4>
			*키워드 검색을 이용하시면 조금 더 쉽게 원하시는 답변을 찾으실 수 있습니다.<br>
			*문의전화: 031-940-9400(ARS. 2번)
			</h4>	
		</div> --%>
		
		<div class="qnaMenu" id="qnaContainer">
			
		</div>		
			
	</div><!-- contents End -->
</div>


<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />