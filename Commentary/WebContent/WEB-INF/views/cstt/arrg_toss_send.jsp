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
<title>토스처리 l 정리수납</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />


<script type="text/javascript">
	
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
	
	$(function() {
		$('.formSelect').sSelect();
	  });
	
	function srch_toss_send(){
		document.mainform.action = "arrg_toss_send.do";
		document.mainform.submit();
	}
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "cstt_cust_list.do";
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
<input type="hidden" id="pageNum" name="pageNum"  value="" />
<input type="hidden" id="e_seq" name="e_seq"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2>토스처리</h2>
			</div>

			<div class="search-block">
				<div class="search-row">
					<input type="text" id="srch_cust_name" name="srch_cust_name" placeholder="고객명 검색" value="${srch.srch_cust_name}" class="readonly" />				
				</div><!-- // search-row -->
				<div class="search-row">
					<select class="formSelect" id="srch_arrg_strg_st" name="srch_arrg_strg_st" style="width:100px;margin-right:17px" title="">
						<option value="">구분</option>
						<option value="접수" <c:if test="${srch.srch_arrg_strg_st eq '접수'}">selected="selected"</c:if>>접수</option>
						<option value="접수완료" <c:if test="${srch.srch_arrg_strg_st eq '접수완료'}">selected="selected"</c:if>>접수완료</option>
						<option value="견적배정" <c:if test="${srch.srch_arrg_strg_st eq '견적배정'}">selected="selected"</c:if>>견적배정</option>
						<option value="견적반려" <c:if test="${srch.srch_arrg_strg_st eq '견적반려'}">selected="selected"</c:if>>견적반려</option>
						<option value="견적완료" <c:if test="${srch.srch_arrg_strg_st eq '견적완료'}">selected="selected"</c:if>>견적완료</option>
						<option value="계약완료" <c:if test="${srch.srch_arrg_strg_st eq '계약완료'}">selected="selected"</c:if>>계약완료</option>
						<option value="작업배정" <c:if test="${srch.srch_arrg_strg_st eq '작업배정'}">selected="selected"</c:if>>작업배정</option>
						<option value="작업반려" <c:if test="${srch.srch_arrg_strg_st eq '작업반려'}">selected="selected"</c:if>>작업반려</option>
						<option value="작업완료" <c:if test="${srch.srch_arrg_strg_st eq '작업완료'}">selected="selected"</c:if>>작업완료</option>
						<option value="계약취소" <c:if test="${srch.srch_arrg_strg_st eq '계약취소'}">selected="selected"</c:if>>계약취소</option>
					</select>
					<select class="formSelect" style="width:150px" title="" id="srch_branch" name="srch_branch">
						<option value="" selected="selected">전달지점</option>
						<c:forEach items="${b_list}" var="b">
							<option value="${b.branch_code}">${b.branch_name}</option>
						</c:forEach>
					</select>
					<span class="txt-label">전달기간</span>
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
					<a href="javascript:srch_toss_send()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->

			<table class="talbe-list">
				<colgroup>
					<col style="width:10%" />
					<col style="width:9%" />
					<col style="width:15%" />
					<col style="width:9%" />
					<col style="width:10%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
					<col style="width:*"/>
				</colgroup>
				<thead>
					<tr>
						<th>관리코드</th>
						<th>고객명</th>
						<th>연락처</th>
						<th>구분</th>
						<th>접수지점</th>
						<th>계약지점</th>
						<th>전달지점</th>
						<th>전달일</th>	
						<th>수수료(원)</th>
						<th>승인 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr>
						<td>${c.arrg_strg_no}</td>
						<td>${c.srvc_cust_nm }</td>
						<td>${c.srvc_phone }</td>
						<td>${c.arrg_strg_st_cd }</td>
						<td>${c.cnsl_branch_name }</td>
						<td>${c.estm_branch_name }</td>
						<td>${c.branch_name2 }</td>
						<td>${c.send_dt }</td>
						<td>${c.toss_fee }</td>
						<td>
							<c:choose>
								<c:when test="${c.appr_yn eq '확인전' }">
									<span class="point-color-g">
								</c:when>
								<c:when test="${c.appr_yn eq '반려' }">
									<span class="point-color-r">
								</c:when>
								<c:otherwise>
									<span style="color:#000000;font-weight:bold">
								</c:otherwise>
							</c:choose>
							${c.appr_yn}</span>
						</td>
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
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>
</body>
</html>