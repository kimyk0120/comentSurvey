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
<title>지점 상세정보</title>
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

	function branch_edit() {
		document.mainform.action = "branch_edit.do";
		document.mainform.submit();
	}
	
	function go_list() {
		document.mainform.action = "branch_list.do";
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
<input type="hidden" id="b_cd" name="b_cd" value="${info.branch_code }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido}"/>
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}"/>
<input type="hidden" id="srch_branch" name="srch_branch" value="${srch.srch_branch}"/>

<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">지점 상세정보</h2>
				<h3 class="mb0">${info.branch_name }</h3>
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
						<th>지점코드</th>
						<td>${info.branch_code}</td>
						<th>이메일(아이디)</th>
						<td>${info.branch_manager_id}</td>
					</tr>
					<tr>
						<th>지점명</th>
						<td>${info.branch_name}</td>
						<th>등록일</th>
						<td>${info.resist_date }</td>
					</tr>
					<tr>
						<th>지점장</th>
						<td>${info.branch_manager_name}</td>
						<th>생년월일</th>
						<td>${info.manager_birth }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">${info.phone }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm } ${info.gugun_code_nm } ${info.address } </td>
					</tr>
					<tr>
						<th>최초계약일</th>
						<td>${info.fst_cntr_dt}</td>
						<th>계약기간</th>
						<td>${info.cntr_prd }년</td> 
					</tr>
					<tr>
						<th>개점일</th>
						<td>${info.open_dt}</td>
						<th>재계약횟수</th>
						<td>${info.re_cntr_cnt }</td>
					</tr>
					<tr>
						<th>재계약일</th>
						<td>${info.re_cntr_dt}</td>
						<th>만료일</th>
						<td>${info.expr_dt }</td>
					</tr>
					<tr>
						<th>가맹금</th>
						<td><fmt:formatNumber value="${info.join_tot_amt }"/> 원</td>
						<th>가맹비</th>
						<td><fmt:formatNumber value="${info.join_amt }"/> 원</td>
					</tr>
					<tr>
						<th>교육비</th>
						<td><fmt:formatNumber value="${info.edu_amt }"/> 원</td>
						<th>보증금</th>
						<td><fmt:formatNumber value="${info.grnt_amt }"/> 원</td>
					</tr>
					<tr>
						<th>로열티(월정료)</th>
						<td><fmt:formatNumber value="${info.royal_amt }"/> 원</td>
						<th>납부일</th>
						<td>${info.pay_dt }</td>
					</tr>
					<tr>
						<th>사업자등록번호</th>
						<td>${info.resist_no}</td>
						<th>상호</th>
						<td>${info.shop_name }</td>
					</tr>
					<tr>
						<th>대표자</th>
						<td>${info.rpst_name}</td>
						<th>사업장주소</th>
						<td>${info.shop_address }</td>
					</tr>
					<tr>
						<th>사업장전화번호</th>
						<td>${info.shop_phone}</td>
						<th>FAX</th>
						<td>${info.shop_fax }</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3"  class="padding-cell" style="height:50px">${info.bigo }</td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-block">
				<a href="javascript:branch_edit()"><span>수정</span></a>
				<a href="javascript:go_list()" class="btn-gray"><span>리스트</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>

</body>
</html>