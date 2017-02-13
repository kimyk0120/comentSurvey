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
<title>교육기관 상세정보</title>
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

	function inst_edit() {
		document.mainform.action = "edu_inst_edit.do";
		document.mainform.submit();
	}
	function none() {
	}
	
	function go_list() {
		
		document.mainform.action = "edu_inst_list.do";
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
<input type="hidden" id="inst_cd" name="inst_cd" value="${info.edu_inst_code}"/>
<input type="hidden" id="srch_inst_group" name="srch_inst_group" value="${srch.srch_inst_group}"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst}"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone}"/>
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido}"/>
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">교육기관 상세정보</h2>
				<h3 class="mb0">${info.edu_inst_nm}</h3>
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
						<th>교육기관코드</th>
						<td colspan="3">${info.edu_inst_code }</td>
					</tr>
					<tr>
						<th>교육기관명</th>
						<td>${info.edu_inst_nm}</td>
						<th>교육기관그룹</th>
						<td>${info.edu_inst_group_code_nm}</td>
					</tr>
					<tr>
						<th>지역</th>
						<td>${info.sido_code_nm } ${info.gugun_code_nm }</td>
						<th>지점</th>
						<td>${info.branch_name }</td>
					</tr>
					<tr>
						<th>참여강사</th>
						<td>${info.teacher_nm} </td>
						<th>홈페이지</th>
						<td>${info.homepage}</td>
					</tr>
					<tr>
						<th>강좌누적</th>
						<td colspan="3"> 수납 : ${info.edu_cnt1} / 가정 : ${info.edu_cnt2} / 방과후 : ${info.edu_cnt3} / 기타 : ${info.edu_cnt4} </td>
					</tr>
					<tr>
						<th>담당자직위</th>
						<td>${info.chrg_pstn}</td>
						<th>담당자명</th>
						<td>${info.chrg_name }</td>
					</tr>
					<tr>
						<th>담당자연락처</th>
						<td>${info.chrg_phone}</td>
						<th>대표이메일</th>
						<td>${info.email}</td>
					</tr>
					<tr>
						<th>대표전화</th>
						<td>${info.main_phone}</td>
						<th>우편번호</th>
						<td>${info.zipcode}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm} ${info.gugun_code_nm} ${info.address }</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3">${info.bigo}</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:inst_edit();" class="btn-negative"><span>수정</span></a>
				<a href="javascript:go_list();"><span>리스트</span></a>
			</div><!--// btn-block -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>
</form>

</body>
</html>