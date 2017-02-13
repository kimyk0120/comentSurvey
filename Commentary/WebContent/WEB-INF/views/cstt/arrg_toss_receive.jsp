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
	$(function() {
		$('.formSelect').sSelect();
		
		/* $("#srch_str_dt").datepicker({
	    });
	    $("#srch_end_dt").datepicker({
	    });
	      */
	  });
	
	function toss_reject(no, seq, st) {
		mainform.a_no.value=no;
		mainform.a_seq.value=seq;
		mainform.t_prt.value=st;
		mainform.a_yn.value="N";
		document.mainform.action = "arrg_toss_receive_yn.do?top="+<%=request.getParameter("top") %>+"&left=0";
		document.mainform.submit();
	}
	
	function toss_accept(no, seq, cd, st) {
		mainform.a_no.value=no;
		mainform.a_seq.value=seq;
		mainform.b_cd.value=cd;
		mainform.t_prt.value=st;
		mainform.a_yn.value="Y";
		document.mainform.action = "arrg_toss_receive_yn.do?top="+<%=request.getParameter("top") %>+"&left=0";
		document.mainform.submit();
	}
	/* 
	function srch_toss_send(){
		document.mainform.action = "arrg_toss_send.do";
		document.mainform.submit();
	} */
	
	function go_page(no) {
		
		mainform.pageNum.value = no;
		document.mainform.action = "cstt_cust_list.do";
		document.mainform.submit();
	}
	
	function arrg_strg_info(seq) {
		mainform.arrg_no.value = seq;
		document.mainform.action = "arrg_strg_toss_info.do";
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
<input type="hidden" id="arrg_no" name="arrg_no"/>
<input type="hidden" id="a_no" name="a_no"/>
<input type="hidden" id="a_seq" name="a_seq"/>
<input type="hidden" id="b_cd" name="b_cd"/>
<input type="hidden" id="t_prt" name="t_prt"/>
<input type="hidden" id="a_yn" name="a_yn"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2>승인처리</h2>
			</div>

			<%-- <div class="search-block">
				<div class="search-row">
					<input type="text" id="srch_cust_name" name="srch_cust_name" placeholder="고객명 검색" value="${srch.srch_cust_name}" class="readonly" />				
				</div><!-- // search-row -->
				<div class="search-row">
					<select class="formSelect" id="srch_arrg_strg_st" name="srch_arrg_strg_st" style="width:100px;margin-right:17px" title="">
						<option value="">구분</option>
						<option value="접수">접수</option>
						<option value="견적">견적</option>
						<option value="계약">계약</option>
						<option value="작업">작업</option>
						<option value="완료">완료</option>
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
			</div><!-- // search-block --> --%>

			<table class="talbe-list">
				<colgroup>
					<col style="width:10%" />
					<col style="width:9%" />
					<col style="width:15%" />
					<col style="width:9%" />
					<col style="width:8%"/>
					<col style="width:8%"/>
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
						<th>계약금</th>
						<th>전달일</th>	
						<th>수수료(원)</th>
						<th>승인 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr>
						<td><a href="javascript:arrg_strg_info('${c.arrg_strg_no }')">${c.arrg_strg_no}</a></td>
						<td>${c.srvc_cust_nm }</td>
						<td>${c.srvc_phone }</td>
						<td>${c.toss_prt_code_nm }</td>
						<td>${c.cnsl_branch_name }</td>
						<td>${c.estm_branch_name }</td>
						<td>${c.tot_work_amt }</td>
						<td>${c.send_dt }</td>
						<td>${c.toss_fee }</td>
						<td>
							<span class="btn-table red"><a href="javascript:toss_reject('${c.arrg_strg_no}','${c.toss_seq}','${c.toss_prt_code }')"><span>거부</span></a></span>
							<span class="btn-table green"><a href="javascript:toss_accept('${c.arrg_strg_no}','${c.toss_seq}','${c.accp_branch_code }','${c.toss_prt_code }')"><span>승인</span></a></span>
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