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
<title>접수 l 정리수납상세 l 정리수납</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>



<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">
	
	$(document).ready(function() {
		
	    
	});
	
	function go_list() {
		
		document.mainform.target = "_self";
		document.mainform.action = "arrg_toss_receive.do";
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
<input type="hidden" id="arrg_no" name="arrg_no" value="${info.arrg_strg_no }"/>
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no }"/>
<input type="hidden" id="srvc_phone" name="srvc_phone"/>
<input type="hidden" id="arrg_strg_st_cd" name="arrg_strg_st_cd" value="${info.arrg_strg_st_cd }"/>
<input type="hidden" id="step_move" name="step_move"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>정리수납상세</h2>
			</div>

			<div class="top-info">
				<div class="process">
					<ul>
						<li><span><span>접수</span></span></li><!-- 해당 단계에 클래스 on 추가 -->
						<li class="text-center"><span><span>견적</span></span></li>
						<li class="text-center"><span><span>계약</span></span></li>
						<li class="text-right"><span><span>작업</span></span></li>
					</ul>
				</div>
				<div class="breif-info">
					<p><span>입금관리</span></p>
					<dl class="clearfix">
						<dt>계약금</dt>
						<dd><span><fmt:formatNumber value="${info.tot_work_amt}" />원</span></dd>
					</dl>
					<dl class="clearfix">
						<dt>입금액</dt>
						<dd><div id="div_camt"><span class="point-color-r"><fmt:formatNumber value="${info.cllt_amt }"/>원</span></div></dd>
					</dl>
				</div>
			</div>
<% pageContext.setAttribute("newLineChar", "\n"); %>
			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>서비스고객명</th>
						<td>${info.srvc_cust_nm }</td>
						<th>연락처</th>
						<td>${info.srvc_phone}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.srvc_sido_code_nm} ${info.srvc_gugun_code_nm } ${info.srvc_address}</td>
					</tr>
					<tr>
						<th>서비스명</th>
						<td>${info.srvc_prt_code_nm } </td>
						<th>접수일</th>
						<td> ${info.cnsl_dt}</td>
					</tr>
					<tr>
						<th class="bg-branch">서비스명</th>
						<td>${info.srvc_prt_code_nm }</td>
						<th class="bg-branch">제휴업체</th>
						<td>${info.allc_comp_name}</td>
					</tr>
					<tr>
						<th class="bg-branch">상담일</th>
						<td>${info.cnsl_dt }</td>
						<th class="bg-branch">접수유형</th>
						<td>${info.rcv_type}</td>
					</tr>
					<tr>
						<th class="bg-branch">상담내용</th>
						<td colspan="3" class="padding-cell">
							<div style="width:100%;height:90px;overflow:auto">${fn:replace(info.estm_bigo, newLineChar, "<br/> ")}</div>
						</td>
					</tr>
				</tbody>
			</table>
			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:10%" />
					<col style="width:25%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:10%" />
					<col style="width:25%" />
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="3" class="bg-customer">견적금액</th>
						<td rowspan="3" ><fmt:formatNumber value="${info.estm_amt}" />원</td>
						<th class="bg-customer">견적CBM</th>
						<td>${info.cbm}</td>
						<th rowspan="3" class="bg-customer">견적 내역</th>
						<td rowspan="3" class="padding-cell">
							<div style="width:100%;height:90px;overflow:auto">${fn:replace(info.estm_cntn, newLineChar, "<br/> ")}</div>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">작업예상시간</th>
						<td>${info.work_expc_time} 시간</td>
					</tr>
					<tr>
						<th class="bg-customer">작업인원</th>
						<td>${info.worker_cnt} 명</td>
					</tr>
				</tbody>
			</table>
			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bg-customer">옵션금액</th>
						<td><fmt:formatNumber value="${info.option_amt}" />원</td>
						<th class="bg-customer">옵션내역</th>
						<td class="padding-cell">
							<div style="width:100%;height:50px;overflow:auto">${fn:replace(info.option_cntn, newLineChar, "<br/> ")}</div>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">견적총금액</th>
						<td colspan="3"><fmt:formatNumber value="${info.tot_work_amt}" />원</td>
					</tr>
					<tr>
						<th class="bg-branch">계약일</th>
						<td>${info.ctrt_dt }</td>
						<th class="bg-branch">계약취소</th>
						<td>
							<c:choose>
								<c:when test="${info.ctrt_cancel_yn eq 'N'}">계약</c:when>
								<c:when test="${info.ctrt_cancel_yn eq 'Y'}">계약취소</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th class="bg-branch">선급금</th>
						<td><fmt:formatNumber value="${info.prepaid}" />원</td>
						<th class="bg-branch">선급지급일</th>
						<td>${info.prepaid_dt }</td>
					</tr>
					<tr>
						<th class="bg-branch">작업시작일</th>
						<td>${info.work_start_dt }</td>
						<th class="bg-branch">작업종료일</th>
						<td>${info.work_end_dt }</td>
					</tr>
					<tr>
						<th class="bg-branch">시작시간 </th>
						<td>${info.start_time}</td>
						<th class="bg-branch">종료시간</th>
						<td>${info.end_time}</td>
					</tr>
					<tr>
						<th class="bg-branch">작업지점</th>
						<td>${info.work_branch_name}</td>
					</tr>
				</tbody>
			</table>
				
				

			<div class="btn-block">
				<a href="javascript:go_list()" class="abr"><span>리스트</span></a>
			</div><!--// btn-block -->		
			

		</div><!--// contents -->
		</form>
		
	</div><!--// container -->
</div>



</body>
</html>