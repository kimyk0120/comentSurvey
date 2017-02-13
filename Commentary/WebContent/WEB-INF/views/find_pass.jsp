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
<script type="text/javascript" src="./common/js/placeholders.min.js"></script>

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
			
		function new_pass() {
			
			if (mainform.ID.value == "") {
				alert("아이디를 입력해주세요");
				return;
			} else if (mainform.email.value == "") {
				alert("받으실 이메일을 입력해주세요");
				return;
			} else {
				
				if(confirm("메일로 임시번호를 발송합니다. 진행하시겠습니까?")) {
			
					$.ajax({ 
						   url: "new_pass.do", 
						   type: "POST", 
						   data: {"ID" : mainform.ID.value, "email" : mainform.email.value},
						   dataType:"text",
						   cache: false,
						   beforeSend: function() { $("#wait").css("display", "block"); },
						   success: function(msg){
							   alert(msg);
							   $("#wait").css("display", "none");
						   }
						   , error: function (xhr, ajaxOptions, thrownError) {
						      }
					}); 
				}
			}
		}
			
		
		function checkEnterKey(){
			if(event.keyCode==13){new_pass();}
		}
		
		function go_login() {
			location.href="login.do";
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
			location.href="main_info.do";
		}
		
		function go_manual() {
			$('#fileName').val("UserManual-V1.0.pdf");
			$('#filePath').val("files/");
			document.mainform2.action = "file_down.do";
			document.mainform2.submit();
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

				<h1><img src="./image/login_h2.png" alt="문화관광해설사 인력관리 시스템" /></h1>
				
					<fieldset>
						<legend><span>문화관광해설사 인력관리 시스템 로그인</span></legend>
						<div id="wait" style="display:none;width:69px;height:89px;border:1px solid black;position:absolute;top:50%;left:50%;padding:2px;"><img src='image/demo_wait.gif' width="64" height="64" />Loading..</div>
						<div><label for="user-id"><span>아이디</span></label><input type="text" id="ID" name="ID" placeholder="등록된 아이디" class="id" title="등록된 아이디" /></div>
						<div><label for="user-id"><span>이메일</span></label><input type="text" id="email" name="email" placeholder="받으실 이메일" title="받으실 이메일" onKeyDown="javascript:checkEnterKey()" value="" class="id" /></div>
						<div class="btn-login-login"><a href="javascript:new_pass();">비밀번호 초기화</a></div>
					</fieldset>
					
					<p class="btn-search"><a href="javascript:go_login();">로그인 페이지로</a></p>
					
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
			<li><a href="#a"><img src="./image/login_logo_mcst.png" alt="문화체육관광부" /></a></li>
			<li><a href="#a"><img src="./image/login_logo_kcti.png" alt="한국문화관광연구원" /></a></li>
		</ul><!-- // col50 -->
		</div><!-- // box-in -->
</div><!-- // box-out -->

</form>
	</body>
</html>


