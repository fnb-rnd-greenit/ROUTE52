<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%		
	String sServerUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	
	if(sServerUrl.indexOf("localhost") == -1 && sServerUrl.indexOf("itsone.iptime.org") == -1) {
		sServerUrl = "https://www.seowongolf.co.kr";
	}
	
	String sContextPath = sServerUrl + request.getContextPath();
%>
<jsp:include page="../include/header.jsp" flush="true" />
<jsp:include page="../include/subTop.jsp" flush="true" />

<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/hellojs/2.0.0-4/hello.all.js"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/jquery-1.11.3.js'/>"></script> --%>
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/naverLogin_implicit-1.0.3.js'/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script> 
<script type="text/javascript">

	//var kakao_key = "2fdf4e8e6e6d474282353f5ef06c8c59";
	var kakao_key = "dc1b9e390d561baaca39c286b7f41b23";
	var kakao_button_image = "<c:url value='/images/hills/login_kakao.png'/>";
	
	var naver_domain = "<%= sServerUrl %>";
	var naver_key = "wSzJ1pJXrPElFz9xdZF2"; 
	var naver_callback = "<%= sContextPath %>/hills/member/succNaverLogin.do";
	var naver_button_image = "<c:url value='/images/hills/login_naver.png'/>";
	
	var facebook_key = "564458247381194";
	var facebook_version = "v3.2";
	var facebook_button_image = "<c:url value='/images/hills/login_face.png'/>";
	
	$(document).ready(function() { 
		onLoadPage();
	});

	function onLoadPage() {
		googleInit();
		
		kakaoInit();
		
		facebookInit();
		
		var msId = "<c:out value='${sessionScope.msMember.msId}'/>";		
		if(msId != "") {
			location.href = "<c:url value='/hills/index.do'/>";	
		}
		
		var id = getCookie("id");
		var pw = getCookie("pw");
		
		if(id != null && id != "") {
			$("#msId").val(id);
			$("#chkSaveId").attr('checked', true);
		}
		
		$("#msId").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	actionLogin();
	        }
	    });

		$("#msPw").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	actionLogin();
	        }
	    });
	}

	function actionLogin() {
		var sUrl = "<c:url value='/hills/member/actionLogin.do'/>";
		var sParams = {};
		
		var msId = $("#msId").val();
		var msPw = $("#msPw").val();
		var autoLogin = $('input:checkbox[id="chkAutoLogin"]').is(":checked") ? "1" : "0";
		
		if(msId == "") {
			alert("아이디를 입력하세요.");
			return;
		} else {
			sParams["msId"] = msId;
		}
		
		if(msPw == "") {
			alert("비밀번호를 입력하세요.");
			return;
		} else {
			sParams["msPw"] = msPw;
		}

		sParams["autoLogin"] = autoLogin;
		
		progressStart();
		
        mAjax2(sUrl, sParams, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}
    			
        		location.href = "<c:url value='/hills/index.do'/>";
            } else if(data.resultCode == "1000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
        		location.href = "<c:url value='/hills/member/memModify.do'/>";
            } else if(data.resultCode == "2000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
        		location.href = "<c:url value='/hills/member/memModify.do'/>";
            } else if(data.resultCode == "3000") {
        		if($('input:checkbox[id="chkSaveId"]').is(":checked")){
        			setCookie("id", $("#msId").val(), 365);
        		} else {
        			setCookie("id", "", 365);
        		}

            	alert(data.resultMessage);
        		location.href = "<c:url value='/hills/member/agree.do'/>";
            } else {
            	alert(data.resultMessage);
            }
        });
	}
	
	function googleInit() {
		hello.init({
			google: '447621951123-uvka3s8cq479k9tvi427mlk3genhs7tt.apps.googleusercontent.com'
		}, {redirect_uri: '<%= sContextPath %>/hills/member/login.do'});
	}
	
	function authGoogle(){
		hello('google').login({scope: 'email'}).then(function(auth) {
			hello(auth.network).api('/me').then(function(r) {
				accessToken = auth.authResponse.access_token;
				getGoogleMe(); 
			});
		});
	}

	function getGoogleMe(){
		hello('google').api('me').then(
			function(json) {
				succLoginWithGoogle(json.id, json.name, json.gender == "male" ? "1" : "2");
			}, 
			function(e) {
	    		console.log('me error : ' + e.error.message);
			}
		);
	}
	
	function kakaoInit() {
		$("#kakao_login_button").attr("src", kakao_button_image);	
		
		Kakao.init(kakao_key);		
	}
	
	function facebookInit() {
		$("#facebook_login_button").attr("src", facebook_button_image);		
		
		document.getElementById('facebook_login_button').addEventListener('click', function() {
		    //do the login
		    FB.login(checkLoginState, {scope: 'email,public_profile', return_scopes: true});
		}, false);
		
		window.fbAsyncInit = function() {
			FB.init({
				appId      : facebook_key,
				cookie     : true,
				xfbml      : true,
				version    : facebook_version
			});
			    
			FB.AppEvents.logPageView();   		    
		};
	
		(function(d, s, id){
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) {return;}
			js = d.createElement(s); js.id = id;
			js.src = "https://connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));		
	}
	
	function loginWithKakao() {
	  // 로그인 창을 띄웁니다.
	  Kakao.Auth.login({
	    success: function(authObj) {
	    	Kakao.API.request({
	            url: '/v2/user/me',
	            success: function(res) {
	            	succLoginWithKakao(res.id, res.properties.nickname, "");
	        },
	        fail: function(error) {
	          alert(JSON.stringify(error));
	        }
	      });
	    },
	    fail: function(err) {
	      alert(JSON.stringify(err));
	    }
	  });
	}
	
	function checkLoginState() {
		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
				FB.api('/me', function(response) {
					succLoginWithFacebook(response.id, response.name, "");
				});
			}
		});		
	}
	
	function succLoginWithGoogle(id, name, gender) {
		gender = "";
		actionLoginForSocial("GOOGLE", id, name, gender);
	}
	
	function succLoginWithNaver(id, name, gender) {
		if(gender == "M") {
			gender = "1";
		} else if(gender == "F") {
			gender = "2";
		} else {
			gender = "";
		}
		actionLoginForSocial("NAVER", id, name, gender);
	}
	
	function succLoginWithKakao(id, name, gender) {
		actionLoginForSocial("KAKAO", id, name, gender);
	}
	
	function succLoginWithFacebook(id, name, gender) {
		actionLoginForSocial("FACEBOOK", id, name, gender);
	}
	
	function actionLoginForSocial(type, id, name, gender) {
		var sUrl = "<c:url value='/hills/member/signUpForSocial.do'/>";
		var sParams = "";
		
		if (type != "") {
			sParams += String.format("msLoginCd={0}", type);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}
		
		if (id != "") {
			sParams += String.format("&msId={0}", id);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}
		
		if (name != "") {
			sParams += String.format("&msName={0}", name);
		} else {
			alert("알 수 없는 오류입니다. 다시 시도해주세요.");
		}
		
		if (gender != "") {
			sParams += String.format("&msSex={0}", gender);
		}
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode == "0000") {
				location.href = "<c:url value='/hills/index.do'/>";
			} else if(data.resultCode == "1000") {
				var msNum = data.rows.msNum;
				var msName = data.rows.msName;
				var msId = data.rows.msId
				var msLoginCd = data.rows.msLoginCd
				
				location.href = "<c:url value='/hills/member/join05.do'/>?msNum=" + msNum + "&msName=" + msName + "&msId=" + msId + "&msLoginCd=" + msLoginCd;
			} else {
				alert(data.resultMessage);
			}
		});
	}	
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>Member &nbsp;&nbsp;&nbsp; ＞ <span>로그인</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">로그인</span>
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>

		<div class="grayBgBox" style="overflow:hidden;">
			
			<div class="logTab">
				<a href="javascript:void(0)" class="loginTab">로그인</a>
				<a href="<c:url value='/hills/member/join02.do'/>" class="LoginjoinTab">회원가입</a>
			</div>
			<div class="loginBox1">		
				<div class="loginCont">
					 <span class="loginTitle">로그인 하시면 더 많은 혜택이 쏟아집니다~!</span>
					 <ul class="loginInput">
						<li>
						  <input type="text" value="" placeholder="아이디&핸드폰번호로 로그인 가능합니다." id="msId">
						</li>
						<li>
						  <input type="password" maxlength="20" placeholder="비밀번호" id="msPw">
						</li>
					 </ul>
					 <a href="javascript:actionLogin()" class="loginBtn">로그인</a>

					 <div class="memBox">
						  <span><input type="checkbox" name="checkbox" id="chkSaveId">
						 &nbsp;아이디저장 </span>
						 <span><input type="checkbox" name="checkbox" id="chkAutoLogin">
						 &nbsp;로그인유지 </span>
					 </div>	
					 <div class="LogFindBtn">
						<a href="<c:url value='/hills/member/find.do'/>" class="id_Btn">아이디찾기</a>
						<a href="<c:url value='/hills/member/find.do'/>">비밀번호찾기</a>
					 </div>
					 <span class="loginTitle">SNS계정으로 간편가입 및 로그인이 가능합니다.</span>
 
					 <div class="snsJoinBox">
					 	<div id="naver_id_login" style="display:inline-block;"></div>
					 	<script type="text/javascript">
							var naver_id_login = new naver_id_login(naver_key, naver_callback);
							var state = naver_id_login.getUniqState();
							naver_id_login.setButton("", 10, "", naver_button_image);//네이버 로그인 이미지 
							naver_id_login.setDomain(naver_domain);
							naver_id_login.setState(state);
							naver_id_login.setPopup();
							naver_id_login.init_naver_id_login();
						</script>
						<img id="facebook_login_button" width="110px"/>
						<a id="custom-login-btn" href="javascript:loginWithKakao()"><img id="kakao_login_button"/></a>
						<img src="<c:url value='/images/hills/login_google.png'/>" alt="" onclick="authGoogle()">
					 </div>		
				</div>
				
				<div class="etcWrap">
					<p><img src="<c:url value='/images/hills/text_etc.png'/>" alt=""></p>
					<div class="etcBnBox">
						<ul>
							<li>
								<a href="<c:url value='/hills/board/view.do?bbsType=51&idx=94'/>"><img src="<c:url value='/images/hills/bn_etc1.jpg'/>" alt=""></a>
								<h3>원진성형외과</h3>
							</li>
							<li>
								<a href="<c:url value='/hills/board/view.do?bbsType=53&idx=83'/>"><img src="<c:url value='/images/hills/bn_etc2.jpg'/>" alt=""></a>
								<h3>메이필드호텔</h3>
							</li>
							<li>
								<a href="<c:url value='/hills/board/view.do?bbsType=53&idx=84'/>"><img src="<c:url value='/images/hills/bn_etc3.jpg'/>" alt=""></a>
								<h3>원마운트</h3>
							</li>
							<li>
								<a href="<c:url value='/hills/board/view.do?bbsType=54&idx=82'/>"><img src="<c:url value='/images/hills/bn_etc4.jpg'/>" alt=""></a>
								<h3>일산<br>타이어프로</h3>
							</li>							
						</ul>
					</div>
					<h2><a href="<c:url value='/hills/board/list.do?bbsType=51'/>"><img src="<c:url value='/images/hills/btn_etcM.png'/>" alt=""></a></h2>
					<div class="etcCover">
						<p>제휴종료<br>
						준비중입니다.</p>
					</div>
				</div>
			
			</div><!-- loginBox End -->
		</div>
 
	</div><!-- contents End -->
</div>
<jsp:include page="../include/footer.jsp" flush="true" />