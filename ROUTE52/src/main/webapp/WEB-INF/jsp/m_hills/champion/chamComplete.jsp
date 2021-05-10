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
		
		if(type == "1") {
			var birth = replaceAll($("#txtBirth").val(), "-", "");
			
			if(birth == "" || birth.length != 8) {
				alert("생년월일을 확인하세요.");
				return;
			}
			
			if(birth.substring(0, 4) >= 1982) {
				sParams += String.format("&ctDiv={0}", "11");
			} else {
				sParams += String.format("&ctDiv={0}", "12");
			}
			sParams += String.format("&birth={0}", birth);
		} else if(type == "2") {
			sParams += String.format("ctDiv={0}", "6");	
		}
		
		sParams += String.format("&coDiv={0}", "65");
		
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
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 대회안내 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList4">			
		<c:if test="${type eq '1'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=1'/>">레이디스골프챔피언십</a></li>
		</c:if>
		<c:if test="${type ne '1'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=1'/>">레이디스골프챔피언십</a></li>
		</c:if>	
		<c:if test="${type eq '2'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=2'/>">DMZ평화골프대회</a></li>
		</c:if>
		<c:if test="${type ne '2'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=2'/>">DMZ평화골프대회</a></li>
		</c:if>	
		<c:if test="${type eq '3'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=3'/>">연단체 챔피언십</a></li>
		</c:if>
		<c:if test="${type ne '3'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=3'/>">연단체 챔피언십</a></li>
		</c:if>	
		<c:if test="${type eq '4'}">
			<li class="on"><a href="<c:url value='/m_hills/champion/chamView.do?type=4'/>">싱글인증전</a></li>
		</c:if>
		<c:if test="${type ne '4'}">
			<li class=""><a href="<c:url value='/m_hills/champion/chamView.do?type=4'/>">싱글인증전</a></li>
		</c:if>	
	</ul>

	<c:if test="${type eq '1'}">
	<div class="contents">
		<div class="champWrap2">			
			<div class="champTitle">
				<img src="/images/hills/main/champBn3.png" style="width:100%;">			
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
				<dl>
					<dt>생년월일 : </dt>
					<dd><input type="text" placeholder="1985-01-01" id="txtBirth" class="pop_birth"></dd>
					<dd class="small">대회 참가신청 시 반드시 신분증에 있는 생년원일을 입력 바랍니다.<br>대회 당일 신분증을 확인하며 생년월일 틀릴 시에는 실격 처리됩니다.</dd>
				</dl>
				<div class="chamAgree">
					<p>대회참가신청 동의 </p>
					<ul>					
						<li class="small1"> 본인은 서원힐스 여성아마추어 골프대회에 참가를 신청하며, 대회와 관련하여 주최측에서 운영하는 사항을 준수하겠습니다.</li>
						<li class="check"><input type="checkbox" id="chkAgree"> 동의합니다.</li>
					</ul>
				</div>		
			</div>
			<ul class="btnBox_1">
			<li class="darksalmon"><a href="javascript:doApply()"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가접수 완료</a></li>
			</ul>			
		</div>	
	</div><!-- contents End -->
	</c:if>
	
	<c:if test="${type eq '2'}">
		<div class="contents">
		<div class="champWrap2">			
			<div class="champTitle">
				<div class="champbg3"></div>
				<h3>
				 Seowon Hills<br>
				<span style="color:#0b3f98;"> DMZ Peace Golf Championship</span>
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
						<li class="small1"> 본인은 서원힐스 제2회 DMZ 평화 골프대회에 참가를 신청하며, 대회와 관련하여 주최측에서 운영하는 사항을 준수하겠습니다.</li>
						<li class="check"><input type="checkbox" id="chkAgree"> 동의합니다.</li>
					</ul>
				</div>		
			</div>
			<ul class="btnBox_1">
			<li class="darksalmon"><a href="javascript:doApply()"><img src="<c:url value='/images/m_hills/icon_write.png'/>" alt=""> 참가접수 완료</a></li>
			</ul>			
		</div>	
	</div><!-- contents End -->
	</c:if>
	
	<jsp:include page="../include/footer.jsp" flush="true" />
</div> 

</body>
</html>