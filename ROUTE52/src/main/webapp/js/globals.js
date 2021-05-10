globals = function() {
	
}

globals.coDiv = function() {

}

globals.coDiv.valley = "61";
globals.coDiv.hills  = "65";

globals.personCd = function() {

}

globals.personCd.three = "01";
globals.personCd.four =	"02";

globals.personCd.codeNm = function(code) {
	if(code == globals.personCd.three) {
		return "3~4인";
	} else if(code == globals.personCd.four) {
		return "4인"; 
	} else {
		return "4인"; 
	}
}