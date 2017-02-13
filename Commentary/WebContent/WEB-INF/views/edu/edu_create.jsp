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
<title>교육계획 등록 – 강사기준  l 교육통합관리</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		var a = "<c:out value="${auth}"/>";
		var t = "<c:out value="${info.teacher_code}"/>";
		
		if(a != '001') {
			$("#teacher_code").val(t); 
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
		
		$( '#start_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",
			onClose: function( selectedDate ) {
				$( '#end_dt' ).datepicker( 'option', 'minDate', selectedDate );
			}
		});
		$( '#end_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd",
			onClose: function( selectedDate ) {
				$( '#start_dt' ).datepicker( 'option', 'maxDate', selectedDate );
			}
		});
	});

	$(function() {
		$('.formSelect').sSelect();
		
		function showModalDialogUrl(url) {
			$.get(url)
				.done(function(html) {
					var $dialog = $(html).appendTo(document.body);
					dialogInitPos($dialog);
					$dialog.fadeIn();

					$dialog.draggable({handler:"div.top-bar > h2"})
						.before('<div class="dim-warp" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');

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
			
			$("#edu_inst_xclose", $dialog).one("click", function(event) {
				
				var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
     				str = str+"<option value=\"\">구군</option></select>";
				   document.getElementById("srch_gugun_div").innerHTML=str;
				   
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#edu_inst_close", $dialog).one("click", function(event) {
				var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
 				str = str+"<option value=\"\">구군</option></select>";
			   document.getElementById("srch_gugun_div").innerHTML=str;
			   
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#teacher_xclose", $dialog).one("click", function(event) {
				
				var str = "<select class=\"formSelect\" id=\"srch_gugun2\" name=\"srch_gugun2\" style=\"width:100px;\" title=\"\">";
 				str = str+"<option value=\"\">구군</option></select>";
			   document.getElementById("srch_gugun_div").innerHTML=str;
			   
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			$("#teacher_close", $dialog).one("click", function(event) {
				
				var str = "<select class=\"formSelect\" id=\"srch_gugun2\" name=\"srch_gugun2\" style=\"width:100px;\" title=\"\">";
 				str = str+"<option value=\"\">구군</option></select>";
			   document.getElementById("srch_gugun_div").innerHTML=str;
			   
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}

		$("#btn-popup").click(function(event) {
			showModalDialog($("#srch_pop_edu_inst"));
		});
		
		$("#btn-popup2").click(function(event) {
			showModalDialog($("#srch_pop_teacher"));
		});
		
	});
	
	function none() {
		var a = "";
		alert("npone");
	}
	
	function get_gugun() {
		
//		var e = document.getElementById("srch_sido");
//		var s_sido = e.options[e.selectedIndex].value;
		var s_sido = $("select[name=srch_sido]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
				   
				   if(msg != null && msg != "") {
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
				   } else {
					   str = str+"<option value=\"\">구군</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("srch_gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
	function get_gugun2() {
		
//		var e = document.getElementById("srch_sido");
//		var s_sido = e.options[e.selectedIndex].value;
		var s_sido = $("select[name=srch_sido2]").val();
		
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"srch_gugun2\" name=\"srch_gugun2\" style=\"width:100px;\" title=\"\">";
				   
				   if(msg != null && msg != "") {
				   
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
				   } else {
					   str = str+"<option value=\"\">구군</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("srch_gugun_div2").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
	/* function checkEnterKey_inst(){
		if(event.keyCode==13){srch_inst();}
	} */
	
	function srch_inst() {
		
		var si = sr_edu_inst.srch_sido.value;
		var gu = sr_edu_inst.srch_gugun.value;
		var inst = sr_edu_inst.srch_edu_inst.value;
		
		if(si == "" && gu == "" && inst == "") {
			alert("하나 이상 조건으로 검색해야 합니다.");
			return;
		}
		else {
			
		 $.ajax({ 
			   url: "srch_edu_inst.do", 
			   type: "POST", 
			   data: {"si" : si, "gu" : gu, "inst" : inst},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:30%\" /><col style=\"width:50%\" /><col style=\"width:20%\" /></colgroup><thead><tr><th>교육기관명</th><th>주소</th><th>연락처</th></tr></thead></table>";
				   str = str + "<div class=\"table-scroll\" style=\"height:123px\"><table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:30%\" /><col style=\"width:50%\" /><col style=\"width:20%\" /></colgroup><tbody>";
				   if( tmp == null || tmp == "" ) {
					   str = str+"<tr><td colspan=\"3\">검색결과가 없습니다</td></tr>";
				   }
				   else {
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
						   var si = tmp_sub[1];
						   if(si == 'null') si = "";
						   var gu = tmp_sub[2];
						   if(gu == 'null') gu = "";
	        				str = str+"<tr><td onclick=\"javascript:pick_inst('"+tmp_sub[4]+"','"+tmp_sub[0]+"')\">"+tmp_sub[0]+"</td><td>"+si+" "+gu+"</td><td>"+tmp_sub[3]+"</td></tr>";
					   }
				   }
				   str = str+"</tbody></table></div>";
				   document.getElementById("div_edu_inst").innerHTML=str;
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			});
		}
	}
	
	function pick_inst(cd, nm) {
		if ( confirm("해당 교육기관으로 선택하시겠습니까?") ) {
			
			mainform.edu_inst_code.value= cd;
			$('#edu_inst_nm').val(nm);
			
			var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
				str = str+"<option value=\"\">구군</option></select>";
		   document.getElementById("srch_gugun_div").innerHTML=str;
			
			$("#srch_pop_edu_inst").hide().prev("div.dim-warp").remove();
		}
	}
	
	/* function checkEnterKey_tch(){
		if(event.keyCode==13){srch_teacher();}
	} */
	
	function srch_teacher() {
		
		var si = sr_teacher.srch_sido2.value;
		var gu = sr_teacher.srch_gugun2.value;
		var tch = sr_teacher.srch_teacher.value;
		
		if(si == "" && gu == "" && tch == "") {
			alert("하나 이상 조건으로 검색해야 합니다.");
			return;
		}
		else {
			
		 $.ajax({ 
			   url: "srch_edu_teacher.do", 
			   type: "POST", 
			   data: {"si" : si, "gu" : gu, "tch" : tch},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:15%\" /<col style=\"width:30%\" /><col style=\"width:35%\" /><col style=\"width:20%\" /></colgroup><thead><tr><th>강사명</th><th>주소</th><th>자격</th><th>연락처</th></tr></thead></table>";
				   str = str + "<div class=\"table-scroll\" style=\"height:123px\"><table class=\"table-popup full\" style=\"width:650px;margin:0px 20px\"><colgroup><col style=\"width:15%\" /><col style=\"width:30%\" /><col style=\"width:35%\" /><col style=\"width:20%\" /></colgroup><tbody>";
				   if( tmp == null || tmp == "" ) {
					   str = str+"<tr><td colspan=\"4\">검색결과가 없습니다</td></tr>";
				   }
				   else {
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split("`");
						   var si = tmp_sub[2];
						   if(si == 'null') si = "";
						   var gu = tmp_sub[3];
						   if(gu == 'null') gu = "";
	        				str = str+"<tr><td onclick=\"javascript:pick_tch('"+tmp_sub[0]+"','"+tmp_sub[1]+"')\">"+tmp_sub[1]+"</td><td>"+si+" "+gu+"</td><td>"+tmp_sub[4]+"("+tmp_sub[5]+")</td><td>"+tmp_sub[6]+"</td></tr>";
					   }
				   }
				   str = str+"</tbody></table>";
				   document.getElementById("div_teacher").innerHTML=str;
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			});
		}
	}
	
	function pick_tch(cd, nm) {
		if ( confirm("해당 강사 선택하시겠습니까?") ) {
			mainform.teacher_code.value= cd;
			mainform.teacher_nm.value=nm;
			
			var str = "<select class=\"formSelect\" id=\"srch_gugun\" name=\"srch_gugun\" style=\"width:100px;\" title=\"\">";
				str = str+"<option value=\"\">구군</option></select>";
		   document.getElementById("srch_gugun_div").innerHTML=str;
			
			$("#srch_pop_teacher").hide().prev("div.dim-warp").remove();
		}
	}
		
		
	function edu_save() {
		if(mainform.lecture_code.value == "" ) {
			alert("강의종류을 선택하여 주십시요.");
			// $("#lecture_code").focus();
			return;
		} else if(mainform.edu_inst_code.value == "") {
			alert("교육기관을 입력하여 주십시요.");
			//$("#edu_inst_code").focus();
			return;
		} else if(mainform.branch_code.value == "") {
			alert("지점을 선택하여 주십시요.");
			//$("#branch_code").focus();
			return;
		} else if(mainform.start_dt.value == "") {
			alert("시작일을 입력하여 주십시요.");
			//$("#start_dt").focus();
			return;
		} else if(mainform.end_dt.value == "") {
			alert("종료일을 입력하여 주십시요.");
			//$("#end_dt").focus();
			return;
		} else if(mainform.tuition.value == "") {
			alert("수강료를 입력하여 주십시요.");
			//$("#tuition").focus();
			return;
		} else if(mainform.exam_fee.value == "") {
			alert("검정료를 입력하여 주십시요.");
			//$("#exam_fee").focus();
			return;
		} /* else if(mainform.tot_edu_proc_time.value == "") {
			alert("총강의시간을 입력하여 주십시요.");
			//$("#tot_edu_proc_time").focus();
			return;
		} else if(mainform.tot_degr.value == "") {
			alert("총회차를 입력하여 주십시요.");
			//$("#tot_degr").focus();
			return;
		} else if(mainform.max_stdt_cnt.value == "") {
			alert("정원을 입력하여 주십시요.");
			//$("#max_stdt_cnt").focus();
			return;
		} else if(mainform.edu_place.value == "") {
			alert("교육장소를 입력하여 주십시요.");
			//$("#edu_place").focus();
			return;
		} else if(mainform.edu_book_fee.value == "") {
			alert("교재비를 입력하여 주십시요.");
			//$("#edu_book_fee").focus();
			return;
		} else if(mainform.mtrl_fee.value == "") {
			alert("재료비를 입력하여 주십시요.");
			//$("#mtrl_fee").focus();
			return;
		}  */
		
		if ( confirm("저장 하시겠습니까?") ) {
			document.mainform.target = "_self";
			document.mainform.action = "edu_save.do";
			document.mainform.submit();
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
	
	function none() {}
	
	function lecture_change() {
		
		var l_cd = mainform.lecture_code.value;
		
		if(l_cd == "TD") {
			document.getElementById("exam_fee_name").innerHTML="수납1급 ";
			$('#tr_exam_fee_td').show();
			$('#tr_exam_fee_te').css("display","none");
			$('#tr_exam_fee_tf').css("display","none");
			$('#tr_exam_fee_ti').css("display","none");
			$('#tr_tea').css("display","none");
			$('#tr_fst_grade').css("display","none");
		} else if(l_cd == "TE") {
			document.getElementById("exam_fee_name").innerHTML="수납1급 ";
			$('#tr_exam_fee_td').css("display","none");
			$('#tr_exam_fee_te').show();
			$('#tr_exam_fee_tf').css("display","none");
			$('#tr_exam_fee_ti').css("display","none");
			$('#tr_tea').css("display","none");
			$('#tr_fst_grade').css("display","none");
		} else if(l_cd == "TF") {
			document.getElementById("exam_fee_name").innerHTML="수납2급 ";
			$('#tr_exam_fee_td').css("display","none");
			$('#tr_exam_fee_te').css("display","none");
			$('#tr_exam_fee_tf').show();
			$('#tr_exam_fee_ti').css("display","none");
			$('#tr_tea').css("display","none");
			$('#tr_fst_grade').css("display","none");
		} else if(l_cd == "TI") {
			document.getElementById("exam_fee_name").innerHTML="수납1급 ";
			$('#tr_exam_fee_td').css("display","none");
			$('#tr_exam_fee_te').css("display","none");
			$('#tr_exam_fee_tf').css("display","none");
			$('#tr_exam_fee_ti').show();
			$('#tr_tea').css("display","none");
			$('#tr_fst_grade').css("display","none");
		} else if(l_cd == "TA") {
			document.getElementById("exam_fee_name").innerHTML="";
			$('#tr_exam_fee_td').css("display","none");
			$('#tr_exam_fee_te').css("display","none");
			$('#tr_exam_fee_tf').css("display","none");
			$('#tr_exam_fee_ti').css("display","none");
			$('#tr_tea').show();
			$('#tr_fst_grade').css("display","none");
		} else if(l_cd == "TB") {
			document.getElementById("exam_fee_name").innerHTML="";
			$('#tr_exam_fee_td').css("display","none");
			$('#tr_exam_fee_te').css("display","none");
			$('#tr_exam_fee_tf').css("display","none");
			$('#tr_exam_fee_ti').css("display","none");
			$('#tr_tea').css("display","none");
			$('#tr_fst_grade').show();
		} else {
			document.getElementById("exam_fee_name").innerHTML="";
			$('#tr_exam_fee_td').css("display","none");
			$('#tr_exam_fee_te').css("display","none");
			$('#tr_exam_fee_tf').css("display","none");
			$('#tr_exam_fee_ti').css("display","none");
			$('#tr_tea').css("display","none");
			$('#tr_fst_grade').css("display","none");
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
<input type="hidden" id="edu_inst_code" name="edu_inst_code" />
<input type="hidden" id="teacher_code" name="teacher_code" />

<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat}" />
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt}" />
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt}" />
<input type="hidden" id="srch_lecture" name="srch_lecture" value="${srch.srch_lecture}" />
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst}" />
<input type="hidden" id="srch_sido" name="srch_sido" value="${srch.srch_sido}" />
<input type="hidden" id="srch_gugun" name="srch_gugun" value="${srch.srch_gugun}" />
<input type="hidden" id="srch_teacher" name="srch_teacher" value="${srch.srch_teacher}" />
<input type="hidden" id="pageNum" name="pageNum" value="${srch.pageNum}" />
<input type="hidden" id="page" name="page" value="${srch.page}"/>

<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">교육계획 등록</h2><!-- 타이틀과 콘텐츠 하단 간격이 없을 때 class="mb0" 적용 -->
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
						<th>강의종류</th>
						<td colspan="3">
							<select class="formSelect" style="width:150px" title="" id="lecture_code" name="lecture_code" onchange="lecture_change()">
								<option value="">선택</option>
								<c:forEach items="${l_list}" var="l">
									<option value="${l.lecture_code}">${l.lecture_nm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>교육기관명</th>
						<td colspan="3">
							<input type="text" id="edu_inst_nm" name="edu_inst_nm" style="width:150px" readonly="readonly"/>
							<span class="btn-table"><a href="javascript:none()" id="btn-popup"><span>선택</span></a></span>
						</td>
					</tr>
					<tr>
						<th>지점명</th>
						<td colspan="3">
							<select class="formSelect" style="width:150px" title="" id="branch_code" name="branch_code">
								<c:forEach items="${b_list}" var="b">
									<option value="${b.branch_code}" >${b.branch_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>강사명</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${auth eq '001'}">
									<input type="text" id="teacher_nm" name="teacher_nm" style="width:150px" readonly="readonly"/>
									<span class="btn-table"><a href="javascript:none()" id="btn-popup2"><span>선택</span></a></span>
								</c:when>
								<c:otherwise>
									${info.teacher_nm}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>강의시작일</th>
						<td>
							<span class="set-date">
								<input type="text" id="start_dt" name="start_dt" value="" placeholder="시작일" style="width:65px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="시작일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th>강의종료일</th>
						<td>
							<span class="set-date">
								<input type="text" id="end_dt" name="end_dt" value="" placeholder="종료일" style="width:65px;" />
								<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="종료일 선택" /></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th>강의시작시간</th>
						<td>
							<select class="formSelect" style="width:45px;" id="start_time1" name="start_time1">
								<option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option>
								<option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option>
								<option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option>
								<option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>
								<option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option>
								<option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option>
							</select>
							<span class="txt-symbol">&nbsp;:&nbsp;</span>
							<select class="formSelect" style="width:45px;" id="start_time2" name="start_time2">
								<option value="00">00</option><option value="10">10</option><option value="20">20</option>
								<option value="30">30</option><option value="40">40</option><option value="50">50</option>
								<option value="-"></option>
							</select>
						</td>
						<th>강의종료시간</th>
						<td>
							<select class="formSelect" style="width:45px;" id="end_time1" name="end_time1">
								<option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option>
								<option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option>
								<option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option>
								<option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>
								<option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option>
								<option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option>
							</select>
							<span class="txt-symbol">&nbsp;:&nbsp;</span>
							<select class="formSelect" style="width:45px;" id="end_time2" name="end_time2">
								<option value="00">00</option><option value="10">10</option><option value="20">20</option>
								<option value="30">30</option><option value="40">40</option><option value="50">50</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>수강료</th>
						<td>
							<input type="text" id="tuition" name="tuition" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
						<th><div id="exam_fee_name" style="display:inline;"></div>검정료</th>
						<td>
							<input type="text" id="exam_fee" name="exam_fee" value="" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
					</tr>
					<tr id="tr_exam_fee_td" style="display:none;">
						<th>수납2급 검정료</th>
						<td colspan="3">
							<input type="text" id="exam_fee2_td" name="exam_fee2_td" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
					</tr>
					<tr id="tr_exam_fee_te" style="display:none;">
						<th>수납2급 검정료</th>
						<td>
							<input type="text" id="exam_fee2_te" name="exam_fee2_te" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
						<th>가정2급 검정료</th>
						<td>
							<input type="text" id="exam_fee3_te" name="exam_fee3_te" value="" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
					</tr>
					<tr id="tr_exam_fee_tf" style="display:none;">
						<th>가정2급 검정료</th>
						<td colspan="3">
							<input type="text" id="exam_fee2_tf" name="exam_fee2_tf" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
					</tr>
					<tr id="tr_exam_fee_ti" style="display:none;">
						<th>코칭2급 검정료</th>
						<td colspan="3">
							<input type="text" id="exam_fee2_ti" name="exam_fee2_ti" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
					</tr>
					<tr>
						<th>총 강의시간</th>
						<td>
							<input type="text" id="tot_edu_proc_time" name="tot_edu_proc_time" value="" placeholder="" style="width:80px" />
						</td>
						<th>총회차</th>
						<td>
							<input type="text" id="tot_degr" name="tot_degr" value="" placeholder="" style="width:80px" />
						</td>
					</tr>
					<tr>
						<th>정원(수강생)</th>
						<td>
							<input type="text" id="max_stdt_cnt" name="max_stdt_cnt" value="" placeholder="" style="width:80px" /> <span>명</span>
						</td>
						<th>교육장소</th>
						<td>
							<input type="text" id="edu_place" name="edu_place" value="" placeholder="" style="width:80px" />
						</td>
					</tr>
					<tr>
						<th>교재비</th>
						<td>
							<input type="text" id="edu_book_fee" name="edu_book_fee" value="" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
						<th>재료비</th>
						<td>
							<input type="text" id="mtrl_fee" name="mtrl_fee" value="" placeholder="" style="width:80px" onkeyup="javascript:cmaComma(this)"/> <span>원</span>
						</td>
					</tr>
					<tr id="tr_tea" style="display:none;">
						<th>기수</th>
						<td>
							<input type="text" id="class_level" name="class_level" style="width:80px" />
						</td>
						<th>1/2급 구분</th>
						<td>
							<select class="formSelect" style="width:150px" title="" id="teacher_prt" name="teacher_prt">
								<option value="2급" selected="selected">2급</option>
								<option value="1급">1급</option>
							</select>
						</td>
					</tr>
					<tr id="tr_fst_grade" style="display:none;">
						<th>기수</th>
						<td colspan="3">
							<input type="text" id="class_level" name="class_level" placeholder="" style="width:80px" />
						</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3" class="padding-cell">
							<textarea id="bigo" name="bigo" style="width:98%; height:80px" ></textarea>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:history.back()" class="btn-negative"><span>취소</span></a>
				<a href="javascript:edu_save()"><span>등록</span></a>
			</div><!--// contents -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>

</form>


<form id="sr_edu_inst" name="sr_edu_inst" action="" method="post">
<div id="srch_pop_edu_inst" class="layer-warp" style="width:730px">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>교육기관 검색</h2>
			<div class="btn-close"><a href="javascript:none()" id="edu_inst_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="layer-content">

			<div class="search-block" style="margin-left:10px;margin-right:10px">
				<div class="search-row">
					<span class="txt-label">지역</span>
					<select class="formSelect" id="srch_sido" name="srch_sido" style="width:100px;" title="" onchange="get_gugun()">
						<option value="" selected="selected">시도</option>
						<c:forEach items="${s_list}" var="s">
							<option value="${s.sido_code}">${s.sido_code_nm}</option>
						</c:forEach>
					</select>
					<span class="txt-symbol">,</span>
					<div id="srch_gugun_div"  style="display:inline;">
						<select class="formSelect" style="width:100px;" title="" id="srch_gugun" name="srch_gugun">
							<option value="" selected="selected">구군</option>
						</select>
					</div>
					<input type="text" id="srch_edu_inst" name="srch_edu_inst" placeholder="교육기관명" value="" style="width:80px" />
					<div id="div_hidden"  style="display:none;">
						<input type="text" id="srch_edu_inst2" name="srch_edu_inst2" placeholder="테스트" value="" style="width:1px" />
					</div>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:srch_inst()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->
			
			<div class="row"  id="div_edu_inst">
				<table class="table-popup full" style="width:650px;margin:0px 20px">
					<colgroup>
						<col style="width:30%" />
						<col style="width:40%" />
						<col style="width:30%" />
					</colgroup>
					<thead>
						<tr>
							<th>교육기관명</th>
							<th>주소</th>
							<th>연락처</th>
						</tr>
					</thead>
				</table>
			</div>

			<div class="btn-block">				
				<!-- <a href="#a"><span>저장</span></a> -->
				<a href="javascript:none()" class="btn-negative" id="edu_inst_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

<form id="sr_teacher" name="sr_teacher" action="" method="post">
<div id="srch_pop_teacher" class="layer-warp" style="width:730px">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>강사 검색</h2>
			<div class="btn-close"><a href="javascript:none()" id="teacher_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>
		<div class="layer-content">

			<div class="search-block" style="margin-left:10px;margin-right:10px">
				<div class="search-row">
					<span class="txt-label">지역</span>
					<select class="formSelect" id="srch_sido2" name="srch_sido2" style="width:100px;" title="" onchange="get_gugun2()">
						<option value="" selected="selected">시도</option>
						<c:forEach items="${s_list}" var="s">
							<option value="${s.sido_code}">${s.sido_code_nm}</option>
						</c:forEach>
					</select>
					<span class="txt-symbol">,</span>
					<div id="srch_gugun_div2"  style="display:inline;">
						<select class="formSelect" style="width:100px;" title="" id="srch_gugun2" name="srch_gugun2">
							<option value="" selected="selected">구군</option>
						</select>
					</div>
					<input type="text" id="srch_teacher" name="srch_teacher" placeholder="강사명" style="width:80px"/>
					<div id="div_hidden2"  style="display:none;">
						<input type="text" id="srch_teacher2" name="srch_teacher2" placeholder="테스트" value="" style="width:1px" />
					</div>
				</div><!-- // search-row -->
				<div class="btn-block">
					<a href="javascript:srch_teacher()"><span class="btn-search">조회하기</span></a>
				</div><!-- // btn-block -->
			</div><!-- // search-block -->
			
			<div id="div_teacher" class="row" >
				<table class="table-popup full" style="width:650px;margin:0px 20px">
					<colgroup>
						<col style="width:20%" />
						<col style="width:30%" />
						<col style="width:30%" />
						<col style="width:20%" />
					</colgroup>
					<thead>
						<tr>
							<th>강사명</th>
							<th>지역</th>
							<th>자격정보</th>
							<th>연락처</th>
						</tr>
					</thead>
				</table>
			</div>

			<div class="btn-block">				
				<!-- <a href="#a"><span>저장</span></a> -->
				<a href="javascript:none()" class="btn-negative" id="teacher_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>