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
			<li class=""><a href="west1.do">웨스트</a></li>
			<li class="on"><a href="south1.do">사우스</a></li>
		</ul>
		
		<div class="courseBg">
			<div class="holeNumBox">
				<div class="holeNum">4</div>
				<ul class="holeText">
					<li class="hole1">hole</li>
					<li class="hole2">SOUTH COURSE</li>
				</ul>
				<select name="" id="" class="select-arrow2"onchange="window.open(value,'_self');">
					<option value="south1.do">선택</option>
					<option value="south1.do">1홀</option>
					<option value="south2.do">2홀</option>
					<option value="south3.do">3홀</option>
					<option value="south4.do">4홀</option>
					<option value="south5.do">5홀</option>
					<option value="south6.do">6홀</option>
					<option value="south7.do">7홀</option>
					<option value="south8.do">8홀</option>
					<option value="south9.do">9홀</option>
				</select>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/m_hills/course/south4.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="100%">
						<source src="<c:url value='/video/hills/south_4.mp4'/>" type="video/mp4">  
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="holeExplain"><img src="<c:url value='/images/m_hills/balloon.png'/>" alt="">&nbsp;그린 앞 벙커 방향으로 티샷 한다면 무난하게 IP 지점까지 도달 할 것이다.
					페어웨이 좌측으로 공간이 넓기 때문에 편안하게 티샷을 한다면 좋은 스코어를 얻을 수 있을것이다.</div>
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
								<th><img src="../images/balloon.png" alt="">&nbsp;</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td></td>
								<td>394</td>
								<td>370</td>
								<td>316</td>
								<td>264</td>
								<td>264</td>
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