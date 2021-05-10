<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/pop_top.css'/>">  
<script>
    var MopenIdx = -1;
    
    function MpopupOpen(i) {
        MinitPopup(i);
    }

    function MinitPopup(i) {
        var fW = $(window).width() / 2;
        var fH = $(window).height() / 2;
        var cW = Number($("#topArea" + i).css("width").replace("px", "")) / 2;
        var cH = Number($("#topArea" + i).css("height").replace("px", "")) / 2;
        var mW = fW - cW;
        var mH = fH - cH;

        $("#topArea" + i).css("left", mW);
        $("#topArea" + i).css("top", mH);

        $("#topArea" + i).css("display", "block");
        $("#overlay1").css("display", "block");

		MopenIdx = i;
    }

    function MpopupClose(i) {
		if(i == 1) {
			$("#topArea" + i).css("display", "none");
			$("#overlay1").css("display", "none");
		} else {
			$("#topArea1").css("display", "none");
			$("#topArea2").css("display", "none");
			$("#overlay1").css("display", "none");
		}        
    }

    function MpopupOverlayClicked() {
		if(MopenIdx == 1) {
			$("#topArea" + i).css("display", "none");
			$("#overlay1").css("display", "none");
		} else {
			$("#topArea1").css("display", "none");
			$("#topArea2").css("display", "none");
			$("#overlay1").css("display", "none");
		} 
    }

    function MpopupBeforeStep(i) {
		$("#topArea" + i).css("display", "none");
		$("#overlay1").css("display", "none");
    }
    
    function clickTab(gubun) {
		if (gubun == "1") {
			$("#Tab1").attr("style",'display:block'); 
			$("#Tab2").attr("style",'display:none'); 
			$("#Tab3").attr("style",'display:none'); 
		} else if (gubun == "2") {
			$("#Tab1").attr("style",'display:none'); 
			$("#Tab2").attr("style",'display:block'); 
			$("#Tab3").attr("style",'display:none'); 
		} else if (gubun == "3") {
			$("#Tab1").attr("style",'display:none'); 
			$("#Tab2").attr("style",'display:none'); 
			$("#Tab3").attr("style",'display:block'); 
		}
	}
</script>

<div id="topArea1" class="searchBox1">
    <div class="choiceBox">
        <span class="title">예약종류</span>
        <span class="reserSelect">
            <select name="" id="" class="selcetBox">
                <option value="">예약전체</option>
                <option value=""></option>
            </select>
        </span>	
    </div>
    <div class="choiceBox">
        <span class="title">일자선택</span>
        <img src="<c:url value='/images/m_valley/modalcal.jpg'/>" alt="달력" class="small_cal">
        <!--미니달력시작-->
        <div class="dayInput" id="show_hideSub5"></div>				
       	<div class="SubMonthBox5">
      		<div class="monthChoice1">
                    <span class="arw"><a href=""><img src="<c:url value='/images/m_valley/arrow_l.png'/>" alt="전 달" ></a></span>
                    <span class="month">2019/2/10</span>
                    <span class="arw"><a href=""><img src="<c:url value='/images/m_valley/arrow_r.png'/>" alt="다음달"></a></span>
                 </div>

            <table class="mainCalendar1" summary="실시간 예약" cellspacing="5">
                     <caption>실시간 예약</caption>
                    <colgroup>
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                    </colgroup>
                    <tbody>
                      <tr>
                        <th scope="col" class="sun">SUN</th>
                        <th scope="col">MON</th>
                        <th scope="col">TUE</th>
                        <th scope="col">WEN</th>
                        <th scope="col">THU</th>
                        <th scope="col">FRI</th>
                        <th scope="col">SAT</th>
                      </tr>
                      <tr>
                        <td><div></div></td>
                        <td><div></div></td>
                        <td><div>1</div></td>
                        <td><div>2</div></td>
                        <td><div>3</div></td>
                        <td><div>4</div></td>
                        <td><div>5</div></td>
                      </tr>
                      <tr>
                        <td><div>6</div></td>
                        <td><div>7</div></td>
                        <td><div>8</div></td>
                        <td><div>9</div></td>
                        <td><div>10</div></td>
                        <td><div>11</div></td>
                        <td><div>12</div></td>
                      </tr>
                      <tr>
                        <td><div>13</div></td>
                        <td><div>14</div></td>
                        <td class="today possible"><div>15</div></td>
                        <td class="possible"><div>16</div></td>
                        <td class="possible"><div>17</div></td>
                        <td class="possible"><div>18</div></td>
                        <td class="possible"><div>19</div></td>
                      </tr>
                      <tr>
                        <td><div>20</div></td>
                        <td><div>21</div></td>
                        <td class="possible"><div>22</div></td>
                        <td class="possible"><div>23</div></td>
                        <td class="possible"><div>24</div></td>
                        <td class="possible"><div>25</div></td>
                        <td class="possible"><div>26</div></td>
                      </tr>
                      <tr>
                        <td class="possible"><div>27</div></td>
                        <td class="possible"><div>28</div></td>
                        <td class="possible"><div>29</div></td>
                        <td class="possible"><div>30</div></td>
                        <td class="possible"><div>31</div></td>
                        <td><div></div></td>
                        <td><div></div></td>
                      </tr>
                    </tbody>
                </table>
            
        </div><!--//미니달력 끝--> 
        <span>&nbsp; ~ &nbsp;</span>
        <img src="<c:url value='/images/m_valley/modalcal.jpg'/>" alt="달력" class="small_cal">
        <!--미니달력시작-->
        <div class="dayInput" id="show_hideSub6"></div>					
            <div class="SubMonthBox6">
                <div class="monthChoice1">
                    <span class="arw"><a href=""><img src="<c:url value='/images/m_valley/arrow_l.png'/>" alt="전 달" width="15" height="20"></a></span>
                    <span class="month">2019/2/10</span>
                    <span class="arw"><a href=""><img src="<c:url value='/images/m_valley/arrow_r.png'/>" alt="다음달" width="15" height="20"></a></span>
                  </div>

                <table class="mainCalendar1" summary="실시간 예약" cellspacing="5">
                    <caption>실시간 예약</caption>
                    <colgroup>
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="*">

                    </colgroup>
                    <tbody>
                      <tr>
                        <th scope="col" class="sun">SUN</th>
                        <th scope="col">MON</th>
                        <th scope="col">TUE</th>
                        <th scope="col">WEN</th>
                        <th scope="col">THU</th>
                        <th scope="col">FRI</th>
                        <th scope="col">SAT</th>
                      </tr>
                      <tr>
                        <td><div></div></td>
                        <td><div></div></td>
                        <td><div>1</div></td>
                        <td><div>2</div></td>
                        <td><div>3</div></td>
                        <td><div>4</div></td>
                        <td><div>5</div></td>
                      </tr>
                      <tr>
                        <td><div>6</div></td>
                        <td><div>7</div></td>
                        <td><div>8</div></td>
                        <td><div>9</div></td>
                        <td><div>10</div></td>
                        <td><div>11</div></td>
                        <td><div>12</div></td>
                      </tr>
                      <tr>
                        <td><div>13</div></td>
                        <td><div>14</div></td>
                        <td class="today possible"><div>15</div></td>
                        <td class="possible"><div>16</div></td>
                        <td class="possible"><div>17</div></td>
                        <td class="possible"><div>18</div></td>
                        <td class="possible"><div>19</div></td>
                      </tr>
                      <tr>
                        <td><div>20</div></td>
                        <td><div>21</div></td>
                        <td class="possible"><div>22</div></td>
                        <td class="possible"><div>23</div></td>
                        <td class="possible"><div>24</div></td>
                        <td class="possible"><div>25</div></td>
                        <td class="possible"><div>26</div></td>
                      </tr>
                      <tr>
                        <td class="possible"><div>27</div></td>
                        <td class="possible"><div>28</div></td>
                        <td class="possible"><div>29</div></td>
                        <td class="possible"><div>30</div></td>
                        <td class="possible"><div>31</div></td>
                        <td><div></div></td>
                        <td><div></div></td>
                      </tr>
                    </tbody>
                </table>
            </div>
        </div><!--//미니달력 끝--> 
    <div class="choiceBox">
        <span class="title">시간대&nbsp;&nbsp;&nbsp;</span>
        <span class="reserTime">
            <select name="" id="">
                <option value="">12시</option>
                <option value=""></option>
            </select>
            <select name="" id="">
                <option value="">12시</option>
                <option value=""></option>
            </select>
        </span>	
    </div>
    <!--그린피영역-->
    <div class="choiceBox">
        그린피 영역
    </div>
    <!--//그린피영역-->
    <div class="dotLine2"></div>
    <div class="btnBox2">
        <li><input type="button" class="motion1" onclick="MpopupOpen(2)" value="검 색"/> </li>
        <li><input type="button" class="cancel" onclick="javascript:MpopupClose(1)" value="취 소"  /></li>
    </div>
</div>
<div id="topArea2" class="searchBox2">
    <h2> &bull; 검색결과 &bull;</h2>
    <div class="searchWrap">
        <!--결과탭-->
        <div class="tLTab">
            <ul>
                <li class="orange" onclick="javascript:clickTab('1');">날짜별</li>
                <li class="deepGray" onclick="javascript:clickTab('2');">시간별</li>
                <li class="gray"onclick="javascript:clickTab('3');">그린피별</li>
            </ul>
        </div>
        <!--날짜별내용-->
        <div class="tLContents" id="Tab1">
            <div class="tLWrap">
                <!--리스트반복-->
                <div class="tLList">
                    <a href="">
                    <p class="day">2019.01.31(목)<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (09 : 30)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <!--//리스트반복-->
                <div class="tLList">
                    <a href="">
                    <p class="day">2019.01.31(목)<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (09 : 30)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">2019.01.31(목)<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (09 : 30)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">2019.01.31(목)<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (09 : 30)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">2019.01.31(목)<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (09 : 30)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">2019.01.31(목)<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (09 : 30)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">2019.01.31(목)<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (09 : 30)<span class="price">160,000원</span></p>
                    </a>
                </div>
            </div>
            <!--버튼-->
            <div class="btnBox3">
                <li><input type="button" class="motion1" onclick="javascript:MpopupBeforeStep(2)" value="전단계"/> </li>
                <li><input type="button" class="cancel" onclick="javascript:MpopupClose(2)" value="닫기"  /></li>
            </div>
            <!--//버튼-->
        </div>
        <!--//날짜별내용-->
        
        <!--시간별내용-->
        <div class="tLContents" id="Tab2">
            <div class="tLWrap">
                <!--리스트반복-->
                <div class="tLList">
                    <a href="">
                    <p class="day">13 : 00 ~ 18 : 00<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (19.01.31 목요일)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <!--//리스트반복-->
                <div class="tLList">
                    <a href="">
                    <p class="day">13 : 00 ~ 18 : 00<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (19.01.31 목요일)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">13 : 00 ~ 18 : 00<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (19.01.31 목요일)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">13 : 00 ~ 18 : 00<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (19.01.31 목요일)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">13 : 00 ~ 18 : 00<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (19.01.31 목요일)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <div class="tLList">
                    <a href="">
                    <p class="day">13 : 00 ~ 18 : 00<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">EAST (19.01.31 목요일)<span class="price">160,000원</span></p>
                    </a>
                </div>
            </div>
            <!--버튼-->
            <div class="btnBox3">
                <li><input type="button" class="motion1" onclick="javascript:MpopupBeforeStep(2)" value="전단계"/> </li>
                <li><input type="button" class="cancel" onclick="javascript:MpopupClose(2)" value="닫기"  /></li>
            </div>
            <!--//버튼-->
        </div>
        <!--//시간별내용-->
        
        <!--그린피별내용-->
        <div class="tLContents" id="Tab3">
            <div class="tLWrap">
                <!--리스트반복-->
                <div class="tLList">
                    <a href="">
                    <p class="day">160,000원<span class="all"><strong>37</strong>건</span></p>
                    <p class="time">19.01.31(목) EAST (09:30)<span class="price">160,000원</span></p>
                    </a>
                </div>
                <!--//리스트반복-->
                
            </div>
            <!--버튼-->
            <div class="btnBox3">
                <li><input type="button" class="motion1" onclick="javascript:MpopupBeforeStep(2)" value="전단계"/> </li>
                <li><input type="button" class="cancel" onclick="javascript:MpopupClose(2)" value="닫기"  /></li>
            </div>
            <!--//버튼-->
        </div>
        <!--//그린피별내용-->
    </div>
</div>
<div id="overlay1" class="overlay" onclick="MpopupOverlayClicked()"></div>