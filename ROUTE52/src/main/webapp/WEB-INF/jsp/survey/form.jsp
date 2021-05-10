<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>서원밸리 설문</title>
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<style>
/*reset css*/
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p,
	blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn,
	em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var,
	b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend,
	table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas,
	details, embed, figure, figcaption, footer, header, hgroup, menu, nav,
	output, ruby, section, summary, time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font: inherit;
	vertical-align: baseline;
	outline: none;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

body {
	line-height: 1;
	font-family: Arial, Tahoma, sans-serif;
}

article, aside, details, figcaption, figure, footer, header, hgroup,
	menu, nav, section {
	display: block;
}

ol, ul {
	list-style: none;
}

blockquote, q {
	quotes: none;
}

blockquote:before, blockquote:after, q:before, q:after {
	content: '';
	content: none;
}

strong {
	font-weight: bold;
}

table {
	border-collapse: collapse;
	border-spacing: 0;
}

img {
	border: 0;
	max-width: 100%;
}
/*//reset*/
body {
	background-color: #e8e8e8
}

.tc {
	text-align: center
}

h1 {
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 15px;
	letter-spacing: -2px;
	margin-top: 15px;
}

h2 {
	font-size: 20px
}

h2.line {
	background-color: #005e5b;
	color: white;
	padding: 10px
}

h3 {
	font-size: 17px;
	line-height: 26px;
	margin: 20px 0 10px 0;
	font-weight: 600
}

p {
	color: #333;
}

button {
	outline: 0
}

.form {
	padding: 30px;
	border: 1px solid #999
}

.ul_answer {

}

.ul_answer li {
	margin: 8px;
	padding: 5px;
	font-size: 15px;
	color: #666;
}

.ul_answer li label {
	vertical-align: middle
}

.ul_answer li input {
	vertical-align: middle
}

textarea {
	width: 99%;
	height: 200px;
	border: 1px solid #d1d1d1;
	background-color: #f9f9f9;
}

.wrap {
	width: 95%;
	margin: 0 auto;
	margin-top: 15px
}

.div_form {
	border: 1px solid #d6d6d6;
	padding: 15px;
	padding-bottom: 30px;
	background-color: #fff;
	margin-bottom: 30px;
	letter-spacing: -1px;
	border-radius: 10px;
}

.div_send {
	text-align: center;
	margin: 0 auto
}

.div_send .btn_send {
	width: 80%;
	color: #005e5b;
	font-weight: bold;
	font-size: 18px;
	background-color: #fff;
	border-radius: 20px;
	border: 2px solid #005e5b;
	padding: 13px;
}

.div_send .btn_send:active {
	background-color: #d7d7d7;
	color: #666
}

.div_send .box {
	padding: 10px;
	background-color: #005e5b;
	line-height: 24px;
	color: white;
	font-size: 14px;
	background: url('/images/bg.jpg');
	background-size: cover;
}

.div_send .box span {

}
</style>
</head>
<body>
	<div class="wrap">
		<div class="div_form">
			<h1 class="tc">고객 서비스 만족도 조사</h1>
			<h2 class="line">MOT ${form[0].CD_TITLE1}</h2>
			<c:forEach items="${form}" var="form" varStatus="status">
				<c:if test="${form.CD_SEQ eq 0}">
					<h3>${form.CD_NAME}</h3>${form.CD_SUB_DIV}
					<div class="ul_answer">
						<input type="hidden" data-code="${form.CD_CODE}" data-seq="${form.CD_SEQ }" value="N" />
					</div>
				</c:if>
				<c:if test="${form.CD_SEQ ne 0}">
					<c:if test="${form.CD_SUB_DIV eq 'C' }">
						<ul class="ul_answer" data-code="${form.CD_CODE}">
							<li>
							<input type="radio" id="answer${form.CD_CODE}_${form.CD_SEQ }" name="${form.CD_CODE}" data-code="${form.CD_CODE}" data-seq="${form.CD_SEQ }" />
							<label for="answer${form.CD_CODE}_${form.CD_SEQ }">${form.CD_NAME}</label>
							</li>
						</ul>
					</c:if>
					<c:if test="${form.CD_SUB_DIV eq 'M' }">
						<textarea class="text_area" data-code="${form.CD_CODE}" data-seq="${form.CD_SEQ }" placeholder="여기 내용을 입력해주세요" style="resize: none;"></textarea>
					</c:if>
					<c:if test="${form.CD_SUB_DIV eq 'P' }">
						<input type="radio" name="cdSubDiv" value="1"/>칭찬
						<input type="radio" name="cdSubDiv" value="2"/>제안
						<input type="radio" name="cdSubDiv" value="3"/>불만
						<input type="radio" name="cdSubDiv" value="4"/>기타
						<br />
						<br />
						<textarea class="text_area" data-code="${form.CD_CODE}" data-seq="${form.CD_SEQ }" data-div="${form.CD_DIV }" placeholder="여기 내용을 입력해주세요" style="resize: none;"></textarea>
					</c:if>
				</c:if>
			</c:forEach>
			<div class="div_send">
				<p class="box">
					보다 나은 서비스로 보답하겠습니다.<br /> 설문에 응해주셔서 감사합니다. <br /> <span> -서원밸리컨트리클럽 임직원 일동-</span>
				</p>
				<br /> <br />
				<c:if test="${form != null}">
					<button class="btn_send">설문 전송</button>
				</c:if>
			</div>
		</div>
		<!--//form-->
	</div>
	<!--//wrap-->
</body>
<script>
	String.prototype.format = function() {
		var args = [].slice.call(arguments);
		return this.replace(/(\{\d+\})/g, function(a) {
			return args[+(a.substr(1, a.length - 2)) || 0];
		});
	};
	$(".btn_send").on("click", function(e) {

		var questionC = new Array();
		var questionM = new Array();
		var checkList = new Array();
		var textList = new Array();
		var param = {
			coDiv : "${form[0].CO_DIV}",
			cdYear : "${form[0].CD_YEAR}",
			cdYearSeq : "${form[0].CD_YEAR_SEQ}",
			enDay : "${form[0].EN_DAY}",
			msPhone : "${form[0].MS_PHONE}",
			updateStaff : "${form[0].MS_NUM}"

		}

		$(".ul_answer").each(function() {
			questionC.push($(this).data("code"));
		});

		questionC = $.unique(questionC);

		$(".text_area").each(function() {
			questionM.push($(this));
		});

		console.log(questionC);

		if (validation(questionC, questionM)) {
			var checkedBox = $(".ul_answer").find("input");

			checkedBox.each(function() {
				var data = {
					motCode : $(this).data("code"),
					motSeq : $(this).data("seq"),
					motCheck : $(this).is(":checked") ? "Y" : "N"
				}

				checkList.push(data);

			});

			var cdSubDiv;
			if($('input[name=cdSubDiv]').val()){
				cdSubDiv = $('input[name="cdSubDiv"]:checked').val();
			}

			var textBox = $(".text_area");
			console.log(cdSubDiv);

			textBox.each(function() {
				var data = {
					motCode : $(this).data("code"),
					motSeq : $(this).data("seq"),
					motCheck : "N",
					motMemo : $(this).val(),
					motDiv : $(this).data("div"),
					motGubun : cdSubDiv
				}

				textList.push(data);
				console.log(data);
			})
			$.ajax({
				type : "GET",
				url : "/survey/save.do",
				data : {
					param : param,
					checkList : checkList,
					textList : textList
				},
				success : function(result) {
					console.log(result + "dd");
					location.href = "/survey/success.do";

				},
				error : function(e) {
					alert("설문에 참여할 수 없습니다.");
				}
			});

		};

	});

	function validation(questionC, questionM) {
		var flag = true;

		$.each(questionC, function(i, el) {
			if (flag) {
				var checkedEl = $(".ul_answer").find(
						"input[type=radio]:checked");

				if (checkedEl.length < 1) {

					alert("질문 " + el + " 항목을 한개 이상 체크 해주세요.")
					checkedEl.focus();
					flag = false;
				}
			}
		})

		// 		$.each(questionM, function(i, el){
		// 			if(flag){
		// 				if(el.val().length < 1 ){
		// 					alert("질문 " + el.data("code") + " 내용을 입력해주세요.");
		// 					el.focus();
		// 					flag = false;
		// 				}
		// 			}
		// 		});

		return flag;

	}
</script>
</html>
