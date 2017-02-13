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
		
		/* $("#estm_dt").datepicker({
	    });
	    $("#cnsl_dt").datepicker({
	    });
	    $("#cllt_dt").datepicker({
	    }); */

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
		
		var d = new Date(); 
		 var toDay = set_standard(d.getFullYear(), 4)+'-'+
			set_standard(d.getMonth() + 1, 2)+'-'+
			set_standard(d.getDate(), 2);
		 
		 var myDate = new Date(toDay)
		 myDate.setMonth(myDate.getDate() + 1);
		  
		 var cDt = "<c:out value="${info.cnsl_dt}"/>";
		 var eDt = "<c:out value="${info.estm_dt}"/>";
		 
		 if(cDt == "")  $('#cnsl_dt').val(toDay);
		 if(eDt == "")  $('#estm_dt').val(myDate);
		
		var saveYn = "<c:out value="${save_yn}"/>";
		if(saveYn == "y") {
			alert("저장되었습니다.");
		}
		
		var ph1 = "<c:out value="${info.ph1}"/>";
		if(ph1 != null && ph1 != '') {
			$("#ph1").val(ph1).change(); 
		}
		
		var br = "<c:out value="${info.branch_code}"/>";
		if(br != null && br != '' && info) {
			$("#estm_branch_code").val(br).change(); 
		}
		
		var sido = "<c:out value="${info.srvc_sido_code}"/>";
		var gugun = "<c:out value="${info.srvc_gugun_code}"/>";
		
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
					   
					   var str = "<select class=\"formSelect\" id=\"srvc_gugun_code\" name=\"srvc_gugun_code\" style=\"width:120px;\" title=\"\">";
					   str=str+"<option value=\"\">선택</option>";
					   for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	     				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   str = str+"</select>";
					   document.getElementById("gugun_div").innerHTML=str;
					   
					   if(gugun != null && gugun != '') {
						   $("#srvc_gugun_code").val(gugun).change(); 
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
	      
		$( '#estm_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		$( '#cnsl_dt' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
		
	});
	
	function set_standard(time, digits) {
		  var zero = '';
		  time = time.toString();

		  if (time.length < digits) {
			for (i = 0; i < digits - time.length; i++)
			  zero += '0';
		  }
		  return zero + time;
		}
	
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
				   
				   var str = "<select class=\"formSelect\" id=\"srvc_gugun_code\" name=\"srvc_gugun_code\" style=\"width:120px;\" title=\"\">";
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
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.srvc_phone.value=p1+"-"+p2+"-"+p3;
		}
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_update1.do";
		document.mainform.submit();
	}
	
	function arrg_next() {
		
		var p1 = $("#ph1").val();
		var p2 = $("#ph2").val();
		var p3 = $("#ph3").val();
		
		if(p1 != '' && p2 != '' && p3 != '') {
			mainform.srvc_phone.value=p1+"-"+p2+"-"+p3;
		}
		
		mainform.arrg_step.value="2";
		mainform.next_step_yn.value="Y";
		document.mainform.target = "_self";
		document.mainform.action = "arrg_strg_update1.do";
		document.mainform.submit();
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
<input type="hidden" id="arrg_step" name="arrg_step" value="1"/>
<input type="hidden" id="next_step_yn" name="next_step_yn" value="N"/>
<input type="hidden" id="step_move" name="step_move"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>정리수납상세</h2>
			</div>

			<div class="top-info">
				<div class="process">
					<ul>
						<li><span class="on" onclick="javascript:go_arrg('1')"><span>접수</span></span></li><!-- 해당 단계에 클래스 on 추가 -->
						<li class="text-center"><span onclick="javascript:go_arrg('2')"><span>견적</span></span></li>
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
						<dd><div id="div_camt"><span class="point-color-r"><fmt:formatNumber value="${info.cllt_amt }" />원</span></div>
						</dd>
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
						<th>고객명</th>
						<td>${cust.cust_nm }</td>
						<th>최초등록일</th>
						<td>${cust.resist_dt }</td>
					</tr>
					<tr>
						<th>지역</th>
						<td>${cust.sido_code_nm} ${cust.gugun_code_nm } </td>
						<th>연락처</th>
						<td>${cust.phone }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">${cust.sido_code_nm} ${cust.gugun_code_nm } ${cust.address}</td>
					</tr>
					<tr>
						<th>가족수</th>
						<td>${cust.fmly_cnt } 명 </td>
						<th>면적 / 거주형태</th>
						<td> ${cust.house_space } / ${cust.live_prt } </td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3" class="padding-cell">${cust.bigo}</td>
					</tr>
					<tr>
						<th class="bg-customer">서비스 고객명</th>
						<td colspan="3">
							<input type="text" id="srvc_cust_nm" name="srvc_cust_nm" value="${info.srvc_cust_nm }" style="width:100px" />
						</td>
					</tr>
					<tr>
						<th class="bg-customer">서비스 지역</th>
						<td>
							<select class="formSelect" id="srvc_sido_code" name="srvc_sido_code" style="width:120px;" onchange="get_gugun()">
								<option value="">시도</option>
								<c:set var="si" value="${info.srvc_sido_code}" />
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}" <c:if test="${si eq s.sido_code}">selected="selected"</c:if> >${s.sido_code_nm}</option>
								</c:forEach>
							</select> 
							<div id="gugun_div"  style="display:inline;">
								<select class="formSelect" style="width:120px;" id="srvc_gugun_code" name="srvc_gugun_code">
									<option value="">구군</option>
								</select>
							</div>
						</td>
						<th class="bg-customer">연락처</th>
						<td>
							<select class="formSelect" style="width:60px" id="ph1" name="ph1">
								<option value="010" <c:if test="${info.ph1 eq '010'}">selected="selected"</c:if>>010</option>
								<option value="011" <c:if test="${info.ph1 eq '011'}">selected="selected"</c:if>>011</option>
								<option value="016" <c:if test="${info.ph1 eq '016'}">selected="selected"</c:if>>016</option>
								<option value="017" <c:if test="${info.ph1 eq '017'}">selected="selected"</c:if>>017</option>
								<option value="018" <c:if test="${info.ph1 eq '018'}">selected="selected"</c:if>>018</option>
								<option value="019" <c:if test="${info.ph1 eq '019'}">selected="selected"</c:if>>019</option>
							</select>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph2" name="ph2" value="${info.ph2 }" style="width:40px;min-width:40px" maxlength="4"/>
							<span class="txt-symbol">-</span>
							<input type="text" id="ph3" name="ph3" value="${info.ph3 }" style="width:40px;min-width:40px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th class="bg-customer">서비스 주소 (나머지)</th>
						<td colspan="3">
							<input type="text" id="srvc_address" name="srvc_address" value="${info.srvc_address }" placeholder="" style="width:94%" />
						</td>
					</tr>
					<tr>
						<th class="bg-branch">접수지점</th>
						<td>
							${info.cnsl_branch_name }
							<%-- <select class="formSelect" style="width:120px" title="" id="cnsl_branch_code" name="cnsl_branch_code" >
								<c:set var="br" value="${info.cnsl_branch_code}" />
								<c:forEach items="${b_list}" var="b">
									<option value="${b.branch_code}" <c:if test="${br eq b.branch_code}">selected="selected"</c:if> >${b.branch_name}</option>
								</c:forEach>
							</select> --%>
						</td>
						<th class="bg-branch">견적희망일</th>
						<td>
							<span class="set-date">
								<input type="text" id="estm_dt" name="estm_dt" value="${info.estm_dt }" placeholder="" style="width:100px;" />
								<span class="btn-calendar"><a href="#a"><img src="image/btn_calendar_input.gif" alt="견적일 선택" /></a></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
					</tr>
					<tr>
						<th class="bg-branch">서비스명</th>
						<td>
							<select class="formSelect" style="width:120px" title="" id="srvc_prt_code" name="srvc_prt_code">
								<option value="B100" <c:if test="${info.srvc_prt_code eq 'B100'}">selected="selected"</c:if>>전체</option>
								<option value="B200" <c:if test="${info.srvc_prt_code eq 'B200'}">selected="selected"</c:if>>옷장</option>
								<option value="B300" <c:if test="${info.srvc_prt_code eq 'B300'}">selected="selected"</c:if>>주방</option>
								<option value="B400" <c:if test="${info.srvc_prt_code eq 'B400'}">selected="selected"</c:if>>냉장고</option>
								<option value="B500" <c:if test="${info.srvc_prt_code eq 'B500'}">selected="selected"</c:if>>컨설팅코칭</option>
								<option value="B600" <c:if test="${info.srvc_prt_code eq 'B600'}">selected="selected"</c:if>>자녀방</option>
							</select>
						</td>
						<th class="bg-branch">제휴업체</th>
						<td>
							<select class="formSelect" style="width:120px" title="">
								<c:set var="ac" value="${info.allc_comp}" />
								<c:forEach items="${a_list}" var="a">
									<option value="${a.allc_comp_no}" <c:if test="${a.allc_comp_no eq ac}">selected="selected"</c:if>>${a.allc_comp_name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th class="bg-branch">상담일</th>
						<td>
							<span class="set-date">
								<input type="text" id="cnsl_dt" name="cnsl_dt" value="${info.cnsl_dt }" placeholder="상담일" style="width:100px;" />
								<span class="btn-calendar"><a href="#a"><img src="image/btn_calendar_input.gif" alt="상담일 선택" /></a></span><!-- 달력 선택 버튼 -->
							</span>
						</td>
						<th class="bg-branch">접수유형</th>
						<td>
							<select class="formSelect" style="width:100px" title="" id="rcv_type" name="rcv_type">
								<option value="">선택</option>
								<option value="인터넷" <c:if test="${info.rcv_type eq '인터넷'}">selected="selected"</c:if>>인터넷</option>
								<option value="전화" <c:if test="${info.rcv_type eq '전화'}">selected="selected"</c:if>>전화</option>
								<option value="소개" <c:if test="${info.rcv_type eq '소개'}">selected="selected"</c:if>>소개</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="bg-branch">상담내용</th>
						<td colspan="3" class="padding-cell">
							<textarea id="estm_bigo" name="estm_bigo" style="width:95%">${info.estm_bigo }</textarea>
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
							<td><input type="text" id="cllt_amt" name="cllt_amt" style="width:80px;text-align:right" onkeyup="cmaComma(this);"/> \</td>
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