<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

	var rows;
	var imageUrl = "https://kr.object.ncloudstorage.com/fnb/{0}/{1}";

	function onLoadMenu() {
		doSearchShop();
		
		$("#txt_menu_keyword").keypress(function (event) {
	        if(event.keyCode == 13) {
	        	doSearchMenus();
	        }
	    });
		
		$("#selCompanyShop").on("change", function() {
			$("#txtShopName").html($("#selCompanyShop option:checked").text());
			doSearchMenus();
		});
	}
	
	function doSearchShop() {
		var sUrl = "<c:url value='/admin/getShop.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var rows = data.rows;
				
				$("#txt_menu_keyword").val("");
				
				$("#tbody-menu").empty();
				
				$("#selCompanyShop").empty();
				
				$("#selCompanyShop").append("<option value=''>선택</option>");
				
				for(i=0; i<rows.length; i++) {
					$("#selCompanyShop").append("<option value='" + rows[i].CD_CODE + "'>" + rows[i].CD_NAME + "</option>");
				} 
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function doSearchMenus() {
		var sUrl = "<c:url value='/admin/getMenus.do'/>";
		var sParams = "";
		
		var shop = $("#selCompanyShop").val();
		var keyword = $("#txt_menu_keyword").val();
		
		if(shop == "") {
			alert("영업장을 선택해주세요.");
			return;
		}
		
		sParams += String.format("coDiv={0}", mCoDiv);
		sParams += String.format("&shop={0}", shop);
		sParams += String.format("&keyword={0}", keyword);
		
		progressStart();
		
		mAjax(sUrl, sParams, function(data) {
			progressStop();
			
			if(data.resultCode = "0000") {
				var tbody = $("#tbody-menu");
				tbody.empty();
				
				rows = data.rows;
				
				for(i=0; i<rows.length; i++) {
					var row = $("<tr></tr>"); 
					
					var image = "";
					
					if(rows[i].PD_IMAGE_URL != "") {
						image = String.format(imageUrl, mCoDiv, rows[i].PD_IMAGE_URL);
					}
					
					var col1 = $(String.format("<div class='menuImg'><img src='{0}'></div>", image)); 
				    var col2 = $(String.format("<td>{0}</td>", rows[i].PD_CD)); 
				    var col3 = $(String.format("<td>{0}</td>", rows[i].PD_NAME)); 
				    var col4 = $(String.format("<td>{0}</td>", rows[i].PD_IMAGE_URL)); 
				    var col5 = $(String.format("<td><input type='file' id='file_{0}' name='file_{0}'></td>", i)); 
				    var col6 = $(String.format("<td><input type='number' name='no_{0}' id='no_{0}' value='{1}'></td>", i, rows[i].FNB_ORDER_BY));
				    var col7 = $(String.format("<td><input type='checkbox' name='use_{0}' id='use_{0}' {1}></td>", i, (rows[i].CART_USEYN == "Y" ? "checked" : "")));
				    var col8 = $(String.format("<td><a href='javascript:saveMenu({0})'><span class='btn blueBg'>등록</span></a></td>", i)); 
				    var col9 = $(String.format("<td><a href='javascript:deleteMenuImage({0})'><span class='btn grayBg'>삭제</span></a></td>", i)); 
				    
					row.append(col1,col2,col3,col4,col5,col6,col7,col8,col9).appendTo(tbody); 
				} 
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function deleteMenuImage(idx) {
		var sUrl = "<c:url value='/admin/deleteMenuImage.do'/>";
		var sParams = "";
		
		sParams += String.format("coDiv={0}", mCoDiv);
		sParams += String.format("&pdCd={0}", rows[idx].PD_CD);
		
		mAjax(sUrl, sParams, function(data) {
			if(data.resultCode == "0000") {
				alert("이미지가 삭제 되었습니다.");
				
				doSearchMenus();
			} else {
				alert(data.resultMessage);
			}
		});
	}
	
	function saveMenu(idx) {
		var sUrl = "<c:url value='/admin/saveMenu.do'/>";
		
		$("#m_coDiv").val(mCoDiv);
		$("#m_idx").val(idx);
		$("#m_pdCd").val(rows[idx].PD_CD);

		var no = $(String.format("{0}no_{1}", "#", idx)).val();
		$("#m_no").val(no);
		
		var use = $(String.format("input:checkbox[id='use_{0}']", idx)).is(":checked") ? "Y" : "N";
		$("#m_use").val(use);
		
        var formData = new FormData($("#menu_form")[0]);
        
        progressStart();
		
        mFileAjax(sUrl, formData, function(data) {
        	progressStop();
        	
        	if(data.resultCode == "0000") {
         		alert("등록 되었습니다.");
         		
         		doSearchMenus();
            } else {
         	   alert(data.resultMessage);
            }
        });
	}

</script>

<div class="admin_wrap">	
	<div class="searchWrap">
		<ul class="search_title" id="txtShopName"> 대식당	</ul>
		<ul class="search1">
		    <li>
		      <input type="text" name="SearchString" id="txt_menu_keyword" placeholder="상품코드, 상품명 입력해주세요." value="">
		    </li>
		    <li><a href="javascript:doSearchMenus()"><span class="btn">검색</span></a></li>
		</ul>
	</div>

	<form id='menu_form' action='fileUpload' method='post' enctype='multipart/form-data'>
	
		<input type="hidden" id="m_coDiv" name="m_coDiv">
		<input type="hidden" id="m_pdCd" name="m_pdCd">
		<input type="hidden" id="m_idx" name="m_idx">
		<input type="hidden" id="m_use" name="m_use">
		<input type="hidden" id="m_no" name="m_no">
	
		<table class="commonTable">
			<caption>메뉴관리</caption>
			<colgroup>
				<col width="20%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="18%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
			</colgroup>
			<tr>
				<th>이미지</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>이미지</th>
				<th>파일 (권장사이즈 - 600 * 400)</th>
				<th>순번</th>
				<th>사용여부</th>
				<th>등록</th>
				<th>삭제</th>
			</tr>
			<tbody id="tbody-menu">			
			</tbody>
		</table>

	</form>
</div>