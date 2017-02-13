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
<title>교육계획 스케줄등록 l 교육통합관리</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script type="text/javascript">

	$(document).ready(function() {
		
		
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
		
		$( '#edu_date' ).datepicker({
			changeYear:true, //년 셀렉트 박스 유무
			changeMonth:true,//달력 셀ㄹ렉트 박스 유무
			showButtonPanel:true,//달력 아래 받기 버튼 오늘 가기 버튼 출력
			dateFormat:"yy-mm-dd"
		});
		
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
			
			if (winHeight < docHeight){
				$(".dim-warp").css ("height", docHeight);
			} else {
				$(".dim-warp").css ("height", winHeight);
			}
			
			/* $("div.btn-close > a", $dialog).one("click", function(event) {
				$dialog.hide()
					.prev("div.dim-warp").remove();
			}); */
			
			$("#btn_schd_close", $dialog).one("click", function(event) {
				$('#edu_date').val('');
				$('#degr').val('');
				$('#start_time1').val('09').change();
				$('#start_time2').val('00').change();
				$('#end_time1').val('09').change();
				$('#end_time2').val('00').change();
				$('#subject').val('');
				$('#sub_cntn').val('');
				$('#t_cnt').val('0');
				document.getElementById("div_t_list").innerHTML="";
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_schd_xclose", $dialog).one("click", function(event) {
				$('#edu_date').val('');
				$('#degr').val('');
				$('#start_time1').val('09').change();
				$('#start_time2').val('00').change();
				$('#end_time1').val('09').change();
				$('#end_time2').val('00').change();
				$('#subject').val('');
				$('#sub_cntn').val('');
				$('#t_cnt').val('0');
				document.getElementById("div_t_list").innerHTML="";
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
			showModalDialog($("#regSchedule"));
			frm_schd.s_seq.value = "";
			$("#btn_del").hide();
		});
	});
	
	
	function schd_info(seq) {
		
		frm_schd.s_seq.value = seq;

		var winHeight2 = $(window).height();
		var docHeight2 = $(document).height();
		
		showModalDialog22($("#regSchedule"));
		$("#btn_del").show();
		
		$.ajax({ 
			   url: "edu_schd_popup.do", 
			   type: "POST", 
			   data: {"s_seq" : seq, "e_seq" : mainform.e_seq.value},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				  
				     var tmp = msg.split('`');
				     var dt = tmp[0];
				     if(dt == 'null') dt = "";
				     $('#edu_date').val(dt);
				     
				     var de = tmp[1];
				     if(de == 'null') de = "";
				     $('#degr').val(de);

					 var s_tm = tmp[2];
				     if(s_tm == 'null') s_tm = "";
					 if(s_tm != "") {
				    	 var stm1 = s_tm.substring(0,2);
				    	 $("#start_time1").val(stm1).change(); 
				    	 var stm2 = s_tm.substring(3,5);
				    	 $("#start_time2").val(stm2).change(); 
				     }
					 
					 var e_tm = tmp[3];
					 if(e_tm == 'null') e_tm = "";
				     if(e_tm != "") {
				    	 var etm1 = e_tm.substring(0,2);
				    	 $("#end_time1").val(etm1).change(); 
				    	 var etm2 = e_tm.substring(3,5);
				    	 $("#end_time2").val(etm2).change();
				     }
				     
				     $('#subject').val(tmp[4]);
				     $('#sub_cntn').val(tmp[5]);
				     
				     var str = "";
				     var s_tmp = tmp[6].split('|');
				     str = str + "<ul id=\"t_list\">";
				     if(s_tmp == "") {
				    	 str = str + "<li></li>";
				    	 frm_schd.t_cnt.value = "0";
				     } else {
				    	 $('#t_cnt').val(s_tmp.length);
				    	 for(var i = 0; i < s_tmp.length ; i++) {
							   var tmp_sub = s_tmp[i].split(",");
		         				str = str+"<li id=\"t_li"+(i+1)+"\"><span>주강사 :"+tmp_sub[2]+"</span><span>보조강사 :"+tmp_sub[4]+"</span><a href=\"javascript:teacher_del('"+(i+1)+"')\" ><span class=\"btn-del\" title=\"삭제\"></span></a>";
		         				str = str+"<input type=\"hidden\" id=\"tch_cd"+(i+1)+"\" name=\"tch_cd"+(i+1)+"\"  value=\""+tmp_sub[1]+"\" /><input type=\"hidden\" id=\"tch2_cd"+(i+1)+"\" name=\"tch2_cd"+(i+1)+"\"  value=\""+tmp_sub[3]+"\" /></li>";
							   }	 
				     }	   
					 str = str+"</ul>";
					   
					 document.getElementById("div_t_list").innerHTML=str;
					   
					 $('.formSelect').sSelect();
					 
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
		
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

		function showModalDialog22($dialog) {
			dialogInitPos($dialog);
			$dialog.fadeIn();

			$dialog.draggable({handle:"div.top-bar > h2"})
				.before('<div class="dim-warp"  style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:100;background-color:rgba(255,255,255,.6)"></div>');
			
			if (winHeight2 < docHeight2){
				$(".dim-warp").css ("height", docHeight2);
			} else {
				$(".dim-warp").css ("height", winHeight2);
			}

			$("#btn_schd_close", $dialog).one("click", function(event) {
				$('#edu_date').val('');
				$('#degr').val('');
				$('#start_time1').val('09').change();
				$('#start_time2').val('00').change();
				$('#end_time1').val('09').change();
				$('#end_time2').val('00').change();
				$('#subject').val('');
				$('#sub_cntn').val('');
				$('#t_cnt').val('0');
				document.getElementById("div_t_list").innerHTML="";
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
			
			$("#btn_schd_xclose", $dialog).one("click", function(event) {
				$('#edu_date').val('');
				$('#degr').val('');
				$('#start_time1').val('09').change();
				$('#start_time2').val('00').change();
				$('#end_time1').val('09').change();
				$('#end_time2').val('00').change();
				$('#subject').val('');
				$('#sub_cntn').val('');
				$('#t_cnt').val('0');
				document.getElementById("div_t_list").innerHTML="";
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
	
	/* 
	function schd_add() {
		window.open('', 'popup_post', 'width=910, height=600, resizable=yes, scrollbars=no, status=no');
	    mainform.target = 'popup_post';
		document.mainform.action = "edu_schd_create.do";
		document.mainform.submit();
	} */
	
	function go_info() {
		document.mainform.action = "edu_info.do";
		document.mainform.submit();
	}
	
	function srch_main_teacher(){
		var srchTm = $('#tch_srch').val();
		
		$.ajax({ 
		   url: "srch_teacher.do", 
		   type: "POST", 
		   data: {"srch_teacher" : srchTm},
		   dataType:"text",
		   cache: false,
		   success: function(msg){
			  
			     var tmp = msg.split('|');
			     var str = "<select class=\"formSelect\" id=\"tch_cd\" name=\"tch_cd\" style=\"width:200px;padding:0px\">";
			     	str = str + "<option value=\"\">선택</option>";
			     for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   
				   str = str+"</select>";
				   document.getElementById("div_tch").innerHTML=str;
				   
				   $('.formSelect').sSelect();
		   }
		   , error: function (xhr, ajaxOptions, thrownError) {
		      }
		}); 
	}
	
	function srch_sub_teacher(){
		var srchTm = $('#tch2_srch').val();
		
		$.ajax({ 
		   url: "srch_teacher.do", 
		   type: "POST", 
		   data: {"srch_teacher" : srchTm},
		   dataType:"text",
		   cache: false,
		   success: function(msg){
			  
			     var str = "<select class=\"formSelect\" id=\"tch2_cd\" name=\"tch2_cd\" style=\"width:200px;padding:0px\">";
			     
			     if(msg == "") {
			    	 str = str + "<option value=\"\">검색결과가 없습니다.</option>";
			     }
			     else {
			     	var tmp = msg.split('|');
			     	str = str + "<option value=\"\">선택</option>";
				     for(var i = 0; i < tmp.length ; i++) {
						   var tmp_sub = tmp[i].split(",");
	         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
			     }	   
				   str = str+"</select>";
				   document.getElementById("div_tch2").innerHTML=str;
				   
				   $('.formSelect').sSelect();
				  
		   }
	
		   , error: function (xhr, ajaxOptions, thrownError) {
		      }
		}); 
	}
	
	function teacher_add() {
		
		var t = frm_schd.t_cnt.value;
		var new_t = parseInt(t) +1;
		frm_schd.t_cnt.value = new_t;
		
		var t_cd = $("#tch_cd option:selected").val();
		var t_nm = $("#tch_cd option:selected").text();
		var t_cd2 = $("#tch2_cd option:selected").val();
		var t_nm2 = $("#tch2_cd option:selected").text();
		
		$("#t_list").append("<li id=\"t_li"+new_t+"\"><span> 주강사 : "+t_nm+"</span><span>보조강사 :"+t_nm2+"</span><a href=\"javascript:teacher_del('"+new_t+"')\"><span class=\"btn-del\" title=\"삭제\"></span></a>"
						+"<input type=\"hidden\" id=\"tch_cd"+new_t+"\" name=\"tch_cd"+new_t+"\"  value=\""+t_cd+"\" />"
						+"<input type=\"hidden\" id=\"tch2_cd"+new_t+"\" name=\"tch2_cd"+new_t+"\" value=\""+t_cd2+"\" /></li>");
	} 
	
	function edu_schd_save() {
		if ( confirm("저장 하시겠습니까?") ) {
			
			document.frm_schd.action = "edu_schd_save.do";
			document.frm_schd.submit();
			
		}
	}
	
	function edu_schd_del() {

		var s = frm_schd.s_seq.value;
		if(s == "" || s == null) {
			alert("입력에서는 삭제가 불가능합니다.");
			return;
		}
		else {
			
			if ( confirm("삭제 하시겠습니까?") ) {
				
				document.frm_schd.action = "edu_schd_del.do";
				document.frm_schd.submit();
			}
		}
	}
	
	function teacher_del(c) {
		$('#t_li'+c).remove();
	}
	
	function none() {
		var a = "";
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
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq}" />
<input type="hidden" id="s_seq" name="s_seq" />
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
		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">교육계획 스케줄등록</h2>
				<div class="btn-block">
					<a href="javascript:;"  id="btn-popup"><span>스케줄 추가</span></a>
				</div>
				<h3>${info.edu_inst_nm } / ${info.branch_name }</h3>
			</div>

			<table class="talbe-schedule">
				<colgroup>
					<col style="width:13%" />
					<col style="width:5%" />
					<col style="width:7%" />
					<col style="width:7%" />
					<col style="width:23%" />
					<col style="width:*"/>
					<col style="width:8%"/>
					<col style="width:8%"/>
				</colgroup>
				<thead>
					<tr>
						<th>일자</th>
						<th>회차</th>
						<th>시작</th>
						<th>종료</th>
						<th>주제</th>
						<th>세부내용</th>
						<th>강사</th>
						<th>보조 강사</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
						<tr onclick="javascript:schd_info('${c.seq}');">
							<td> ${c.edu_date }</td>
							<td> ${c.degr}</td>
							<td>${c.start_time} </td>
							<td>${c.end_time}</td>
							<td class="text-left" >${c.subject}</td>
							<td class="text-left">${c.sub_cntn}</td>
							<td>
								<ul>
								<c:forEach items="${t_list}" var="t">
									<c:if test="${c.seq eq t.seq}">
										<li>${t.main_teacher_nm}</li>
									</c:if>
								</c:forEach>
								</ul>
							</td>
							<td>
								<ul>
								<c:forEach items="${t_list}" var="t">
									<c:if test="${c.seq eq t.seq}">
										<li>${t.sub_teacher_nm}</li>
									</c:if>
								</c:forEach>
								</ul>
							</td>
							<%-- <c:choose>
							<c:when test="${c.cnt gt 1}">
								<c:if test="${c.rnk eq 1}"><td  rowspan="${c.cnt }"> ${c.edu_date }</td></c:if>
								<c:if test="${c.rnk eq 1}"><td rowspan="${c.cnt }">${c.start_time} </td></c:if>
								<c:if test="${c.rnk eq 1}"><td rowspan="${c.cnt }">${c.end_time}</td></c:if>
								<c:if test="${c.rnk eq 1}"><td class="text-left" rowspan="${c.cnt }">${c.subject}</td></c:if>
								<c:if test="${c.rnk eq 1}"><td class="text-left" rowspan="${c.cnt }">${c.sub_cntn}</td></c:if>
								<td>${c.main_teacher_nm}</td>
								<td>${c.sub_teacher_nm}</td>
							</c:when>
							<c:otherwise>
								<td> ${c.edu_date }</td>
								<td>${c.start_time} </td>
								<td>${c.end_time}</td>
								<td class="text-left" >${c.subject}</td>
								<td class="text-left">${c.sub_cntn}</td>
								<td>${c.main_teacher_nm}</td>
								<td>${c.sub_teacher_nm}</td>
							</c:otherwise>
							</c:choose> --%>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) == 0 }">
						<tr>
							<td colspan="7">검색 결과가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<div class="btn-block text-right">
				<a href="javascript:go_info()"><span class="btn-go">교육상세로</span></a>
			</div><!--// btn-block -->
			

		</div><!--// contents -->
</form>
	</div><!--// container -->
</div>


<form id="frm_schd" name="frm_schd" action="" method="post">
<input type="hidden" id="edu_proc_seq" name="edu_proc_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<input type="hidden" id="t_cnt" name="t_cnt" value="0"/> 
<input type="hidden" id="s_seq" name="s_seq"/>
<div id="regSchedule" class="layer-warp" style="width:830px">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>스케줄 추가 </h2>
			<div class="btn-close"><a href="javascript:none()" id="btn_schd_xclose"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="layer-content">

			<div class="row clearfix">
				<dl class="date">
					<dt>일자</dt>
					<dd>
						<span class="set-date">
							<input type="text" id="edu_date" name="edu_date"  style="width:85px;" />
							<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="교육일 선택" /></span><!-- 달력 선택 버튼 -->
						</span>
					</dd>
				</dl>
				<dl class="date">
					<dt>회차</dt>
					<dd>
						<input type="text" id="degr" name="degr" style="width:20px;min-width:20px;" /> 회차
					</dd>
				</dl>
				<dl class="time" style="padding: 0px 30px">
					<dt>교육시간</dt>
					<dd>
						<div id="div_tm1" style="display:inline;">
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
						</div>
						<span class="txt-symbol">&nbsp;~&nbsp;</span>
						<div id="div_tm2" style="display:inline;">
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
						</div>
					</dd>
				</dl>
			</div>
			<div class="row clearfix">
				<dl class="subject" style="width:350px;padding:0px 20px">
					<dt>주제</dt>
					<dd>
						<textarea id="subject" name="subject" style="width:99%"></textarea>
					</dd>
				</dl>
				<dl class="detail" style="width:350px;padding:0px 20px">
					<dt>세부내용</dt>
					<dd>
						<textarea id="sub_cntn" name="sub_cntn" style="width:99%"></textarea>
					</dd>
				</dl>
			</div>

			<div class="row clearfix">
				<dl class="teacher">
					<dt>
						강사
						<!-- <span class="btn-table"><a href="#a"><span>추가</span></a></span> -->
					</dt>
					<dd>
						<span class="txt-label">주강사 : </span>
						<input type="text" id="tch_srch" name="tch_srch" onkeyup="javascript:srch_main_teacher()" placeholder="이름검색" class="readonly" style="width:40px;min-width:40px" />
						<div id="div_tch" style="display:inline;">
							<select class="formSelect" style="width:180px;" title="">
								<option value="" selected="selected">선택</option>
							</select>
						</div>
						<span class="txt-label ml20">보조강사 : </span>
						<input type="text" id="tch2_srch" name="tch2_srch" onkeyup="javascript:srch_sub_teacher()" placeholder="이름검색" class="readonly" style="width:40px;min-width:40px" />
						<div id="div_tch2" style="display:inline;">
							<select class="formSelect" style="width:180px;" title="">
								<option value="" selected="selected">선택</option>
							</select>
						</div>
						<span class="btn-table green"><a href="javascript:teacher_add()"><span>저장</span></a></span>
						<!-- <span class="btn-table"><a href="#a"><span>취소</span></a></span> -->	
					</dd>
					<dd>
						<div id="div_t_list">
							<ul id="t_list">
							</ul>
						</div>
					</dd>
				</dl>
			</div>

			<div class="btn-block">				
				<div id="btn_del" style="display:none"><a href="javascript:edu_schd_del()" class="btn-negative" style="float:left; margin-left:10px;"><span>삭제</span></a></div>
				<a href="javascript:edu_schd_save()"><span>저장</span></a>
				<a href="javascript:;" id="btn_schd_close" class="btn-gray"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>