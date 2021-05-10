<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header5.jsp" />

<script type="text/javascript">

	$(document).ready(function() {
		initHeaderTab(7);
	});
	
	function big2Tab(idx) {
	  for(i=0; i<6; i++) {
	    if(i==idx) {
	      $("#b2Tab" + i).addClass("on");
	      $("#b2f_tab" + i).show();
	    } else {
	      $("#b2Tab" + i).removeClass("on");
	      $("#b2f_tab" + i).hide();
	    }
	  }
	}
</script>

<div id="wrap">
	<div id="championCon">
		<div class="chConBox" style="width:1000px; margin:0 auto; text-align:center;"> 
		<!-- 데이타 시작 -->
			<%-- <div class="b2f_movie">
			<div class="b2f_box">
				<img src="<c:url value='/images/hills/b2f_1.jpg'/>" usemap="#Map" border="0">
				<map name="Map" id="Map">
				  <area shape="rect" coords="106,1436,578,1536" href="#b2f1" />
				  <area shape="rect" coords="639,1438,1114,1536" href="#b2f2" />
				</map>
			</div>
			<div class="b2f_box1" id="b2f1">
				<div class="movie">
					<video muted="true" loop="loop" id="" controls="controls">
						<source src="<c:url value='/video/hills/b2f_191014.mp4'/>" type="video/mp4"> 
					</video>				
				</div>
			</div>
			<div class="b2f_box2" id="b2f2">
				<div class="movie">
					<video muted="true" loop="loop" id="" controls="controls">
						<source src="<c:url value='/video/hills/b2f_191014_2.mp4'/>" type="video/mp4"> 
					</video>				
				</div>
			</div>
			</div> --%>
		<!-- 데이타 종료 -->
			<img src="<c:url value='/images/hills/big2_all_top.jpg'/>">
			<div style="background-color:#fff; width:100%;">
			<div class="b2f_tab">
				<ul>
					<li id="b2Tab1" class="on" onclick="javascript:big2Tab(1)">명예의 전당</li>
					<li id="b2Tab2" onclick="javascript:big2Tab(2)">2020</li>
					<li id="b2Tab3" onclick="javascript:big2Tab(3)">2019</li>
					<li id="b2Tab4" onclick="javascript:big2Tab(4)">2018</li>
					<li id="b2Tab5" onclick="javascript:big2Tab(5)">2017</li>
				</ul>
			</div>
			</div>
			
			<div id="b2f_tab1">
				<img src="<c:url value='/images/hills/big2_all_con.jpg'/>">
			</div>
			<div id="b2f_tab2">
				<img src="<c:url value='/images/hills/big2_2020.jpg'/>">
			</div>
			<div id="b2f_tab3">
				<img src="<c:url value='/images/hills/big2_2019.jpg'/>">
			</div>
			<div id="b2f_tab4">
				<img src="<c:url value='/images/hills/big2_2018.jpg'/>">
			</div>
			<div id="b2f_tab5">
				<img src="<c:url value='/images/hills/big2_2017.jpg'/>">
			</div>
		</div>
	</div>
</div>

<jsp:include page="../include/popup/champion_pop.jsp" />
<jsp:include page="../include/footer.jsp" flush="true" />