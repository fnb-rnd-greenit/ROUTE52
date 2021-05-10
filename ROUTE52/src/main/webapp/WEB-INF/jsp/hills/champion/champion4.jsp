<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header4.jsp" />

<script type="text/javascript">
	function onClickTabs(i) {
		var isOdd = i % 2 == 1 ? true : false; // 홀수인지 판단
		idx1 = i; // 보여줄 친구 인덱스
		idx2 = isOdd ? i + 1 : i - 1; // 가릴친구 인덱스 (홀수면 + 1 , 짝수면 - 1)
	
		$("#tab" + idx1).show();
		$("#tab" + idx2).hide();
	}	
</script>
<style>
 	*:focus { outline: none; }
	.ladysWrap{ width:980px; margin:0 auto; text-align: center;}
	.ladysWrap p{ width: 980px;}
	.ladysWrap p img{vertical-align: top;}
	.ladysWrap p:nth-child(2){ background-color: #ececd4;}
	.ladysWrap p:nth-child(4){ background-color: #c9e2df;}
	.ladysWrap p:nth-child(6){ background-color: #c9e2df;}
	.ladysWrap p:nth-child(8){ background-color: #adae50;}
	.ladysWrap p:nth-child(10){ background-color: #ef9a2d;}
	.ladysWrap p:nth-child(12){ background-color: #96b9bd;}
	#tab2,#tab4,#tab6,#tab8,#tab10,#tab12{ display: none;}
	.pointer{ cursor: pointer;}
</style>

<div id="wrap">
	<div id="championCon">
		<div class="chConBox">
			<div class="ladysWrap">
				<p><img src="<c:url value='/images/hills/champion/lady/01.jpg'/>" usemap="#Map" >
				<map name="Map" id="Map">
					<area shape="rect" coords="172,519,448,602" href="/hills/champion/ladyPassport.do?action=I" />
					<area shape="rect" coords="528,523,810,604" href="/hills/champion/ladyPassport.do" />
					<area shape="rect" coords="82,809,233,892" href="#link1" />
					<area shape="rect" coords="747,809,898,892" href="#link5" />
					<area shape="rect" coords="143,1014,316,1091" href="#link2" />
					<area shape="rect" coords="176,1181,290,1260" href="#link3" />
					<area shape="rect" coords="723,1211,896,1288" href="#link4" />
					<area shape="rect" coords="491,1421,622,1496" href="#link6" />
				</map>			
				</p>
				<p id="link1">
					<img src="<c:url value='/images/hills/champion/lady/02-1.jpg'/>" onclick="onClickTabs(1)" class="pointer">
					<img src="<c:url value='/images/hills/champion/lady/02-2.jpg'/>" onclick="onClickTabs(2)" class="pointer">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/03.jpg'/>" id="tab1" usemap="#Map2">
					<map name="Map2" id="Map2">
					  <area shape="rect" coords="353,439,630,520" href="/hills/champion/ladyPassport.do?action=I" />
					</map>
					<img src="<c:url value='/images/hills/champion/lady/03_over.jpg'/>" id="tab2">
				</p>
				<p id="link2">
					<img src="<c:url value='/images/hills/champion/lady/04-1.jpg'/>" onclick="onClickTabs(3)" class="pointer">
					<img src="<c:url value='/images/hills/champion/lady/04-2.jpg'/>" onclick="onClickTabs(4)" class="pointer">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/05.jpg'/>" id="tab3">
					<img src="<c:url value='/images/hills/champion/lady/05_over.jpg'/>" id="tab4">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/06-1.jpg'/>" onclick="onClickTabs(5)" class="pointer">
					<img src="<c:url value='/images/hills/champion/lady/04-2.jpg'/>" onclick="onClickTabs(6)" class="pointer">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/07.jpg'/>" id="tab5">
					<img src="<c:url value='/images/hills/champion/lady/07_over.jpg'/>" id="tab6">
				</p>
				<p id="link3">
					<img src="<c:url value='/images/hills/champion/lady/08-1.jpg'/>" onclick="onClickTabs(7)" class="pointer">
					<img src="<c:url value='/images/hills/champion/lady/08-2.jpg'/>" onclick="onClickTabs(8)" class="pointer">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/09.jpg'/>" id="tab7">
					<img src="<c:url value='/images/hills/champion/lady/09_over.jpg'/>" id="tab8">
				</p>
				<p id="link4">
					<img src="<c:url value='/images/hills/champion/lady/10-1.jpg'/>" onclick="onClickTabs(9)" class="pointer"> 
					<img src="<c:url value='/images/hills/champion/lady/10-2.jpg'/>" onclick="onClickTabs(10)" class="pointer">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/11.jpg'/>" id="tab9">
					<img src="<c:url value='/images/hills/champion/lady/11_over.jpg'/>" id="tab10">
				</p>
				<p id="link5">
					<img src="<c:url value='/images/hills/champion/lady/12-1.jpg'/>" onclick="onClickTabs(11)" class="pointer"> 
					<img src="<c:url value='/images/hills/champion/lady/12-2.jpg'/>" onclick="onClickTabs(12)" class="pointer">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/13.jpg'/>" id="tab11">
					<img src="<c:url value='/images/hills/champion/lady/13_over.jpg'/>" id="tab12">
				</p>
				<p>
					<img src="<c:url value='/images/hills/champion/lady/14.jpg'/>">
				</p>
				<p id="link6">
					<img src="<c:url value='/images/hills/champion/lady/15.jpg'/>">
				</p>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" flush="true" />