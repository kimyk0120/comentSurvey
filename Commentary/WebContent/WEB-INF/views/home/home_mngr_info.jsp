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
<title>컨설턴트 상세정보</title>
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


	function home_mngr_edit() {
		document.mainform.action = "home_mngr_edit.do";
		document.mainform.submit();
	}
	
	function go_list() {
		
		document.mainform.action = "home_mngr_list.do";
		document.mainform.submit();
	}
	
	/* function cstt_cancel() {
		if ( confirm("계약해지 하시겠습니까?") ) {
			document.mainform.target = "_self";
			document.mainform.action = "cstt_cancel.do";
			document.mainform.submit();
		}
	} */
	
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
<input type="hidden" id="h_no" name="h_no" value="${info.home_mngr_no}"/>
<input type="hidden" id="srch_prt" name="srch_prt" value="${srch.srch_prt}"/>
<input type="hidden" id="srch_pay_day" name="srch_pay_day" value="${srch.srch_pay_day}"/>
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido}"/>
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}"/>
<input type="hidden" id="srch_home_mngr" name="srch_home_mngr" value="${srch.srch_home_mngr}"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

<div id="wrapper">
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">가정관리사 상세정보</h2>
				<!-- <div class="btn-block">
					<a href="javascript:cstt_cancel()" class="btn-negative"><span style="color:#FFF">계약해지</span></a>
				</div> -->
				
				<h3 class="mb0">${info.home_mngr_name} 가정관리사</h3>
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
						<th>가정관리사코드</th>
						<td>${info.home_mngr_no}</td>
						<th rowspan="3">사진</th>
						<td rowspan="3" class="inner">
							<c:if test="${fn:length(info.image_path) gt 0 }">
								<img src="files/image/${info.image_path}" class="person" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th>가정관리사명</th>
						<td>${info.home_mngr_name}</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${info.resist_no} (${info.age}세)</td>
					</tr>
					<tr>
						<th>최초등록일</th>
						<td>
							${info.resist_dt }
						</td>
						<th>작업횟수</th>
						<td>${info.work_cnt}</td>
					</tr>
					<tr>
						<th>구분</th>
						<td>${info.home_mngr_role_code_nm}</td>
						<th>연락처</th>
						<td>${info.phone }</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>${info.email }</td>
						<th>급여일</th>
						<td>${info.pay_day}</td>
					</tr>
					<tr>
						<th>근로형태</th>
						<td>${info.work_prt}</td>
						<th>계좌정보</th>
						<td>${info.bank_info}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm} ${info.gugun_code_nm} ${info.address }</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3"><textarea id="bigo" name="bigo" style="height:80px;width:90%;padding:5px;margin:2px"  readonly="readonly">${info.bigo}</textarea></td>
					</tr>
				</tbody>
			</table>
			
			<dl class="table-dl mt35"><!-- 개인 정보와 떨어져 있는 처음 dl 에만 mt35 삽입 -->
				<dt>
					수강이력
				</dt>
				<dd>
					<table class="talbe-inner">
						<colgroup>
							<col style="width:25%" />
							<col style="width:25%" />
							<col style="width:25%" />
							<col style="width:25%" />
						</colgroup>
						<thead>
							<tr>
								<th>강의</th>
								<th>교육기관</th>
								<th>자격번호</th>
								<th>취득일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${e_list}" var="e" varStatus="status">
								<tr>
									<td>${e.lecture_nm}</td>
									<td>${e.edu_inst_nm}</td>
									<td>${e.qlfc_no}</td>
									<td>${e.qlfc_date}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</dd>
			</dl>

			<div class="btn-block">
				<a href="javascript:home_mngr_edit();" class="btn-negative"><span>수정</span></a>
				<a href="javascript:go_list();"><span>리스트</span></a>
			</div><!--// btn-block -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>
</form>

</body>
</html>