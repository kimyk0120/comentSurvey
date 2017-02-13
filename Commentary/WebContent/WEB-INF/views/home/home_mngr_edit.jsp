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
<title>가정관리사 상세정보</title>
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
			$("#ph1").val(ph1).change(); 
		}
		var wp = "<c:out value="${info.work_prt}"/>";
		if(wp != null && wp != '') {
			$("#work_prt").val(wp).change(); 
		}
		var pd = "<c:out value="${info.pay_day}"/>";
		if(pd != null && pd != '') {
			$("#pay_day").val(pd).change(); 
		}
		
		var sido = "<c:out value="${info.sido_code}"/>";
		var gugun = "<c:out value="${info.gugun_code}"/>";
		
		if(sido != null && sido != '') {
			
			$("#sido_code").val(sido).change();
		
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
		
	function home_mngr_save() {
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
		
		
		document.mainform.action = "home_mngr_save.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
		document.mainform.submit();
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
	
	function chkNum(obj) {
		var num_check=/^[0-9]*$/;
		if(!num_check.test(obj.value)) {
			alert("숫자만 입력하십시오.\n\n특수문자와 한글/영문은 사용할수 없습니다.");
			obj.value="";
	        obj.focus();
	        return false;
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
<form id="mainform" name="mainform" action="" method="post" enctype="multipart/form-data">
<input type="hidden" id="c_no" name="h_no" value="${info.home_mngr_no}"/>
<input type="hidden" id="s_no" name="s_no" value="${info.student_no}"/>
<input type="hidden" id="img_path" name="img_path" value="${info.image_path }" />
<input type="hidden" id="email" name="email"/>
<input type="hidden" id="phone" name="phone"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

<div id="wrapper">
	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">가정관리사 상세정보</h2>
				
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
						<th>가정관리사명</th>
						<td><input type="text" id="home_mngr_name" name="home_mngr_name" value="${info.home_mngr_name }" style="width:80px" /></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type="text" id="resist_no" name="resist_no" value="${info.resist_no }" style="width:80px" onkeyup="chkNum(this)" placeholder="6자리로 입력하세요"/></td>
					</tr>
					<tr>
						<th>구분</th>
						<td colspan="3">
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc1" name="home_srvc1" value="Y"
								<c:forEach items="${ms_list}" var="m" varStatus="status">
									<c:if test="${m.home_mngr_role_code eq '01'}">checked="checked"
									</c:if>
								</c:forEach>
								/><label for="home_srvc1"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;margin-right:20px">가사도우미</div>
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc2" name="home_srvc2" value="Y"
								<c:forEach items="${ms_list}" var="m" varStatus="status">
									<c:if test="${m.home_mngr_role_code eq '02'}">checked="checked"
									</c:if>
								</c:forEach>
								/><label for="home_srvc2"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;margin-right:20px">베이비시터</div>
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc3" name="home_srvc3" value="Y"
								<c:forEach items="${ms_list}" var="m" varStatus="status">
									<c:if test="${m.home_mngr_role_code eq '03'}">checked="checked"
									</c:if>
								</c:forEach>
								/><label for="home_srvc3"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;margin-right:20px" >입주도우미</div>
							<div class="pos-relative" style="display:inline;top:-4px">
								<input type="checkbox" id="home_srvc4" name="home_srvc4" value="Y"
								<c:forEach items="${ms_list}" var="m" varStatus="status">
									<c:if test="${m.home_mngr_role_code eq '04'}">checked="checked"
									</c:if>
								</c:forEach>
								/><label for="home_srvc4"><span></span></label>
							</div>
							<div style="display:inline;top:10px;position:relative;">산후도우미</div>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
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
							<input type="text" id="ph2" name="ph2" value="${info.ph2 }" style="width:40px" maxlength="4" onkeyup="chkNum(this)"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" value="${info.ph3 }" style="width:40px" maxlength="4" onkeyup="chkNum(this)"/>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
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
					<tr>
						<th>근로형태</th>
						<td>
							<select class="formSelect" style="width:100px" id="work_prt" name="work_prt">
								<option value="시간제">시간제</option>
								<option value="월급제">월급제</option>
								<option value="고정제">고정제</option>
								<option value="기타">기타</option>
							</select>
						</td>
						<th>급여일</th>
						<td>
							<select class="formSelect" style="width:100px" id="pay_day" name="pay_day">
								<c:forEach begin="1" end="31" var="dt">
									<option value="${dt}">${dt}일</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>계좌정보</th>
						<td colspan="3"><input type="text" id="bank_info" name="bank_info" value="${info.bank_info }" style="width:300px" />
						</td>
					</tr>
					<tr>
						<th>주소</th>
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
						<th>비고</th>
						<td colspan="3"><textarea id="bigo" name="bigo" style="height:80px;width:90%;padding:5px;margin:2px" >${info.bigo}</textarea></td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn-block">
				<a href="javascript:home_mngr_save()"><span>저장</span></a>
				<a href="javascript:history.back()" class="btn-gray"><span>취소</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>
</form>

</body>
</html>