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
<title>접수 l 정리수납상세 l 정리수납</title>
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

			$("div.btn-close > a", $dialog).one("click", function(event) {
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_cllt_close", $dialog).one("click", function(event) {
				$('#cllt_dt').val('');
				$('#cllt_amt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
				
				cllt_reload();
			});
			$("#btn_cllt_xclose", $dialog).one("click", function(event) {
				$('#cllt_dt').val('');
				$('#cllt_amt').val('');
				$dialog.hide()
					.prev("div.dim-warp").remove();
				
				cllt_reload();
			});
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}

		$("#btn-popup").click(function(event) {
			showModalDialog($("#regSchedule"));
		});

		$("#btn-add").click(function(event) {
			$("#input-block").show();
		});
		$("#btn-cancle").click(function(event) {
			$("#input-block").hide();
		});
	});
	
	$(document).ready(function() {
		
		var saveYn = "<c:out value="${save_yn}"/>";
		
		if(saveYn == "y") {
			alert("저장되었습니다.");
		}
		
		/* var br = "<c:out value="${info.branch_code}"/>";
		if(br != null && br != '' && info) {
			$("#estm_branch_code").val(br).change(); 
		}
	 */
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
	      
		$( '#estm_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#cllt_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
	});
	
	function get_gugun() {
		
		var e = document.getElementById("srvc_sido_code");
		var s_sido = e.options[e.selectedIndex].value;
				
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"srvc_gugun_code\" name=\"srvc_gugun_code\" style=\"width:100px;\" title=\"\">";
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
	
	function arrg_save() {
		
		if(document.getElementById('cstt_no')) {
			if(mainform.cstt_no.value != null && mainform.cstt_no.value != "") {
				var cstt = mainform.cstt_no.value;
				mainform.estm_cstt_no.value= cstt;
			}
		}
		
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_update2.do";
		document.mainform.submit();
	}
	
	function arrg_next() {
		
		if(document.getElementById('cstt_no')) {
			if(mainform.cstt_no.value != null && mainform.cstt_no.value != "") {
				var cstt = mainform.cstt_no.value;
				mainform.estm_cstt_no.value= cstt;
			}
		}
		
		mainform.arrg_step.value="3";
		mainform.next_step_yn.value="Y";
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_update2.do";
		document.mainform.submit();
	}
	
	function srch_cstt(){
		var csttSrch = $('#cstt_srch').val();
		
		$.ajax({ 
		   url: "srch_cstt.do", 
		   type: "POST", 
		   data: {"srch_cstt" : csttSrch, "srch_role" : '01'},
		   dataType:"text",
		   cache: false,
		   success: function(msg){
			  
			     var tmp = msg.split('|');
			     var str = "<select class=\"formSelect\" id=\"cstt_no\" name=\"cstt_no\" style=\"width:200px;\">";
			     if( tmp == null || tmp == "" ) {
					   str = str+"<option value=\"\">검색 결과가 없습니다</option>";
				   }
				   else {
				     str = str + "<option value=\"\">선택</option>";
				     for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split("`");
	         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
						   }
				   }	   
				   str = str+"</select>";
				   document.getElementById("div_tch").innerHTML=str;
				   $('.formSelect').sSelect();
		   }
		   , error: function (xhr, ajaxOptions, thrownError) {
		      }
		}); 
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
	    
	    var estm = mainform.estm_amt.value;
	    var op = mainform.option_amt.value;
	    
	    if(estm != null ) estm = estm.replace(/[^\d]+/g, '');
		if(op != null ) op = op.replace(/[^\d]+/g, '');
		if(estm == "") estm = "0";
		if(op == "") op = "0";
		var a = parseInt(estm) + parseInt(op);
		
		while(regx.test(a)){  
	        a = a.toString().replace(regx,"$1,$2");  
	    } 
	    $('#tot_work_amt').val(a);
	    
	}
	
	function go_arrg(seq) {
		mainform.step_move.value=seq;
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_info.do";
		document.mainform.submit();
	}
	
	function arrg_list() {
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_list.do";
		document.mainform.submit();
	}
	
	function cllt_save() {
		
		var dt = frm_cllt.cllt_dt.value;
		var amt = frm_cllt.cllt_amt.value;
		var arrg_no = mainform.arrg_no.value;
		amt = amt.replace(/,/gi,'');
		
		if(dt == "" || amt == "") {
			alert("일자 / 금액을 모두 입력하셔야 합니다.");
			return;
		}
		else {
			$.ajax({ 
				   url: "cllt_save.do", 
				   type: "POST",
				   data: {"cllt_dt" : dt, "cllt_amt" : amt, "arrg_no" : arrg_no},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "";
					   str = str+ "<table class=\"talbe-inner\"><colgroup><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /></colgroup><tbody>";
						
					   if( tmp == null || tmp == "" ) {
						   str = str+"<tr><td colspan=\"5\">입금결과가 없습니다</td></tr>";
					   }
					   else {
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split("`");
		        				str = str+"<tr><th>일자</th><td>"+tmp_sub[3]+"</td><th>금액</th><td>"+tmp_sub[2]+"원</td>";
		        				if(tmp_sub[1] == "0") {
		        					str = str+"<td><span style=\"font-weight:bold;color:#00bcae\">선급금</span></td><tr>";
		        				}
		        				else {
		        					str = str+"<td><span class=\"btn-table red\"><a href=\"javascript:cllt_del('"+tmp_sub[1]+"')\"><span>삭제</span></a></span></td></tr>";
		        				}
						   }
					   }
					   str = str+"</tbody></table>";		
					   document.getElementById("scroll-block").innerHTML=str;
					   $('#cllt_amt').val('');
						$('#cllt_dt').val('');
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
		}
	}
	
	function cllt_del(seq) {
		
		var arrg_no = mainform.arrg_no.value;
		
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({ 
				   url: "cllt_del.do", 
				   type: "POST",
				   data: {"arrg_no" : arrg_no, "cllt_seq" : seq},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "";
					   str = str+ "<table class=\"talbe-inner\"><colgroup><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /></colgroup><tbody>";
						
					   if( tmp == null || tmp == "" ) {
						   str = str+"<tr><td colspan=\"5\">입금결과가 없습니다</td></tr>";
					   }
					   else {
						   for(var i = 0; i < tmp.length ; i++) {
							   var tmp_sub = tmp[i].split("`");
							   
		        				str = str+"<tr><th>일자</th><td>"+tmp_sub[3]+"</td><th>금액</th><td>"+tmp_sub[2]+" \\</td>";
		        				if(tmp_sub[1] == "0") {
		        					str = str+"<td><span style=\"font-weight:bold;color:#00bcae\">선급금</span></td><tr>";
		        				}
		        				else {
		        					str = str+"<td><span class=\"btn-table red\"><a href=\"javascript:cllt_del('"+tmp_sub[1]+"')\"><span>삭제</span></a></span></td></tr>";
		        				}
						   }
					   }
					   str = str+"</tbody></table>";		
					   document.getElementById("scroll-block").innerHTML=str;
						
					   $('#cllt_amt').val('');
						$('#cllt_dt').val('');
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
		}
	}
	
	function cllt_reload() {
		
		var arrg_no = mainform.arrg_no.value;
		
		$.ajax({ 
			   url: "cllt_reload.do", 
			   type: "POST",
			   data: {"arrg_no" : arrg_no},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var str = "";
				   str  = str + "<span class=\"point-color-r\">"+msg+"원</span>";
				   document.getElementById("div_camt").innerHTML=str;
				   
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
				   alert("status : " + xhr.status);
			       alert("err: " +thrownError);
			   }
		});
	}
	
	function none() {
		
	}
	
	/* function option_input() {
		
		showModalDialog($("#div_option"));
		
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

			$("#btn_option_close", $dialog).one("click", function(event) {
				var regx = new RegExp(/(-?\d+)(\d{3})/); 
				var cnt = $('#option_list_cnt').val();
				var amt = "0";
				var op = "";
				
				for (var i=0; i < cnt; i++) {
					op = $("#option_"+i+"").val().replace(/,/gi,'');
					amt = parseInt(amt) + parseInt(op);
				}
				while(regx.test(amt)){  
					amt = amt.toString().replace(regx,"$1,$2");  
			    } 
			    $('#option_amt').val(amt);
			    
			    var estm = mainform.estm_amt.value;
			    var op = mainform.option_amt.value;
			    
			    if(estm != null ) estm = estm.replace(/[^\d]+/g, '');
				if(op != null ) op = op.replace(/[^\d]+/g, '');
				if(estm == "") estm = "0";
				if(op == "") op = "0";
				var a = parseInt(estm) + parseInt(op);
				
				while(regx.test(a)){  
			        a = a.toString().replace(regx,"$1,$2");  
			    } 
			    $('#tot_work_amt').val(a);
				
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_option_xclose", $dialog).one("click", function(event) {
				var regx = new RegExp(/(-?\d+)(\d{3})/); 
				var cnt = $('#option_list_cnt').val();
				var amt = "0";
				var op = "";
				
				for (var i=0; i < cnt; i++) {
					op = $("#option_"+i+"").val().replace(/,/gi,'');
					amt = parseInt(amt) + parseInt(op);
				}
				while(regx.test(amt)){  
					amt = amt.toString().replace(regx,"$1,$2");  
			    } 
			    $('#option_amt').val(amt);
			    
			    var estm = mainform.estm_amt.value;
			    var op = mainform.option_amt.value;
			    
			    if(estm != null ) estm = estm.replace(/[^\d]+/g, '');
				if(op != null ) op = op.replace(/[^\d]+/g, '');
				if(estm == "") estm = "0";
				if(op == "") op = "0";
				var a = parseInt(estm) + parseInt(op);
				
				while(regx.test(a)){  
			        a = a.toString().replace(regx,"$1,$2");  
			    } 
			    $('#tot_work_amt').val(a);
				
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}
		
	}
	 */
	function toss_cancel(no, seq) {
		
		if(confirm("취소하시겠습니까?")) {
			$.ajax({ 
				   url: "toss_cancel.do", 
				   type: "POST",
				   data: {"arrg_no" : no, "toss_seq" : seq},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   var tmp = msg.split('|');
					   
					   var str = "";
					   str = str+ "<select class=\"formSelect\" style=\"width:120px\" id=\"toss_branch_code\" name=\"toss_branch_code\" >";
						
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split("`");
						   
	        				str = str+"<option value="+tmp_sub[0]+">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select> ";		
					   document.getElementById("toss_div").innerHTML=str;
					   
					   $('.formSelect').sSelect();
						
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
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
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"  value="" />
<input type="hidden" id="arrg_no" name="arrg_no" value="${info.arrg_strg_no }"/>
<input type="hidden" id="c_no" name="c_no" value="${info.cust_no }"/>
<input type="hidden" id="srvc_phone" name="srvc_phone"/>
<input type="hidden" id="arrg_step" name="arrg_step" value="2"/>
<input type="hidden" id="next_step_yn" name="next_step_yn" value="N"/>
<input type="hidden" id="arrg_strg_st_cd" name="arrg_strg_st_cd" value="${info.arrg_strg_st_cd }"/>
<%-- <input type="hidden" id="estm_branch_code" name="estm_branch_code" value="${info.estm_branch_code }"/> --%>
<input type="hidden" id="step_move" name="step_move"/>
<input type="hidden" id="option_list_cnt" name="option_list_cnt" value="${fn:length(o_list) }"/>

<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>정리수납상세</h2>
			</div>

			<div class="top-info">
				<div class="process">
					<ul>
						<li><span onclick="javascript:go_arrg('1')"><span>접수</span></span></li><!-- 해당 단계에 클래스 on 추가 -->
						<li class="text-center"><span class="on" onclick="javascript:go_arrg('2')"><span>견적</span></span></li>
						<li class="text-center"><span onclick="javascript:go_arrg('3')"><span>계약</span></span></li>
						<li class="text-right"><span onclick="javascript:go_arrg('4')"><span>작업</span></span></li>
					</ul>
				</div>
				<div class="breif-info">
					<p><a href="javascript:none()" id="btn-popup"><span>입금관리</span></a></p>
					<dl class="clearfix">
						<dt>계약금</dt>
						<dd><span><fmt:formatNumber value="${info.tot_work_amt}" />원</span></dd>
					</dl>
					<dl class="clearfix">
						<dt>입금액</dt>
						<dd><div id="div_camt"><span class="point-color-r"><fmt:formatNumber value="${info.cllt_amt }"/>원</span></div></dd>
					</dl>
				</div>
			</div>

			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>서비스고객명</th>
						<td>${info.srvc_cust_nm }</td>
						<th>연락처</th>
						<td>${info.srvc_phone}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${info.srvc_sido_code_nm} ${info.srvc_gugun_code_nm } ${info.srvc_address}</td>
					</tr>
					<tr>
						<th>서비스명</th>
						<td>${info.srvc_prt_code_nm } </td>
						<th>접수일</th>
						<td> ${info.cnsl_dt}</td>
					</tr>
					<tr>
						<th class="bg-customer">
							<c:choose >
								<c:when test="${info.estm_branch_code eq null or info.estm_branch_code eq ''}">견적토스</c:when>
								<c:otherwise>견적지점</c:otherwise>
							</c:choose>
						</th>
						<td>
							<div id="toss_div">
							<c:choose>
								<c:when test="${e_toss.arrg_strg_no ne null and (e_toss.appr_yn eq null or e_toss.appr_yn eq 'N') }">
									${e_toss.accp_branch_name}  <span class="btn-table"><a href="javascript:toss_cancel('${e_toss.arrg_strg_no}','${e_toss.toss_seq }')" id=""><span>취소</span></a></span>
								</c:when>
								<c:when test="${info.estm_branch_code eq null or info.estm_branch_code eq ''}">
									<select class="formSelect" style="width:180px" title="" id="toss_branch_code" name="toss_branch_code" >
										<c:set var="br" value="${info.cnsl_branch_code}" />
										<c:forEach items="${b_list}" var="b">
											<option value="${b.branch_code}" <c:if test="${br eq b.branch_code}">selected="selected"</c:if> >${b.branch_name}</option>
										</c:forEach>
									</select> 
								</c:when>
								<c:otherwise>
									${info.estm_branch_name}
									<input type="hidden" id="estm_branch_code" name="estm_branch_code" value="${info.estm_branch_code}" />
								</c:otherwise>
							</c:choose>
							</div>
						</td>
						<th class="bg-customer">견적자</th>
						<td>
							<span style="font-weight:bold">${info.estm_cstt_name }</span><br/>
							<input type="hidden" id="estm_cstt_no" name="estm_cstt_no" value="${info.estm_cstt_no }" />
							<input type="text" id="cstt_srch" name="cstt_srch" onkeyup="javascript:srch_cstt()" placeholder="이름검색" style="min-width:40px;width:50px"/>
							<div id="div_tch" style="display:inline;">
							</div>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">견적일</th>
						<td>
							<span class="set-date">
								<input type="text" id="estm_dt" name="estm_dt" value="${info.estm_dt }" placeholder="" style="width:80px;" />
								<span class="btn-calendar"><a href="#a"><img src="image/btn_calendar_input.gif" alt="견적일 선택" /></a></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th class="bg-customer">견적수수료</th>
						<td>
							<c:set var="estmFee"><fmt:formatNumber pattern="#,###" value="${info.estm_fee}" /> </c:set>
							<input type="text" id="estm_fee" name="estm_fee" value="${estmFee}" style="width:60px" onkeyup="cmaComma(this);"/> 원
						</td>
					</tr>
					</tbody>
				</table>
				<table class="talbe-view top-line">
				<colgroup>
					<col style="width:10%" />
					<col style="width:25%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:10%" />
					<col style="width:25%" />
				</colgroup>
				<tbody>
					<tr>
						<th rowspan="3" class="bg-customer">견적금액</th>
						<td rowspan="3" >
							<c:set var="estmAmt"><fmt:formatNumber pattern="#,###" value="${info.estm_amt}" /> </c:set>
							<input type="text" id="estm_amt" name="estm_amt" value="${estmAmt}" style="width:80px" onkeyup="cmaComma(this);"/> 원
						</td>
						<th class="bg-customer">견적CBM</th>
						<td>
							<input type="text" id="cbm" name="cbm" value="${info.cbm}" style="width:60px" />
						</td>
						<th rowspan="3" class="bg-customer">견적 내역</th>
						<td rowspan="3" class="padding-cell">
							<textarea id="estm_cntn" name="estm_cntn" style="width:95%;height:90px">${info.estm_cntn }</textarea>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">작업예상시간</th>
						<td>
							<input type="text" id="work_expc_time" name="work_expc_time" value="${info.work_expc_time}" style="width:60px" /> 시간
						</td>
					</tr>
					<tr>
						<th class="bg-customer">작업인원</th>
						<td>
							<input type="text" id="worker_cnt" name="worker_cnt" value="${info.worker_cnt}" style="width:60px" /> 명
						</td>
					</tr>
				</tbody>
			</table>
			<table class="talbe-view top-line">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bg-customer">옵션금액</th>
						<td>
							<c:set var="optionAmt"><fmt:formatNumber pattern="#,###" value="${info.option_amt}" /> </c:set>
							<input type="text" id="option_amt" name="option_amt" value="${optionAmt}" style="width:80px" onkeyup="cmaComma(this);"/> 원
						</td>
						<th class="bg-customer">옵션내역</th>
						<td class="padding-cell">
							<textarea id="option_cntn" name="option_cntn" style="width:95%">${info.option_cntn }</textarea>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">견적총금액</th>
						<td colspan="3">
							<c:set var="totAmt"><fmt:formatNumber pattern="#,###" value="${info.tot_work_amt}" /> </c:set>
							<input type="text" id="tot_work_amt" name="tot_work_amt" value="${totAmt}" style="width:80px" readonly="readonly"/> 원
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block">
				<a href="javascript:arrg_list()" class="btn-negative abl"><span>취소</span></a>
				<a href="javascript:arrg_save()"><span>저장</span></a>
				<a href="javascript:arrg_next()" class="abr"><span>다음</span></a>
			</div><!--// btn-block -->		
			

		</div><!--// contents -->
		
		<div id="div_option" class="layer-warp">
			<div class="layer-inner">
				<div class="top-bar">
					<h2>옵션금액관리</h2>
					<div class="btn-close"><a href="javascript:none()" id="btn_option_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
				</div>
		
				<div class="layer-content">
		
					<div id="scroll-block2">	
						<table class="talbe-inner">
							<colgroup>
								<col style="width:50%" />
								<col style="width:50%" />
							</colgroup>
							<tbody>
								<c:forEach items="${o_list}" var="o" varStatus="status">
									<tr>
										<th>${o.option_prt_code_nm }</th>
										<td>
											<c:set var="optionAmt"><fmt:formatNumber pattern="#,###" value="${o.option_amt}" /> </c:set>
											<input type="text" id="option_${status.index }" name="option_${status.index }" value="${optionAmt }" style="width:80px;text-align:right" onkeyup="cmaComma(this);"/> 원
										</td>
									</tr>
								</c:forEach>
							</tbody>					
						</table>
					</div>
		
					<div class="btn-block">
						<a href="javascript:none()" class="btn-negative" id="btn_option_close"><span>닫기</span></a>
					</div><!--// btn-block -->
		
				</div><!--// layer-content -->
			</div><!--// layer-inner -->
		
		</div><!--// layer-pop -->
		
		
		
		
		
		</form>
		
	</div><!--// container -->
</div>

<form id="frm_cllt" name="frm_cllt" action="" method="post">
<div id="regSchedule" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>입금관리</h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_cllt_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="layer-content">

			<div class="btn-block">				
				<a id="btn-add"><span>+ 추가하기</span></a>
			</div><!--// btn-block -->

			<div id="input-block">
				<table>
					<colgroup>
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<tbody>
						<tr>
							<th>입금일자</th>
							<td>
								<span class="set-date">
									<input type="text" id="cllt_dt" name="cllt_dt" style="width:65px;" />
									<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="견적일 선택" /></span><!-- 달력 선택 버튼 -->
								</span>
							</td>
							<th>금액</th>
							<td><input type="text" id="cllt_amt" name="cllt_amt" style="width:80px;text-align:right" onkeyup="cmaComma(this);"/> 원</td>
							<td>
								<span class="btn-table green"><a href="javascript:cllt_save()"><span>저장</span></a></span>
								<span class="btn-table"><a href="#a" id="btn-cancle"><span>취소</span></a></span>
							</td>
						</tr>
					</tbody>					
				</table>
			</div>

			<div id="scroll-block">	
				<table class="talbe-inner">
					<colgroup>
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<tbody>
						<c:forEach items="${c_list}" var="c">
							<tr>
								<th>일자</th>
								<td>${c.cllt_dt}</td>
								<th>금액</th>
								<td>
									<fmt:formatNumber value="${c.cllt_amt}" /> 원
								</td>
								<td>
									<c:choose>
										<c:when test="${c.cllt_seq eq 0 }">
											<span style="font-weight:bold;color:#00bcae">선급금</span>
										</c:when>
										<c:otherwise>
											<span class="btn-table red"><a href="javascript:cllt_del('${c.cllt_seq }')"><span>삭제</span></a></span>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>					
				</table>
			</div>

			<div class="btn-block">
				<a href="javascript:none()" class="btn-negative" id="btn_cllt_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->
	</div><!--// layer-inner -->

</div><!--// layer-pop -->
</form>

</body>
</html>