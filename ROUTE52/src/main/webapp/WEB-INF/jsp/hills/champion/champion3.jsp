<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header3.jsp" />

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
				<%-- <img src="<c:url value='/images/hills/champion/group.jpg'/>"border="0"  usemap="#Map" />
  				<map name="Map" id="Map">
	  				<area shape="rect" coords="144,462,385,536" href="/hills/board/view.do?bbsType=1&idx=59" />
	  				<area shape="rect" coords="467,460,700,542" href="https://kr.object.ncloudstorage.com/contents/seowon-member/2019_%EC%9A%B0%EC%88%98%EC%97%B0%EB%8B%A8%EC%B2%B4_%EC%B1%94%ED%94%BC%EC%96%B8%EC%8B%AD_%EC%B0%B8%EA%B0%80_%EC%8B%A0%EC%B2%AD%EC%84%9C.doc" />
				</map> --%>
				<img src="<c:url value='/images/hills/champion/group1.jpg'/>" border="0"  usemap="#Map" /> 
				<map name="Map">
				  <area shape="rect" coords="97,3381,473,3503" href="https://www.seowongolf.co.kr/hills/board/view.do?bbsType=44&idx=153">
				  <area shape="rect" coords="530,3385,906,3502" href="https://kr.object.ncloudstorage.com/hills/document/2020_%EC%97%B0%EB%8B%A8%EC%B2%B4_%EC%B1%94%ED%94%BC%EC%96%B8%EC%8B%AD_%EC%B0%B8%EA%B0%80_%EC%8B%A0%EC%B2%AD%EC%84%9C.doc">
				</map>
				
				</li>
			</ul>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" flush="true" />