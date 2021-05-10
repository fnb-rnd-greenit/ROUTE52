<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/valley/content.css'/>">
<div class="subImgbox">
	<div class="subImg">
		<img src="<c:url value='/images/valley/subTxt.png'/>" alt="서브 텍스트">
	</div>
</div>

<!--family_site-->
    <div id="sidebar-menu">
        <div class="fixPannel">
            <div class="pannelBtn" onclick="openNav()">
            	<h1><img src="<c:url value='/images/valley/main/arw1.jpg'/>" ></h1>
                <p><img src="<c:url value='/images/valley/main/imgPannel.jpg'/>" ></p>
                <strong>Family SITE</strong>
                <h4>서원 관련 사이트 이동</h4>
            </div>
        </div>
        <div class="sidenav_wrap">
            <div id="mySidenav" class="sidenav">
                <%-- <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"><img src="<c:url value='/images/valley/main/x.jpg'/>"></a> --%>
                <h1><a href="javascript:void(0)" class="" onclick="closeNav()"><img src="<c:url value='/images/valley/main/arw1.jpg'/>" ></a></h1>
                <strong>Family SITE</strong>
                <div class="sideList">
                    <ul>
                    	<li class="sideBn_home"><a href="<c:url value='../../'/>" target="_blank"><span>홈</span>HOME</a></li>
                        <li>
                            <div class="fmlbn">
                                <a href="<c:url value='/hills/index.do'/>" target="_blank"><img src="<c:url value='/images/valley/main/sideTitle_over.jpg'/>" class="first_bn">
                                <img src="<c:url value='/images/valley/main/sideTitle.jpg'/>" class="second_bn"></a>
                            </div>
                        </li>
                        <li>
	                        <div class="fmlbn">
	                        	<a href="http://seowonatrium.co.kr/" target="_blank"><img src="<c:url value='/images/valley/main/sideTitle1_over.jpg'/>" class="first_bn">
	                            <img src="<c:url value='/images/valley/main/sideTitle1.jpg'/>" class="second_bn"></a>
	                        </div>
	                    </li>
	                    <li>
	                      	<div class="fmlbn">
	                    	    <a href="<c:url value='/hills/academi/academi.do'/>" target="_blank"><img src="<c:url value='/images/valley/main/sideTitle2_over.jpg'/>" class="first_bn">
	                        	<img src="<c:url value='/images/valley/main/sideTitle2.jpg'/>" class="second_bn"></a>
	                        </div>
	                    </li>
                    </ul>
                </div>
            </div>
        </div>    
    </div>