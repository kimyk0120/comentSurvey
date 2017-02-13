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
		
	    /* $("#exam_pay_dt").datepicker({
	    });
	    $("#tuition_pay_dt").datepicker({
	    });
	    $("#qlfc_issue_dt").datepicker({
	    }); */
	     
	  });
	
	$(document).ready(function() {
		var em2 = "<c:out value="${info.em2}"/>";
		
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#em3').val(em2);
		} else {
			document.getElementById("div_email").style.display = "none";
		}
		
		var ph1 = "<c:out value="${info.ph1}"/>";
		if(ph1 != null && ph1 != '') {
			$("#ph1").val(ph1).attr("selected","selected"); 
		}
		var fAnnc = "<c:out value="${info.fst_annc}"/>";
		if(fAnnc != null && fAnnc != '') {
			$("#fst_annc").val(fAnnc).attr("selected","selected"); 
		}
		var sAnnc = "<c:out value="${info.snd_annc}"/>";
		if(sAnnc != null && sAnnc != '') {
			$("#snd_annc").val(sAnnc).attr("selected","selected"); 
		}
		
		var sido = "<c:out value="${info.sido_code}"/>";
		var gugun = "<c:out value="${info.gugun_code}"/>";
		
		if(sido != null && sido != '') {
			
			$("#sido_code").val(sido).attr("selected","selected");
		
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:100px;\" title=\"\">";
					   str=str+"<option value=\"\">선택</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   if(gugun != null && gugun != '') {
						   $("#gugun_code").val(gugun).attr("selected","selected"); 
					   }
					   $('.formSelect').sSelect();
					   
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
		
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

		$( '#exam_pay_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"//날짜 출력 형식
		});
		$( '#tuition_pay_dt' ).datepicker({
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			changeYear:true, //년 셀렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"//날짜 출력 형식
		});
		$( '#qlfc_issue_dt' ).datepicker({
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			changeYear:true, //년 셀렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"//날짜 출력 형식
		});
		
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
				   document.getElementById("gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
	function email_select() {
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email").style.display = "inline";
			$('#em3').val("");
		} else {
			document.getElementById("div_email").style.display = "none";
		}
			
	}
		
	
	function edu_stdt_save() {
		var e1 = $("#em1").val();
		var e2 = $("#em2").val();
		var e3 = $("#em3").val();
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		if(e1 != '') {
			if(e2 != '') {
				mainform.email.value=e1+"@"+e2;
			} else if(e3 != '') {
				mainform.email.value=e1+"@"+e3;
			}
		}
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.phone.value=p1+"-"+p2+"-"+p3;
		}
		
		document.mainform.target = "_self";
		document.mainform.action = "edu_stdt_save.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
		document.mainform.submit();
	}
	
	function edu_stdt_info() {
		
		document.mainform2.target = "_self";
		document.mainform2.action = "edu_stdt_info.do";
		document.mainform2.submit();
	}
	
	function img_del() {
		var str = "<input type=\"file\" id=\"stdt_img\" name=\"stdt_img\" size=\"12\" onchange=\"readURL(this)\"/><img id=\"img_view\" src=\"#\" alt=\"your image\" />";
		
		document.getElementById("div_img").innerHTML=str;
	    mainform.img_change.value="Y";
	}
	
	function readURL(input) {

		var  str_dotlocation,str_ext,str_low;
		str_value  = $('#stdt_img').val();
		str_low   = str_value.toLowerCase(str_value);
		str_dotlocation = str_low.lastIndexOf(".");
		str_ext   = str_low.substring(str_dotlocation+1);

		if (str_ext != "png" && str_ext != "jpg" && str_ext != "gif" && str_ext != "jpeg") {
		     alert("파일 형식이 맞지 않습니다.\n png,jpg,gif,jpeg 만\n 업로드가 가능합니다!");
		  	 $('#stdt_img').val('');
		     return;
		}
		
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();

	        reader.onload = function (e) {
	            $('#img_view').attr('src', e.target.result);
	        }

	        reader.readAsDataURL(input.files[0]);
	        
	        document.getElementById("img_view").height = "80";
	        $("#img_change").val("Y");
	    }
	}
	
	function cmaComma(obj) {
		var strNum = /^[/,/,0-9]*$/;
		var str = "" + obj.value.replace(/,/gi,''); // 콤마 제거  
	    var regx = new RegExp(/(-?\d+)(\d{3})/);  
		
		if (!strNum.test(obj.value)) {
	        alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
	        obj.focus();
	        return false;
	    }

		while(regx.test(str)){  
	        str = str.replace(regx,"$1,$2");  
	    }  
        obj.value = str;
		
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
<form id="mainform2" name="mainform2" method="post">
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq}"/>
<input type="hidden" id="stdt_no" name="stdt_no" value="${info.student_no }"/>
<input type="hidden" id="img_path" name="img_path" value="${info.image_path }" />
<input type="hidden" id="img_change" name="img_change" value="N"/>
<input type="hidden" id="email" name="email"/>
<input type="hidden" id="phone" name="phone"/>
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="re_url" name="re_url" value="${srch.re_url}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
</form>

<form id="mainform" name="mainform" method="post" enctype="multipart/form-data">
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq}"/>
<input type="hidden" id="stdt_no" name="stdt_no" value="${info.student_no }"/>
<input type="hidden" id="img_path" name="img_path" value="${info.image_path }" />
<input type="hidden" id="img_change" name="img_change" value="N"/>
<input type="hidden" id="email" name="email"/>
<input type="hidden" id="phone" name="phone"/>
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="re_url" name="re_url" value="${srch.re_url}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">  ${info.lecture_nm } / ${info.edu_inst_nm } </h2>
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
						<td>
							<input type="text" id="student_name" name="student_name" value="${info.student_name }" style="width:80px" />
						</td>
						<th class="bg-customer" rowspan="2">사진</th>
						<td rowspan="2" class="inner">
							<div id="div_img" style="display:inline;" >
								<c:choose>
									<c:when test="${fn:length(info.image_path) gt 0 }">
										<img src="files/image/${info.image_path}" class="person" />
										<span class="btn-del" title="삭제" onclick="javascript:img_del()"></span>
									</c:when>
									<c:otherwise>
										<input type="file" id="stdt_img" name="stdt_img" size="12" onchange="readURL(this)"/>
										<img id="img_view" src="" />
									</c:otherwise>
								</c:choose>
							</div>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">생년월일</th>
						<td>
							<input type="text" id="resist_no" name="resist_no" value="${info.resist_no }" style="width:80px" />
						</td>
					</tr>
					<tr>
						<th class="bg-customer">연락처</th>
						<td colspan="3">
							<select class="formSelect" style="width:60px" id="ph1" name="ph1">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph2" name="ph2" value="${info.ph2 }" style="width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" value="${info.ph3 }" style="width:40px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">주소</th>
						<td colspan="3">
							<select class="formSelect" id="sido_code" name="sido_code" style="width:100px;" onchange="get_gugun()">
								<option value="">시도</option>
								<c:set var="si" value="${info.sido_code}" />
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}" <c:if test="${si eq s.sido_code}">selected="selected"</c:if> >${s.sido_code_nm}</option>
								</c:forEach>
							</select> 
							<div id="gugun_div"  style="display:inline;">
								<select class="formSelect" style="width:100px;" id="gugun_code" name="gugun_code">
									<option value="">구군</option>
								</select>
							</div>
							<input type="text" id="address" name="address" value="${info.address }" placeholder="나머지 주소를 입력하세요" />
						</td>
					</tr>
					<tr>
						<th class="bg-customer">이메일</th>
						<td colspan="3">
							<input type="text" id="em1" name="em1" value="${info.em1 }" style="width:150px" />
							<span class="txt-symbol">@</span>
							<select class="formSelect" style="width:150px" id="em2" name="em2" onchange="email_select()">
								<option value="">직접입력</option>
								<option value="naver.com" <c:if test="${info.em2 eq 'naver.com'}">selected="selected"</c:if>>naver.com</option>
								<option value="nate.com" <c:if test="${info.em2 eq 'nate.com'}">selected="selected"</c:if>>nate.com</option>
								<option value="empal.com" <c:if test="${info.em2 eq 'empal.com'}">selected="selected"</c:if>>empal.com</option>
								<option value="daum.net" <c:if test="${info.em2 eq 'daum.net'}">selected="selected"</c:if>>daum.net</option>
								<option value="hanmail.net" <c:if test="${info.em2 eq 'hanmail.net'}">selected="selected"</c:if>>hanmail.net</option>
								<option value="google.com" <c:if test="${info.em2 eq 'google.com'}">selected="selected"</c:if>>google.com</option>
								<option value="gmail.com" <c:if test="${info.em2 eq 'gmail.com'}">selected="selected"</c:if>>gmail.com</option>
								<option value="hotmail.com" <c:if test="${info.em2 eq 'hotmail.com'}">selected="selected"</c:if>>hotmail.com</option>
							</select>
							<div id="div_email"  style="display:inline;">
								<input type="text" id="em3" name="em3" style="width:150px" />
							</div>
						</td>
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
						<td><input type="text" id="attn_score" name="attn_score" value="${info.attn_score }" style="width:80px"/></td>
						<th>필기시험</th>
						<td><input type="text" id="write_score" name="write_score" value="${info.write_score }" style="width:80px"/></td>
					</tr>
					<tr>
						<th>검정여부</th>
						<td>
							<select class="formSelect" style="width:100px" id="exam_yn" name="exam_yn">
								<option value=""></option>
								<option value="Y" <c:if test="${info.exam_yn eq 'Y'}">selected="selected"</c:if>>Yes</option>
								<option value="N" <c:if test="${info.exam_yn eq 'N'}">selected="selected"</c:if>>No</option>
							</select>
						</td>
						<th>실기시험</th>
						<td><input type="text" id="prac_score" name="prac_score" value="${info.prac_score }" style="width:80px"/></td>
					</tr>
					<tr>	
						<th>검정료</th>
						<td>
							<c:set var="examPay"><fmt:formatNumber pattern="#,###" value="${info.exam_pay}" /> </c:set>
							<input type="text" id="exam_pay" name="exam_pay" value="${examPay}" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
						<th>검정료납부일</th>
						<td>
							<span class="set-date">
							<input type="text" id="exam_pay_dt" name="exam_pay_dt" value="${info.exam_pay_dt }" style="width:65px;"/>
							<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span>
							</span>
						</td>
					</tr>
					<tr>
						<th>수강료</th>
						<td>
							<c:set var="tuition"><fmt:formatNumber pattern="#,###" value="${info.tuition}" /> </c:set>
							<input type="text" id="tuition" name="tuition" value="${tuition}" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
						<th>수강료납부일</th>
						<td>
							<span class="set-date">
							<input type="text" id="tuition_pay_dt" name="tuition_pay_dt" value="${info.tuition_pay_dt }" style="width:65px;"/>
							<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span>
							</span>
						</td>
					</tr>
					<c:choose>
						<c:when test="${info.lecture_code eq 'TC' or info.lecture_code eq 'HC' }">
							<tr>
								<th>실습일지</th>
								<td colspan="3">
									<select class="formSelect" style="width:100px" id="test_data" name="test_data">
										<option value=""></option>
										<option value="Y" <c:if test="${info.test_data eq 'Y'}">selected="selected"</c:if>>Yes</option>
										<option value="N" <c:if test="${info.test_data eq 'N'}">selected="selected"</c:if>>No</option>
									</select>
								</td>
							</tr>
						</c:when>
						<c:when test="${info.lecture_code eq 'TB' or info.lecture_code eq 'HB' }">
							<tr>
								<th>실습일지</th>
								<td colspan="3">
									<select class="formSelect" style="width:100px" id="test_data" name="test_data">
										<option value=""></option>
										<option value="Y" <c:if test="${info.test_data eq 'Y'}">selected="selected"</c:if>>Yes</option>
										<option value="N" <c:if test="${info.test_data eq 'N'}">selected="selected"</c:if>>No</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>실기자료</th>
								<td>
									<select class="formSelect" style="width:100px" id="prct_data" name="prct_data">
										<option value=""></option>
										<option value="Y" <c:if test="${info.prct_data eq 'Y'}">selected="selected"</c:if>>Yes</option>
										<option value="N" <c:if test="${info.prct_data eq 'N'}">selected="selected"</c:if>>No</option>
									</select>
								</td>
								<th>실습평가자료</th>
								<td>
									<select class="formSelect" style="width:100px" id="edu_eval_subm_yn" name="edu_eval_subm_yn">
										<option value=""></option>
										<option value="Y" <c:if test="${info.edu_eval_subm_yn eq 'Y'}">selected="selected"</c:if>>Yes</option>
										<option value="N" <c:if test="${info.edu_eval_subm_yn eq 'N'}">selected="selected"</c:if>>No</option>
									</select>
								</td>
							</tr>
						</c:when>
						<c:when test="${info.lecture_code eq 'TA' or info.lecture_code eq 'HA' }">
							<tr>
								<th>멘토링</th>
								<td>
									<select class="formSelect" style="width:100px" id="ment_time" name="ment_time">
										<option value=""></option>
										<option value="Y" <c:if test="${info.ment_time eq 'Y'}">selected="selected"</c:if>>Yes</option>
										<option value="N" <c:if test="${info.ment_time eq 'N'}">selected="selected"</c:if>>No</option>
									</select>
								</td>
								<th>청강</th>
								<td>
									<select class="formSelect" style="width:100px" id="audit_time" name="audit_time">
										<option value=""></option>
										<option value="Y" <c:if test="${info.audit_time eq 'Y'}">selected="selected"</c:if>>Yes</option>
										<option value="N" <c:if test="${info.audit_time eq 'N'}">selected="selected"</c:if>>No</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>1차발표</th>
								<td>
									<select class="formSelect" style="width:150px" id="fst_annc" name="fst_annc">
										<option value="">선택</option>
										<option value="A+">A+</option>
										<option value="A">A</option>
										<option value="A-">A-</option>
										<option value="B+">B+</option>
										<option value="B">B</option>
										<option value="B-">B-</option>
										<option value="C+">C+</option>
										<option value="C">C</option>
										<option value="C-">C-</option>
									</select>
								</td>
								<th>2차발표</th>
								<td>
									<select class="formSelect" style="width:150px" id="snd_annc" name="snd_annc">
										<option value="">선택</option>
										<option value="A+">A+</option>
										<option value="A">A</option>
										<option value="A-">A-</option>
										<option value="B+">B+</option>
										<option value="B">B</option>
										<option value="B-">B-</option>
										<option value="C+">C+</option>
										<option value="C">C</option>
										<option value="C-">C-</option>
									</select>
								</td>
							</tr>
						</c:when>
					</c:choose>
					<tr>
						<th>자격증번호</th>
						<td>${info.qlfc_no}</td>
						<th>자격발급일</th>
						<td>
							<span class="set-date">
							<input type="text" id="qlfc_issue_dt" name="qlfc_issue_dt" value="${info.qlfc_issue_dt }" style="width:65px"/>
							<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span>
							</span>
						</td>
					</tr>
					
				</tbody>
			</table>
			<div class="btn-block">
				<a href="javascript:edu_stdt_save()"><span>저장</span></a>
				<a href="javascript:edu_stdt_info()" class="btn-gray"><span>취소</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>

</body>
</html>