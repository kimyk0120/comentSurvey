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
		document.mainform.action = "community_list.do";
		document.mainform.submit();
	}
	
	function board_create() {
		$("#comm_seq").val("0");
		document.mainform.action = "community_create.do";
		document.mainform.submit();
	}
	
	function srch_board() {
		document.mainform.action = "community_list.do";
		document.mainform.submit();
	}
	
	$(document).ready(function() {
		
		var auth = "<c:out value="${srch.auth_no}"/>";
			
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
	
	function comm_info(no) {
		mainform.comm_seq.value = no;
		document.mainform.action = "community_info.do";
		document.mainform.submit();
	}
	
	
</script>
</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">

	<jsp:include page="../main/topMenu.jsp"  />

<input type="hidden" id="pageNum" name="pageNum"  value="" />
<input type="hidden" id="comm_seq" name="comm_seq"/>

	<div id="container" class="colum1"><!-- 왼쪽에 사용자 정보가 없을 경우 클래스 colum1 삽입 -->

		<div class="contents">
		
			<h2>커뮤니티 조회</h2>
			
			<div class="shadow-box" style="padding-top:20px">

			<div class="search-block">

				<div class="item-block clearfix">
					<dl>
						<dt>제목+내용</dt>
						<dd>
							<ul> 
								<li><input type="text" name="srch_title" id="srch_title" value="${srch.srch_nm }" style="width:180px;" /></li>
							</ul>
						</dd>
					</dl>
					<dl style="width:95%">
						<dt>작성일</dt>
						<dd>
							<div class="set-period normal">
								<span class="set-date">
									<input type="text" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }" placeholder="날짜 선택" style="width:80px;" class="calendar" title="검색 작성시작일"/>
								</span>
								<span class="txt-symbol">~</span>
								<span class="set-date mr7">
									<input type="text" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }" placeholder="날짜 선택" style="width:80px;" class="calendar" title="검색 작성종료일"/>
								</span>
							</div>
						</dd>
					</dl>
				</div><!-- // item-block -->
				<div class="item-block clearfix">
					<dl>
						<dt>상태</dt>
						<dd>
							<ul> 
								<li>
									<div class="pos-relative" style="display:inline"><input type="radio" name="srch_nm" id="act_yn_radio0" value="" checked="checked"/><label for="act_yn_radio0">전체</label></div>
									<div class="pos-relative" style="display:inline"><input type="radio" name="srch_nm" id="act_yn_radio1" value="2"/><label for="act_yn_radio1">진행중</label></div>
									<div class="pos-relative" style="display:inline"><input type="radio" name="srch_nm" id="act_yn_radio2" value="1"/><label for="act_yn_radio2">종료</label></div>
								</li>
							</ul>
						</dd>
					</dl>
				</div><!-- // item-block -->

				<div class="btn-block" style="margin-top:-5px">
					<a href="javascript:srch_board()" class="btn-search3"><span>검색</span></a>
				</div>
					
				</div><!-- //search-block -->

			<c:if test="${srch.auth_no eq 1}" >
				<div class="btn-block text-right mb10">
					<a href="javascript:board_create()" class="btn-blue"><span>등록</span></a>
				</div>
			</c:if>
			
			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:50%" />
					<col style="width:15%" />
					<col style="width:20%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>제목</th>
						<th>응답수</th>
						<th>등록일</th>
						<th>진행상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
						<tr onclick="javascript:comm_info('${c.comm_seq}')">
							<td>${c.row_num}</td>
							<td style="word-break:break-all">${c.title}</td>
							<td>${c.cnt}</td>
							<td>${c.reg_dt}</td>
							<td>${c.open_yn eq 'Y' ? '진행중' : '완료'}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) lt 1}">
						<tr><td colspan="6">검색 결과가 없습니다.</td></tr>
					</c:if>
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
				   		<li><a class="no-bg" href="javascript:go_page('${(numPageGroup-1)*pageGroupSize }')">&lt;</a></li>
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