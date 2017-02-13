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
<title>문화관광해설사 관리시스템</title>
<link href="common/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>
<jsp:useBean id="now" class="java.util.Date" />

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />


<script type="text/javascript">

	$(document).ready(function() {
		
	});

	$(function() {
		$('.formSelect').sSelect();
	});
	
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
	
	function email_select2() {
		var e = document.getElementById("em2");
		var em = e.options[e.selectedIndex].value;
		
		if( em == "" || em == null) {
			document.getElementById("div_email2").style.display = "inline";
			$('#em3').val("");
		} else {
			document.getElementById("div_email2").style.display = "none";
		}
	}
	
	function auth_ch() {
		
		var aNo = $("select[name=auth_no]").val();
		
		if(aNo == "2" || aNo == "3") {
			document.getElementById("org_yn").style.display = "inline-block";
		} else {
			document.getElementById("org_yn").style.display = "none";
			 $("input:checkbox[name='cnsm_org_yn']").attr('checked', false);
		}
		
		
	}
	
	function get_gugun() {
		
		var s_sido = $("select[name=sido_cd]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "<select class=\"formSelect\" id=\"gugun_cd\" name=\"gugun_cd\" style=\"width:150px;\" title=\"\">";
				   str=str+"<option value=\"\">선택</option>";
				   if(msg != "" && msg != null) {
					   var tmp = msg.split('|');
					   
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   		}
				   }
				   str = str+"</select>";
				   document.getElementById("gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
	function user_save() {
		
		var ph1 = mainform.ph1.value;
		var ph2 = mainform.ph2.value;
		var ph3 = mainform.ph3.value;
		
		if(ph1 != '' && ph2 != '' && ph3 != '') {
			mainform.phone.value=ph1+"-"+ph2+"-"+ph3;
		}
		
		var e1 = mainform.email1.value;
		var e2 = mainform.email2.value;
		var e3 = mainform.email3.value;
		
		if(e1 != '') {
			if(e2 != '') {
				mainform.email.value=e1+"@"+e2;
			} else if(e3 != '') {
				mainform.email.value=e1+"@"+e3;
			}
		}
		
		var iD = $("#em1").val();
		/* var e2 = $("#em2").val();
		var e3 = $("#em3").val(); */
		
		/* if(e1 != '') {
			if(e2 != '') {
				iD=e1+"@"+e2;
			} else if(e3 != '') {
				iD=e1+"@"+e3;
			}
		} */
		$('#id2').val(iD);
		
		var sCd = $("select[name=sido_cd]").val();
		var gCd = $("select[name=gugun_cd]").val();
		var aCd = $("select[name=auth_no]").val();
		
		if($('#id_ok').val() != "Y") {
			alert("아이디 중복 체크를 해주십시오.");
		//	$("#id2").focus();
			return;
		} else if( $('#userId').val() != $('#id2').val() ) {
			alert("중복 겁사한 아이디와 다른 아이디입니다. 다시 중복 체크 해주십시오.");
			$("#em1").focus();
			return;
		} else if( $('#pw').val() == "" ) {
			alert("비밀번호를 입력하여 주십시요.");
			$("#pw").focus();
			return;
		} else if( $('#pw').val() != $('#pw2').val() ) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#pw2").focus();
			return;
		} else if($('#nm').val() == "" ) {
			alert("이름을 입력하여 주십시요.");
			$("#nm").focus();
			return;
		} else if($('#phone').val() == "" ) {
			alert("연락처를 입력하여 주십시요.");
			$("#ph1").focus();
			return;
		} else if($('#email').val() == "" ) {
			alert("이메일을 입력하여 주십시요.");
			$("#email1").focus();
			return;
		} else if($("#auth_no option:selected").val() == "") {
			alert("권한을 선택하여 주십시요.");
			$("#auth_no").focus();
			return;
		} else if(aCd == "2" && (sCd == "" || sCd == null)) {
			alert("지자체(시도) 권한의 경우 소속(시도)을 선택해야 합니다.");
			return;
		} else if(aCd == "3" && (gCd == "" || gCd == null)) {
			alert("지자체(구군) 권한의 경우 소속(구군)을 선택해야 합니다.");
			return;
		}
		else {
			if(aCd == "2" && gCd != "") {
				alert("지자체(시도) 권한의 경우 소속은 시도만  저장됩니다.");
				$("#gugun_cd").val("").change(); 
			} 
			document.mainform.target = "_self";
			document.mainform.action = "user_save.do";
			document.mainform.submit();
		}
	}
	
	function user_list() {
		
		//document.mainform.target = "_self";
		//document.mainform.action = "user_list.do";
		window.location.href = "user_list.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
		// document.mainform.submit();
	}
	
	function id_check() {
		
		//var iD = $("#id2").val();
		//var iD = "";
		var iD = $("#em1").val();
		/* var e2 = $("#em2").val();
		var e3 = $("#em3").val(); 
		
		if(e1 != '') {
			if(e2 != '') {
				iD=e1+"@"+e2;
			} else if(e3 != '') {
				iD=e1+"@"+e3;
			}
		}
		*/
		
		if( iD == "" || iD == null ) {
			alert("아이드를 정확하게 입력해주세요.");
			   $("#em1").focus();
			   return;
		}
		else {
		
			$.ajax({ 
				   url: "id_check.do", 
				   type: "POST", 
				   data: {"id" : iD},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   if(msg == "Y") {
						    $('#id_ok').val('Y');
							document.getElementById("id_comment").style.display = "inline-block";
							document.getElementById("div_id_ok").className = "success";
							$('#userId').val(iD);
					   }
					   else if(msg == "N"){
						   alert("동일한 아이디가 존재합니다. 다시 입력해주세요");
						   $("#em1").focus();
						   return false;
					   }
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
	}
	
	function pw_ok() {
		var p1 = $("#pw").val();
		var p2 = $("#pw2").val();
		
		if(p1 == p2) {
			document.getElementById("pw_comment1").style.display = "none";
			document.getElementById("pw_comment2").style.display = "inline-block";
			document.getElementById("div_pw_ok").className = "success";
		}
		else {
			document.getElementById("pw_comment1").style.display = "inline-block";
			document.getElementById("pw_comment2").style.display = "none";
			document.getElementById("div_pw_ok").className = "fail";
		}
	} 
	
</script>
</head>
<body>
<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="phone" name="phone" />
<input type="hidden" id="email" name="email" />
<input type="hidden" id="id_ok" name="id_ok" />
<input type="hidden" id="userId" name="userId" />
<input type="hidden" id="id2" name="id2" />

	<jsp:include page="../main/topMenu.jsp"  />
	

	<div id="container" class="colum1">

		<div class="contents">

			<h2>사용자 등록</h2>
			
			<div class="shadow-box">				

				<table class="talbe-view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th>아이디</th>
							<td>
								<div id="div_id_ok" class="fail">
									<input type="text" name="em1" id="em1" value="" title="이메일 아이디" style="width:150px"/>
										<!-- <span class="txt-symbol">@</span>
										<select class="formSelect phone-num" style="width:120px" name="em2" id="em2" title="이메일 도메인 선택" onchange="email_select2()">
											<option value="">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="nate.com">nate.com</option>
											<option value="empal.com">empal.com</option>
											<option value="daum.net">daum.net</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="google.com">google.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="hotmail.com">hotmail.com</option>
										</select>
										<div id="div_email2"  style="display:inline;">
											<input type="text" id="em3" name="em3" style="width:120px" title="아이디 이메일 도메인 직접 입력"/>
										</div> -->
									<div style="display:inline"><span class="btn-table"><a href="javascript:id_check()"><span>아이디중복</span></a></span>
									<span id="id_comment" class="comment" style="display:none;">사용가능한 아이디입니다.</span></div>
								</div>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="pw" id="pw" style="width:150px;" title="비밀번호" /></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<div id="div_pw_ok" class="fail">
									<input type="password" name="pw2" id="pw2" style="width:150px;" title="비밀번호 확인" onkeyup="javascript:pw_ok();"/>
									<span id="pw_comment1" class="comment" style="display:none;">비밀번호 불일치</span>
									<span id="pw_comment2" class="comment" style="display:none;">비밀번호 일치</span>
								</div>
							</td>
						</tr> 
						<tr>
							<th>소속</th>
							<td>
								<select class="formSelect" id="sido_cd" name="sido_cd" style="width:150px;" title="" onchange="get_gugun()">
									<option value="">시도</option>
									<c:forEach items="${s_list}" var="s">
										<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
									</c:forEach>
								</select>
								<span class="txt-symbol">,</span>
								<div id="gugun_div" style="display:inline;">
									<select class="formSelect" style="width:150px;" title="">
										<option value="">구군</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th>성명</th>
							<td>
								<div class="item-block">
									<input type="text" name="nm" id="nm" style="width:150px;" title="성명" />
								</div>
							</td>
						</tr>
						<tr>
							<th>권한</th>
							<td>
								<div class="item-block" style="display:inline">
									<select class="formSelect" id="auth_no" name="auth_no" style="width:150px;" title="사용자 권한" onchange="javascipt:auth_ch()">
										<option value="">권한</option>
										<option value="1">관리자</option>
										<option value="2">지자체(시도)</option>
										<option value="3">지자체(구군)</option>
										<option value="5">한국관광공사</option>
									</select>
								</div>
								<div id="org_yn" class="pos-relative" style="margin-left:10px;display:none"><input type="checkbox" name="cnsm_org_yn" id="rd1" value="Y" /><label for="rd1">위탁기관여부</label></div>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<div class="email-block">
									<input type="text" name="email1" id="email1" value="" title="이메일 아이디" style="width:150px"/>
									<span class="txt-symbol">@</span>
									<!-- <input type="text" name="email2" id="email2" value="" title="이메일 도메인" /> -->
									<select class="formSelect phone-num" style="width:120px" name="email2" id="email2" title="이메일 도메인 선택" onchange="email_select()">
										<option value="">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="nate.com">nate.com</option>
										<option value="empal.com">empal.com</option>
										<option value="daum.net">daum.net</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="google.com">google.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="hotmail.com">hotmail.com</option>
									</select>
									<div id="div_email"  style="display:inline;">
										<input type="text" id="email3" name="email3" style="width:120px" title="이메일 도메인 직접 입력" />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>
								<div class="phone-block">
									<input type="text" id="ph1" name="ph1" value="" title="전화번호 국번" class="row-input" />
									<span class="txt-symbol">-</span>
									<input type="text" id="ph2" name="ph2" value="" title="전화번호 앞 3~4 자리" class="row-input" />
									<span class="txt-symbol">-</span>
									<input type="text" id="ph3" name="ph3" value="" title="전화번호 뒤 4 자리" class="row-input" />
								</div>
							</td>
						</tr>
						
					</tbody>
				</table>

				<div class="btn-block text-center mt20">
					<a href="javascript:user_save()" class="btn-blue"><span>등록</span></a>
					<a href="javascript:user_list()" class="btn-orange"><span>리스트</span></a>
				</div>

			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
</div>


</body>
</html>

