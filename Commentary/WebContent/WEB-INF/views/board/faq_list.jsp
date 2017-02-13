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
<title>문화관광해설사 관리시스템</title>
<link href="common/css/style.css" rel="stylesheet" type="text/css" />
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
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "faq_list.do";
		document.mainform.submit();
	}
	
	function faq_create() {
		document.mainform.action = "faq_create.do";
		document.mainform.submit();
	}
	
	function srch_faq() {
		document.mainform.action = "faq_list.do";
		document.mainform.submit();
	}
	
	$(document).ready(function() {
		
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
	
	function faq_info(f_no) {
		mainform.f_seq.value = f_no;
		document.mainform.action = "faq_info.do";
		document.mainform.submit();
	}
	
	function faq_edit(f_no) {
		mainform.f_seq.value = f_no;
		document.mainform.action = "faq_edit.do";
		document.mainform.submit();
	}
	
	function faq_show(id) {
		
		//var st = document.getElementById("tr_answ_"+id).style.display;
		
		var st = $("#tr_answ_"+id).css("display");
		
		if(st == "none") {
			$("#tr_answ_"+id).css("display", "");
		}
		else {
			$("#tr_answ_"+id).css("display", "none");
		}
		
	}
	
	
</script>

<style type="text/css">

	table {width:100%;border-collapse:collapse}
	.faq-list {border-top:1px solid #dcdcdc;border-bottom:1px solid #dcdcdc}
	.faq-list th {height:33px;background:#efefef;color:#333;border-bottom:1px solid #dcdcdc}
	.faq-list td {height:30px;border-bottom:1px solid #dcdcdc;text-align:center;padding:0 10px}
	.faq-list tr:hover td {cursor:pointer;color:#333}
	.faq-list tr:hover td a {color:#333} */
</style>

</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">

	<jsp:include page="../main/topMenu.jsp"  />

<input type="hidden" id="pageNum" name="pageNum"  value="" />
<input type="hidden" id="f_seq" name="f_seq"/>

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 없을 경우 클래스 colum1 삽입 -->

		<div class="contents">
		
			<h2>FAQ 조회</h2>
			
			<div class="shadow-box" style="padding-top:20px">

			<c:if test="${srch.auth_no eq 1 }" >
				<div class="btn-block text-right mb10">
					<a href="javascript:faq_create()" class="btn-blue"><span>FAQ 등록</span></a>
				</div>
			</c:if>

			<table class="faq-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:* " />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>질문</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
						<tr onclick="javascript:faq_show('${c.faq_seq}')" style="background:#f0f3ff;">
							<td>${c.row_num}</td>
							<td style="word-break:break-all">${c.qstn}</td>
							<c:choose>
								<c:when test="${srch.auth_no eq 1 }">
									<td>${c.reg_dt} <a href="javascript:faq_edit('${c.faq_seq}')">[수정]</a></td>
								</c:when>
								<c:otherwise>
									<td>${c.reg_dt}</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr id="tr_answ_${c.faq_seq}" style="display:none;">
							<td></td>
							<td style="word-break:break-all">${c.answ}</td>
							<td></td>
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
				   		<li><a class="no-bg" href="javascript:go_page('1')">&lt;&lt;</a></li>
				   		<li><a class="no-bg" href="javascript:go_page('${(numPageGroup-2)*pageGroupSize+1 }')">&lt;</a></li>
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
				   		<li><a class="no-bg" href="javascript:go_page('${numPageGroup*pageGroupSize+1}')">&gt;</a></li>
				   		<li><a class="no-bg" href="javascript:go_page('<fmt:formatNumber value="${count/pageSize}" type="number" maxFractionDigits="0"/>')">&gt;&gt;</a></li>
				   </c:if>
				</c:if>
			</ul>
		</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
	</form>	
</div><!--// container -->

</body>
</html>