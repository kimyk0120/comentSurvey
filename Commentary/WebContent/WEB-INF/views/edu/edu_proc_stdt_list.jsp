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
<title>교육계획 l 교육통합관리</title>
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
		
	function stdt_create() {
		document.mainform.target = "_self";
		document.mainform.action = "stdt_create.do";
		document.mainform.submit();
	}
	
	function go_back() {
		var p = mainform.page.value;
		if( p == "edu_stdt_list.do") {
			document.mainform.action = "edu_stdt_list.do?top=0&left=1";
		} else if ( p == "edu_attd_list.do") {
			document.mainform.action = "edu_attd_list.do?top=0&left=2";
		}
		document.mainform.target = "_self";
		document.mainform.submit();
	}
	
	
/* 	function stdt_list() {
		document.mainform.target = "_self";
		document.mainform.action = "edu_stdt_list.do?top=0&left=1";
		document.mainform.submit();
	}
	
	function attd_list() {
		document.mainform.target = "_self";
		document.mainform.action = "edu_attd_list.do?top=0&left=2";
		document.mainform.submit();
	}
 */	
	function stdt_info(stdt) {
		document.mainform.target = "_self";
		mainform.stdt_no.value = stdt;
		document.mainform.action = "edu_stdt_info.do";
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

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />


<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"  value="${srch.pageNum}"/>
<input type="hidden" id="stdt_no" name="stdt_no"/>
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="l_cd" name="l_cd" value="${info.lecture_code }"/>
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>
<input type="hidden" id="re_url" name="re_url" value="${srch.re_url }"/>

<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">
			<div class="contents-top">
				<h2>수강생 < ${info.lecture_nm} / ${info.edu_inst_nm}</h2>
				<div class="btn-block">
					<a href="javascript:stdt_create()"><span>수강생등록</span></a>
				</div>
			</div>

			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:15%" />
					<col style="width:20%" />
					<col style="width:25%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>성명</th>
						<th>연락처</th>
						<th>주소</th>
						<th>이메일</th>
						<th>출석</th>
						<th>검정료입금일</th>
						<th>검정여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<tr>
						<td>${c.row_num}</td>
						<td><a href="javascript:stdt_info('${c.student_no}')">${c.student_name}</a></td>
						<td>${c.phone}</td>
						<td class="text-left">${c.sido_code_nm} ${c.gugun_code_nm} ${c.address }</td>
						<td>${c.email}</td>
						<td>${c.attn_cnt}</td>
						<td>${c.exam_pay_dt}</td>
						<td>${c.exam_yn}</td>
					</tr>
					</c:forEach>
				</tbody>
				
			</table>
			
			<div class="btn-block text-right">
				<a href="javascript:go_back()"><span class="btn-go">돌아가기</span></a>
				<!-- <a href="javascript:attd_list()"><span class="btn-go">출석 및 평가</span></a> -->
			</div><!--// btn-block -->
			
			
			
		</div>
	</form>	

		</div><!--// contents -->
	</div><!--// container -->
</div>


</body>
</html>