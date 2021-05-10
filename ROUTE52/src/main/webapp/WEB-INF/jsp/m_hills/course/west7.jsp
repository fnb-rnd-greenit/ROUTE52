<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 코스안내 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList3">			
		<li class="on"><a href="<c:url value='/m_hills/course/courseIntro.do'/>">코스안내</a></li>
		<li class=""><a href="<c:url value='/m_hills/course/east1.do'/>">코스공략도</a></li>
		<li class=""><a href="javascript:alert('준비중입니다')">코스갤러리</a></li>
		<%-- <li class=""><a href="<c:url value='/m_hills/course/courseGallery.do'/>">코스갤러리</a></li> --%>
	</ul>

	<div class="contents">
		<div class="midTitleBox">
			<span class="commonDot"> 코스공략도</span>		
		</div>
		<ul class="btnType">
			<li class=""><a href="east1.do">이스트</a></li>
			<li class="on"><a href="west1.do">웨스트</a></li>
			<li class=""><a href="south1.do">사우스</a></li>
		</ul>
		
		<div class="courseBg">
			<div class="holeNumBox">
				<div class="holeNum">7</div>
				<ul class="holeText">
					<li class="hole1">hole</li>
					<li class="hole2">WEST COURSE</li>
				</ul>
				<select name="" id="" class="select-arrow2"onchange="window.open(value,'_self');">
					<option value="west1.do">선택</option>
					<option value="west1.do">1홀</option>
					<option value="west2.do">2홀</option>
					<option value="west3.do">3홀</option>
					<option value="west4.do">4홀</option>
					<option value="west5.do">5홀</option>
					<option value="west6.do">6홀</option>
					<option value="west7.do">7홀</option>
					<option value="west8.do">8홀</option>
					<option value="west9.do">9홀</option>
				</select>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/m_hills/course/west7.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="100%">
						<source src="<c:url value='/video/hills/west_7.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="holeExplain"><img src="<c:url value='/images/m_hills/balloon.png'/>" alt="">&nbsp;티잉 그라운드 앞쪽으로 큰 해저드가 있기 때문에 심리적으로 불안한 홀이라고 생각할 수 있지만, 두려움만 떨쳐 버린다면 좋은 결과를 얻을 수 있는 홀이다. 그린은 좌측에서 우측으로 경사가 심하게 흐르는 핀 좌측을 보고 샷을 하는 전략을 펼쳐야 할 것이다. </div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HDCP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>3</td>
								<td></td>
								<td>201</td>
								<td>180</td>
								<td>153</td>
								<td>128</td>
								<td>128</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
			
		
	</div><!-- contents End -->
	
	<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>