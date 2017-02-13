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
<title>강사 상세정보</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>


<style type="text/css">
	section {
  		position: relative;
		}
section.positioned {
  position: absolute;
  top:100px;
  left:100px;
  width:800px;
}
.container {
  overflow-y: auto;
  height: 200px;
}
hist_tbl.table {
  border-spacing: 0;
  width:100%;
}
.hist_tbl th, .hist_tbl td {height:35px;border-bottom:1px solid #dcdcdc}
.hist_tbl th {height:35px;border-bottom:1px solid #dcdcdc;background-color:#eefcfc}
.hist_tbl td {text-align:center;padding:0 5px}
.hist_tbl td.text-left {padding-left:25px}

hist_tbl.th div{
  position: absolute;
  background: transparent;
  color: #fff;
  padding: 9px 25px;
  top: 0;
  margin-left: -25px;
  line-height: normal;
  border-left: 1px solid #800;
}
hist_tbl.tr:last-child div{
  border-bottom: none;
}
</style>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">


	$(document).ready(function() {
		
		
	});

$(function() {
	$('.formSelect').sSelect();
	
	var winHeight = $(window).height();
	var docHeight = $(document).height();

	function showModalDialogUrl(url) {
			$.get(url)
				.done(function(html) {
					var $dialog = $(html).appendTo(document.body);
					dialogInitPos($dialog);
					$dialog.fadeIn();

					$dialog.draggable({handler:"div.top-bar > h2"})
					.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

					if (winHeight < docHeight){
						$(".dim-warp").css ("height", docHeight);
					} else {
						$(".dim-warp").css ("height", winHeight);
					}

					$("div.close > a", $dialog).one("click", function(event) {
						$dialog.add($dialog.prev("div.dim-warp")).remove();
					});
				});
		}

		function showModalDialog($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handle:"div.top-bar > h2"})
				.before('<div class="dim-warp"  style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

			/* $("div.btn-close > a", $dialog).one("click", function(event) {
				$dialog.hide()
					.prev("div.dim-warp").remove();
			}); */
			$("#btn_schl_close", $dialog).one("click", function(event) {
				$('#grdt_year').val('');
				$('#schl_name').val('');
				$('#major').val('');
				$('#grdt_prt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_schl_xclose", $dialog).one("click", function(event) {
				$('#grdt_year').val('');
				$('#schl_name').val('');
				$('#major').val('');
				$('#grdt_prt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_fmly_close", $dialog).one("click", function(event) {
				$('#rel').val('');
				$('#family_name').val('');
				$('#born_year').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_fmly_xclose", $dialog).one("click", function(event) {
				$('#rel').val('');
				$('#family_name').val('');
				$('#born_year').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_qlfc_close", $dialog).one("click", function(event) {
				$('#qlfc_dt').val('');
				$('#cntn').val('');
				$('#inst_info').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_qlfc_xclose", $dialog).one("click", function(event) {
				$('#qlfc_dt').val('');
				$('#cntn').val('');
				$('#inst_info').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_carr_close", $dialog).one("click", function(event) {
				$('#prd').val('');
				$('#comp_name').val('');
				$('#pstn').val('');
				$('#rspn_task').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_carr_xclose", $dialog).one("click", function(event) {
				$('#prd').val('');
				$('#comp_name').val('');
				$('#pstn').val('');
				$('#rspn_task').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_hist_close", $dialog).one("click", function(event) {
				$('#work_prd').val('');
				$('#h_comp_name').val('');
				$('#h_pstn').val('');
				$('#rspn_work').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_hist_xclose", $dialog).one("click", function(event) {
				$('#work_prd').val('');
				$('#h_comp_name').val('');
				$('#h_pstn').val('');
				$('#rspn_wprl').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}

		$("#btn_schl_add").click(function(event) {
			showModalDialog($("#div_schl"));
		});
		$("#btn_fmly_add").click(function(event) {
			showModalDialog($("#div_fmly"));
		});
		$("#btn_qlfc_add").click(function(event) {
			showModalDialog($("#div_qlfc"));
		});
		$("#btn_carr_add").click(function(event) {
			showModalDialog($("#div_carr"));
		});
		$("#btn_hist_add").click(function(event) {
			showModalDialog($("#div_hist"));
		});
		
		
});


	function edu_stdt_edit() {
		document.mainform.action = "teacher_edit.do";
		document.mainform.submit();
	}
	function none() {
	}
	
	function schl_save() {
		document.frm_schl.action = "teacher_schl_save.do";
		document.frm_schl.submit();
	}
	
	function schl_info(seq, yy, nm, ma, prt) {
		showModalDialog($("#div_schl"));
		frm_schl.s_seq.value=seq;
		
		var winHeight = $(window).height();
		var docHeight = $(document).height();
		
		function showModalDialog($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handler:"div.top-bar > h2"})
			.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}

			$("#btn_schl_close", $dialog).one("click", function(event) {
				$('#grdt_year').val('');
				$('#schl_name').val('');
				$('#major').val('');
				$('#grdt_prt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_schl_xclose", $dialog).one("click", function(event) {
				$('#grdt_year').val('');
				$('#schl_name').val('');
				$('#major').val('');
				$('#grdt_prt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$('#grdt_year').val(yy);
			$('#schl_name').val(nm);
			$('#major').val(ma);
			$('#grdt_prt').val(prt);
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	function fmly_save() {
		document.frm_fmly.action = "teacher_fmly_save.do";
		document.frm_fmly.submit();
	}
	
	function fmly_info(seq, rel, nm, bo) {
		showModalDialog($("#div_fmly"));
		frm_fmly.f_seq.value=seq;
		
		var winHeight = $(window).height();
		var docHeight = $(document).height();
		
		function showModalDialog($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handler:"div.top-bar > h2"})
			.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}

			$("#btn_fmly_close", $dialog).one("click", function(event) {
				$('#rel').val('');
				$('#family_name').val('');
				$('#born_year').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_fmly_xclose", $dialog).one("click", function(event) {
				$('#rel').val('');
				$('#family_name').val('');
				$('#born_year').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$('#rel').val(rel);
			$('#family_name').val(nm);
			$('#born_year').val(bo);
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	function qlfc_save() {
		document.frm_qlfc.action = "teacher_qlfc_save.do";
		document.frm_qlfc.submit();
	}
	
	function qlfc_info(seq, dt, cntn, inst) {
		showModalDialog($("#div_qlfc"));
		frm_qlfc.q_seq.value=seq;
		
		var winHeight = $(window).height();
		var docHeight = $(document).height();
		
		function showModalDialog($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handler:"div.top-bar > h2"})
			.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}

			$("#btn_qlfc_close", $dialog).one("click", function(event) {
				$('#qlfc_dt').val('');
				$('#cntn').val('');
				$('#inst_info').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_qlfc_xclose", $dialog).one("click", function(event) {
				$('#qlfc_dt').val('');
				$('#cntn').val('');
				$('#inst_info').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$('#qlfc_dt').val(dt);
			$('#cntn').val(cntn);
			$('#inst_info').val(inst);
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	function carr_save() {
		document.frm_carr.action = "teacher_carr_save.do";
		document.frm_carr.submit();
	}
	
	function carr_info(seq, prd, nm, pstn, rspn) {
		showModalDialog($("#div_carr"));
		frm_carr.c_seq.value=seq;
		
		var winHeight = $(window).height();
		var docHeight = $(document).height();
		
		function showModalDialog($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handler:"div.top-bar > h2"})
			.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}

			$("#btn_carr_close", $dialog).one("click", function(event) {
				$('#prd').val('');
				$('#comp_name').val('');
				$('#pstn').val('');
				$('#rspn_task').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_carr_xclose", $dialog).one("click", function(event) {
				$('#prd').val('');
				$('#comp_name').val('');
				$('#pstn').val('');
				$('#rspn_task').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$('#prd').val(prd);
			$('#comp_name').val(nm);
			$('#pstn').val(pstn);
			$('#rspn_task').val(rspn);
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	function hist_save() {
		document.frm_hist.action = "teacher_hist_save.do";
		document.frm_hist.submit();
	}
	
	function hist_info(seq, prd, nm, pstn, rspn) {
		showModalDialog($("#div_hist"));
		frm_hist.h_seq.value=seq;
		
		var winHeight = $(window).height();
		var docHeight = $(document).height();
		
		function showModalDialog($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handler:"div.top-bar > h2"})
			.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}

			$("#btn_hist_close", $dialog).one("click", function(event) {
				$('#work_prd').val('');
				$('#h_comp_name').val('');
				$('#h_pstn').val('');
				$('#rspn_work').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#btn_hist_xclose", $dialog).one("click", function(event) {
				$('#work_prd').val('');
				$('#h_comp_name').val('');
				$('#h_pstn').val('');
				$('#rspn_work').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$('#work_prd').val(prd);
			$('#h_comp_name').val(nm);
			$('#h_pstn').val(pstn);
			$('#rspn_work').val(rspn);
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
	}
	
	function go_list() {
		
		document.mainform.action = "teacher_list.do";
		document.mainform.submit();
	}
	
	function teacher_edit() {
		document.mainform.action = "teacher_edit.do";
		document.mainform.submit();
	}
	
	function Download(url) {
	    document.getElementById('my_iframe').src = url;
	}
	
	function file_down(nm) { 
		mainform2.fileName.value=nm;
		mainform2.filePath.value="files/resume/";
		document.mainform2.action = "edu_file_down.do";
		document.mainform2.submit();
	}
	
	function user_resist() {
		
		var e = $('#email').val();
		var s = $('#student_no').val();
		
		if(confirm("회원등록하시겠습니까?")) {
		
			if(e == "") {
				alert("이메일 정보가 없습니다.");
				return;
			}
			else if(s == "") {
				alert("등록된 수강생 번호가 없습니다.");
				return;
			}
			else {
				
				$.ajax({ 
					   url: "user_email_check.do", 
					   type: "POST", 
					   data: {"email" : e},
					   dataType:"text",
					   cache: false,
					   success: function(msg){
						   
						   if(msg == "Y") {
							    document.mainform.action = "teacher_user_create.do";
							    document.mainform.submit();
						   }
						   else if(msg == "N"){
							   alert("동일한 아이디가 존재합니다. 다시 입력해주세요");
							   return false;
						   }
						   
					   }
					   , error: function (xhr, ajaxOptions, thrownError) {
					      }
					}); 
			}
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
<form id="mainform2" name="mainform2" action="" method="post">
<input type="hidden" id="fileName" name="fileName" />
<input type="hidden" id="filePath" name="filePath" />
</form>
<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="tch_no" name="tch_no" value="${info.teacher_code}"/>
<input type="hidden" id="email" name="email" value="${info.email }"/>
<input type="hidden" id="teacher_nm" name="teacher_nm" value="${info.teacher_nm }"/>
<input type="hidden" id="student_no" name="student_no" value="${info.student_no }"/>
<input type="hidden" id="phone" name="phone" value="${info.phone }"/>
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture}"/>
<input type="hidden" id="srch_teacher_name" name="srch_teacher_name" value="${srch.srch_teacher_name}"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone}"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<input type="hidden" id="pageNum" name="pageNum"  value="${srch.pageNum}"/>

<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">강사 상세정보</h2>
				<h3 class="mb0">${info.teacher_nm} 강사</h3>
				<c:if test="${srch.auth eq '001' and fn:length(info.user_id) eq 0 }" >
					<div class="btn-block">
						<a href="javascript:user_resist()"><span>회원등록</span></a>
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
						<th>강사코드</th>
						<td>${info.teacher_code }</td>
						<th rowspan="3">사진</th>
						<td rowspan="3" class="inner">
							<c:if test="${fn:length(info.image_path) gt 0 }">
								<img src="files/image/${info.image_path}" class="person" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th>강사명</th>
						<td>${info.teacher_nm}</td>
					</tr>
					<tr>
						<th>강사자격</th>
						<td>${info.lecture_nm }</td>
					</tr>
					<tr>
						<th>취득강사</th>
						<td colspan="3">${info.teacher_qlfc_prt_nm } </td>
					</tr>
					<tr>
						<th>지역</th>
						<td>${info.sido_code_nm} ${info.gugun_code_nm}</td>
						<th>강좌누적수</th>
						<td>${info.row_num }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${info.phone }</td>
						<th>이메일</th>
						<td>${info.email }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.sido_code_nm} ${info.gugun_code_nm} ${info.address }</td>
					</tr>
					<tr>
						<th>계좌정보</th>
						<td colspan="3">${info.bank_info}</td>
					</tr>
					<tr>
						<th>이력서</th>
						<td colspan="3"><a href="javascript:file_down('${info.resume}')" class="attach-file">${info.resume}</a></td>
					</tr>
				</tbody>
			</table>
			
			<dl class="table-dl mt35"><!-- 개인 정보와 떨어져 있는 처음 dl 에만 mt35 삽입 -->
				<dt>
					학력 정보
					<span class="btn-table"><a href="javascript:none()" id="btn_schl_add"><span>추가</span></a></span>
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
								<th>졸업년도</th>
								<th>학교명</th>
								<th>전공</th>
								<th>구분</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${s_list}" var="s" varStatus="status">
								<tr>
									<td>${s.grdt_year}</td>
									<td><a href="javascript:schl_info('${s.schl_seq}','${s.grdt_year}','${s.schl_name}','${s.major}','${s.grdt_prt}')">${s.schl_name}</a></td>
									<td>${s.major}</td>
									<td>${s.grdt_prt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</dd>
			</dl>
			<dl class="table-dl">
				<dt>
					가족 정보
					<span class="btn-table"><a href="javascript:none()" id="btn_fmly_add"><span>추가</span></a></span>
				</dt>
				<dd>
					<table class="talbe-inner">
						<colgroup>
							<col style="width:33.333%" />
							<col style="width:33.333%" />
							<col style="width:33.333%" />
						</colgroup>
						<thead>
							<tr>
								<th>관계</th>
								<th>성명</th>
								<th>출생년도</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${f_list}" var="f" varStatus="status">
								<tr>
									<td>${f.rel}</td>
									<td><a href="javascript:fmly_info('${f.family_seq}','${f.rel}','${f.family_name}','${f.born_year}')">${f.family_name}</a></td>
									<td>${f.born_year}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</dd>
			</dl>
			<dl class="table-dl">
				<dt>
					자격 정보
					<span class="btn-table"><a href="javasciprt:none()" id="btn_qlfc_add"><span>추가</span></a></span>
				</dt>
				<dd>
					<table class="talbe-inner">
						<colgroup>
							<col style="width:33.333%" />
							<col style="width:33.333%" />
							<col style="width:33.333%" />
						</colgroup>
						<thead>
							<tr>
								<th>취득일자</th>
								<th>활동내역</th>
								<th>기관</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${q_list}" var="q" varStatus="status">
								<tr>
									<td>${q.qlfc_dt}</td>
									<td><a href="javascript:qlfc_info('${q.qlfc_seq}','${q.qlfc_dt}','${q.cntn}','${q.inst_info}')">${q.cntn}</a></td>
									<td>${q.inst_info}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</dd>
			</dl>
			<dl class="table-dl">
				<dt>
					경력 정보
					<span class="btn-table"><a href="javascript:none()" id="btn_carr_add"><span>추가</span></a></span>
				</dt>
				<dd>
					<table class="talbe-inner">
						<colgroup>
							<col style="width:35%" />
							<col style="width:*" />
							<col style="width:18%" />
							<col style="width:18%" />
						</colgroup>
						<thead>
							<tr>
								<th>기간</th>
								<th>회사명</th>
								<th>직위</th>
								<th>담당업무</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${c_list}" var="c" varStatus="status">
								<tr>
									<td><a href="javascript:carr_info('${c.carr_seq}','${c.prd}','${c.comp_name}','${c.pstn}','${c.rspn_task}')">${c.prd}</a></td>
									<td>${c.comp_name}</td>
									<td>${c.pstn}</td>
									<td>${c.rspn_task}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</dd>
			</dl>
			<dl class="table-dl">
				<dt>
					강의경력 정보
					<span class="btn-table"><a href="javascript:none()" id="btn_hist_add"><span>추가</span></a></span>
				</dt>
				<dd>
					<%-- <table class="talbe-inner">
						<colgroup>
							<col style="width:30%" />
							<col style="width:*" />
							<col style="width:18%" />
							<col style="width:18%" />
						</colgroup>
						<thead>
							<tr> --%>
					<section class="">			
  						<div class="container">
    					<table class="hist_tbl">
    						<colgroup>
								<col style="width:30%" />
								<col style="width:*" />
								<col style="width:18%" />
								<col style="width:18%" />
							</colgroup>
      						<thead>
        						<tr class="header">
								<th>기간</th>
								<th>회사명</th>
								<th>직위</th>
								<th>담당업무</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${h_list}" var="h" varStatus="status">
								<tr>
									<td>
										<c:choose>
											<c:when test="${h.tch_seq eq '0'}">
												${h.work_prd}
											</c:when>
											<c:otherwise>
												<a href="javascript:hist_info('${h.tch_seq}','${h.work_prd}','${h.comp_name}','${h.pstn}','${h.rspn_work}')">${h.work_prd}</a>
											</c:otherwise>
										</c:choose>
									</td>
									<td>${h.comp_name}</td>
									<td>${h.pstn}</td>
									<td>${h.rspn_work}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
					</section>
				</dd>
			</dl>

			<div class="btn-block">
				<a href="javascript:teacher_edit();" class="btn-negative"><span>수정</span></a>
				<a href="javascript:go_list();"><span>리스트</span></a>
			</div><!--// btn-block -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>
</form>

<form id="frm_schl" name="frm_schl" action="" method="post">
<div id="div_schl" class="layer-warp">
<input type="hidden" id="s_seq" name="s_seq" />
<input type="hidden" id="tch_no" name="tch_no" value="${info.teacher_code}"/>
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture }"/>
<input type="hidden" id="srch_teacher_name" name="srch_teacher_name" value="${srch.srch_teacher_name }"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
	<div class="layer-inner">
		<div class="top-bar">
			<h2>학력정보</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_schl_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			
			<table class="talbe-list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>졸업년도</th>
						<td><input type="text" id="grdt_year" name="grdt_year" style="width:90%"></input></td>
						<th>학교명</th>
						<td><input type="text" id="schl_name" name="schl_name" style="width:90%"></input></td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<th>전공</th>
						<td><input type="text" id="major" name="major" style="width:90%"></input></td>
						<th>구분</th>
						<td><input type="text" id="grdt_prt" name="grdt_prt" style="width:90%"></input></td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">				
				<a href="javascript:schl_save()"><span>저장</span></a>
				<a href="javascript:none()" class="btn-negative" id="btn_schl_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

<form id="frm_fmly" name="frm_fmly" action="" method="post">
<div id="div_fmly" class="layer-warp">
<input type="hidden" id="f_seq" name="f_seq" />
<input type="hidden" id="tch_no" name="tch_no" value="${info.teacher_code}"/>
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture }"/>
<input type="hidden" id="srch_teacher_name" name="srch_teacher_name" value="${srch.srch_teacher_name }"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
	<div class="layer-inner">
		<div class="top-bar">
			<h2>가족정보</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_fmly_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			
			<table class="talbe-list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>관계</th>
						<td><input type="text" id="rel" name="rel" style="width:90%"></input></td>
						<th>성명</th>
						<td><input type="text" id="family_name" name="family_name" style="width:90%"></input></td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<th>출생년도</th>
						<td><input type="text" id="born_year" name="born_year" style="width:90%"></input></td>
						<th></th>
						<td></td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">				
				<a href="javascript:fmly_save()"><span>저장</span></a>
				<a href="javascript:none()" class="btn-negative" id="btn_fmly_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

<form id="frm_qlfc" name="frm_qlfc" action="" method="post">
<div id="div_qlfc" class="layer-warp">
<input type="hidden" id="q_seq" name="q_seq" />
<input type="hidden" id="tch_no" name="tch_no" value="${info.teacher_code}"/>
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture }"/>
<input type="hidden" id="srch_teacher_name" name="srch_teacher_name" value="${srch.srch_teacher_name }"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
	<div class="layer-inner">
		<div class="top-bar">
			<h2>자격정보</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_qlfc_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			
			<table class="talbe-list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>일자</th>
						<td><input type="text" id="qlfc_dt" name="qlfc_dt" style="width:90%"></input></td>
						<th>활동내역</th>
						<td><input type="text" id="cntn" name="cntn" style="width:90%"></input></td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<th>기관</th>
						<td><input type="text" id="inst_info" name="inst_info" style="width:90%"></input></td>
						<th></th>
						<td></td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">				
				<a href="javascript:qlfc_save()"><span>저장</span></a>
				<a href="javascript:none()" class="btn-negative" id="btn_qlfc_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>
<form id="frm_carr" name="frm_carr" action="" method="post">
<div id="div_carr" class="layer-warp">
<input type="hidden" id="c_seq" name="c_seq" />
<input type="hidden" id="tch_no" name="tch_no" value="${info.teacher_code}"/>
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture }"/>
<input type="hidden" id="srch_teacher_name" name="srch_teacher_name" value="${srch.srch_teacher_name }"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
	<div class="layer-inner">
		<div class="top-bar">
			<h2>경력정보</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_carr_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			
			<table class="talbe-list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>기간</th>
						<td><input type="text" id="prd" name="prd" style="width:90%"></input></td>
						<th>회사명</th>
						<td><input type="text" id="comp_name" name="comp_name" style="width:90%"></input></td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<th>직위</th>
						<td><input type="text" id="pstn" name="pstn" style="width:90%"></input></td>
						<th>담당업무</th>
						<td><input type="text" id="rspn_task" name="rspn_task" style="width:90%"></input></td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">				
				<a href="javascript:carr_save()"><span>저장</span></a>
				<a href="javascript:none()" class="btn-negative" id="btn_carr_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

<form id="frm_hist" name="frm_hist" action="" method="post">
<div id="div_hist" class="layer-warp">
<input type="hidden" id="h_seq" name="h_seq" />
<input type="hidden" id="tch_no" name="tch_no" value="${info.teacher_code}"/>
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture }"/>
<input type="hidden" id="srch_teacher_name" name="srch_teacher_name" value="${srch.srch_teacher_name }"/>
<input type="hidden" id="srch_phone" name="srch_phone" value="${srch.srch_phone }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
	<div class="layer-inner">
		<div class="top-bar">
			<h2>경력정보</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_hist_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			
			<table class="talbe-list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>기간</th>
						<td><input type="text" id="work_prd" name="work_prd" style="width:90%"></input></td>
						<th>회사명</th>
						<td><input type="text" id="h_comp_name" name="h_comp_name" style="width:90%"></input></td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<th>직위</th>
						<td><input type="text" id="h_pstn" name="h_pstn" style="width:90%"></input></td>
						<th>담당업무</th>
						<td><input type="text" id="rspn_work" name="rspn_work" style="width:90%"></input></td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">				
				<a href="javascript:hist_save()"><span>저장</span></a>
				<a href="javascript:none()" class="btn-negative" id="btn_hist_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>