<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../include/ct_header5.jsp" />

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
.chamTxtBox{ font-size:14px; line-height:22px; border-radius:8px; border:1px solid #ddd; background-color:#f8f8f8; padding:20px; }
</style>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">대회소개</span>
			<span class="titleDes"></span>
		</div>
			<div class="chamTxtBox">
			 제4회 서원·클럽디 레이디스 골프 챔피언십은 총 시상규모 4억원 상당의 골프장에서 주관·주최하는 전국 최대 규모의 여성골프대회입니다.<br> 이번 대회는 지난 대회를 거쳐오면서 부족했던 점들을 더욱 보완하여, 대회를 더욱 품격있게 격상시키기 위해 만반의 준비를 하고 있습니다.<br> 
	여성 골퍼분들의 도전을 기다리고 있으니 많은 관심 부탁드립니다.			
			</div>
		
		<div class="subTitle subBottom">
			<span class="title">지난 대회스케치</span>
			<span class="titleDes"></span>
		</div>
		<div class="listBox">
			<div class="findBox">
				<select name="" id="searchOption" class="select-arrow">
					<option value="">전체</option>
					<option value="1">제목</option>
					<option value="2">내용</option>
					<option value="3">작성자</option>
				</select>
				<input type="text" class="findTxt" id="searchText">
				<a href="javascript:doSearch()" class="orangeBtn">검색</a>
			</div>

			<div class="galleryListBox" id="gBody"><div class="galleryBox fadeBox fadeInUp" style="visibility: visible; animation-name: fadeInUp;">                          <div class="gallBoxCont">                                          <a href="javascript:onClickRow(0)" class="galImg"><img src="/common/downloadImage.do?division=hills&amp;folderName=20190430&amp;fileName=1556597920138.jpg" alt=""></a>        <a href="javascript:onClickRow(0)"> 										               <div class="gallery">							                   <div class="gallTitle">제2회여성아마추어대회                                     <span class="orangeRed"></span>                             </div>                                                         <p class="gallDate">2019.04.30</p>                                    <span class="gallBtn">자세히보기</span>                       </div>                                                     </a>                                                       </div>                                                     </div>                                                         <div class="galleryBox fadeBox fadeInUp" style="visibility: visible; animation-name: fadeInUp;">                          <div class="gallBoxCont">                                          <a href="javascript:onClickRow(1)" class="galImg"><img src="/common/downloadImage.do?division=hills&amp;folderName=20190430&amp;fileName=1556597893919.jpg" alt=""></a>        <a href="javascript:onClickRow(1)"> 										               <div class="gallery">							                   <div class="gallTitle">제1회여성아마추어대회                                     <span class="orangeRed"></span>                             </div>                                                         <p class="gallDate">2019.04.30</p>                                    <span class="gallBtn">자세히보기</span>                       </div>                                                     </a>                                                       </div>                                                     </div>                                                         </div>
		</div>	
						
		<div class="paging" id="paging"><ul><li class="on" onclick="doSearchPaging(1)">1</li></ul></div>		
		
		
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer.jsp" flush="true" />