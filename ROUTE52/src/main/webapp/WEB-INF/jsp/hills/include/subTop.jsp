<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/content.css'/>">
<div class="subImgbox">
	<div class="subImg">
		<img src="<c:url value='/images/hills/subTxt.png'/>" alt="">
	</div>
</div>

<!--family_site-->
    <div id="sidebar-menu">
        <div class="fixPannel">
            <div class="pannelBtn" onclick="openNav()">
            	<h1><img src="<c:url value='/images/hills/main/arw1.jpg'/>" ></h1>
                <p><img src="<c:url value='/images/hills/main/imgPannel.jpg'/>" ></p>
                <strong>Family SITE</strong>
                <h4>서원 관련 사이트 이동</h4>
            </div>
        </div>
        <div class="sidenav_wrap">
            <div id="mySidenav" class="sidenav">
                <%-- <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"><img src="<c:url value='/images/hills/main/x.jpg'/>"></a> --%>
                <h1><a href="javascript:void(0)" class="" onclick="closeNav()"><img src="<c:url value='/images/hills/main/arw1.jpg'/>" ></a></h1>
                <strong>Family SITE</strong>
                <div class="sideList">
                    <ul>
                    	<li class="sideBn_home"><a href="<c:url value='../../'/>" target="_blank"><span>홈</span>HOME</a></li>
                        <li>
                            <div class="fmlbn">
                                <a href="<c:url value='/valley/index.do'/>" target="_blank"><img src="<c:url value='/images/hills/main/sideTitle_over.jpg'/>" class="first_bn">
                                <img src="<c:url value='/images/hills/main/sideTitle.jpg'/>" class="second_bn"></a>
                            </div>
                        </li>
                        <li>
	                        <div class="fmlbn">
	                        	<a href="http://seowonatrium.co.kr/" target="_blank"><img src="<c:url value='/images/hills/main/sideTitle1_over.jpg'/>" class="first_bn">
	                            <img src="<c:url value='/images/hills/main/sideTitle1.jpg'/>" class="second_bn"></a>
	                        </div>
	                    </li>
	                    <li>
	                      	<div class="fmlbn">
	                            <a href="<c:url value='/hills/academi/academi.do'/>"><img src="<c:url value='/images/hills/main/sideTitle2_over.jpg'/>" class="first_bn">
	                            <img src="<c:url value='/images/hills/main/sideTitle2.jpg'/>" class="second_bn"></a>
	                        </div>
	                    </li>
                    </ul>
                </div>
            </div>
        </div>        
    </div>
    
    <!--제휴업체-->
    <div id="sidebar-menu1">
        <div class="fixPannel1">
            <div class="pannelBtn1" onclick="LopenNav()">
                <h2><img src="<c:url value='/images/hills/main/arw.gif'/>" ></h2>
                <p>ALLIANCE</p>
                <h4>제휴업체</h4>
            </div>
        </div>
        <div class="sidenav_wrap1">
            <div id="mySidenav1" class="sidenav1">
                <%-- <a href="javascript:void(0)" class="closebtn" onclick="LcloseNav()"><img src="<c:url value='/images/hills/main/lb_x.gif'/>"></a> --%>
                <a href="javascript:void(0)" class="closebtn1" onclick="LcloseNav()"><img src="<c:url value='/images/hills/main/arw.gif'/>" ></a>
                <div class="sideList1">
                    <strong>제휴업체</strong>
                    <hr>
                    <ul>
                        <li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance1.jpg'/>"></a></li>
                        <li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance2.jpg'/>"></a></li>
                        <li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance3.jpg'/>"></a></li>
                        <li><a href="javascript:alert('제휴종료\n준비중입니다.')"><img src="<c:url value='/images/hills/main/alliance4.jpg'/>"></a></li>
                        <%-- <li><a href="<c:url value='/hills/board/view.do?bbsType=51&idx=94'/>"><img src="<c:url value='/images/hills/main/alliance1.jpg'/>"></a></li>
                        <li><a href="<c:url value='/hills/board/view.do?bbsType=53&idx=83'/>"><img src="<c:url value='/images/hills/main/alliance2.jpg'/>"></a></li>
                        <li><a href="<c:url value='/hills/board/view.do?bbsType=54&idx=82'/>"><img src="<c:url value='/images/hills/main/alliance3.jpg'/>"></a></li>
                        <li><a href="<c:url value='/hills/board/view.do?bbsType=53&idx=84'/>"><img src="<c:url value='/images/hills/main/alliance4.jpg'/>"></a></li> --%>
                    </ul>
                </div>
            </div>
        </div>    
    </div>
    
    <!--퀵예약-->
    <div id="quickReser">
        <a href="javascript:reservePopupOpen(1)">
        <div class="fixquickReser">
        	<h1><img src="<c:url value='/images/hills/main/arw.gif'/>" ></h1>
            <p><img src="<c:url value='/images/hills/main/clock.png'/>" ></p>
            <h2>퀵예약</h2>
        </div>
        </a>
    </div>
    
     <!--추천그린피-->
    <div id="sidebar-menu3">
    <div id="recommendGP">
        <a href="javascript:reservePopupOpen2()">
        <div class="fixquickReser">
        	<h1><img src="<c:url value='/images/hills/main/arw2.jpg'/>" ></h1>
            <p><img src="<c:url value='/images/hills/main/clock1.png'/>" ></p>
            <h2>맞춤그린피</h2>
        </div>
        </a>
    </div>
    </div>