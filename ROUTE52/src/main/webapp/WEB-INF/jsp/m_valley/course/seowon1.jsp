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
				<div class="holeNum">1</div>
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

			<div class="courseImg"><img src="<c:url value='/images/m_valley/course/seowon1.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video muted="true" loop="loop" id="bgvid" controls="controls" width="100%">
						<source src="<c:url value='/video/valley/seowon1(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="holeExplain"><img src="<c:url value='/images/m_valley/balloon.png'/>" alt="">&nbsp;왼쪽 산자락의 화려한 관목과 그린 오른쪽의 연못이 한 눈에 내려다 보이는 홀로훅과 슬라이스가 모두 염려되는 홀입니다. 티샷지점으로부터 210~250야드 거리의 페어웨이 오른쪽에 벙커가 있고 OB지역과 근접해 있으므로 왼쪽을 공략합니다. 세컨 샷은 그린 우측의 해저드를 주의해야 합니다. </div>
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
								<td>15</td>
								<td>390</td>
								<td>362</td>
								<td>307</td>
								<td>284</td>
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