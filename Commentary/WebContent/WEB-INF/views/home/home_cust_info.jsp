<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
        
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" />
<title>고객 상세정보</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">

	function go_list() {
		
		document.mainform.action = "home_cust_list.do";
		document.mainform.submit();
	}
	
	function home_cust_edit() {
		document.mainform.action = "home_cust_edit.do";
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
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no}"/>
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido}"/>
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}"/>
<input type="hidden" id="srch_cust" name="srch_cust" value="${srch.srch_cust}"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone}"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

<div id="wrapper">

		<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />
		
		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">고객상세정보</h2>
				<h3 class="mb0">${info.cust_nm} 고객</h3>
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
						<th>고객명</th>
						<td>${info.cust_nm}</td>
						<th>최초등록일</th>
						<td>${info.resist_dt }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm} ${info.gugun_code_nm} ${info.address }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">${info.phone }</td>
					</tr>
					<tr>
						<th>지하철역</th>
						<td>${info.subway }</td>
						<th>거주형태</th>
						<td>${info.live_prt}</td>
					</tr>
					<tr>
						<th>가족수</th>
						<td>${info.fmly_cnt } </td>
						<th>평수</th>
						<td>${info.house_space } </td>
					</tr>
					<tr>
						<th>첫째출생년도</th>
						<td> 
						 	<c:set var="yyy"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
							<c:set var="yy"><fmt:formatNumber value="${yyy}" pattern="####"/> </c:set>
							${info.fst_kid_birth} 년도
							<c:if test="${info.fst_kid_birth ne null and info.fst_kid_birth ne '' }" >
								<c:set var="fst"><fmt:formatNumber value="${info.fst_kid_birth}" pattern="####"/></c:set>
								<c:set var="f" value="${yy - fst +1}" />  
								( ${f} 세 ) 
							</c:if> 
						</td>
						<th>둘째출생년도</th>
						<td>
							${info.scd_kid_birth}  년도
							<c:if test="${info.scd_kid_birth ne null and info.scd_kid_birth ne '' }" >
								<c:set var="scd"><fmt:formatNumber value="${info.scd_kid_birth}" pattern="####"/></c:set>
								<c:set var="s" value="${yy - scd +1}" />  
								( ${s} 세 ) 
							</c:if> 
						
						</td>
					</tr>
				</tbody>
			</table>
			
			<dl class="table-dl mt35"><!-- 개인 정보와 떨어져 있는 처음 dl 에만 mt35 삽입 -->
				<dt>
					작업기록
				</dt>
				<dd>
					<table class="talbe-inner">
						<colgroup>
							<col style="width:20%" />
							<col style="width:15%" />
							<col style="width:20%" />
							<col style="width:25%" />
							<col style="width:20%" />
						</colgroup>
						<thead>
							<tr>
								<th>일자</th>
								<th>상태</th>
								<th>금액</th>
								<th>서비스명</th>
								<th>가정관리사</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${c_list}" var="c" varStatus="status">
								<tr>
									<td>${c.cnsl_dt}</td>
									<td>${c.home_mng_prt}</td>
									<td>${c.cust_amt}</td>
									<td>${c.home_mng_srvc_code_nm}</td>
									<td>${c.home_mngr_name}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</dd>
			</dl>
			

			<div class="btn-block">
				<a href="javascript:home_cust_edit();" class="btn-negative"><span>수정</span></a>
				<a href="javascript:go_list();"><span>리스트</span></a>
			</div><!--// btn-block -->
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</body>
</html>