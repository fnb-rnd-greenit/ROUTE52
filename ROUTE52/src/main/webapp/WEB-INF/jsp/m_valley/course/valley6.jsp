<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> 코스안내 <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList3">			
		<li class=""><a href="<c:url value='/m_valley/course/courseIntro.do'/>">코스안내</a></li>
		<li class="on"><a href="<c:url value='/m_valley/course/seowon1.do'/>">코스공략도</a></li>
		<li class=""><a href="javascript:alert('준비중입니다')">코스갤러리</a></li>
		<%-- <li class=""><a href="<c:url value='/m_valley/course/courseGallery.do'/>">코스갤러리</a></li> --%>
	</ul>

	<div class="contents">
		<div class="midTitleBox">
			<span class="commonDot"> 코스공략도</span>		
		</div>
		<ul class="btnType">
			<li class=""><a href="seowon1.do">서원</a></li>
			<li class="on"><a href="valley1.do">밸리</a></li>
		</ul>
		
		<div class="courseBg">
			<div class="holeNumBox">
				<div class="holeNum">6</div>
				<ul class="holeText">
					<li class="hole1">hole</li>
					<li class="hole2">VALLEY COURSE</li>
				</ul>
				<select name="" id="" class="select-arrow2"onchange="window.open(value,'_self');">
					<option value="valley1.do">선택</option>
					<option value="valley1.do">1홀</option>
					<option value="valley2.do">2홀</option>
					<option value="valley3.do">3홀</option>
					<option value="valley4.do">4홀</option>
					<option value="valley5.do">5홀</option>
					<option value="valley6.do">6홀</option>
					<option value="valley7.do">7홀</option>
					<option value="valley8.do">8홀</option>
					<option value="valley9.do">9홀</option>
				</select>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/m_valley/course/valley6.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="100%">
						<source src="<c:url value='/video/valley/valley6(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="holeExplain"><img src="<c:url value='/images/m_valley/balloon.png'/>" alt="">&nbsp;완만한 오르막 코스로 티샷과 세컨 샷 모두 정확해야 좋은 결과를 얻을 수 있으며 욕심을 부리면 낭패를 볼 수 있습니다. 티샷은 155~180야드 지점의 벙커 왼쪽 페어웨이를 공략하되 슬라이스를 조심해야 합니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="10%">
							<col width="18%">
							<col width="18%">
							<col width="18%">
							<col width="18%">
							<col width="18%">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HDCP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td>4</td>
								<td>420</td>
								<td>383</td>
								<td>348</td>
								<td>327</td>
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