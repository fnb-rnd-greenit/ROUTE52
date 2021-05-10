function objectTAG(name,file,width,height,wmode,bgcolor) {
	document.write('\
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="'+width+'" height="'+height+'" id="'+name+'" align="middle">\
<param name="allowScriptAccess" value="sameDomain">\
<param name="movie" value="'+file+'">\
<param name="quality" value="high">\
<param name="wmode" value="'+wmode+'">\
<param name="bgcolor" value="'+bgcolor+'">\
<embed src="'+file+'" quality="high" wmode="'+wmode+'" bgcolor="'+bgcolor+'" width="'+width+'" height="'+height+'" name="'+name+'" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="https://www.macromedia.com/go/getflashplayer">\
</object>\
	');
}

function embedTAG() {

}

function appletTAG() {

}


<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'block':(v=='hide')?'none':v; }
    obj.display=v; }
}
//-->

<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a = document.MM_sr;
  for(i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) {
	x.src = x.oSrc;
  }
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}

function view_notice(flag) {
	for (var i=0; i < 3; i++){
		downnum = document.getElementById('sMenu'+i);
		if (flag == i)
		{
			downnum.style.display = "block";
		}else {
			downnum.style.display = "none";
		}
	}
}
//-->

function bluring(){ 
if(event.srcElement.tagName=="A"||event.srcElement.tagName=="IMG") 

document.body.focus(); 
} 
document.onfocusin=bluring; 

<!--

function w_open(){
		noticeWindow  =  window.open('/include/mail_out.asp','11','scrollbars=no,status=no,toolbar=no,menubar=no,width=830,height=460,top=0,left=0');
		noticeWindow.opener = self;
}
function w_open2(){
		noticeWindow  =  window.open('/include/mail_out2.asp','22','scrollbars=no,status=no,toolbar=no,menubar=no,width=700,height=239,top=0,left=0');
		noticeWindow.opener = self;
}

//예약서비스
	 function goReservMenuView2()
	 {
	 tempBookDate = "";
     bk_div = "";
	  var divpop = document.getElementById( "reserv");

//	  divpop.style.visibility = "visible";
	  divpop.style.display = "block";
	 }

	 function goReservMenuView()
	 {
	 tempBookDate = "";
     bk_div = "";
	  var divpop = document.getElementById( "reserv");

//	alert(divpop);

		  if (divpop == null)
		  {
			  alert('로그인이 되어 있지 않습니다. 로그인을 해주세요.');
			  location.href = "/08membership/membership01.asp";
		  }else{

	//	  divpop.style.visibility = "visible";
		  divpop.style.display = "block";
		  }
	 }

	 function goReservParMenuView()
	 {
	 tempBookDate = "";
     bk_div = "";
	  var divpop2 = document.getElementById( "reserv_par");

//	alert(divpop);

		  if (divpop2 == null)
		  {
			  alert('로그인이 되어 있지 않습니다. 로그인을 해주세요.');
			  location.href = "/08membership/membership01.asp";
		  }else{

	//	  divpop.style.visibility = "visible";
		  divpop2.style.display = "block";
		  }
	 }
//-->



<!--
 self.onError=null;
 currentX = currentY = 0;
 whichIt = null;
 lastScrollX = 0; lastScrollY = 0;
 action = window.setInterval('heartBeat()',1);
 
 function heartBeat() { 
  diffY = document.body.scrollTop;
  diffX = 0;
  if (diffY != lastScrollY) {
   percent = .2 * (diffY - lastScrollY);
  if (percent > 0) {
   percent = Math.ceil(percent);
   }
   else {
   percent = Math.floor(percent);
   }
   document.all.layer_right.style.pixelTop += percent;
   lastScrollY = lastScrollY + percent;
   }
  if (diffX != lastScrollX) {
   percent = .2 * (diffX - lastScrollX);
  if (percent > 0) {
   percent = Math.ceil(percent);
   }
   else {
   percent = Math.floor(percent);
   }
   document.all.layer_right.style.pixelLeft += percent;
   lastScrollY = lastScrollY + percent;
   }
 }

-->
