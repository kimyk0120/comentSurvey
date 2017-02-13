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
<title>출고</title>
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
		
		var srchDlvr = "<c:out value="${srch.srch_dlvr_objt}"/>";
		
		if(srchDlvr != null && srchDlvr != '') {
			$("#srch_dlvr_objt").val(srchDlvr).change(); 
		}
		
		$.datepicker.regional['ko'] = {
	            closeText: '닫기',
	            prevText: '이전달',
	            nextText: '다음달',
	            currentText: '오늘',
	            monthNames: ['1월','2월','3월','4월','5월','6월',
	            '7월','8월','9월','10월','11월','12월'],
	            monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	            '7월','8월','9월','10월','11월','12월'],
	            dayNames: ['일','월','화','수','목','금','토'],
	            dayNamesShort: ['일','월','화','수','목','금','토'],
	            dayNamesMin: ['일','월','화','수','목','금','토'],
	            buttonImageOnly: false,
	            weekHeader: 'Wk',
	            dateFormat: 'yy-mm-dd',
	            firstDay: 0,
	            isRTL: false,
	            duration:200,
	            showAnim:'show',
	            showMonthAfterYear: true
	          //  minDate: +0
        };
	      $.datepicker.setDefaults($.datepicker.regional['ko']);
		
		$( '#srch_str_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",//날짜 출력 형식
			onClose: function( selectedDate ) {
				$( '#srch_end_dt' ).datepicker( 'option', 'minDate', selectedDate );
			}
		});
		$( '#srch_end_dt' ).datepicker({
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			changeYear:true, //년 셀렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",//날짜 출력 형식
			onClose: function( selectedDate ) {
				$( '#srch_str_dt' ).datepicker( 'option', 'maxDate', selectedDate );
			}
		});
	});
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "prod_dlvr_list.do";
		document.mainform.submit();
	}
	
	function dlvr_create() {
		document.mainform.action = "prod_dlvr_create.do";
		document.mainform.submit();
	}
	
	function srch_prod() {
		document.mainform.action = "prod_dlvr_list.do";
		document.mainform.submit();
	}
	
	
	function prod_dlvr_info(seq) {
		mainform.d_no.value = seq;
		document.mainform.action = "prod_dlvr_info.do";
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
<div id="wrapper">

		<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"  value="" />
<input type="hidden" id="d_no" name="d_no"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>출고</h2>
				<div class="btn-block">
					<a href="javascript:dlvr_create()"><span>출고신청</span></a>
				</div>
			</div>

			<div class="search-block">
				<c:if test="${srch.auth eq '001'}" >
					<div class="search-row">
						<select class="formSelect" style="width:100px;" title="" id="srch_dlvr_objt" name="srch_dlvr_objt">
							<option value="" selected="selected">구분</option>
							<c:forEach items="${d_list}" var="d" > 
								<option value="${d.dlvr_objt_code }">${d.dlvr_objt_code_nm }</option>
							</c:forEach>
						</select>
					</div>
				</c:if>
				<div class="search-row">
					<select class="formSelect" style="width:100px;margin-right:20px" title="" id="srch_cmpl_yn" name="srch_cmpl_yn">
						<option value="">출고여부</option>
						<option value="Y" <c:if test="${srch.srch_cmpl_yn eq 'Y'}">selected="selected"</c:if> >출고완료</option>
						<option value="N" <c:if test="${srch.srch_cmpl_yn eq 'N'}">selected="selected"</c:if> >미출고</option>
					</select>
					<input type="text" id="srch_name" name="srch_name" placeholder="이름검색" value="${srch.srch_name}" class="readonly" />
					<input type="text" id="srch_prod" name="srch_prod" placeholder="폼목명 검색" value="${srch.srch_prod}" class="readonly" />
					<span class="txt-label">기간</span>
					<span class="set-date">
						<input type="text" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt}" placeholder="시작일" style="width:65px;" />
						<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
					</span>
					<span class="txt-symbol">~</span>
					<span class="set-date">
						<input type="text" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt}" placeholder="종료일" style="width:65px;" />
						<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="종료일 선택" /></span><!-- 달력 선택 버튼 -->
					</span>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:srch_prod()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:30%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th style="padding:0px 5px">No</th>
						<th style="padding:0px 5px">일자</th>
						<th style="padding:0px 5px">품목</th>
						<th style="padding:0px 5px">출고여부</th>
						<th style="padding:0px 5px">거래처</th>
						<th style="padding:0px 5px">수량</th>
						<th style="padding:0px 5px">단가</th>
						<th style="padding:0px 5px">총액</th>
						<th style="padding:0px 5px">입금액</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr onclick="javascript:prod_dlvr_info('${c.dlvr_no}')">
						<td style="padding:0px 5px">${c.row_num}</td>
						<td style="padding:0px 5px">${c.appl_date}</td>
						<td style="padding:0px 5px">${c.prod_name}</td>
						<td style="padding:0px 5px">
							<c:choose>
								<c:when test="${c.cmpl_yn eq 'Y'}" >완료</c:when>
								<c:otherwise>미출고</c:otherwise>
							</c:choose>
						</td>
						<td style="padding:0px 5px">${c.dlvr_objt_code_nm} / ${c.name }</td>
						<td style="padding:0px 5px">${c.qty} </td>
						<td style="padding:0px 5px"><fmt:formatNumber value="${c.unit_price}"/></td>
						<td style="padding:0px 5px"><fmt:formatNumber value="${c.amt}"/></td>
						<td style="padding:0px 5px"><fmt:formatNumber value="${c.cllc_amt}"/></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<ul class="paging">
				<c:if test="${count > 0}">
				   <c:set var="pageCount" value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}"/>
				   <c:set var="startPage" value="${pageGroupSize*(numPageGroup-1)+1}"/>
				   <c:set var="endPage" value="${startPage + pageGroupSize-1}"/>
				   <c:if test="${endPage > pageCount}" ><c:set var="endPage" value="${pageCount}" /></c:if>
				          
				   <c:if test="${numPageGroup > 1}">
				   		<li><a class="no-bg" href="javascript:go_page('1')">&lt;</a></li>
				   		<li><a class="no-bg" href="javascript:go_page('${(numPageGroup-2)*pageGroupSize+1 }')">&lt;&lt;</a></li>
				   </c:if>
				
				   <c:forEach var="i" begin="${startPage}" end="${endPage}">
				       <li>
				           <c:choose>
				               <c:when test="${currentPage == i}">
				               		<a href="javascript:go_page('${i}')" class="no-bg on">${i}</a>
				               </c:when>
				               <c:otherwise>
						       		<a href="javascript:go_page('${i}')" class="no-bg">${i}</a>
				               </c:otherwise>
						   </c:choose>    		
				       </li>
				   </c:forEach>
				   <c:if test="${numPageGroup < pageGroupCount}">
				   		<li><a class="no-bg" href="javascript:go_page('${numPageGroup*pageGroupSize+1}')">&gt;&gt;</a></li>
				   		<li><a class="no-bg" href="javascript:go_page('<fmt:formatNumber value="${count/pageSize+1}" type="number" maxFractionDigits="0"/>')">&gt;</a></li>
				   </c:if>
				</c:if>
			</ul>
		</div>
	</form>	

		</div><!--// contents -->
	</div><!--// container -->

</body>
</html>