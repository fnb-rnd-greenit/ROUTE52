<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header3.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		initHeaderTab(2);
	});

</script>

<div id="wrap">
	<div id="championCon">
		<div class="chConBox">
			<ul>
				<%-- <li style="text-align:center;"><img src="<c:url value='/images/hills/trumpy3.jpg'/>" border="0" /></li> --%>
				<li style="text-align:center;"><img src="<c:url value='/images/hills/trumpy3_2.jpg'/>" border="0" /></li>
			</ul>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" flush="true" />