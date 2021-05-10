<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.aca_overlay{display: none;position: fixed;top: 0%;left: 0%;width: 100%;height: 100%;background:#000;z-index:1004;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);}
.aca_content{display: none;position: fixed;width:545px;height:548px;background:#fff;z-index:1005;margin:0 auto; border:5px solid #ff6600; padding:15px 25px;}
.t_infoBox{ width:100%; float:left; padding:0; margin:0;}
.t_infoBox .t_infoWrap{ float:left; width:48%; padding:0; margin-right:4%;  }
.t_infoBox .t_infoWrap:last-child{ margin-right:0;}
.t_infoBox .t_infoWrap p{ width:80%; margin:0 auto;}
.t_infoBox .t_infoWrap p img{width:100%; border:1px solid #aeaeae;}
.t_infoBox .t_infoWrap h2{width:100%; color:#ff6600; font-size:16px; font-weight:700; padding: 20px 0 10px;}
.t_infoBox .t_infoWrap h3{width:100%; font-weight:500; padding-top:10px; line-height:20px; color:#939393;}
.t_infoBox .t_infoWrap div.textArea{font-size:14px; color:#939393; line-height:20px;height:100px; overflow-y:auto; border:1px solid #ddd; background-color:#f7f7f7; }

.t_infoBox .t_infoWrap1{ width:100%; text-align:center; padding:0; }
.t_infoBox .t_infoWrap1 p img{width:186px; border:1px solid #aeaeae;}
.t_infoBox .t_infoWrap1 h2{width:100%; color:#ff6600; font-size:16px; font-weight:700; padding: 20px 0 10px;}
.t_infoBox .t_infoWrap1 h3{width:100%; font-weight:500; padding-top:10px; line-height:20px; color:#939393;}
.t_infoBox .t_infoWrap1 div.textArea{font-size:14px; color:#939393; line-height:20px;height:100px; overflow-y:auto; border:1px solid #ddd; background-color:#f7f7f7; }

.t_info2{ width:100%; float:left; padding-top:5px; margin:0;}
.t_info2 h2{ padding:24px 0 8px;}
.t_info2 div.textArea{overflow-y:auto; background-color:#f7f7f7; width:100%; height:100px; font-size:14px; color:#939393; line-height:20px;border:1px solid #ddd;}
.acaClose{ position:absolute;text-align:center; right:-21px; top:-21px; cursor:pointer;}
</style>
<script>
	var currentPage;

    function aca_popupOpen(i) {
        initAcaPopup(i);
    }

    function initAcaPopup(i) {
    	currentPage = i;
    	
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#aca_popup" + i).css("width").replace("px", "")) / 2;
        var cH = Number($("#aca_popup" + i).css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#aca_popup" + i).css("left", mW);
        $("#aca_popup" + i).css("top", mH);

        $("#aca_popup" + i).css("display", "block");
        $("#aca_overlay").css("display", "block");
    }

    function aca_popupClose(i) {
        $("#aca_popup" + i).css("display", "none");
        $("#aca_overlay").css("display", "none");
    }

    function overlayPopupClose() {
        $("#aca_popup" + currentPage).css("display", "none");
        $("#aca_overlay").css("display", "none");
    }
</script>
<div id="aca_popup1" class="aca_content">
<div class="acaClose" onclick="aca_popupClose(1)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_infoBox">
		<div class="t_infoWrap">
			<p><img src="<c:url value='/images/hills/aca/t1.jpg'/>" alt=""></p>
			<h2>나병관 원장</h2>
			<div class="textArea">
			-KPGA TOUR PRO<br>
			-건국대학교 골프산업대학원 석사<br>
			(프로골퍼 양성 지도 전공)<br>
			-현 광탄 중고등학교 골프부 코치,감독<br>
			-016 KTF TOUR 5회 대회 우승<br>
			-베어리버배 KBS SKY TOUR 8회 대회우승<br>
			-대한민국 지도자 체육부문 대상<br>
			-이데일리TV, 한국경제TV, KBS N스포츠 골프해설위원<br>
			-책 ‘싱글이 되는 42법칙’ 저자	
			</div>
		</div>
		<div class="t_infoWrap">
			<p><img src="<c:url value='/images/hills/aca/t1_2.jpg'/>" alt=""></p>
			<h2>윤서호 프로</h2>
			<div class="textArea">
			-2004 KPGA TOUR PRO<br>
			-2004 KPGA KBS투어 10회대회 준우승<br>
			-2005 KPGA 베어리버 투어 4회대회 준우승<br>
			-2007~2008 SBS 코리안투어 풀시드<br>
			-2013 KPGA 챌린지 투어 1회대회 준우승<br>
			-2013 KGF 로컬투어 2회대회 준우승<br>
			-2013 KGF 상금랭킹 5위<br>
			-현 NBK 아카데미 헤드프로
			</div>
		</div>
	</div>		
	<div class="t_info2">
		<h2>NBK 아카데미 소개</h2>
		<div class="textArea">
NBK 골프아카데미는 2004년 3월에 설립되어 현재에 이르기까지 많은선수들의 역경과 도전을 함께 해 왔으며 KGA주관대회와 각종 전국대회 우승및 입상자를배출 KPGA와  KLPGA다수의 프로선수를 배출하여 아카데미 선수양성의 실력을 입증해 왔습니다.<br>
저희 NBK골프아카데미는 국내 최고수준의 숏게임장 퍼팅장 벙커연습장을 갖춘 서원밸리CC에 위치하여 부족함없는 라운딩과 훈련을 합리적가격으로 이용할 수 있어 학부모님과 프로들의 부담을 덜어드리는 한편 ,평촌우리병원과 파트너쉽 체결로 부상선수관리와 매년 평촌우리병원배 대회및 자체대회를 실시하여 장학금지급및 동기유발과 경기라는 중압감속에서 평소 스킬을 발휘 할 수 있도록 투어프로의 실전 노하우를 직접 경험하고 인근의 광탄 중ㆍ고등학교와의 협업을통해 학업을 소홀히 하지않고 학업향상을 도모하여 경쟁력있는 선수로 성장을 이끌어 왔습니다.
		</div>
	</div>
</div>
<div id="aca_popup2" class="aca_content">	
<div class="acaClose" onclick="aca_popupClose(2)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_infoBox">
		<div class="t_infoWrap">
			<p><img src="<c:url value='/images/hills/aca/t2.jpg'/>" alt=""></p>
			<h2>김광담 원장</h2>
			<div class="textArea">
			-KPGA TOUR PRO<br>
			-016 TOUR 8th 우승<br>
			-016 TOUR 9th 우승<br>
			-99년 016 TOUR 상금왕<br>
			-PGA 선수권 11위<br>
			-PGA CUP 16위	
			</div>
		</div>
		<div class="t_infoWrap">
			<p><img src="<c:url value='/images/hills/aca/t2_2.jpg'/>" alt=""></p>
			<h2>홍윤균 프로</h2>
			<div class="textArea">
			-KPGA TOUR PRO<br>
-용인대 사회체육학과 석사<br>
-용인대 사회교육원 겸임교수<br>
-2002~2004년 코리안투어 활동<br>
-동국대 골프 PGA 양성과정 책임교수
			</div>
		</div>
	</div>		
	<div class="t_info2">
		<h2>KS 아카데미</h2>
		<div class="textArea">
	안녕하세요 KS 골프아카데미 김광담 원장입니다<br> 
	저희는 철저한 프로그램과 최고의 투어프로 강사진으로 만들어진 골프 아카데미로서 아이들 성장과 미래의 꿈을 이루기 위해 부모의 마음으로 희생과 사랑으로 지도하며 타 아카데미와 차별성 도출을 위한 전략적 프로그램으로 아이들과 커뮤니케이션을 만들기 위해 최선을 다합니다.<br>
	개인별 장점은 자신감으로 끌어 올려주며 부족한 점은 체계적인 지도자의 지도와 컴퓨터스윙분석, TPI 트레이닝 및 골프 심리 트레이닝으로 구체적인 지도로 실력향상을 위해 노력합니다 골프 아카데미의 최고가 되기 위해 열정과 자부심을 가지고 노력하는 K S 골프아카데미로서 선수들이 어떠한 요구에도 부족함 없이 대응하고 질적 우월성을 기반으로 최고의 골프선수를 육성하는 KS 골프 아카데미입니다<br> 
	감사합니다
		</div>
	</div>
</div>
<div id="aca_popup3" class="aca_content">	
<div class="acaClose" onclick="aca_popupClose(3)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_infoBox">
		<div class="t_infoWrap1">
		<p><img src="<c:url value='/images/hills/aca/t3.jpg'/>" alt=""></p>
		<h2>이정희 원장</h2>
		</div>
	</div>
	<div class="t_info2">
		<div class="textArea">
		-KPGA PRO<br>
-2급 생활체육지도자(골프)<br>
-TPI LEVEL 1 FITNESS<br>
-TPI LEVEL 2 JUNIOR COACH<br>
-한국 스포츠 마사지 협회 회원<br>
-운동처방 지도자
		</div>
		<h2>PJ 아카데미</h2>
		<div class="textArea">
PJ 골프아카데미의 PJ는 <br>
“ Passion of Junior ”의 약자로 주니어의 열정이라는 뜻을 담고 있습니다.<br>
저희 아카데미는 기본기와 성실함, 그리고 골프에 대한 열정을 가장 중요하게 생각하는 곳입니다.<br> 
   PJ 골프 아카데미는 현재 서원밸리 CC내에 위치하고 있습니다. 퍼팅장과 어프로치 연습장, 샷연습을 하기에 모든 시설이 잘 갖추어진 곳입니다.<br> 
골프실력을 월등하게 끌어올리기에 더할나위 없이 좋은 환경입니다.<br>
   최고의 강팀을 만들기 위해 최선을 다하는 아카데미, 골프를 사랑하는 아카데미, 실력으로 증명해 보이는 아카데미를 찾으신다면 저희 PJ 골프아카데미가 정답입니다.
		</div>		
	</div>
</div>
<div id="aca_popup4" class="aca_content">
<div class="acaClose" onclick="aca_popupClose(4)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>	
	<div class="t_infoBox">
		<div class="t_infoWrap">
			<p><img src="<c:url value='/images/hills/aca/t4.jpg'/>" alt=""></p>
			<h2>정해심 원장</h2>
			<div class="textArea">
			-KPGA TOUR PRO<br>
-전) 제이골프 해설위원<br>
     제이골프 레슨프로그램 다수 진행<br>
-2008 스포츠 서울 골프아카데미부분 대상 수상<br>
-2014, 2016 골프다이제스트 선정 <br>
 한국 골프교습가 30인 선정<br>
-전) 스카이72 골프 아카데미 원장
			</div>
		</div>
		<div class="t_infoWrap">
			<p><img src="<c:url value='/images/hills/aca/t4_2.jpg'/>" alt=""></p>
			<h2>정준영 프로</h2>
			<div class="textArea">
			-KPGA TOUR PRO<br>
-2011년 KPGA 챌린지 투어 2 / 10회 우승<br>
-2011년 KPGA 챌린지 투어 상금왕<br>
-2012년 아시안 투어 멤버<br>
-2013년 KPGA 코리안 투어 멤버<br>
-제이골프 레슨프로그램 출연
			</div>
		</div>
	</div>
	<div class="t_info2">
		<h2>JS 아카데미</h2>
		<div class="textArea">
저희 JS 아카데미는 30년을 운영하면서 안시현, 김주미등 다수의 유명프로들을 배출한 정통 아카데미입니다.<br>
다양한 프로그램과 탄탄한 기본기를 바탕으로 골프를 위한 최상의 조건 / 최고의 강사진 / 전통 맞춤 골프 레슨 / 골프 전문 트레이닝(TPI) 등 꾸준한 레슨과 상담을 통해 여러분을 최고의 선수로 만들어 드리겠습니다.
		</div>		
	</div>
</div>
<div id="aca_popup5" class="aca_content">
<div class="acaClose" onclick="aca_popupClose(5)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>	
	<div class="t_infoBox">
		<div class="t_infoWrap1">
		<p><img src="<c:url value='/images/hills/aca/t5.jpg'/>" alt=""></p>
		<h2>이종현 원장</h2>
		</div>
	</div>
	<div class="t_info2">
		<div class="textArea">
		-KPGA TOUR PRO<br>
-건국대학교 체육교육학과 졸업<br>
-UCLA GOLF TEAM<br>
-PROFESSIONAL CAREER GOLF COLLEGE<br>
-US 2부 TOUR 활동(NIKE, BUY.COM)<br>
-12~17년 태국 라용C.C 헤드프로
		</div>
		<h2>T.F 아카데미</h2>
		<div class="textArea">
저희 Team Freddie 아카데미는 체계적인 시스템 아래 투어 프로, 프로지망생들과 화목한 분위기 속에서 운동 할 수 있는 환경이 구성되어 있습니다.<br>
만족할 수 있는 결과를 꿈꾼다면 Team Freddie로~!
		</div>
	</div>
</div>
<div id="aca_popup6" class="aca_content">
<div class="acaClose" onclick="aca_popupClose(6)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>	
	<div class="t_infoBox">
		<div class="t_infoWrap1">
		<p><img src="<c:url value='/images/hills/aca/t6.jpg'/>" alt=""></p>
		<h2>성호준 원장</h2>
		</div>
	</div>
	<div class="t_info2">
		<div class="textArea">
		-용인대학교 졸업<br>
-Shafston/Diploma of golf management<br>
-PGA Member of Australia<br>
-TPI Certified Professional<br>
-Kinetic swing certification Level I , II
		</div>
		<h2>T.P 아카데미</h2>
		<div class="textArea">
더플레이어스 골프 아카데미는 2003년 호주 브리즈번에서 시작하여 2008년 부터 현재까지 한국에서 운영 중입니다<br>
'부러운 선수가 되지 말고 존경받는 선수가 되라'는 아카데미 운영 방침을 따라 프로 골퍼로서 갖추어야 할 자질을 아마추어시절 부터 교육하고 있습니다.<br>
더플레이어스는 골프기술 뿐만 아니라 인성교육을 중요시 생각하는 골프 아카데미 입니다.
		</div>		
	</div>
</div>
<div id="aca_popup7" class="aca_content">	
<div class="acaClose" onclick="aca_popupClose(7)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>
	<div class="t_infoBox">
		<div class="t_infoWrap1">
		<p><img src="<c:url value='/images/hills/aca/t7.jpg'/>" alt=""></p>
		<h2>최천호 원장</h2>
		</div>
	</div>
	<div class="t_info2">
		<div class="textArea">
		-KPGA TOUR PRO<br>
-홍익대학교 졸업<br>
-2013년 KOREAN TOUR 시드프로<br>
-2015년 David Tam’s Academy 출신
		</div>
		<h2>KGTC 아카데미</h2>
		<div class="textArea">
*프로가 되기위한 과정에 꼭 필요한 Skill<br>
*선수가 갖춰야할 Mental and Course Management<br>
*선수 개개인의 특성에 맞춤레슨으로 훈련<br>
 KGTC Academy의 Slogan은 “될때까지” 입니다
		</div>
	</div>
</div>
<div id="aca_popup8" class="aca_content">
<div class="acaClose" onclick="aca_popupClose(8)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>	
	<div class="t_infoBox">
		<div class="t_infoWrap1">
		<p><img src="<c:url value='/images/hills/aca/t8.jpg'/>" alt=""></p>
		<h2>유은석 원장</h2>
		</div>
	</div>
	<div class="t_info2">
		<div class="textArea">
		-Murry State University 경영학 졸업<br>
-San Diego Golf Academy 졸업<br>
-Nike Junior Camp 디렉터<br>
-JR 사우스베이CC 헤드프로<br>
-2005,2006년 최우수 지도자상 수상
		</div>
		<h2>BY 아카데미</h2>
		<div class="textArea">
US PGA, KPGA 프로님이 직접 아카데미를 운영하고 모든 첨단 시스템 분석기구, 티칭도구를 이용해 부족한 스윙분석과 훈련을 시킵니다.<br> 
많은 선수들을 배출하고 최선을 다해 열심히 노력하는 학생들도 많은 저희 BY아카데미를 자랑하고자 합니다. <br>
훌륭한 선수를 수많이 배출하고 있는 저희 BY아카데미를 믿고 찾아 주시면 최선을 다해 좋은 선수를 양성하겠습니다.
		</div>		
	</div>
</div>

<div id="aca_popup9" class="aca_content">
<div class="acaClose" onclick="aca_popupClose(9)"><img src="<c:url value='/images/hills/x.png'/>" alt=""></div>	
	<div class="t_infoBox">
		<div class="t_infoWrap1">
		<p><img src="<c:url value='/images/hills/aca/t9.jpg'/>" alt=""></p>
		<h2>이단 원장</h2>
		</div>
	</div>
	<div class="t_info2">
		<div class="textArea">
		-KPGA PRO<br>
-명지대학교 미래융합 골프과정 지도교수<br>
-데이비리드베터 골프 아카데미 수료<br>
-조티엘 인터내셔널 골프스쿨 수료<br>
-05~06년 필리핀 리비에라 골프 아카데미 프로<br>
-10~13년 골프 포트 (구)빠제로골프 프로<br>
-현 서원밸리 d&b 골프 아카데미 원장
		</div>
		<h2>d&b 아카데미</h2>
		<div class="textArea">
d&b아카데미는 현 주니어 선수 및 프로들이 함께 어울려 즐기며 배우는 하나의 공간이며 누구에게나 맞는 좋은 스윙은 없다는 신념으로 작은 변화로 개개인의 최적화 스윙 및 스타일을 찾아주는 아카데미입니다
		</div>		
	</div>
</div>

<div id="aca_overlay" class="aca_overlay" onclick="overlayPopupClose()"></div>