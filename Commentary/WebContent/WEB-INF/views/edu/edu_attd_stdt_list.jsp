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
<title>출석 및 평가</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">

	$(document).ready(function() {
		var st = "";
		<c:forEach items="${list}" var="c" varStatus="status">
			st = st + "|" + "<c:out value="${c.student_no}"/>";
		</c:forEach>
		
		mainform.st.value= st.substring(1, st.length);
		
		var sYn = "<c:out value="${save_yn}"/>";
		if (sYn == "Y") alert("저장되었습니다.");
		
	});

	$(function() {
		$('.formSelect').sSelect();
		$("#listScroll").contentScroll();
	});
		
	function attd_save() {
		document.mainform.target = "_self";
		document.mainform.action = "edu_attd_stdt_save.do";
		document.mainform.submit();
	}
	
	function stdt_info(stdt) {
		mainform.stdt_no.value = stdt;
		document.mainform.target = "_self";
		document.mainform.action = "edu_stdt_info.do";
		document.mainform.submit();
	}
	
	function go_list() {
		
		var p = mainform.page.value;
		if( p == "edu_attd_list.do") {
			document.mainform.action = "edu_attd_list.do?top=0&left=2";
		} else if ( p == "edu_list.do") {
			document.mainform.action = "edu_list.do?top=0&left=4";
		}
		
		document.mainform.target = "_self";
		document.mainform.submit();
	}

	function CheckAll(seq){
		
		// $("input[name=attd_"+seq+"]:checkbox").attr("checked", true);
		// var chk = document.getElementsByName("del_unit[]");
		//var sz = "<c:out value="${fn:length(list)}"/>";
		
		var stat = "<c:out value="${list[0].student_no}"/>";
		var d = "attd_"+stat+"_"+seq;
		//var chk = $('input[name="'+d+'"]').attr("checked");
		var st_cnt = mainform.st.value;
		
		var tmp = st_cnt.split('|');
		var dd = "";
		
		if($('input[name="'+d+'"]').attr("checked")) {
			for (var i=0; i < tmp.length; i++) {
				dd = "attd_"+tmp[i]+"_"+seq;
				$('input[name="'+dd+'"]').attr("checked",false);
				$('input[name="'+dd+'"]').prop("checked",false);
			}
		}	else {
			for (var i=0; i < tmp.length; i++) {
				dd = "attd_"+tmp[i]+"_"+seq;
				$('input[name="'+dd+'"]').attr("checked",true);
				$('input[name="'+dd+'"]').prop("checked",true);
				//$('input[name="'+dd+'"]').prop( "checked", true );
			}
		}
		
		/* <c:forEach items="${list}" var="c" varStatus="status">
			var st = "<c:out value="${c.student_no}"/>";
			var dd = "attd_"+st+"_"+seq;
			$('input[name="'+dd+'"]').attr("checked",true);
		</c:forEach> */
		
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
<input type="hidden" id="pageNum" name="pageNum" value="${srch.pageNum}" />
<input type="hidden" id="stdt_no" name="stdt_no"/>
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="st" name="st" />

<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>

<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">출석 및 평가</h2>
				<h3> ${info.lecture_nm} / ${info.edu_inst_nm}</h3>
			</div>
			
			<div id="multi-table" class="clearfix">
			
				<div id="item-area">
					<table class="talbe-schedule">
						<colgroup>
							<col style="width:5px" />
							<col style="width:20px;border-left:1px solid #dedede;border-right:1px solid #dedede" />
							<col style="width:25px" />
							<col style="width:25px" />
							<col style="width:25px" />
							<col style="width:25px" />
							<c:if test="${info.lecture_code eq 'TA' or info.lecture_code eq 'TB'}">
								<col style="width:25px" />
								<col style="width:25px" />
							</c:if>
							<col style="width:25px;border-right:1px solid #dedede" />
							<%-- <c:set var="si" value="${fn:length(degr)}" />
							<fmt:parseNumber var="wi" value="${45/si}" integerOnly="true" />
							<c:forEach items="${degr}" var="d" varStatus="status">
								<col style="width:${wi}%" />
							</c:forEach> --%>
						</colgroup>
						<thead>
							<tr>
								<th style="width:5px">No</th>
								<th>성명</th>
								<th>합격 여부</th>
								<th>실기 점수</th>
								<th>필기 시험</th>
								<th>검정 여부</th>
								<c:choose>
									<c:when test="${info.lecture_code  eq 'TC'}">
										<th>실습자료</th>
									</c:when>
									<c:when test="${info.lecture_code  eq 'TB'}">
										<th>실습자료</th>
										<th>실기자료</th>
										<th>실습평가</th>
									</c:when>
									<c:when test="${info.lecture_code  eq 'TA'}">
										<th>멘토링</th>
										<th>청강자료</th>
										<th>강의평가</th>
									</c:when>
								</c:choose>
						<%-- <c:forEach items="${degr}" var="d" varStatus="status">
							<th><a href="javascript:CheckAll('${d.degr}')"> ${d.degr}회차 </a></th>
						</c:forEach> --%>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="c" varStatus="status">
							<tr>
								<td>${c.row_num}</td>
								<td><a href="javascript:stdt_info('${c.student_no}')">${c.student_name}</a></td>
								<td>${c.pass_yn}</td>
								<td>${c.prac_score}</td>
								<td>${c.write_score}</td>
								<td>${c.exam_yn}</td>
								<c:choose>
									<c:when test="${info.lecture_code  eq 'TC'}">
										<td>${c.test_data }</td>
									</c:when>
									<c:when test="${info.lecture_code  eq 'TB'}">
										<td>${c.test_data }</td>
										<td>${c.prct_data }</td>
										<td>${c.test_subm_data }</td>
									</c:when>
									<c:when test="${info.lecture_code  eq 'TA'}">
										<td>${c.ment_time }</td>
										<td>${c.audit_time }</td>
										<td>${c.edu_eval_subm_yn }</td>
									</c:when>
								</c:choose>
								<%-- <c:forEach items="${degr}" var="d" varStatus="status">
									<td>
										<input type="checkbox" id="attd_${c.student_no}_${d.degr}" name="attd_${c.student_no}_${d.degr}" value="Y"
											<c:forEach items="${a_list}" var="a" varStatus="status">
												<c:if test="${a.student_no eq c.student_no and a.degr eq d.degr and a.attd_yn eq 'Y'}">checked="checked"
												</c:if>
											</c:forEach>
										/>
									</td>
								</c:forEach> --%>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<c:set var="ss" value="${fn:length(degr)}" />
				<fmt:parseNumber var="wid" value="${ss*60}" integerOnly="true" />
				<c:choose>
					<c:when test="${ss lt 7}">
						<c:set var="len" value="${wid }" />
					</c:when>
					<c:otherwise><c:set var="len" value="420" /></c:otherwise>
				</c:choose>
				<div id="scroll-area" style="width:${len}px"><!-- 넓이 지정 필요 : 55 x 4(보여줄 셀 갯수) -->
				<c:set var="si" value="${fn:length(degr)}" />
					<fmt:parseNumber var="wi" value="${si*55}" integerOnly="true" />
					<table class="talbe-schedule" style="width:${wi}px"><!-- 테이블 넓이 지정 필요 : 55 x 5(셀 갯수) -->
						<colgroup>
							<c:forEach items="${degr}" var="d" varStatus="status">
								<col style="width:30px" />
							</c:forEach>
						</colgroup>
						<thead>
							<tr>
								<c:forEach items="${degr}" var="d" varStatus="status">
									<th><a href="javascript:CheckAll('${d.degr}')"> ${d.degr}회차 </a></th>
									<%-- <th>${d.degr}회차 </th> --%>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="c" varStatus="status">
							<tr>
								 <c:forEach items="${degr}" var="d" varStatus="status">
								<td>
									<!--	<input type="checkbox" id="attd_${c.student_no}_${d.degr}" name="attd_${c.student_no}_${d.degr}" value="Y"
											<c:forEach items="${a_list}" var="a" varStatus="status">
												<c:if test="${a.student_no eq c.student_no and a.degr eq d.degr and a.attd_yn eq 'Y'}">checked="checked"
												</c:if>
											</c:forEach>
										/> <span>출석여부</span> -->
									<div class="pos-relative">
										<input type="checkbox" id="attd_${c.student_no}_${d.degr}" name="attd_${c.student_no}_${d.degr}" value="Y"
											<c:forEach items="${a_list}" var="a" varStatus="status">
												<c:if test="${a.student_no eq c.student_no and a.degr eq d.degr and a.attd_yn eq 'Y'}">checked="checked"
												</c:if>
											</c:forEach>
										/><label for="attd_${c.student_no}_${d.degr}"><span>출석여부</span></label>
									</div>
								</td>
								</c:forEach>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div><!--// multi-table -->
					
					<div class="btn-block text-right">
						<a href="javascript:go_list()" class="btn-negative abl"><span>리스트</span></a>
						<a href="javascript:attd_save()"><span>저장</span></a>
					</div><!--// contents -->
			
		</div>
	</form>	

		</div><!--// contents -->
	</div><!--// container -->


</body>
</html>