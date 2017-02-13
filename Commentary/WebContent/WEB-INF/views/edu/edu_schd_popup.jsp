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
		var start_tm = "<c:out value="${info.start_time}"/>";
		var end_tm = "<c:out value="${info.end_time}"/>";
		
		if(start_tm != null && start_tm != '') {
			var start_tm1 = start_tm.substring(0, 2);
			$("#start_time1").val(start_tm1).attr("selected","selected"); 
			var start_tm2 = start_tm.substring(3, 5);
			$("#start_time2").val(start_tm2).attr("selected","selected"); 
			
		}
		if(end_tm != null && end_tm != '') {
			var end_tm1 = end_tm.substring(0, 2);
			$("#end_time1").val(end_tm1).attr("selected","selected"); 
			var end_tm2 = end_tm.substring(3, 5);
			$("#end_time3").val(end_tm2).attr("selected","selected"); 
		}
		
		var t_cnt = "<c:out value="${fn:length(t_list)}"/>";
		mainform.t_cnt.value=t_cnt;
		
	});

	$(function() {
		$('.formSelect').sSelect();
	});
	
	function pop_close() { 
		if(confirm("저장없이 닫으시겠습니까?")) {
			
		self.close();
		}
	}
	
	$(function() {
	    $("#edu_date").datepicker({
	    });
	  });
	
	function teacher_add() {
		
		var t = mainform.t_cnt.value;
		mainform.t_cnt.value= parseInt(t) +1;
		
	//	alert("ln : " + $( '#t_list li' ).length);
		
		$("#t_list").append("<li id=\"t_li"+mainform.t_cnt.value+"\"> 주강사 : <input type=\"text\" id=\"tch_srch"+mainform.t_cnt.value+"\" name=\"tch_srch"+mainform.t_cnt.value+"\" onkeyup=\"javascript:srch_main_teacher('"+mainform.t_cnt.value+"')\" placeholder=\"강사명 검색\" />"
						+"<div id=\"div_tch"+mainform.t_cnt.value+"\" style=\"display:inline;\"><select id=\"tch_cd"+mainform.t_cnt.value+"\" name=\"tch_cd"+mainform.t_cnt.value+"\" style=\"width:180px;\"></select></div>"
						+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 보조강사 : <input type=\"text\" id=\"tch2_srch"+mainform.t_cnt.value+"\" name=\"tch2_srch"+mainform.t_cnt.value+"\" onkeyup=\"javascript:srch_sub_teacher('"+mainform.t_cnt.value+"')\" placeholder=\"강사명 검색\" />"
						+"<div id=\"div2_tch"+mainform.t_cnt.value+"\" style=\"display:inline;\"><select id=\"tch2_cd"+mainform.t_cnt.value+"\" name=\"tch2_cd"+mainform.t_cnt.value+"\" style=\"width:180px;\"></select></div>"
						+"<a href=\"javascript:teacher_del('"+mainform.t_cnt.value+"')\"><span class=\"btn-del\"></span>"
						+"<input type=\"hidden\" id=\"tch_cd"+mainform.t_cnt.value+"\" name=\"tch_cd"+mainform.t_cnt.value+"\">"
						+"<input type=\"hidden\" id=\"tch2_cd"+mainform.t_cnt.value+"\" name=\"tch2_cd"+mainform.t_cnt.value+"\"></li>");
	} 
	
	function teacher_del(c) {
	//	alert( c );
		$('#t_li'+c).remove();
	}
	
	function srch_main_teacher(seq){
		var srchTm = $('#tch_srch'+seq).val();
		
		$.ajax({ 
		   url: "srch_teacher.do", 
		   type: "POST", 
		   data: {"srch_teacher" : srchTm},
		   dataType:"text",
		   cache: false,
		   success: function(msg){
			  
			     var tmp = msg.split('|');
			     var str = "<select id=\"tch_cd"+seq+"\" name=\"tch_cd"+seq+"\" style=\"width:180px;\">";
			     	str = str + "<option value=\"\">선택</option>";
			     for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   
				   str = str+"</select>";
				   document.getElementById("div_tch"+seq).innerHTML=str;
				  
		   }
		   , error: function (xhr, ajaxOptions, thrownError) {
		      }
		}); 
	}
	
	function srch_sub_teacher(seq){
		var srchTm = $('#tch2_srch'+seq).val();
		
		$.ajax({ 
		   url: "srch_teacher.do", 
		   type: "POST", 
		   data: {"srch_teacher" : srchTm},
		   dataType:"text",
		   cache: false,
		   success: function(msg){
			  
			     var tmp = msg.split('|');
			     var str = "<select id=\"tch2_cd"+seq+"\" name=\"tch2_cd"+seq+"\" style=\"width:180px;\">";
			     	str = str + "<option value=\"\">선택</option>";
			     for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
         				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
					   }
					   
				   str = str+"</select>";
				   document.getElementById("div2_tch"+seq).innerHTML=str;
				  
		   }
		   , error: function (xhr, ajaxOptions, thrownError) {
		      }
		}); 
	}
	
	function edu_schd_save() {
		if ( confirm("저장 하시겠습니까?") ) {
			
			$.ajax({ 
				   url: "edu_schd_save.do", 
				   type: "POST",
				   data: $("#mainform").serialize(),
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   
					   opener.location.href="edu_schd_info.do?edu_proc_seq="+${info.edu_proc_seq };
					   
					   window.close();
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
					   alert("status : " + xhr.status);
				       alert("err: " +thrownError);
				   }
			});
			
		}
	}
	
</script>
</head>
<body>
<form id="mainform" name="mainform" action="" method="post">
<input type="text" id="t_cnt" name="t_cnt"/>
<input type="hidden" id="edu_proc_seq" name="edu_proc_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="seq" name="seq" value="${info.seq}"/>
<div id="regSchedule" class="layer-warp2">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>스케줄 추가</h2>
			<div class="btn-close"><a href="javascript:pop_close()"><img src="image/btn_close.png" alt="Close"></a></div>
		</div>

		<div class="layer-content">

			<div class="row clearfix">
				<dl class="date">
					<dt>일자</dt>
					<dd>
						<span class="set-date">
							<input type="text" id="edu_date" name="edu_date" value="${info.edu_date}" style="width:80px;" />
							<span class="btn-calendar"><img src="image/btn_calendar_input.gif" alt="교육일 선택" /></span>
						</span>
					</dd>
				</dl>
				<dl class="time">
					<dt>교육시간</dt>
					<dd>
						<select class="formSelect" style="width:45px;" id="start_time1" name="start_time1">
							<option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option>
							<option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option>
							<option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option>
							<option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>
							<option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option>
							<option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option>
						</select>
						<span class="txt-symbol">:</span>
						<select class="formSelect" style="width:45px;" id="start_time2" name="start_time2">
							<option value="00">00</option><option value="10">10</option><option value="20">20</option>
							<option value="30">30</option><option value="40">40</option><option value="50">50</option>
						</select>
					</dd>
					<dd class="text-center">
						<span class="txt-symbol">~</span>
					</dd>
					<dd>
						<select class="formSelect" style="width:45px;" id="end_time1" name="end_time1">
							<option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option>
							<option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option>
							<option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option>
							<option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>
							<option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option>
							<option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option>
						</select>
						<span class="txt-symbol">:</span>
						<select class="formSelect" style="width:45px;" id="end_time2" name="end_time2">
							<option value="00">00</option><option value="10">10</option><option value="20">20</option>
							<option value="30">30</option><option value="40">40</option><option value="50">50</option>
						</select>
					</dd>
				</dl>
				<dl class="subject" style="width:200px">
					<dt>주제</dt>
					<dd style="height:200px">
						<textarea id="subject" name="subject" style="width:95%;height:95%">${info.subject}</textarea>
					</dd>
				</dl>
				<dl class="detail" style="width:300px">
					<dt>세부내용</dt>
					<dd style="height:200px">
						<textarea id="sub_cntn" name="sub_cntn" style="width:95%;height:95%">${info.sub_cntn }</textarea>
					</dd>
				</dl>
			</div>

			<div class="row clearfix">
				<dl class="teacher" style="width:800px">
					<dt>강사<a href="javascript:teacher_add()"> <span class="btn-add"></span> </a></dt>
					<dd>
						<ul id="t_list">
							<c:forEach items="${t_list}" var="t" varStatus="status">
								<li id="t_li${status.index+1}">
									주강사 : ${t.main_teacher_nm }
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									보조강사 : ${t.sub_teacher_nm }
									<a href="javascript:teacher_del('${status.index+1}')"><span class="btn-del"></span></a>
									<input type="hidden" id="tch_cd${status.index+1}" name="tch_cd${status.index+1}" value="${t.main_teacher_code }" />
									<input type="hidden" id="tch2_cd${status.index+1}" name="tch2_cd${status.index+1}" value="${t.sub_teacher_code }" />
								</li>
							</c:forEach>
						</ul>
					</dd>
				</dl>
			</div>

			<div class="btn-block">				
				<a href="javascript:edu_schd_save()"><span>저장</span></a>
				<a href="javascript:pop_close()" class="btn-negative"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div> <!-- // layer-pop -->
</form>
</body>
</html>