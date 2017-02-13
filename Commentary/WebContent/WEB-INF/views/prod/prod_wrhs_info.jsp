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
<title>입고 상세</title>
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
	});

	
	$(document).ready(function() {
		
	});

	function wrhs_edit() {
		document.mainform.action = "prod_wrhs_edit.do";
		document.mainform.submit();
	}
	
	function go_list() {
		
		document.mainform.action = "prod_wrhs_list.do";
		document.mainform.submit();
	}
	
	function moveUrl(t, l, url ) {
		mainform.top.value=t;
		mainform.left.value=l;
		location.href = url+"?top="+t+"&left="+l;
		//document.mainform.action = url;
		//document.mainform.submit();
	}
	
</script>
</head>
<body>

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="w_no" name="w_no" value="${info.wrhs_no}"/>
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
				<h2 class="mb0">입고상세</h2>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:30%" />
					<col style="width:70%" />
				</colgroup>
				<tbody>
					<tr>
						<th>신청일자</th>
						<td> ${info.odr_dt}</td>
					</tr>
					<tr>
						<th>품목명</th>
						<td>${info.prod_name}</td>
					</tr>
					<tr>
						<th>거래처</th>
						<td>${info.pchs_cust_name}</td>
					</tr>
					<tr>
						<th>출고단가</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.unit_price}" /> <span>\</span></td>
					</tr>
					<tr>
						<th>수량</th>
						<td>${info.qty } 개</td>
					</tr>
					<tr>
						<th>금액</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.amt}" /> <span>\</span></td>
					</tr>
					<tr>
						<th>지급액</th>
						<td><fmt:formatNumber pattern="#,###" value="${info.pay}" /> <span>\</span></td>
					</tr>
					<tr>
						<th>지급일</th>
						<td>${info.pay_dt}</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:wrhs_edit()" class="btn-negative"><span>수정</span></a>
				<a href="javascript:go_list()"><span>리스트</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>