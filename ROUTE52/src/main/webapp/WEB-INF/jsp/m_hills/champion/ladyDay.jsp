<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<script type="text/javascript">
	function onClickTabs(i) {
		var isOdd = i % 2 == 1 ? true : false; // 홀수인지 판단
		idx1 = i; // 보여줄 친구 인덱스
		idx2 = isOdd ? i + 1 : i - 1; // 가릴친구 인덱스 (홀수면 + 1 , 짝수면 - 1)
	
		$("#tab" + idx1).show();
		$("#tab" + idx2).hide();
	}	
</script>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<style>
 	*:focus { outline: none; }
	.ladysWrap{ width:100%; text-align: center; position:relative;}
	.ladysWrap p{ max-width:500px; margin:0 auto;}
	.ladysWrap p img{vertical-align: top;max-width:100%;}
	.ladysWrap h2{max-width:500px; margin: 0 auto;}
	.ladysWrap h2:nth-child(2){ background-color: #ececd4;}
	.ladysWrap h2:nth-child(4){ background-color: #c9e2df;}
	.ladysWrap h2:nth-child(6){ background-color: #c9e2df;}
	.ladysWrap h2:nth-child(8){ background-color: #adae50;}
	.ladysWrap h2:nth-child(10){ background-color: #ef9a2d;}
	.ladysWrap h2:nth-child(12){ background-color: #96b9bd;}
	#tab2,#tab4,#tab6,#tab8,#tab10,#tab12{ display: none;}
	.ladysWrap h2 div{ min-width: 320px; max-width:500px; margin:0 auto; text-align:center;}
	.ladysWrap h2 div li{ display: inline-block;}
	.ladysWrap h2 div li:first-child img{ max-width:260px;}
	.ladysWrap h2 div li:last-child img{ max-width:35px;}
	.ladysWrap .topImageWrap{max-width:500px;margin:0 auto; text-align:center;}
	.ladysWrap .topImageWrap h3 img{ width:100%;}
	.ladysWrap .topImageWrap h4 { width:50%; float:left; overflow:hidden;}
	.ladysWrap .topImageWrap h4 img{ width:100%;}
	.pointer{ cursor: pointer;}
	.ladytopBtn{ position: fixed;bottom:150px;right:10px;}
</style>

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> Lady's Day <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<div class="viewBox bgBottom">
			<div class="ladysWrap">
				<div class="topImageWrap">
					<h3><img src="<c:url value='/images/m_hills/lady/00.jpg'/>"></h3>
					<h4><a href="/m_hills/champion/loginchamPop2.do"><img src="<c:url value='/images/m_hills/lady/00-1.jpg'/>"></a></h4>
					<h4><a href="/hills/champion/ladyPassport.do"><img src="<c:url value='/images/m_hills/lady/00-2.jpg'/>"></a></h4>
					<h3><img src="<c:url value='/images/m_hills/lady/01.jpg'/>"></h3>
					<h4><a href="#link1"><img src="<c:url value='/images/m_hills/lady/01-1.jpg'/>"></a></h4>
					<h4><a href="#link5"><img src="<c:url value='/images/m_hills/lady/01-2.jpg'/>"></a></h4>
					<h3><img src="<c:url value='/images/m_hills/lady/01-3.jpg'/>"></h3>
					<h4><a href="#link2"><img src="<c:url value='/images/m_hills/lady/01-4.jpg'/>"></a></h4>
					<h4><img src="<c:url value='/images/m_hills/lady/01-5.jpg'/>"></h4>
					<h3><img src="<c:url value='/images/m_hills/lady/01-6.jpg'/>"></h3>
					<h4><a href="#link3"><img src="<c:url value='/images/m_hills/lady/01-7.jpg'/>"></a></h4>
					<h4><a href="#link4"><img src="<c:url value='/images/m_hills/lady/01-8.jpg'/>"></a></h4>
					<h3><img src="<c:url value='/images/m_hills/lady/01-9.jpg'/>"></h3>
					<h4><img src="<c:url value='/images/m_hills/lady/01-10.jpg'/>"></h4>
					<h4><a href="#link6"><img src="<c:url value='/images/m_hills/lady/01-11.jpg'/>"></a></h4>
					<h3><img src="<c:url value='/images/m_hills/lady/01-12.jpg'/>"></h3>
				</div>
				<h2 id="link1">
					<div>
						<ul>
							<li><img src="<c:url value='/images/m_hills/lady/02-1.jpg'/>" onclick="onClickTabs(1)" class="pointer"></li>
							<li><img src="<c:url value='/images/m_hills/lady/02-2.jpg'/>" onclick="onClickTabs(2)" class="pointer"></li>
						</ul>
					</div>
				</h2>
				<p>
					<img src="<c:url value='/images/m_hills/lady/03.jpg'/>" id="tab1">
					<img src="<c:url value='/images/m_hills/lady/03_over.jpg'/>" id="tab2">
					<a href="/m_hills/champion/loginchamPop2.do"><img src="<c:url value='/images/m_hills/lady/03_1.jpg'/>"></a>
				</p>
				<h2 id="link2">
					<div>
						<ul>
							<li><img src="<c:url value='/images/m_hills/lady/04-1.jpg'/>" onclick="onClickTabs(3)" class="pointer"></li>
							<li><img src="<c:url value='/images/m_hills/lady/04-2.jpg'/>" onclick="onClickTabs(4)" class="pointer"></li>
						</ul>
					</div>
				</h2>
				<p>
					<img src="<c:url value='/images/m_hills/lady/05.jpg'/>" id="tab3">
					<img src="<c:url value='/images/m_hills/lady/05_over.jpg'/>" id="tab4">
				</p>
				<h2>
					<div>
						<ul>
							<li><img src="<c:url value='/images/m_hills/lady/06-1.jpg'/>" onclick="onClickTabs(5)" class="pointer"></li>
							<li><img src="<c:url value='/images/m_hills/lady/04-2.jpg'/>" onclick="onClickTabs(6)" class="pointer"></li>
						</ul>
					</div>
				</h2>
				<p>
					<img src="<c:url value='/images/m_hills/lady/07.jpg'/>" id="tab5">
					<img src="<c:url value='/images/m_hills/lady/07_over.jpg'/>" id="tab6">
				</p>
				<h2 id="link3">
					<div>
						<ul>
							<li><img src="<c:url value='/images/m_hills/lady/08-1.jpg'/>" onclick="onClickTabs(7)" class="pointer"></li>
							<li><img src="<c:url value='/images/m_hills/lady/08-2.jpg'/>" onclick="onClickTabs(8)" class="pointer"></li>
						</ul>
					</div>
				</h2>
				<p>
					<img src="<c:url value='/images/m_hills/lady/09.jpg'/>" id="tab7">
					<img src="<c:url value='/images/m_hills/lady/09_over.jpg'/>" id="tab8">
				</p>
				<h2 id="link4">
					<div>
						<ul>
							<li><img src="<c:url value='/images/m_hills/lady/10-1.jpg'/>" onclick="onClickTabs(9)" class="pointer"></li> 
							<li><img src="<c:url value='/images/m_hills/lady/10-2.jpg'/>" onclick="onClickTabs(10)" class="pointer"></li>
						</ul>
					</div>
				</h2>
				<p>
					<img src="<c:url value='/images/m_hills/lady/11.jpg'/>" id="tab9">
					<img src="<c:url value='/images/m_hills/lady/11_over.jpg'/>" id="tab10">
				</p>
				<h2 id="link5">
					<div>
						<ul>
							<li><img src="<c:url value='/images/m_hills/lady/12-1.jpg'/>" onclick="onClickTabs(11)" class="pointer"></li> 
							<li><img src="<c:url value='/images/m_hills/lady/12-2.jpg'/>" onclick="onClickTabs(12)" class="pointer"></li>
						</ul>
					</div>
				</h2>
				<p>
					<img src="<c:url value='/images/m_hills/lady/13.jpg'/>" id="tab11">
					<img src="<c:url value='/images/m_hills/lady/13_over.jpg'/>" id="tab12">
				</p>
				<p>
					<img src="<c:url value='/images/m_hills/lady/14.jpg'/>">
				</p>
				<p id="link6">
					<img src="<c:url value='/images/m_hills/lady/15.jpg'/>">
				</p>
			</div>
			
			<div class="ladytopBtn"><a href="#"><img src="<c:url value='/images/m_hills/top_up.png'/>"></a></div>
			
			<div class="btnBox3">
				<ul>
		       		<li><input type="button" class="motion" onclick="location.href='/m_hills/champion/loginchamPop2.do'" value="참가신청"></li>
		        </ul>
		    </div>		
		</div>
		
	</div><!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>