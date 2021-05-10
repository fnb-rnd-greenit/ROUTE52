<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<script type="text/javascript">

	function doApply() {
		var sUrl = "<c:url value='/common/doCompetitionsApply.do'/>";
		var sParams = "";
		var type = "${type}";
		
		var agree = $("input[id=chkAgree]:checked").val();
		
		if(agree != "on") {
			alert("대회 참가신청에 동의하세요.");
			return;
		}
		
		sParams += String.format("ctDiv={0}", "5");	
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("참가신청 완료되었습니다.");
				
				location.href = "<c:url value='/m_hills/index.do'/>"
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
</script>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> Lady's Day <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<div class="champWrap2">			
			<div class="champTitle">
				<h3 style= "width:95%; padding:0 0 16px 0;">
				 골프장 최초 여성의, 여성에 의한, 여성을 위한 BIC 프로모션 <br>
				<span>“서원힐스 LADY’S DAY PASSPORT ”</span>
				</h3>			
			</div>
			<div class="champList">
				<dl>
					<dt>신청자 성함 : </dt>
					<dd>${sessionScope.msMember.msName}</dd>
				</dl>
				<dl>
					<dt>신청자 ID : </dt>
					<dd>${sessionScope.msMember.msId}</dd>
				</dl>
				<dl>
					<dt>연락처 : </dt>
					<dd>${sessionScope.msMember.phone1}-${sessionScope.msMember.phone2}-${sessionScope.msMember.phone3}</dd>
					<dd class="small">수정이 필요한 분은 <span>개인정보수정</span>에서 정정한 뒤 다시 로그인 하여 주시기 바랍니다.</dd>
				</dl>
				<div class="chamAgree">
					<p>대회참가신청 동의 </p>
					<ul>					
						<li class="small1"> 본인은 서원힐스 LADY’S DAY PASSPORT를 신청하며, 주최측에서 운영하는 사항을 준수하겠습니다.</li>
						<li class="check"><input type="checkbox" id="chkAgree"> 동의합니다.</li>
					</ul>
				</div>		
			</div>
			<ul class="btnBox_1">
			<li class="darksalmon"><a href="javascript:doApply()"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가접수 완료</a></li>
			</ul>			
		</div>	
	</div><!-- contents End -->
		
	<jsp:include page="../include/footer.jsp" flush="true" />
</div> 

</body>
</html>