<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
		doSearch();
		
	    var offset = $(".myzoneTabList7").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);  
	});
</script>

<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
			<p>고객센터 &nbsp;&nbsp;&nbsp; ＞ <span>오시는길</span></p>
		</div>
	</div>


<div id="wrap">
	<div class="subTitle1">
		<span class="title1">오시는길</span>
	</div>
	
	<!--네이버지도-->
	<div class="contents" id="map1">
		<div class="mapTabList7">
			<ul>
			<li class="on"><a href="javascript:mapTab('1');">네이버맵</a></li>
			<li><a href="javascript:mapTab('2');">제1자유로 방면</a></li>
			<li><a href="javascript:mapTab('3');" >제2자유로</a></li>
			<li><a href="javascript:mapTab('4');">서울 외곽순환도로 - <br>통일로IC 진출</a></li>
			<li><a href="javascript:mapTab('5');">서울 외곽순환도로 - <br>송추IC 진출</a></li>
			<li><a href="javascript:mapTab('6');">양주시청 사거리</a></li>
			<li><a href="javascript:mapTab('7');">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
			</ul>
		</div>
		
		<div class="map_wrap">
			<div class="mapBox">
			<img src="<c:url value='/images/valley/map/map.jpg'/>">
			<a class="left_btn" href="http://naver.me/FDJ9CqHU" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 네이버지도 보기</a>
				<a class="right_btn1" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 1호선)</a>
				<a class="right_btn2" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 39호선)</a>
			</div>
		</div>
	</div>
	
	<!--제1자유로 방면-->
	<div class="contents" id="map2">
		<div class="mapTabList7">
			<ul>
			<li><a href="javascript:mapTab('1');">네이버맵</a></li>
			<li class="on"><a href="javascript:mapTab('2');">제1자유로 방면</a></li>
			<li><a href="javascript:mapTab('3');" >제2자유로</a></li>
			<li><a href="javascript:mapTab('4');">서울 외곽순환도로 - <br>통일로IC 진출</a></li>
			<li><a href="javascript:mapTab('5');">서울 외곽순환도로 - <br>송추IC 진출</a></li>
			<li><a href="javascript:mapTab('6');">양주시청 사거리</a></li>
			<li><a href="javascript:mapTab('7');">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
			</ul>
		</div>		
		
		<div class="map_wrap">
			<div class="mapBox">
				<img src="<c:url value='/images/valley/map/map1.jpg'/>">
				<a class="left_btn" href="https://map.naver.com/?sText=66y467CcSUM%3D&dtPathType=2&lng=fe39cb5d610379616a7e9c4e766224bb&mapMode=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&eType=SITE&sType=SITE&lat=cc28d00f37e34698e5b456142f884f50&dlevel=7&enc=b64&edid=11613479&elng=64fe6dc44ee80f86355471cfbeffc9f3&sdid=19309684&menu=route&eelat=b5f90b82bf48800877b746e0b2b2bf02&elat=43c90128d5b316adf8d17d3d895f0b73&pathType=0&slng=5acebb2642a94ecb8bf0f2890e531f13&eelng=dbe50211e2983da6161e6b5dfc279c7f&slat=ab95262e575b69add3cb2c7c3ba416a6" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>">실시간 빠른길 찾기</a>
				<a class="right_btn1" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 1호선)</a>
				<a class="right_btn2" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 39호선)</a>
			</div>
			<h2> &#8226; 제1자유로 방면</h2>
			<h3>1. 문발 IC진출(광탄/교하지구: 56번 도로)- 2. 광탄 IC - 3.방축교차로 우회전- 4.방축2교차로 직진(광적,양주방향) - 5. 서원밸리컨트리클럽 도착</h3>		
		</div>
	</div>
	
	
	<!--제2자유로-->
	<div class="contents" id="map3">
		<div class="mapTabList7">
			<ul>
			<li><a href="javascript:mapTab('1');">네이버맵</a></li>
			<li><a href="javascript:mapTab('2');">제1자유로 방면</a></li>
			<li class="on"><a href="javascript:mapTab('3');" >제2자유로</a></li>
			<li><a href="javascript:mapTab('4');">서울 외곽순환도로 - <br>통일로IC 진출</a></li>
			<li><a href="javascript:mapTab('5');">서울 외곽순환도로 - <br>송추IC 진출</a></li>
			<li><a href="javascript:mapTab('6');">양주시청 사거리</a></li>
			<li><a href="javascript:mapTab('7');">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
			</ul>
		</div>	
		
		<div class="map_wrap">
			<div class="mapBox">
				<img src="<c:url value='/images/valley/map/map2.jpg'/>">
				<a class="left_btn" href="https://map.naver.com/?edid=11613479&sText=7Iug7Y%2BJSUM%3D&elng=64fe6dc44ee80f86355471cfbeffc9f3&sdid=19416772&dtPathType=2&menu=route&lng=4f3daae47d9e4b540ec93d0154ac402a&eelat=b5f90b82bf48800877b746e0b2b2bf02&mapMode=0&elat=43c90128d5b316adf8d17d3d895f0b73&pathType=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&slng=f1835cc8a95ef09e88f0a24c64a9399a&eelng=dbe50211e2983da6161e6b5dfc279c7f&eType=SITE&slat=1393894b6df4e7336bd05a30df5e1015&sType=SITE_1&lat=898a556ec75bf1c48e0b5d6b77106f46&dlevel=7&enc=b64" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>">실시간 빠른길 찾기</a>
				<a class="right_btn1" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 1호선)</a>
				<a class="right_btn2" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 39호선)</a>
			</div>
			<h2> &#8226; 제2자유로</h2>
			<h3>1. 신평IC - 2. 법곳IC 우회전 - 3. 산내교차로 우회전 - 4.광탄 IC직진 - 5.방축교차로 우회전- 6.방축2교차로 직진(광적,양주방향) - 7. 서원밸리컨트리클럽 도착</h3>	
		</div>
	</div>
	
	<!--서울 외곽순환도로-통일로IC 진출-->
	<div class="contents" id="map4">
		<div class="mapTabList7">
			<ul>
			<li><a href="javascript:mapTab('1');">네이버맵</a></li>
			<li><a href="javascript:mapTab('2');">제1자유로 방면</a></li>
			<li><a href="javascript:mapTab('3');" >제2자유로</a></li>
			<li class="on"><a href="javascript:mapTab('4');">서울 외곽순환도로 - <br>통일로IC 진출</a></li>
			<li><a href="javascript:mapTab('5');">서울 외곽순환도로 - <br>송추IC 진출</a></li>
			<li><a href="javascript:mapTab('6');">양주시청 사거리</a></li>
			<li><a href="javascript:mapTab('7');">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
			</ul>
		</div>		
		
		<div class="map_wrap">
			<div class="mapBox">
				<img src="<c:url value='/images/valley/map/map3.jpg'/>">
				<a class="left_btn" href="https://map.naver.com/?sText=7Ya17J2866GcSUM%3D&dtPathType=2&lng=3439d3649d8872c322d68beecca2266b&mapMode=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&eType=SITE&sType=SITE&lat=427ba54f9343fb042bfee916860fdcc9&dlevel=7&enc=b64&edid=11613479&elng=937a0ebb5a2abd167814d083cfb914c9&sdid=19039403&eslng=15057a114a94bd61f062f647bf034172&menu=route&eelat=b5f90b82bf48800877b746e0b2b2bf02&elat=b212d2f9bf916d84b2d2598a85191e5d&pathType=0&slng=30a715543bc7172d1d5929884e67755f&eelng=dbe50211e2983da6161e6b5dfc279c7f&slat=aa6c02d57be854e71f5baeb2e2927508&eslat=802aaf772ac6921a856c01a40af0c985" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>">실시간 빠른길 찾기</a>
				<a class="right_btn1" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 1호선)</a>
				<a class="right_btn2" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 39호선)</a>
			</div>
			<h2> &#8226; 서울 외곽순환도로-통일로IC 진출</h2>
			<h3>1. 대자사거리(의정부/고양동:39번)우회전- 2. 고양동 신삼거리(푸른마을,GS주유소 삼거리에서 광탄 보광사)좌회전-3. 농원가든 삼거리(광탄/보광사/국군벽제병원)우회전 - 4. 벽제 삼거리(광탄/용미리묘지)좌회전- 5. 혜음령터널 직진- 6. 발랑리, 마장리방면 우회전- 7. 창만 사거리 직진-8.서원밸리컨트리클럽 도착</h3>
		</div>
	</div>
	
	<!--송추IC-->
	<div class="contents" id="map5">
		<div class="mapTabList7">
			<ul>
			<li><a href="javascript:mapTab('1');">네이버맵</a></li>
			<li><a href="javascript:mapTab('2');">제1자유로 방면</a></li>
			<li><a href="javascript:mapTab('3');" >제2자유로</a></li>
			<li><a href="javascript:mapTab('4');">서울 외곽순환도로 - <br>통일로IC 진출</a></li>
			<li class="on"><a href="javascript:mapTab('5');">서울 외곽순환도로 - <br>송추IC 진출</a></li>
			<li><a href="javascript:mapTab('6');">양주시청 사거리</a></li>
			<li><a href="javascript:mapTab('7');">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
			</ul>
		</div>	
		
		<div class="map_wrap">
			<div class="mapBox">
				<img src="<c:url value='/images/valley/map/map4.jpg'/>">
				<a class="left_btn" href="https://map.naver.com/?sText=7Iah7LaUSUM%3D&dtPathType=2&lng=ffae0607bbd709d543e7a7911e6f0828&mapMode=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&eType=SITE&sType=SITE&lat=f1168d8625f63e6075b51c62b4cd2566&dlevel=7&enc=b64&edid=11613479&elng=64fe6dc44ee80f86355471cfbeffc9f3&sdid=18313047&eslng=89023a68a00db41084a42eb11bb18c11&menu=route&eelat=b5f90b82bf48800877b746e0b2b2bf02&elat=43c90128d5b316adf8d17d3d895f0b73&pathType=0&slng=92a6f2a44ac6f19eef2a9a6b84a1bd0e&eelng=dbe50211e2983da6161e6b5dfc279c7f&slat=d05bee1b0e0f651874839f0fa70ebb36&eslat=57f1eaf1f09dbea8f0ecb9fe0b7a10c3" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>">실시간 빠른길 찾기</a>
				<a class="right_btn1" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 1호선)</a>
				<a class="right_btn2" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 39호선)</a>
			</div>
			<h2> &#8226; 서울 외곽순환도로-송추IC 진출</h2>
			<h3>1. 송추IC(39번 국도 만나는 삼거리에서 일산,인천방향)좌회전 -2. 고양동 신삼거리(푸른마을, GS주유소 삼거리에서 광탄 보광사)우회전 -3. 농원가든 삼거리(광탄/보광사/국군벽제병원)우회전 - 4. 벽제 삼거리(광탄/용미리묘지)좌회전- 5. 혜음령터널 직진- 6. 발랑리, 마장리방면 우회전- 7. 창만 사거리 직진-8.서원밸리컨트리클럽 도착</h3>
		</div>
	</div>
	
	<!--양주시청사거리-->
	<div class="contents" id="map6">
		<div class="mapTabList7">
			<ul>
			<li><a href="javascript:mapTab('1');">네이버맵</a></li>
			<li><a href="javascript:mapTab('2');">제1자유로 방면</a></li>
			<li><a href="javascript:mapTab('3');" >제2자유로</a></li>
			<li><a href="javascript:mapTab('4');">서울 외곽순환도로 - <br>통일로IC 진출</a></li>
			<li><a href="javascript:mapTab('5');">서울 외곽순환도로 - <br>송추IC 진출</a></li>
			<li class="on"><a href="javascript:mapTab('6');">양주시청 사거리</a></li>
			<li><a href="javascript:mapTab('7');">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
			</ul>
		</div>	
		
		<div class="map_wrap">
			<div class="mapBox">
				<img src="<c:url value='/images/valley/map/map5.jpg'/>">
				<a class="left_btn" href="https://map.naver.com/?sText=7JaR7KO87Iuc7LKt7IKs6rGw66as&dtPathType=2&lng=777b045fd369f59439612d18439b8eee&mapMode=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&eType=SITE&sType=SITE&lat=844a49f913c9570bcfa7b01486c95484&dlevel=8&enc=b64&edid=11613479&elng=64fe6dc44ee80f86355471cfbeffc9f3&sdid=18294339&menu=route&eelat=b5f90b82bf48800877b746e0b2b2bf02&elat=43c90128d5b316adf8d17d3d895f0b73&pathType=0&slng=dcffbd9edb1cf17fe6e65a6a7c00efdf&eelng=dbe50211e2983da6161e6b5dfc279c7f&slat=59b12a4fb50736b5a27cbefbed79d11c" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>">실시간 빠른길 찾기</a>
				<a class="right_btn1" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 1호선)</a>
				<a class="right_btn2" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 39호선)</a>
			</div>
			<h2> &#8226; 양주시청 사거리</h2>
			<h3>1.양주시청 사거리(법원리/백석/광적방향:360번)좌회전 - 2.막은골 삼거리(법원리/백석/광적)직진- 3.오산 삼거리(법원리/광전:360번)우회전 -4. 백석 삼거리(파주/광적:360번 직진) - 5. 가납사거리(파주/장흥:360번)좌회전 - 6. 대성빌라 사거리(파주/연곡리 2시방향도로: 360번)직진 - 7. 석천가든 앞 삼거리(파주/비암리:360번)직진-8.서원밸리컨트리클럽 도착</h3>	
		</div>
	</div>
	
	<!--구리-포천간 고속도로(강동구,잠실,광진구)-->
	<div class="contents" id="map7">
		<div class="mapTabList7">
			<ul>
			<li><a href="javascript:mapTab('1');">네이버맵</a></li>
			<li><a href="javascript:mapTab('2');">제1자유로 방면</a></li>
			<li><a href="javascript:mapTab('3');" >제2자유로</a></li>
			<li><a href="javascript:mapTab('4');">서울 외곽순환도로 - <br>통일로IC 진출</a></li>
			<li><a href="javascript:mapTab('5');">서울 외곽순환도로 - <br>송추IC 진출</a></li>
			<li><a href="javascript:mapTab('6');">양주시청 사거리</a></li>
			<li class="on"><a href="javascript:mapTab('7');">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
			</ul>
		</div>		
		
		<div class="map_wrap">
			<div class="mapBox">
				<img src="<c:url value='/images/valley/map/map6.jpg'/>">
				<a class="left_btn" href="https://map.naver.com/?edid=20340126&sText=66%2B86529SUM%3D&elng=1d94082ce209e34b3acbbac37aaf6a7c&sdid=967986235&eslng=fe69b1889836c87b458399ea00fdb9ac&dtPathType=2&menu=route&lng=68e0fa143d95a627b75a6e9f93629909&mapMode=0&elat=3c912e7a5c55e0b03c32657b49ea87d4&pathType=0&eText=7ISc7JuQ7Z6Q7IqkQ0M%3D&slng=fa42f6aa3f48ac0a81ceb1635c7441da&eType=SITE_1&slat=9b526e196874e576c86c6a861431db38&sType=SITE_1&eslat=f0d19bc579ba9a93e19c854eee3c2e05&lat=64d6ad68493ad3f4f5cf961480258e9f&dlevel=6&enc=b64" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>">실시간 빠른길 찾기</a>
				<a class="right_btn1" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 1호선)</a>
				<a class="right_btn2" href="http://m.its.go.kr/nticMap2" target="_blank"><img src="<c:url value='/images/valley/map/arwBox.png'/>"> 실시간교통정보(국도 39호선)</a>
			</div>
			<h2> &#8226; 구리-포천간 고속도로(강동구,잠실,광진구)</h2>
			<h3> 1. 민락IC - 2. 민락교차로- 3. 광사교차로- 4.양주시청 사거리(법원리/백석/광적방향:360번)좌회전 - 5.막은골 삼거리(법원리/백석/광적)직진- 6.오산 삼거리(법원리/광전:360번)우회전 -7. 백석 삼거리(파주/광적:360번 직진) - 8. 가납사거리(파주/장흥:360번)좌회전 - 9. 대성빌라 사거리(파주/연곡리 2시방향도로: 360번)직진 - 10. 석천가든 앞 삼거리(파주/비암리:360번)직진-
11. 서원밸리컨트리클럽 도착</h3>	
		</div>
	</div>
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />