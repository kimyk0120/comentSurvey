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
<title>상품 상세정보</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
	
	function pchs_cust_save() {
		
		var p1 = $('#ph1').val();
		var p2 = $('#ph2').val();
		var p3 = $('#ph3').val();
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.phone.value=p1+"-"+p2+"-"+p3;
		}
		
		document.mainform.action = "pchs_cust_save.do";
		document.mainform.submit();
	}
	
	$(function() {
		$('.formSelect').sSelect();
	});

	
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
<input type="hidden" id="phone" name="phone"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />
		
		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">거래처 등록</h2>
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:30%" />
					<col style="width:70%" />
				</colgroup>
				<tbody>
					<tr>
						<th>거래처명</th>
						<td><input type="text" id="pchs_cust_name" name="pchs_cust_name" /></td>
					</tr>
					<tr>
						<th>담당자</th>
						<td><input type="text" id="pchs_chrg_name" name="pchs_chrg_name" /></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<select class="formSelect" style="width:60px" id="ph1" name="ph1">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph2" name="ph2" style="width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" style="width:40px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>주요품목</th>
						<td>
							<select class="formSelect" style="width:150px;" title="" id="main_prod_code" name="main_prod_code">
								<option value="" selected="selected">구분</option>
								<c:forEach items="${p_list}" var="p" > 
									<option value="${p.prod_code }">${p.prod_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:pchs_cust_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>