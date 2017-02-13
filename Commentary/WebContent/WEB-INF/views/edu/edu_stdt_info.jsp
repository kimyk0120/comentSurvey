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
<title>수강생상세 </title>
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

	
	function get_gugun() {
		
		var e = document.getElementById("sido_code");
		var s_sido = e.options[e.selectedIndex].value;
				
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:100px;\" title=\"\">";
				   for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("srch_gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
	function email_select() {
		var e = document.getElementById("email2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#email3').val("");
		} else {
			document.getElementById("div_email").style.display = "none";
		}
			
	}
	
	function edu_stdt_edit() {
		document.mainform.target = "_self";
		document.mainform.action = "edu_stdt_edit.do";
		document.mainform.submit();
	}
	
	function stdt_pass() {
		
		if(confirm("합격처리 하시겠습니까?")) {
			document.mainform.target = "_self";
			document.mainform.action = "edu_stdt_pass.do";
			document.mainform.submit();
		}
	}
	
	function go_list() {
		var le = <%=request.getParameter("left") %>
		/* var re = $('#re_url').val();
		if(re == "edu_cert_stdt_list.do") {
			document.mainform.action = "edu_cert_stdt_list.do";
		}
		else {
			document.mainform.action = "edu_proc_stdt_list.do";
		} */
		
		if(le == "3") {
			document.mainform.action = "edu_cert_stdt_list.do";
		} else if(le == "2") {
			document.mainform.action = "edu_attd_stdt_list.do";
		} else {
			document.mainform.action = "edu_proc_stdt_list.do";
		}
		
		document.mainform.target = "_self";
		document.mainform.submit();
	}
	
	function edu_stdt_delete() {
		
		if(confirm("삭제 처리하시겠습니까?")) {
			document.mainform.target = "_self";
			document.mainform.action = "edu_stdt_delete.do";
			document.mainform.submit();
		}
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
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="l_cd" name="l_cd" value="${info.lecture_code }"/>
<input type="hidden" id="stdt_no" name="stdt_no" value="${info.student_no }"/>
<input type="hidden" id="teacher_prt" name="teacher_prt" value="${info.teacher_prt }"/>
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>
<input type="hidden" id="re_url" name="re_url" value="${srch.re_url }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">  ${info.lecture_nm } / ${info.edu_inst_nm } </h2>
				<c:if test="${ (info.qlfc_no eq '' or info.qlfc_no eq null) and auth eq '001'}">
					<div class="btn-block">
						<a href="javascript:stdt_pass()"><span>합격처리</span></a>
					</div>
				</c:if>
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
						<th class="bg-customer">성명</th>
						<td>${info.student_name }</td>
						<th class="bg-customer" rowspan="3">사진</th>
						<td rowspan="3" class="inner">
							<c:if test="${fn:length(info.image_path) gt 0 }">
								<img src="files/image/${info.image_path}" class="person" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">생년월일</th>
						<td>${info.resist_no}</td>
					</tr>
					<tr>
						<th class="bg-customer">연락처</th>
						<td>${info.phone }</td>
					</tr>
					<tr>
						<th class="bg-customer">주소</th>
						<td colspan="3">${info.sido_code_nm } ${info.gugun_code_nm } ${info.address } </td>
					</tr>
					<tr>
						<th class="bg-customer">이메일</th>
						<td colspan="3">${info.email }</td>
					</tr>
					
				</tbody>
			</table>
			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>출석점수</th>
						<td>${info.attn_score }</td>
						<th>필기시험</th>
						<td>${info.write_score}</td>
					</tr>
					<tr>
						<th>검정여부</th>
						<td>${info.exam_yn }</td>
						<th>실기시험</th>
						<td>${info.prac_score }</td>
					</tr>
					<tr>
						<th>검정료</th>
						<td><fmt:formatNumber value="${info.exam_pay}" pattern="#,###"/>원</td>
						<th>검정료납부일</th>
						<td>${info.exam_pay_dt }</td>
					</tr>
					<tr>
						<th>수강료</th>
						<td><fmt:formatNumber value="${info.tuition}" pattern="#,###"/>원</td>
						<th>수강료납부일</th>
						<td>${info.tuition_pay_dt}</td>
					</tr>
					<c:choose>
						<c:when test="${info.lecture_code eq 'TC' or info.lecture_code eq 'HC' }">
							<tr>
								<th>실습일지</th>
								<td colspan="3">${info.test_data }</td>
							</tr>
						</c:when>
						<c:when test="${info.lecture_code eq 'TB' or info.lecture_code eq 'HB' }">
							<tr>
								<th>실습일지</th>
								<td colspan="3">${info.test_data }</td>
							</tr>
							<tr>
								<th>실기자료</th>
								<td>${info.prct_data }</td>
								<th>실습평가자료</th>
								<td>${info.edu_eval_subm_yn }</td>
							</tr>
						</c:when>
						<c:when test="${info.lecture_code eq 'TA' or info.lecture_code eq 'HA' }">
							<tr>
								<th>멘토링</th>
								<td>${info.ment_time}</td>
								<th>청강</th>
								<td>${info.audit_time}</td>
							</tr>
							<tr>
								<th>1차발표</th>
								<td>${info.fst_annc}</td>
								<th>2차발표</th>
								<td>${info.snd_annc}</td>
							</tr>
						</c:when>
					</c:choose>
					<tr>
						<th>자격증번호</th>
						<td>${info.qlfc_no }</td>
						<th>자격발급일</th>
						<td>${info.qlfc_issue_dt}</td>
					</tr>
				</tbody>
			</table>
			<div class="btn-block">
				<c:if test="${srch.re_url ne 'edu_cert_stdt_list.do' and auth eq '001' }"> 
					<a href="javascript:edu_stdt_delete()" class="abl btn-negative"><span>삭제</span></a>
				</c:if>
				<a href="javascript:edu_stdt_edit()" class="btn-gray"><span>수정</span></a>
				<a href="javascript:go_list()"><span>리스트</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>

</body>
</html>