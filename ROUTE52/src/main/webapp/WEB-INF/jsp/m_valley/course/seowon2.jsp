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
		<li class="on"><a href="<c:url value='/m_valley/course/east1.do'/>">코스공략도</a></li>
		<li class=""><a href="javascript:alert('준비중입니다')">코스갤러리</a></li>
		<%-- <li class=""><a href="<c:url value='/m_valley/course/courseGallery.do'/>">코스갤러리</a></li> --%>
	</ul>

	<div class="contents">
		<div class="midTitleBox">
			<span class="commonDot"> 코스공략도</span>		
		</div>
		<ul class="btnType">
			<li class="on"><a href="seowon1.do">서원</a></li>
			<li class=""><a href="valley1.do">밸리</a></li>
		</ul>
		
		<div class="courseBg">
			<div class="holeNumBox">
				<div class="holeNum">2</div>
				<ul class="holeText">
					<li class="hole1">hole</li>
					<li class="hole2">SEOWON COURSE</li>
				</ul>
				<select name="" id="" class="select-arrow2"onchange="window.open(value,'_self');">
					<option value="seowon1.do">선택</option>
					<option value="seowon1.do">1홀</option>
					<option value="seowon2.do">2홀</option>
					<option value="seowon3.do">3홀</option>
					<option value="seowon4.do">4홀</option>
					<option value="seowon5.do">5홀</option>
					<option value="seowon6.do">6홀</option>
					<option value="seowon7.do">7홀</option>
					<option value="seowon8.do">8홀</option>
					<option value="seowon9.do">9홀</option>
				</select>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/m_valley/course/seowon2.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="100%">
						<source src="<c:url value='/video/valley/seowon2(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="holeExplain"><img src="<c:url value='/images/m_valley/balloon.png'/>" alt="">&nbsp;확 트인 전경이 시원스러운 홀로 3개의 연못과 계곡의 폭포가 한 눈에 들어옵니다. 레귤러 티에서는 260야드 지점의 페어웨이 양쪽 벙커 사이를 겨냥해야 하며, 프론트티에서는 페어웨이 중간이 있는 280야드 개울지를<br>
					고려해야 합니다.</div>
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
								<td>5</td>
								<td>9</td>
								<td>548</td>
								<td>514</td>
								<td>471</td>
								<td>451</td>
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