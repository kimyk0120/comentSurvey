<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
        
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" />
<title>출고 등록</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
	
	$(function() {
		$('.formSelect').sSelect();
		$("#appl_dt").datepicker({
	    });
	});

	
	$(document).ready(function() {
		
		var auth = "<c:out value="${srch.auth}"/>";
		
		if(auth == '002') {
			$("#dlvr_objt_code").val(auth); 
		}
	});

	function dlvr_edit() {
		document.mainform.action = "prod_dlvr_edit.do";
		document.mainform.submit();
	}
	
	function go_list() {
		
		document.mainform.action = "prod_dlvr_list.do";
		document.mainform.submit();
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
		//document.mainform.action = url;
		//document.mainform.submit();
	}
	
	function cmaComma(obj) {
		var strNum = /^[/,/,0-9]*$/;
		var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }

		while(regx.test(str)){  
	        str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str;
	}
	
	function get_price() {
		
		var p = $("#prod_code option:selected").val();
		
		var d = $("#dlvr_objt option:selected").val();
		mainform.dlvr_objt_code.value=d;
		
		if(p != null && p!= "" && mainform.dlvr_objt_code.value != null && mainform.dlvr_objt_code.value != "") {
			$.ajax({ 
				   url: "get_price.do", 
				   type: "POST", 
				   data: {"p_code" : p, "d_code" : mainform.dlvr_objt_code.value},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   
					   if(msg != null && msg != "") {
					   	$('#unit_price').val(msg);
					   }
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				});
		}
		
		if( p == "B02") {
			var str = "<select class=\"formSelect\" style=\"width:100px;\" id=\"cust_objt_no\" name=\"cust_objt_no\">";
			str = str + "<c\:forEach items=\"${b_list}\" var=\"b\" ><option value=\"${b.branch_code }\">${b.branch_name}</option></c\:forEach></select>";
			document.getElementById("div_srch_cust").innerHTML=str;
		} else {
			var str = "<input type=\"text\" id=\"srch_c\" name=\"srch_c\" onkeyup=\"javascript:srch_cust()\" placeholder=\"강사명 검색\" style=\"width:120px\"/><div id=\"div_c\" style=\"display:inline;\"></div>";
			document.getElementById("div_srch_cust").innerHTML=str;
		}
	}
	
	function get_amt(obj) {
		var p = mainform.unit_price.value;
		var q = mainform.qty.value;
		
		var strNum = /^[/,/,0-9]*$/; // 숫자와 , 만 가능
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }
		
		var regx = new RegExp(/(-?\d+)(\d{3})/);
		
		if (p != null && p != "" && q != null && q != "") {
			var a = parseInt(p) * parseInt(q); 
			a = a.toString();
			a = a.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			mainform.amt.value= a;
		}
	}
	
	function get_tot_amt(obj) {
		var p = mainform.unit_price.value;
		var q = mainform.dlvr_qty.value;
		
		var strNum = /^[/,/,0-9]*$/; // 숫자와 , 만 가능
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }
		
		var regx = new RegExp(/(-?\d+)(\d{3})/);
		
		if (p != null && p != "" && q != null && q != "") {
			var a = parseInt(p) * parseInt(q); 
			a = a.toString();
			a = a.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			mainform.tot_amt.value= a;
		}
	}
	
	function srch_cust(){
		
		var c = $('#srch_c').val();
		var p = $("#dlvr_objt option:selected").val();
		if(p == null || p == "") {
			alert("출고분류를 먼저 선택해주세요");
			$("#dlvr_objt").focus();
			return false;
		} else {
		
			$.ajax({ 
			   url: "srch_cust.do", 
			   type: "POST", 
			   data: {"dlvr_objt" : p, "srch_name" : c},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				  
				     var tmp = msg.split('|');
				     var str = "<select class=\"formSelect\" id=\"cust_objt_no\" name=\"cust_objt_no\" style=\"width:180px;\">";
				     	str = str + "<option value=\"\">선택</option>";
				     for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split("`");
	         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
						   
					   str = str+"</select>";
					   document.getElementById("div_c").innerHTML=str;
					   
					   $('.formSelect').sSelect();
					  
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
		}
	}
	
</script>
</head>
<body>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="d_no" name="d_no" value="${info.dlvr_no}"/>
<input type="hidden" id="dlvr_objt_code" name="dlvr_objt_code" />
<input type="hidden" id="srch_dlvr_objt" name="srch_dlvr_objt" value="${srch.srch_dlvr_objt }"/>
<input type="hidden" id="srch_name" name="srch_name" value="${srch.srch_name }"/>
<input type="hidden" id="srch_prod" name="srch_prod" value="${srch.srch_prod }"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />
		
		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">출고상세</h2>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>신청일자</th>
						<td colspan="3"> ${info.appl_date }</td>
					</tr>
					<tr>
						<th>품목명</th>
						<td colspan="3">${info.prod_name}</td>
					</tr>
					<tr>
						<th>출고분류</th>
						<td>${info.dlvr_objt_code_nm}</td>
						<th>인수자</th>
						<td>${info.name }</td>
					</tr>
					<tr>
						<th>출고단가</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.unit_price}" /></td>
						<th>판매분류</th>
						<td>${info.dlvr_prt_code_nm }</td>
					</tr>
					<tr>
						<th>수량</th>
						<td>${info.qty } </td>
						<th>금액</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.amt}" /></td>
					</tr>
					<tr>
						<th>출고수량</th>
						<td>${info.dlvr_qty }</td>
						<th>출고금액</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.tot_amt}" /></td>
					</tr>
					<tr>
						<th>부가세</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.vat}" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th>입금액</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.cllc_amt}" /></td>
						<th>입금일</th>
						<td>${info.cllc_dt }</td>
					</tr>
					<tr>
						<th>출고여부</th>
						<td>${info.cmpl_yn }</td>
						<th>출고일</th>
						<td>${info.dlvr_dt }</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:dlvr_edit()" class="btn-negative"><span>수정</span></a>
				<a href="javascript:go_list()"><span>리스트</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>