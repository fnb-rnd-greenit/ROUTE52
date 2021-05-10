<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script type="text/javascript">

	var mWeek;
	var mDay;
	var mTime;
	var mGpNum;

	$(document).ready(function() {
		init();
	});     
	
	function init() {
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId == "") {
			alert("로그인 후 이용 가능합니다.");
			location.href = "<c:url value='/hills/member/login.do'/>";	
		}
		
	    var offset = $(".myzoneTabList5").offset();  
	    $('html, body').animate({scrollTop : offset.top}, 400);
	    
	    $("#txtManNum, #txtWomanNum").on("change keyup paste", function() {
	    	var man = Number($("#txtManNum").val());
	    	var woman = Number($("#txtWomanNum").val());
	    	man = man == "" ? 0 : man;
	    	woman = woman == "" ? 0 : woman;
	    	$("#txtTotalPersonNum").val(man + woman);
	    });
	    
	    $("#chkEtc").on("change", function() {
	    	if($("input:checkbox[id='chkEtc']").is(":checked")) {
	    		$("#txtEtcRemark").removeClass("yearBg");
	    		$("#txtEtcRemark").attr("readonly", false);
	    	} else {
	    		$("#txtEtcRemark").addClass("yearBg");
	    		$("#txtEtcRemark").attr("readonly", true);
	    		$("#txtEtcRemark").val("");
	    	}
	    });
	    
	    getTimeCode();
	}
	
	function getTimeCode() {
		sUrl = "<c:url value='/common/getTimeCode.do'/>";
		sParams = "";

		sParams += String.format("&coDiv={0}", "65");
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				mWeek = data.rows.week;
				mDay = data.rows.day;
				mTime = data.rows.time;	
				
				$("#selHopeWeek1").append("<option value=''>선택</option>");
				$("#selHopeWeek2").append("<option value=''>선택</option>");
				$("#selHopeDayOfWeek1").append("<option value=''>선택</option>");
				$("#selHopeDayOfWeek2").append("<option value=''>선택</option>");
				$("#selHopeTime1").append("<option value=''>선택</option>");
				$("#selHopeTime2").append("<option value=''>선택</option>");
				
				for(i=0; i<mWeek.length; i++) {
					$("#selHopeWeek1").append("<option value='" + mWeek[i].CD_CODE + "'>" + mWeek[i].CD_TITLE1 + "</option>");
					$("#selHopeWeek2").append("<option value='" + mWeek[i].CD_CODE + "'>" + mWeek[i].CD_TITLE1 + "</option>");
				}
				for(i=0; i<mDay.length; i++) {
					$("#selHopeDayOfWeek1").append("<option value='" + mDay[i].CD_CODE + "'>" + mDay[i].CD_TITLE1 + "</option>");
					$("#selHopeDayOfWeek2").append("<option value='" + mDay[i].CD_CODE + "'>" + mDay[i].CD_TITLE1 + "</option>");
				}
				for(i=0; i<mTime.length; i++) {
					$("#selHopeTime1").append("<option value='" + mTime[i].CD_CODE + "'>" + mTime[i].CD_TITLE1 + "</option>");
					$("#selHopeTime2").append("<option value='" + mTime[i].CD_CODE + "'>" + mTime[i].CD_TITLE1 + "</option>");
				}
				
				$("#selHopeWeek1").on("change", function() {
					for(i=0; i<mWeek.length; i++) {
						if(mWeek[i].CD_CODE == $(this).val()) {
							if(mWeek[i].CD_TYPE == "Y") {
								alert(mWeek[i].CD_TITLE3);
								$(this).val("");
							}							
						}
					}
				});				
				$("#selHopeWeek2").on("change", function() {
					for(i=0; i<mWeek.length; i++) {
						if(mWeek[i].CD_CODE == $(this).val()) {
							if(mWeek[i].CD_TYPE == "Y") {
								alert(mWeek[i].CD_TITLE3);
								$(this).val("");
							}							
						}
					}
				});		
				$("#selHopeDayOfWeek1").on("change", function() {
					for(i=0; i<mDay.length; i++) {
						if(mDay[i].CD_CODE == $(this).val()) {
							if(mDay[i].CD_TYPE == "Y") {
								alert(mDay[i].CD_TITLE3);
								$(this).val("");
							}							
						}
					}
				});
				$("#selHopeDayOfWeek2").on("change", function() {
					for(i=0; i<mDay.length; i++) {
						if(mDay[i].CD_CODE == $(this).val()) {
							if(mDay[i].CD_TYPE == "Y") {
								alert(mDay[i].CD_TITLE3);
								$(this).val("");
							}							
						}
					}
				});
				$("#selHopeTime1").on("change", function() {
					for(i=0; i<mTime.length; i++) {
						if(mTime[i].CD_CODE == $(this).val()) {
							if(mTime[i].CD_TYPE == "Y") {
								alert(mTime[i].CD_TITLE3);
								$(this).val("");
							}							
						}
					}
				});
				$("#selHopeTime2").on("change", function() {
					for(i=0; i<mTime.length; i++) {
						if(mTime[i].CD_CODE == $(this).val()) {
							if(mTime[i].CD_TYPE == "Y") {
								alert(mTime[i].CD_TITLE3);
								$(this).val("");
							}							
						}
					}
				});
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function daumPostcode(selectorZip, selectorAddr) {
        new daum.Postcode({
            oncomplete: function(data) {
                var fullRoadAddr = data.roadAddress;
                var extraRoadAddr = '';
                
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }

                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }

                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

				$(selectorZip).val(data.zonecode);
                $(selectorAddr).val(fullRoadAddr);
            }
        }).open();
    }
	
	function doSave() {
		var sUrl = "<c:url value='/common/doSaveYearTeam.do'/>";
		var sParams = "";
		
		var agree = $(":input:radio[name=chkAgree]:checked").val();
		if(agree == null || agree != "Y") {
			alert("연단체 이용 약관을 확인 후 다시 시도해 주십시오.");
			return;
		}
		
		var agree1 = $(":input:radio[name=chkAgree1]:checked").val();
		if(agree1 == null || agree1 != "Y") {
			alert("개인정보 수집 및 이용약관에 동의 후 진행 부탁드립니다.");
			return;
		}
		
		sParams = String.format("&coDiv={0}", globals.coDiv.hills);
		var txtTeamName = $("#txtTeamName").val();
		if(txtTeamName == "") {
			alert("단체명을 입력해주세요.");
			return;
		}
		if(txtTeamName != null && txtTeamName != "") sParams += String.format("&txtTeamName={0}", txtTeamName);
		var txtRecommendName = $("#txtRecommendName").val();
		if(txtRecommendName != null && txtRecommendName != "") sParams += String.format("&txtRecommendName={0}", txtRecommendName);
		var txtUnitPrice = $("#txtUnitPrice").val();
		if(txtUnitPrice == "") {
			alert("예상객단가를 입력해주세요.");
			return;
		}
		if(txtUnitPrice != null && txtUnitPrice != "") sParams += String.format("&txtUnitPrice={0}", txtUnitPrice);
		var txtManNum = $("#txtManNum").val();
		if(txtManNum == "") {
			alert("회원수(남)를 입력해주세요.");
			return;
		}
		if(txtManNum != null && txtManNum != "") sParams += String.format("&txtManNum={0}", txtManNum);
		var txtWomanNum = $("#txtWomanNum").val();
		if(txtWomanNum == "") {
			alert("회원수(여)를 입력해주세요.");
			return;
		}
		if(txtWomanNum != null && txtWomanNum != "") sParams += String.format("&txtWomanNum={0}", txtWomanNum);
		var txtTeamNum = $("#txtTeamNum").val();
		if(txtTeamNum == "") {
			alert("팀수를 입력해주세요.");
			return;
		}
		if(txtTeamNum != null && txtTeamNum != "") sParams += String.format("&txtTeamNum={0}", txtTeamNum);
		var chkNewYn = $("input:radio[name='chkNewYn']:checked").val();     
		if(chkNewYn != null && chkNewYn != "") sParams += String.format("&chkNewYn={0}", chkNewYn);
		var selHopeWeek1 = $("#selHopeWeek1").val();
		if(selHopeWeek1 != null && selHopeWeek1 != "") sParams += String.format("&selHopeWeek1={0}", selHopeWeek1);
		var selHopeDayOfWeek1 = $("#selHopeDayOfWeek1").val();
		if(selHopeDayOfWeek1 != null && selHopeDayOfWeek1 != "") sParams += String.format("&selHopeDayOfWeek1={0}", selHopeDayOfWeek1);
		var selHopeTime1 = $("#selHopeTime1").val();
		if(selHopeTime1 != null && selHopeTime1 != "") sParams += String.format("&selHopeTime1={0}", selHopeTime1);
		var selHopeWeek2 = $("#selHopeWeek2").val();
		if(selHopeWeek2 != null && selHopeWeek2 != "") sParams += String.format("&selHopeWeek2={0}", selHopeWeek2);
		var selHopeDayOfWeek2 = $("#selHopeDayOfWeek2").val();
		if(selHopeDayOfWeek2 != null && selHopeDayOfWeek2 != "") sParams += String.format("&selHopeDayOfWeek2={0}", selHopeDayOfWeek2);
		var selHopeTime2 = $("#selHopeTime2").val();
		if(selHopeTime2 != null && selHopeTime2 != "") sParams += String.format("&selHopeTime2={0}", selHopeTime2);
		var chkSameJop = $("input:checkbox[id='chkSameJop']").is(":checked") ? "Y" : "N";
		if(chkSameJop != null && chkSameJop != "") sParams += String.format("&chkSameJop={0}", chkSameJop);
		var chkSameSchool = $("input:checkbox[id='chkSameSchool']").is(":checked") ? "Y" : "N";
		if(chkSameSchool != null && chkSameSchool != "") sParams += String.format("&chkSameSchool={0}", chkSameSchool);
		var chkClub = $("input:checkbox[id='chkClub']").is(":checked") ? "Y" : "N";
		if(chkClub != null && chkClub != "") sParams += String.format("&chkClub={0}", chkClub);
		var chkPractice = $("input:checkbox[id='chkPractice']").is(":checked") ? "Y" : "N";
		if(chkPractice != null && chkPractice != "") sParams += String.format("&chkPractice={0}", chkPractice);
		var chkBand = $("input:checkbox[id='chkBand']").is(":checked") ? "Y" : "N";
		if(chkBand != null && chkBand != "") sParams += String.format("&chkBand={0}", chkBand);
		var chkJob = $("input:checkbox[id='chkJob']").is(":checked") ? "Y" : "N";
		if(chkJob != null && chkJob != "") sParams += String.format("&chkJob={0}", chkJob);
		var chkArea = $("input:checkbox[id='chkArea']").is(":checked") ? "Y" : "N";
		if(chkArea != null && chkArea != "") sParams += String.format("&chkArea={0}", chkArea);
		var chkEtc = $("input:checkbox[id='chkEtc']").is(":checked") ? "Y" : "N";
		if(chkEtc != null && chkEtc != "") sParams += String.format("&chkEtc={0}", chkEtc);
		var txtEtcRemark = $("#txtEtcRemark").val();
		if(txtEtcRemark != null && txtEtcRemark != "") sParams += String.format("&txtEtcRemark={0}", txtEtcRemark);
		var txtGrandName = $("#txtGrandName").val();
		if(txtGrandName == "") {
			alert("회장-성명을 입력해주세요.");
			return;
		}
		if(txtGrandName != null && txtGrandName != "") sParams += String.format("&txtGrandName={0}", txtGrandName);
		var txtGrandComp = $("#txtGrandComp").val();
		if(txtGrandComp == "") {
			alert("회장-직장을 입력해주세요.");
			return;
		}
		if(txtGrandComp != null && txtGrandComp != "") sParams += String.format("&txtGrandComp={0}", txtGrandComp);
		var txtGrandPosition = $("#txtGrandPosition").val();
		if(txtGrandPosition == "") {
			alert("회장-직책을 입력해주세요.");
			return;
		}
		if(txtGrandPosition != null && txtGrandPosition != "") sParams += String.format("&txtGrandPosition={0}", txtGrandPosition);
		var txtGrandPhone1 = $("#txtGrandPhone1").val();
		if(txtGrandPhone1 == "") {
			alert("회장-핸드폰번호를 입력해주세요.");
			return;
		}
		if(txtGrandPhone1 != null && txtGrandPhone1 != "") sParams += String.format("&txtGrandPhone1={0}", txtGrandPhone1);
		var txtGrandPhone2 = $("#txtGrandPhone2").val();
		if(txtGrandPhone2 == "") {
			alert("회장-핸드폰번호를 입력해주세요.");
			return;
		}
		if(txtGrandPhone2 != null && txtGrandPhone2 != "") sParams += String.format("&txtGrandPhone2={0}", txtGrandPhone2);
		var txtGrandPhone3 = $("#txtGrandPhone3").val();
		if(txtGrandPhone3 == "") {
			alert("회장-핸드폰번호를 입력해주세요.");
			return;
		}
		if(txtGrandPhone3 != null && txtGrandPhone3 != "") sParams += String.format("&txtGrandPhone3={0}", txtGrandPhone3);
		var txtGrandEmail1 = $("#txtGrandEmail1").val();
		var txtGrandEmail2 = $("#txtGrandEmail2").val();
		var txtGrandEmail = String.format("{0}@{1}", txtGrandEmail1, txtGrandEmail2);
		if(txtGrandEmail != null && txtGrandEmail != "") sParams += String.format("&txtGrandEmail={0}", txtGrandEmail);
		var txtGrandZipCode = $("#txtGrandZipCode").val();
		if(txtGrandZipCode == "") {
			alert("회장-주소를 입력해주세요.");
			return;
		}
		if(txtGrandZipCode != null && txtGrandZipCode != "") sParams += String.format("&txtGrandZipCode={0}", txtGrandZipCode);
		var txtGrandAddress1 = $("#txtGrandAddress1").val();
		if(txtGrandAddress1 == "") {
			alert("회장-주소를 입력해주세요.");
			return;
		}
		if(txtGrandAddress1 != null && txtGrandAddress1 != "") sParams += String.format("&txtGrandAddress1={0}", txtGrandAddress1);
		var txtGrandAddress2 = $("#txtGrandAddress2").val();
		if(txtGrandAddress2 == "") {
			alert("회장-주소를 입력해주세요.");
			return;
		}
		if(txtGrandAddress2 != null && txtGrandAddress2 != "") sParams += String.format("&txtGrandAddress2={0}", txtGrandAddress2);
		var txtManagerName = $("#txtManagerName").val();
		if(txtManagerName == "") {
			alert("총무-성명을 입력해주세요.");
			return;
		}
		if(txtManagerName != null && txtManagerName != "") sParams += String.format("&txtManagerName={0}", txtManagerName);
		var txtManagerComp = $("#txtManagerComp").val();
		if(txtManagerComp == "") {
			alert("총무-직장을 입력해주세요.");
			return;
		}
		if(txtManagerComp != null && txtManagerComp != "") sParams += String.format("&txtManagerComp={0}", txtManagerComp);
		var txtManagerPosition = $("#txtManagerPosition").val();
		if(txtManagerPosition == "") {
			alert("총무-직책을 입력해주세요.");
			return;
		}
		if(txtManagerPosition != null && txtManagerPosition != "") sParams += String.format("&txtManagerPosition={0}", txtManagerPosition);
		var txtManagerPhone1 = $("#txtManagerPhone1").val();
		if(txtManagerPhone1 == "") {
			alert("총무-핸드폰번호를 입력해주세요.");
			return;
		}
		if(txtManagerPhone1 != null && txtManagerPhone1 != "") sParams += String.format("&txtManagerPhone1={0}", txtManagerPhone1);
		var txtManagerPhone2 = $("#txtManagerPhone2").val();
		if(txtManagerPhone2 == "") {
			alert("총무-핸드폰번호를 입력해주세요.");
			return;
		}
		if(txtManagerPhone2 != null && txtManagerPhone2 != "") sParams += String.format("&txtManagerPhone2={0}", txtManagerPhone2);
		var txtManagerPhone3 = $("#txtManagerPhone3").val();
		if(txtManagerPhone3 == "") {
			alert("총무-핸드폰번호를 입력해주세요.");
			return;
		}
		if(txtManagerPhone3 != null && txtManagerPhone3 != "") sParams += String.format("&txtManagerPhone3={0}", txtManagerPhone3);
		var txtManagerEmail1 = $("#txtManagerEmail1").val();
		var txtManagerEmail2 = $("#txtManagerEmail2").val();
		var txtManagerEmail = String.format("{0}@{1}", txtManagerEmail1, txtManagerEmail2);
		if(txtManagerEmail != null && txtManagerEmail != "") sParams += String.format("&txtManagerEmail={0}", txtManagerEmail);
		var txtManagerZipCode = $("#txtManagerZipCode").val();
		if(txtManagerZipCode == "") {
			alert("총무-주소를 입력해주세요.");
			return;
		}
		if(txtManagerZipCode != null && txtManagerZipCode != "") sParams += String.format("&txtManagerZipCode={0}", txtManagerZipCode);
		var txtManagerAddress1 = $("#txtManagerAddress1").val();
		if(txtManagerAddress1 == "") {
			alert("총무-주소를 입력해주세요.");
			return;
		}
		if(txtManagerAddress1 != null && txtManagerAddress1 != "") sParams += String.format("&txtManagerAddress1={0}", txtManagerAddress1);
		var txtManagerAddress2 = $("#txtManagerAddress2").val();
		if(txtManagerAddress2 == "") {
			alert("총무-주소를 입력해주세요.");
			return;
		}
		if(txtManagerAddress2 != null && txtManagerAddress2 != "") sParams += String.format("&txtManagerAddress2={0}", txtManagerAddress2);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {
				alert("연단체 신청이 완료되었습니다.");
				history.back();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function threeGroupTab(idx) {
		for(i=1; i<=3; i++) {          
			if(i==idx) {
				$("#tGroupTab" + i).addClass("on");
				$("#tgContainer" + i).show();
			} else {
				$("#tGroupTab" + i).removeClass("on");
				$("#tgContainer" + i).hide();
			}
		}
	} 
	
	$( document ).ready( function() {
		$( '.teamTerms' ).click( function() {
	    	$(".termsWrap").slideToggle();
		});
	});
	
	function doSearchTeamPeople() {
		var sUrl = "<c:url value='/hills/member/doSearchTeamPeople.do'/>";
		var sParams = "";
		
		sParams += "gpNum=" + mGpNum;
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {
				var tbody = $("#tbody-people");
				tbody.empty();
				
				for(i=0; i<data.rows.length; i++) {
					var tr = $("<tr></tr>");
					
					var name = data.rows[i].MS_NAME;
					var phone = data.rows[i].MS_PHONE;
					var netYn = data.rows[i].GP_NET_YN;
					
					var td1 = $("<td>" + (i + 1) + "<input type='hidden' id='hidPeopleFlag_" + (i + 1) + "' value='O'></td>");
					var td2 = $("<td>" + name + "</td>");
					var td3 = $("<td>" + phone + "</td>");
					var td4 = $("<td>" + (netYn == "Y" ? "회원" : "비회원") + "</td>");
					var td5 = $("<td></td>");

					tbody.append(tr.append(td1, td2, td3, td4, td5));
				}
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function addPeople() {
		var tbody = $("#tbody-people");
		var length = tbody.children("tr").length;
		
		var tr = $("<tr id='tr-people" + (length + 1) + "'></tr>");
		
		var td1 = $("<td>" + (length + 1) + "<input type='hidden' id='hidPeopleFlag_" + (length + 1) + "' value='N'></td>");
		var td2 = $("<td><input type='text' id='txtPeopleName_" + (length + 1) + "'></td>");
		var td3 = $("<td><input type='text' class='short' id='txtPeoplePhone1_" + (length + 1) + "'> - <input type='text' class='short' id='txtPeoplePhone2_" + (length + 1) + "'> - <input type='text' class='short' id='txtPeoplePhone3_" + (length + 1) + "'></td>");
		var td4 = $("<td><label><input type='radio' name='chkPeopleNetYn_" + (length + 1) + "' value='Y'> 회원 </label> <label><input type='radio' name='chkPeopleNetYn_" + (length + 1) + "' value='N' checked> 비회원 </label></td>");
		var td5 = $("<td><a href='javascript:doDeleteRow(" + (length + 1) + ");' class='GpBtn1'>삭제</a></td>");
		
		tbody.append(tr.append(td1, td2, td3, td4, td5));
	}
	
	function doDeleteRow(i) {
		$("#tr-people" + i).hide();
		$("#hidPeopleFlag_" + i).val("O");
	}
	
	function doSavePeople() {
		var sUrl = "<c:url value='/hills/member/doSavePeople.do'/>";
		var sParams;
		var sData = "";

		var tbody = $("#tbody-people");
		var length = tbody.children("tr").length;
		
		var data = [];
		
		for(i=0; i<length; i++) {
			if($("#hidPeopleFlag_" + (i + 1)).val() == "O") {
				continue;
			}
			var name = $("#txtPeopleName_" + (i + 1)).val();
			var phone1 = $("#txtPeoplePhone1_" + (i + 1)).val();
			var phone2 = $("#txtPeoplePhone2_" + (i + 1)).val();
			var phone3 = $("#txtPeoplePhone3_" + (i + 1)).val();
			var netYn = $("input:radio[name='chkPeopleNetYn_" + (i + 1) + "']:checked").val();
			
			if(name != "" && phone1 != "" && phone2 != "" && phone3 != "") {
				var mem = {
					"name" : encodeURI(name),
					"phone" : phone1 + phone2 + phone3,
					"netYn" : netYn
				}
				
				data.push(mem);
			} else {
				alert((i + 1) + "번째 정보를 확인하세요.");
				return;
			}
		}
		
		if(data.length == 0) {
			alert("입력 된 회원이 없습니다.");
			return;
		}
		
		sData = JSON.stringify(data);

		sParams = {
			"gpNum" : mGpNum,
			"sData" : sData
		};
		
		jQuery.ajaxSettings.traditional = true;
		
		progressStart();
		
		mAjax2(sUrl, sParams, function(data) {
			progressStop();
			
			alert(data.resultMessage);
			
			if(data.resultCode == "0000") {
				doSearchTeamPeople();
			}
		});
	}
	
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>(연)단체안내 &nbsp;&nbsp;&nbsp; ＞ <span>연단체</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">	
		<div class="myzoneTabList5">
			<a href="<c:url value='/hills/team/yearTeam.do'/>" class="">연단체안내</a>	
			<a href="<c:url value='/hills/team/yearRequest.do'/>" class="on">연단체신청</a>
			<%-- <a href="<c:url value='/hills/team/groupRequest.do'/>" class="">공지사항/조편성기입하기</a>	 --%>
			<a href="<c:url value='/hills/team/generalTeam.do'/>" class="">일반단체안내</a>
			<a href="<c:url value='/hills/team/generalRequest.do'/>" class="">일반단체신청</a>
			<a href="<c:url value='/hills/team/lease.do'/>" class="">대관안내</a>
		</div>
		
		<div class="subTitle">
			<span class="title">연단체 신청</span>
			<div class="subLine"></div>
		</div>
		
		<div class="groupTab2">
			<a id="tGroupTab1" href="javascript:threeGroupTab(1)" class="on">연단체 온라인 신청</a>
			<a id="tGroupTab2" href="javascript:threeGroupTab(2)">연단체 오프라인 신청서</a>
			<a id="tGroupTab3" href="javascript:threeGroupTab(3)">온라인 회원 명부 기입</a>
		</div>
			
		<div id="tgContainer1">
			<table class="yearTable">
				<colgroup>
					<col width="8%">
					<col width="8%">
					<col width="15%">
					<col width="*">
					<col width="15%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th colspan="2">단체명<br><span class="vImport">*필수</span></th>
						<td colspan="4"><input type="text" class="long" id="txtTeamName"></td>
					</tr>
					<tr>
						<th colspan="2">추천인</th>
						<th>성명</th>
						<td><input type="text" class="middle" id="txtRecommendName"></td>
						<th>예상객단가<br>
						<span>※ 1인 대식당+프로샵</span><br><span class="vImport">*필수</span></th>
						<td><input type="number" class="middle" id="txtUnitPrice"></td>
					</tr>
					<tr>
						<th colspan="2">회원수<br><span class="vImport">*필수</span></th>
						<td colspan="2">(남) <input type="number" class="sShot"
							id="txtManNum">명 / (여) <input type="number" class="sShot"
							id="txtWomanNum">명 / 총 <input type="text"
							class="shot yearBg" readonly id="txtTotalPersonNum"> 명 (
							<input type="number" class="sShot" id="txtTeamNum"> 팀 )
						</td>
						<th>회원구분<br><span class="vImport">*필수</span></th>
						<td><label><input type="radio" name="chkNewYn"
								value="Y" checked="checked"> 신규 </label><label><input
								type="radio" name="chkNewYn" value="N"> 기존</label></td>
					</tr>
					<tr>
						<th colspan="2">1 희망일<br><span class="vImport">*필수</span></th>
						<td colspan="4">매월 <select id="selHopeWeek1">
						</select>째 주 <select id="selHopeDayOfWeek1">
						</select>요일 (신청시간대 : <select id="selHopeTime1">
						</select>)
						</td>
					</tr>
					<tr>
						<th colspan="2">2 희망일<br><span class="vImport">*필수</span></th>
						<td colspan="4">매월 <select id="selHopeWeek2">
						</select>째 주 <select id="selHopeDayOfWeek2">
						</select>요일 (신청시간대 : <select id="selHopeTime2">
						</select>)
						</td>
					</tr>
					<tr>
						<th colspan="2">모임성격<br><span class="vImport">*필수</span></th>
						<td colspan="4"><label><input type="checkbox"
								id="chkSameJop"> 동종업</label> <label><input
								type="checkbox" id="chkSameSchool"> 동창</label> <label><input
								type="checkbox" id="chkClub"> 동호회</label> <label><input
								type="checkbox" id="chkPractice"> 연습장</label> <label><input
								type="checkbox" id="chkBand"> 밴드</label> <label><input
								type="checkbox" id="chkJob"> 직장</label> <label><input
								type="checkbox" id="chkArea"> 지역</label> <label><input
								type="checkbox" id="chkEtc"> 기타</label> <input type="text"
							class="mlong yearBg" readonly id="txtEtcRemark"
							placeholder="상세기재 : ex. OO은행지점모임, OO기업인"></td>
					</tr>
					<tr>
						<th rowspan="8">연락처</th>
						<th rowspan="4">회장</th>
						<th rowspan="2">성 명<br><span class="vImport">*필수</span></th>
						<td rowspan="2"><input type="text" class="middle"
							id="txtGrandName"></td>
						<th>휴대폰<br><span class="vImport">*필수</span></th>
						<td><input type="number" class="sShot" id="txtGrandPhone1">
							- <input type="number" class="sShot" id="txtGrandPhone2">
							- <input type="number" class="sShot" id="txtGrandPhone3">
						</td>
					</tr>
					<tr>
						<th>E-MAIL</th>
						<td><input type="text" class="shot" id="txtGrandEmail1">
							@ <input type="text" class="shot" id="txtGrandEmail2"></td>
					</tr>
					<tr>
						<th>직장<br><span class="vImport">*필수</span></th>
						<td><input type="text" class="middle" id="txtGrandPosition"></td>
						<th rowspan="2">우편물 받을 주소<br><span class="vImport">*필수</span></th>
						<td rowspan="2"><input type="text" class="mmiddle yearBg"
							id="txtGrandZipCode" readonly><a
							href="javascript:daumPostcode('#txtGrandZipCode', '#txtGrandAddress1')"
							class="btnYear">주소검색</a><br> <input type="text"
							class="mlong yearBg" id="txtGrandAddress1" readonly><br>
						<input type="text" class="mlong" id="txtGrandAddress2"></td>
					</tr>
					<tr>
						<th>직책<br><span class="vImport">*필수</span></th>
						<td><input type="text" class="middle" id="txtGrandComp"></td>
					</tr>
					<tr>
						<th rowspan="4">총무</th>
						<th rowspan="2">성 명<br><span class="vImport">*필수</span></th>
						<td rowspan="2"><input type="text" class="middle"
							id="txtManagerName"></td>
						<th>휴대폰<br><span class="vImport">*필수</span></th>
						<td><input type="number" class="sShot" id="txtManagerPhone1">
							- <input type="number" class="sShot" id="txtManagerPhone2">
							- <input type="number" class="sShot" id="txtManagerPhone3">
						</td>
					</tr>
					<tr>
						<th>E-MAIL</th>
						<td><input type="text" class="shot" id="txtManagerEmail1">
							@ <input type="text" class="shot" id="txtManagerEmail2"></td>
					</tr>
					<tr>
						<th>직장<br><span class="vImport">*필수</span></th>
						<td><input type="text" class="middle" id="txtManagerPosition"></td>
						<th rowspan="2">우편물 받을 주소<br><span class="vImport">*필수</span></th>
						<td rowspan="2"><input type="text" class="mmiddle yearBg"
							id="txtManagerZipCode" readonly><a
							href="javascript:daumPostcode('#txtManagerZipCode', '#txtManagerAddress1')"
							class="btnYear">주소검색</a><br> <input type="text"
							class="mlong yearBg" id="txtManagerAddress1" readonly><br>
						<input type="text" class="mlong" id="txtManagerAddress2"></td>
					</tr>
					<tr>
						<th>직책<br><span class="vImport">*필수</span></th>
						<td><input type="text" class="middle" id="txtManagerComp"></td>
					</tr>
				</tbody>
			</table>

			<div class="RequestBox">
				<h1 class="commonDot">개인 정보 수집 및 이용에 관한 사항</h1>
				<p>
					1. 개인정보의 수집 및 이용목적 : 연단체 모집<br> 2. 수집하는 개인정보의 항목<br>
					&nbsp;&nbsp;&nbsp;1) 이용자 식별을 위한 내용 : 성명,주소<br>
					&nbsp;&nbsp;&nbsp;2) 안내를 위한 내용 : 전화번호, 직장/직책<br> 3. 회원가입정보의 보유
					및 이용기간 : 1년<br> &nbsp;&nbsp;&nbsp;본인은 위 정보를 요청하는 것에 대해 이해하며 위에
					적은 바와 같이 이용하는데 동의합니다.
				</p>
				<h3>
					<label><input type="radio" name="chkAgree1" value="Y">
						동의 </label> <label><input type="radio" name="chkAgree1" value="N">
						비동의 </label>
				</h3>
				<h4>※ 동의시 서명과 같은 효과를 나타냅니다.</h4>
			</div>
			<div class="RequestBox">	
				<h1 class="commonDot">서원힐스 연단체 이용 약관을 확인하였습니까?</h1>
				<h3>
					<label><input type="radio" name="chkAgree" value="Y">
						예 </label> <label><input type="radio" name="chkAgree" value="N">
						아니오 </label>
				</h3><br><br><br><br><br><br><br>
				<strong class="orange right">마케팅전략팀 T. 031-940-9400 / F. 031-957-2500</strong>
			</div>
			<div class="RequestBox1">
				<!-- <p class="teamTerms">
					<img src="/images/hills/teamTerms.png" alt=""> 서원힐스 연단체 이용약관	보기
				</p> -->
				
				<p class="teamTerms"><img src="<c:url value='/images/hills/teamTerms.png'/>" alt=""> 서원힐스 연단체 이용약관 보기</p>
		
				<div class="termsWrap" style="display: none;">
				<h2>서원힐스 연단체 이용 약관(운영규정)</h2>
				<h3>제 1 조 【 목적 】</h3>
				<p>본 약관은 서원밸리컨트리클럽(이하 “당 클럽”)을 이용하려는 서원힐스 연부킹 단체팀(이하 “연단체”)의 클럽 시설물 이용 및 이에 따른 책임에 관한 사항을 규정함을 목적으로 한다.</p>
				<h3>제 2 조 【 구성 】</h3>
				<p>
				1. 연단체 팀 구성은 3팀 이상 5팀(1팀 4인 기준) 이내로 한다<br>
	2. 연단체로서 연간 8회 이상 내장을 기본으로 운영한다.<br>
	3. 연단체 소속의 모든 회원들은 당 클럽 홈페이지(www.seowongolf.co.kr) 에 회원 가입을 한 후, 회원 명부를 제출하여야 한다.<br>
				</p>
				<h3>제 3 조 【 신청 】</h3>
				<p>1. 매년 10월 ~ 11월 중에 차년도 연단체를 신청한다.<br>
	2. 신청은 당 클럽 홈페이지에서 서원힐스 연단체 신청서 양식을 다운받아 FAX(031-957-2500) 또는 홈페이지에 게시된 이메일로 접수한다.<br>
	3. 기존 연단체도 해마다 재 신청 하여야 한다. <br>
	4. 확정 통보는 당 해년도 당 클럽이 정한 기간에 연단체 대표에게 유선 및 SMS 등으로 개별 통보하여 확정한다.<br>
	5. 선정된 연단체는 클럽 규정을 준수한다.</p>
				<h3>제 4 조 【 예약관리 】</h3>
				<p>
				1. 연단체의 조편성은 경기일 최소 3일전까지 당 클럽에 FAX, 이메일, SMS 등으로 확정 통보 하여야 한다.<br>
	2. 연단체 확정시 해당 주차, 요일, 시간대를 결정하여 이를 기준으로 매월 배정한다.<br> 
	   단, 당 클럽의 영업 상황에 따라 매월 신청 시간대에서 약 1시간 내외로 유동적일 수 있다.<br>
	3. 예약 확정일자, 시간대는 매월 3주전 목요일까지 회장 또는 총무에게 유선(SMS)으로 통보한다<br>
	4. 배정 완료 후 팀 수 변경 및 시간대 조정은 경기일 7일 전까지 요청하여야 한다.<br>
	5. 사전 통보 없이 예약 팀 수 보다 적게 내장하는 경우 제 8조 위약 관리 조항에 해당된다.<br>
	6. 코스 배정은 이스트, 웨스트, 사우스 총 3개 코스를 로테이션으로 한다. (특정코스 지정불가)<br>
	7. 2부 타임에 내장하는 연단체는 대식당 이용 조건이 있으며 성실히 이행하여야 한다.<br>
	8. 클럽 이용 실적(행사횟수, 약정객단가, 포인트, 매너이슈 등)이 연단체 이용 및 차년도 재계약에 영향을 미칠 수 있다.<br>
	9. 연단체 모든 혜택은 팀당 4인 전제일 때만 가능하다.<br>
	10. 예약을 불이행하는 경우에는 당 클럽에서 정한 규정에 따라 마이너스 포인트 부과 또는 일정기간의 예약 정지나 이용제한, 위약금 부과 등의 조치를 취할 수 있다.<br>			
				</p>
				<h3>제 5 조 【 혜택 】</h3>
				<p>
				1. 연단체 그린피는 변동 요금으로 당 클럽의 홈페이지에 공지되는 실시간 그린피 기준에서 시즌별, 요일별, 시간대별로 정한 금액으로 할인이 적용 된다.<br>
	   단, 연단체 소속 회원 전원이 서원 힐스 홈페이지 인터넷회원으로 가입 한 후, 회장/총무가 단체의 회원 명부를 클럽에 제출 및 등록하는 조건으로 매월 행사시 연단체 요금이 적용 된다.<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;1) 6시대 : 1.5~3.5만원 할인 (MIN 9.5만원 ~ MAX 11만원) <br>
	    &nbsp;&nbsp;&nbsp;&nbsp;2) 7시대 : 2만원 할인 (MIN 12만원 ~ MAX 13만원)
	               단, 라운드 전 또는 후 1회 이상 대식당 이용 조건<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;3) 2부 : 2~3만원 할인, 확정그린피 14만원, 하계기간 별도 요금 정책 적용
	                단, 1인 객단가(식음+프로샵) 3만원 이상 이용 조건<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;4) 16시대 : 2~3만원 할인(MIN. 月~木 10만원, 金 11만원) 적용<br>
	   &nbsp;&nbsp;&nbsp;&nbsp;5) 조조(06:30 이전) : 5시대 9만원 확정그린피, 6시대 연단체가에서 0.5~1만원 추가 할인<br>
	   &nbsp;&nbsp;&nbsp;&nbsp;6) 나이트(17시 이후) : 9만원 확정그린피, 하계기간 실시간그린피에서 2만원 할인<br>
	   &nbsp;&nbsp;&nbsp;&nbsp;※ 월요일 7시대, 10~13시대 추가 1만원 할인<br>
	   &nbsp;&nbsp;&nbsp;&nbsp;※ 상기 할인 금액과 아래 상시 혜택 및 추가 베네핏은 당 클럽의 사정에 따라 변경 될 수 있으며, 변경시 고지 후 시행 한다. <br>
	2. 하계기간 2부 타임에 행사시 특가 이벤트 요금으로 적용하며 7~8월 연속 행사 완료시 추가 베네핏을 제공한다. (연단체 회원이 개인팀으로 내장시 특전 포함)<br>
	3. 상시 혜택으로 라운드 전 연습장 타석 이용시 50%할인, 베이커리 10~20% 상시할인(사전 할인 품목 제외), 프로샵 5~10% 할인(행사 및 할인제외품목 제외), 라운드 전/후 대식당 모두 이용시 추가 베네핏 제공, 웨딩/대관/소모임 등 연단체 회원 가족 20% 할인, 추천시는 식음 10% 할인 한다.<br>
	4. 상반기/하반기 사용 가능한 쿠폰을 제공한다. <br>
	    &nbsp;&nbsp;&nbsp;&nbsp;1) 우수연단체(행사횟수, 약정객단가, 매너이슈, 포인트) 조기 재계약시 프리미엄 쿠폰북을 제공한다.<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;2) 쿠폰북의 형태와 수량, 내용, 사용방법, 지급기준 등은 당 클럽에서 정하며 첫 입회일에 회장 또는 총무에게 제공한다.<br> 
	    &nbsp;&nbsp;&nbsp;&nbsp;3) 제공된 쿠폰은 명시된 유효기간 내에만 사용 가능하며, 유효기간 내 사용하지 않을 경우 기간 연장이 불가하다<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;4) 단체용(연단체 행사용)으로 발급된 쿠폰은 양도할 수 없고, 개인용 쿠폰은 일부 양도 가능하나 연단체 행사 또는 할인 적용된 일반 단체에서는 사용할 수 없다. (개인팀 이용시 적용)<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;5) 그린피/식음 할인 쿠폰은 다른 그린피/식음 이벤트와 중복 적용 되지 않으며 라운드 전 프론트에 제시하여야 원활하게 적용 된다.<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;6) 쿠폰은 비매품으로 판매할 수 없으며 4인 내장시만 적용 가능하다.<br>
	    &nbsp;&nbsp;&nbsp;&nbsp;7) 쿠폰 분실시 재발급이 불가능 하며, 계약 기간 중 연단체 탈퇴시 제공된 쿠폰은 모두 반납하여야 하고, 이미 쿠폰을 사용했거나 분실 또는 기타 사유로 반납할 수 없는 경우는 쿠폰을 최초 수령한 회장/총무의 책임 아래 해당 비용을 모두 변상하여야 한다.<br> 
	   &nbsp;&nbsp;&nbsp;&nbsp;※ 연단체 회장/총무는 쿠폰 이용자에게 상기 내용을 포함하여 각 쿠폰에 명시된 준수사항을 확인하고 사용할 수 있도록 하여야 한다<br>
				</p>
				<h3>제 6 조 【 수용 】</h3>
				<p>
				1. 운영기간은 1월부터 12월까지 12개월로 하며, 행사는 주중(월요일부터 금요일)에 한하여 진행한다. 단, 연중 12, 1, 2월의 3개월간은 일조시간 단축에 따라 경기를 제한할 수 있다.<br>
	2. 연단체 행사는 월 1회로 제한한다. 단, 5주차에 한하여 실시간 그린피로 허용한다.<br>
	3. 연단체의 약정된 팀 수 이상으로 행사시 추가된 팀은 실시간 그린피 요금 정책에 따른다.<br>
	4. 경기일이 공휴일인 경우 당 클럽과의 협의를 통해 해당 주 다른 요일 및 다른 주 해당 요일로 조정해야 하며, 주말 또는 공휴일(임시 공휴일 포함)에 행사를 진행할 경우 실시간 그린피가 적용된다. <br>
	5. 상반기 실적(행사횟수, 약정객단가, 포인트, 매너이슈 등)에 따라 하반기 이용에 제한이 있을 수 있으며, 연간 실적에 따라 기존 연단체의 차년도 재계약에 제한을 두거나 티타임을 우선 배정할 수 있다.<br>
	6. 당 클럽의 상황과 일조량에 따라 2부제 또는 3부제로 운영을 하며 신청 시간대는 3부제 기준이므로 2부제로 운영하는 경우 신청 시간대가 아닌 다른 시간대로 조정이 불가피하며 조정시 시간대별 연단체 요금 정책에 따른다. <br> 
	7. 골프장 이용과 관련된 규정 및 이용 요금은 경기 당일 기준에 준하여 적용 한다.<br>
	8. 단체 행사 시상품의 외부 반입은 지양 한다.<br>
	9. 골프장 운영상 사유가 있거나 클럽 행사가 있을 경우 연단체 배정일이 변경될 수 있다.<br>
	10. 실시간 그린피는 클럽 정책에 따라 상시 변동될 수 있다.			
				</p>
				<h3>제 7 조 【 이용의 거절 】</h3>
				<p>
				당 클럽은 다음의 경우에는 클럽의 이용을 거절하거나 퇴장을 요구할 수 있다.<br>
	1. 예약된 티타임 시간을 지키지 않는 때<br>
	2. 본 약관을 위반하였을 때<br>
	3. 경기능력이 현저히 부족하여 다른 이용자의 경기에 큰 방해가 될 때<br>
	4. 도박성 내기를 하는 등 미풍양속에 어긋나는 행동을 할 때<br>
	5. 대한골프협회 규칙, 기타 이용자 에티켓과 관련하여 클럽이 미리 고지한 준수사항을 위반할 때<br>
	6. 골프장에 근무하는 직원, 캐디들에 대한 폭언 및 성희롱을 할 때<br>
	&nbsp;&nbsp;&nbsp;&nbsp;(발생 즉시 강제 퇴장 요청, 연단체 취소 및 영구 내장 정지)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;※ 남녀고용평등법 제 2조 [별표1] 직장내 성희롱을 판단하기 위한 기준의 예시 기준<br> 
	7. 기타 사유로 당 클럽 이용에 적합하지 않다고 객관적으로 판단될 때<br>
				</p>
				<h3>제 8 조 【 위약규정 】</h3>
				<p>
				1. 연단체의 운영은 해당 회장이 모든 책임을 진다.<br>
	2. 해당 월 라운드 취소나 팀 수를 축소 운영할 경우 경기일 7일 전까지 힐스 예약실의 주차별 배정 담당자에게 유선으로 통보하여야 한다.<br>
	3. 7일 전 일부 취소되어 1팀만 운영하게 되는 경우 실시간 그린피를 적용 한다.<br>
	4. 3인 내장시 3.5인 요금으로 정산 또는 클럽에서 인정하는 할인 쿠폰 2매로 대체 가능하다.<br>
	5. 예약일 6~4일 전 전면, 일부 취소 <br>
	   - 위약금(취소 팀 수 * 1팀 4인기준 그린피 25%) 및 마이너스 포인트 부과<br>
	6. 예약일 3~1일 전 전면, 일부 취소 <br>
	   - 위약금(취소 팀 수 * 1팀 4인기준 그린피 50%) 및 마이너스 포인트 부과
	7. No-Show, 당일취소)<br>
	   - 위약금(취소 팀 수 * 1팀 4인기준 그린피 100%) 및 마이너스 포인트 부과
	8. 위약금 미납 시 잔여 연 부킹 취소 및 해당 연단체 회원 모두를 영구 내장 정지한다.
				</p>
				<h3>제 9 조 【 경기진행 】</h3>
				<p>
				1. 모든 이용자는 클럽내에서 항상 신사적 에티켓과 매너를 유지하고 질서를 지켜 다른 이용자 또는 경기 진행에 지장을 주지 말아야 한다.<br>
	2. 원활한 경기진행을 위해 최소 40분전에 입장 등록을 마치고, Tee-Off 20분전까지 스타트광장에서 경기 준비를 완료하여야 한다.<br>
	3. Tee-Off 20분 전 이후 내장 시 홀 합류, 홀 점프 등 당 클럽의 현장 경기 진행에 적극 협조 하여야 한다.<br>
	4. 당 클럽은 경우에 따라 경기 시간에 제한을 둘 수 있으며, 경기진행 비협조 및 비매너시는 경고 조치하고 1회 이상의 경고에도 불구하고 적절한 속도를 유지하지 못하거나 개선되지 않을 경우 해당 경기자에게 퇴장 요청을 할 수 있다.<br>
	5. 코스내 지정된 장소 이외에서의 흡연은 절대 불가하며, 경기 중 쓰레기를 적당한 용기에 처리함으로써 코스를 청결하게 유지하는데 협조하여야 한다.<br>
	6. 강설, 폭우, 안개, 기타 천재지변 등 불가항력적인 사유로 플레이를 할 수 없을 경우 경기를 취소할 수 있다.<br>
				</p>
				<h3>제 10 조 【 포인트제도 】</h3>
				<p>
				1. 연단체의 입회시 부과되는 기본 포인트는 50점이며, 아래의 표에 따라 매월 가산 또는 차감된다.</p>
					<table class="commonTable" style="width:95%;">
	                <caption>포인트제도	</caption>
					<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					</colgroup>
	                	<tr>
	                        <th scope="col">구분</th>
	                        <th scope="col">내용</th>
							<th scope="col">포인트</th>
							<th scope="col">비고</th>
						</tr>
						<tr>
							<th rowspan="3">에티켓</th>
							<td>폭언 및 성희롱</td>
							<td colspan="2">발생 즉시 클럽 이용 거절 [약관 제 7 조 참조]</td>
						</tr>
						<tr>
							<td>진행, 예약협조 및 매너 우수</td>
							<td>+ 10</td>
							<td rowspan="2">접점 파트의 수시 현장 평가<br>(월별 포인트 업데이트)</td>
						</tr>
						<tr>
							<td>진행, 예약협조 및 매너 불량</td>
							<td>- 10</td>
						</tr>
						<tr>
							<th rowspan="5">위약 및 취소</th>
							<td>미내장 및 당일 전면, 일부 취소</td>
							<td>- 50</td>
							<td rowspan="6">위약금 완납시 <br>적용된 마이너스 포인트의 50%를<br>플러스 포인트로 제공</td>
						</tr>
						<tr>
							<td>1일전 전면, 일부 취소</td>
							<td>- 40</td>
						</tr>
						<tr>
							<td>2일전 전면, 일부 취소</td>
							<td>- 30</td>
						</tr>
						<tr>
							<td>3일전 전면, 일부 취소</td>
							<td>- 20</td>
						</tr>
						<tr>
							<td>6~4일전 전면, 일부 취소</td>
							<td>- 10</td>
						</tr>
						<tr>
							<th rowspan="3">내장</th>
							<td>1팀 4인 기준으로 결원시 1명당</td>
							<td>- 10</td>
						</tr>
						<tr>
							<td>Tee-Off 임박 내장 및 이후 내장</td>
							<td>- 10</td>
							<td></td>
						</tr>
						<tr>
							<td>연간 행사 횟수 8회 미만</td>
							<td>- 20</td>
							<td>1회당</td>
						</tr>
						<tr>
							<td><strong>운영</strong></td>
							<td>혹서기(7,8월)행사 진행</td>
							<td>+ 30</td>
							<td></td>
						</tr>				
					</table>
				<p><br>&nbsp;&nbsp;&nbsp;&nbsp;* 비매너 예시<br>
	 &nbsp;&nbsp;&nbsp;&nbsp;1) 아래 예시에 대하여 무리하게 요청하거나 반복적이고 집요한 요구 및 강압적인 태도, 요청 사항이 받아들여지지 않을시 지속적인 은근한 괴롭힘 등<br>
	 &nbsp;&nbsp;&nbsp;&nbsp;예시) 추가할인, 밸리(회원제) 배정, 식사/커피서비스, 프로모션(이벤트)과 할인 중복 적용, <br>
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;특정 시간대로 이동 또는 고정, 연단체회원의 개인 티타임 선배정 요청, <br>
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;특정 코스 배정, 할인 쿠폰 추가 요청, 쿠폰 유효기간 연장 또는 재발급 등<br>
	 &nbsp;&nbsp;&nbsp;&nbsp;2) 직원 및 캐디의 자존감 하락의 요인이 되는 태도 및 언행, 고성, 욕설, 폭언 등<br>
	 &nbsp;&nbsp;&nbsp;&nbsp;3) 경기 진행 비협조, 취식물 반입 등<br>
	 &nbsp;&nbsp;&nbsp;&nbsp;4) 기타 통상적인 비매너를 모두 포함한다.<br>
	<br>
	2. 잔여 누적 포인트 20점 이하 시점에 회장/총무에게 고지하여 포인트 회복의 기회를 부여한다.<br>
	3. 잔여 누적 포인트이 10점 미만인 경우 잔여 연부킹 배정을 제한 또는 취소할 수 있다.<br>
				</p>
				<h3>제 11 조【 외부반입 취식물 관련 】</h3>
				<p>건강과 위생을 위하여 취식물 외부 반입을 제한한다. (특히 여름철 식중독 예방 차원)</p>
				<h3>제 12 조【 기타 】</h3>
				<p>본 약관에 명시되지 아니한 사항 또는  해석상 다툼이 있는 사항에 대해서는  일반 관례에 따라 합의하여 결정하되, 합의가 이루어지지 아니한 경우에는 민사소송법상의 관할 법원에 제기한다. </p>
				<h3>부칙</h3>
				<p>본 약관은 2019년 1월  1일부터 시행한다.</p>
				</div>
				
				
				<h2>
					<a href="javascript:doSave()" class="btnYear1"> 신청하기</a>
				</h2>
			</div>
		</div>
		
		<div id="tgContainer2" style="display:none">
			<div class="groupWrite1">
				<a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%202020%EB%85%84%20%EC%97%B0%EB%8B%A8%EC%B2%B4%20%EC%8B%A0%EC%B2%AD%EC%84%9C.hwp" class="yearAgreey1"><img src="<c:url value='/images/hills/whiteFile.png'/>" alt=""><span class="yearText">연단체 신청서<br>(HWP Download)</span></a>
				<a href="https://kr.object.ncloudstorage.com/contents/seowon-member/서원힐스%202020년%20연단체%20신청서_pdf.pdf
" class="yearAgreey1"><img src="<c:url value='/images/hills/whiteFile.png'/>" alt=""><span class="yearText">연단체 신청서<br>(PDF Download)</span></a>
				<p>&bull; 팩스 접수 : 연단체 신청서 양식 다운로드 후 서면으로 작성하여 031-957-2500으로 접수<br>
					&bull; 현장 접수 : 서원힐스 프론트에서 신청서를 직접 수령하여 서면 기입 후 접수<br>
					&bull; 이메일 접수 :	연단체 신청서 양식 다운로드 후 서면으로 작성하여 swmk@seowongolf.co.kr 으로 스캔한 신청서 송부</p>
				<br><br><br>
				<a href="https://kr.object.ncloudstorage.com/contents/seowon-member/2020%20%EC%84%9C%EC%9B%90%ED%9E%90%EC%8A%A4%20%EC%97%B0%EB%8B%A8%EC%B2%B4%20%EC%8B%A0%EC%B2%AD%28%EB%8F%99%EC%9D%98%29%EC%84%9C.hwp" class="yearAgreey1"><img src="<c:url value='/images/hills/whiteFile.png'/>" alt=""><span class="yearText">연단체 동의서<br>(HWP Download)</span></a>
				<a href="https://kr.object.ncloudstorage.com/contents/seowon-member/2020%20서원힐스%20연단체%20신청%28동의%29서_pdf.pdf
" class="yearAgreey1"><img src="<c:url value='/images/hills/whiteFile.png'/>" alt=""><span class="yearText">연단체 동의서<br>(PDF Download)</span></a>
				<p>&bull; 연단체 (온라인/오프라인) 신청 완료 후 동의서 제출하라는 공지를 받은 단체만 작성하여 제출<br>
&bull; 제출한 동의서 원본은 회장/총무님 보관, 사본은 클럽 보관</p>
			</div>
		</div>
		
		<div id="tgContainer3" style="display:none">
			<div class="groupWrite2">
				<div class="commonDot"> 온라인 회원 명부 기입하기</div>
				
				<!-- 입력 : 아이디는 바꾸지 말아주세요~~~~ -->
				<div class="onlineList">
					<dl>
						<dt>등록자</dt>
						<dd><input type="text" class="gwriteText" value="${sessionScope.msMember.msName}" style="background:#EDEDED; text-indent:5px;" disabled></dd>
						<p><input type="checkbox" id="chkTeamPosition1" disabled> <span>회장</span> <input type="checkbox" id="chkTeamPosition2" disabled>  총무 </p>		
					</dl>
					<dl>
						<dt>연도</dt>
						<dd><input type="text" class="gwriteText" id="txtTeamYear" style="background:#EDEDED" disabled></dd>
						<p><span>주차</span><input type="text" class="gwriteText" id="txtTeamJuDiv" style="background:#EDEDED" disabled></p>
					</dl>
					<dl>
						<dt>단체명</dt>
						<dd><input type="text" class="gwriteText" id="txtGpName" style="background:#EDEDED" disabled></dd>
						<p><input type="text" class="gwriteText" id="txtSearchKeyword" onKeypress="javascript:if(event.keyCode==13) {searchPopupOpen()}"style="text-indent:5px;"> <a href="javascript:void(0);" onclick="searchPopupOpen()" class="GpBtn">검색</a></p>
					</dl>
				</div>
				
				<jsp:include page="../include/popup/popup_people_search.jsp" flush="true" />	 
								 
				<table class="groupT1">
					<colgroup>
						<col width="15%">
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th>순번</th>
							<th>성명</th>
							<th>휴대전화</th>
							<th>인터넷회원여부</th>
							<th>삭제</th>
						</tr>
					</thead>					
					<tbody id="tbody-people">
					</tbody>
				</table>
				
				<div class="plusTd" id="btnTeamPeoplesPlus" onclick="addPeople()" style="display:none">
					<img src="<c:url value='/images/hills/gplus.png'/>" >
					<h3>테이블 추가</h3>
				</div>
				
				<!-- 클릭이벤트만 doSavePeople() 요거 넣어주시면됩니다 a태그,div 기타 등등 아무거나 쓰셔도 됩니다. -->
				<a href="javascript:void(0)" onclick="doSavePeople()" id="btnTeamPeoplesSave" style="display:none" class="GpSave"> 저장 </a>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />