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
<link href="./common/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="./common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="./common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="./common/js/ui.js"></script>

	<script type="text/javascript">
			
		$(document).ready(function(){
			var m = "<c:out value="${msg}"/>";
			
			if(m != "") {
				alert(m);
			}
			
		});
		
		$(function() {
			$('.formSelect').sSelect();
		});
			
		function login() {
			
			var prt =  $(':radio[name="login_prt"]:checked').val();
			if(prt == "2") {
				if (mainform.ID.value == "") {
					alert("아이디를 입력해주세요");
					return;
				}	
			}
			if (mainform.PW.value == "") {
				alert("비밀번호를 입력해주세요");
				return;
			} else {
				document.mainform.action = "login_check.do";
				document.mainform.submit();
			}
			
		}	
		
		function checkEnterKey(){
			if(event.keyCode==13){login();}
		}
		
		function go_pass() {
			location.href="find_pass.do";
		}
		
		function go_board() {
			location.href="non_login_user.do?prt=1";
		}
		
		function go_board_info(seq) {
			location.href="non_login_user.do?prt=1&b_seq="+seq;
		}
		function go_qna() {
			location.href="non_login_user.do?prt=2";
		}
		function go_faq() {
			location.href="non_login_user.do?prt=3";
		}
		
		function main_info() {
			location.href="non_login_user.do?prt=4";
		}
		
		function go_manual() {
			$('#fileName').val("UserManual-V1.0.pdf");
			$('#filePath').val("files/");
			document.mainform2.action = "file_down.do";
			document.mainform2.submit();
		}
		
		function login_prt_chk(prt) {
			
			if(prt == "1" || prt == "3") {
				$("#cmmt_id").css("display", "none");
				$("#mng_id").css("display", "block");
			} else {
				$("#cmmt_id").css("display", "block");
				$("#mng_id").css("display", "none");
			}
			
		}
		
		
		function get_gugun() {
			var s_sido = $("select[name=srch_sido]").val();
			$.ajax({ 
				   url: "srch_gugun.do", 
				   type: "POST", 
				   data: {"s_sido" : s_sido},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
					   var tmp = msg.split('|');
					   if(msg != "") {
						   str=str+"<option value=\"\">전체</option>";
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split(",");
		        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   		}
					   } else {
						   str=str+"<option value=\"\">없음</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   $('.formSelect').sSelect();
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
		}
		
		</script>
  		
	</head>
		
<body id="login">

<form id="mainform2" name="mainform2" action="" method="post">
<input type="hidden" id="fileName" name="fileName" />
<input type="hidden" id="filePath" name="filePath" />
</form>


<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="top" name="top" value="0" />
<input type="hidden" id="left" name="left" value="0" />
<input type="hidden" id="b_seq" name="b_seq" />
<input type="hidden" id="prt" name="prt" />

<div class="box-out">

	<div class="box-in">
	
		<div class="col50 clearfix">

			<div class="col-l">

				<h1><img src="./image/login_h2.png" alt="문화관광해설사 관리 시스템" /></h1>
				
					<fieldset>
						<legend><span>문화관광해설사 관리 시스템 로그인</span></legend>
						
						<div class="pos-relative"><input type="radio" name="login_prt" id="radio11" value="1" style="height:20px" onclick="javascript:login_prt_chk('1')"/><label for="radio11">관리자</label></div>
						<div class="pos-relative"><input type="radio" name="login_prt" id="radio12" value="2" style="height:20px" onclick="javascript:login_prt_chk('2')"/><label for="radio12">해설사</label></div>
						<div class="pos-relative"><input type="radio" name="login_prt" id="radio13" value="3" style="height:20px" onclick="javascript:login_prt_chk('3')"/><label for="radio13">위탁기관</label></div>
						
						<div id="cmmt_id" style="display:none;"><label for="user-id"><span>아이디</span></label><input type="text" id="ID" name="ID" value="" class="id" title="아이디"/></div>
						<div class="search-row" id="mng_id" style="display:none;margin-top:5px">
							<label for="srch_sido_cd">지역선택</label>
								<select class="formSelect" id="srch_sido" name="srch_sido" style="width:100px;margin-right:7px" title="" onchange="get_gugun()" tabindex="1">
									<option value="">전체</option>
									<c:forEach items="${s_list}" var="s">
										<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
									</c:forEach>
									<option value="Z">문화체육관광부</option>
								</select>
							<div id="gugun_div" style="display:inline;">
								<!-- <select class="formSelect" style="width:150px;" title="" tabindex="2">
									<option value="">전체</option>
								</select> -->
							</div>
						</div><!-- // search-row -->

						<div><label for="user-pw"><span>패스워드</span></label><input type="password" id="PW" name="PW" onKeyDown="javascript:checkEnterKey()" value="" class="pw" title="패스워드"/></div>
						
						<div class="btn-login-login"><a href="javascript:login();">Login</a></div>
					</fieldset>
					
					<p class="btn-search"><a href="javascript:go_pass();"> 비밀번호 찾기</a></p>
					<p class="btn-search" style="padding-top:5px">
						<a href="http://kcti.re.kr/policy_pop.dmj" target="_blank" title="새 창으로 개인정보처리방침 보기" onclick="window.open(this.href,'policyPopup','width=575,height=650,toolbar=no,resizable=yes,scrollbars=yes,left=0,top=0'); return false;" title="개인정보처리방침" >개인정보처리방침</a>
					</p>
					
			</div>
			
			<div class="col-r">

				<ul class="btn-go1">
					<li><a href="javascript:main_info();">시스템 안내</a></li>
					<li><a href="javascript:go_manual();">사용자 매뉴얼</a></li>
					<li><a href="javascript:go_board()">공지사항</a></li>
				</ul>	
			
				<div class="notice">
					<ul>	
						<c:forEach items="${b_list}" var="c" varStatus="status">
						<li><a href="javascript:go_board_info('${c.board_seq }')" >${c.title}</a></li>
						</c:forEach>
					</ul>
					<p class="btn-login-more"><a href="javascript:go_board()">더 보기</a></p>
				</div>
				
			</div>
			
			<div class="btn-go2">
				<a href="javascript:go_qna()" class="btn1">Q&amp;A</a>
				<a href="javascript:go_faq()" class="btn2">FAQ</a>
			</div>
		</div><!-- // col50 -->
		
		<ul class="col50 link clearfix">
			<li><a href="http://www.mcst.go.kr"><img src="./image/login_logo_mcst.png" alt="문화체육관광부" /></a></li>
			<li><a href="http://www.kcti.re.kr"><img src="./image/login_logo_kcti.png" alt="한국문화관광연구원" /></a></li>
		</ul><!-- // col50 -->
		</div><!-- // box-in -->
</div><!-- // box-out -->

</form>
	</body>
</html>


