<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header2.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		initHeaderTab(1);
	});

</script>

<div id="wrap">
	<div id="championCon">
		<div class="chConBox" style="width:980px;">
			<ul>
				<li>
				<img src="<c:url value='/images/hills/champion/DMZ.jpg'/>"border="0"  usemap="#Map" />
				<map name="Map">
				 <!--  <area shape="rect" coords="310,1052,671,1113" href="javascript:initPopup(1)"> -->
				  <c:choose>
					    <c:when test="${sessionScope.msMember.msId eq '' || sessionScope.msMember.msId eq null}">
					    	<area shape="rect" coords="310,1052,671,1113"  onfocus="this.blur()" href="javascript:initPopup(1)" />
					    </c:when>
					    <c:otherwise>
					    	<area shape="rect" coords="310,1052,671,1113"  onfocus="this.blur()" href="javascript:initPopup(2)" />
					    </c:otherwise>
					</c:choose>
				</map>
				</li>
			</ul>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" flush="true" />