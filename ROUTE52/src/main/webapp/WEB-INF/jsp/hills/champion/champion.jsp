<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		initHeaderTab(1);
	});

</script>

<div id="wrap">
	<div id="championCon">
		<div class="chConBox">
			<ul>
				<li>
				<img src="<c:url value='/images/hills/champion/womenImg.jpg'/>" usemap="#Map" border="0" />
				<map name="Map" id="Map">
					<c:choose>
					    <c:when test="${sessionScope.msMember.msId eq '' || sessionScope.msMember.msId eq null}">
					    	<area shape="rect" coords="871,416,1070,459"  onfocus="this.blur()" href="javascript:initPopup(1)" />
					    </c:when>
					    <c:otherwise>
					    	<area shape="rect" coords="871,416,1070,459"  onfocus="this.blur()" href="javascript:initPopup(2)" />
					    </c:otherwise>
					</c:choose>
				</map>
				</li>
				<li style="text-align:center;"><img src="<c:url value='/images/hills/champion/womenImg2.jpg'/>" border="0" /></li>
			</ul>
		</div>
	</div>
</div>

<jsp:include page="../include/popup/champion_pop.jsp" />
<jsp:include page="../include/footer.jsp" flush="true" />