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
<title>덤인시스템</title>
<link href="common/css/dumin.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">

	$(function() {
		$('.formSelect').sSelect();
	});
		
	function go_back() {
		document.mainform.action = "edu_lcns_list.do";
		document.mainform.target = "_self";
		document.mainform.submit();
	}
	
	$(document).ready(function() {
		var st = "";
		<c:forEach items="${list}" var="c" varStatus="status">
			st = st + "|" + "<c:out value="${c.student_no}"/>" + "_" + "<c:out value="${c.row_num}"/>";
		</c:forEach>
		
		mainform.st.value= st.substring(1, st.length);
		
	});
	
	
/* 	function stdt_list() {
		document.mainform.target = "_self";
		document.mainform.action = "edu_stdt_list.do?top=0&left=1";
		document.mainform.submit();
	}
	
	function attd_list() {
		document.mainform.target = "_self";
		document.mainform.action = "edu_attd_list.do?top=0&left=2";
		document.mainform.submit();
	}
 */	
	function stdt_info(stdt) {
		document.mainform.target = "_self";
		mainform.stdt_no.value = stdt;
		document.mainform.action = "edu_stdt_info.do";
		document.mainform.submit();
	}
 
 	function CheckAll(scr){
		
		/* var st_cnt = mainform.st.value;
		
		var tmp = st_cnt.split('|');
		var dd = "";
		
		if($('input[name="chk_all"]').prop("checked")) {
			for (var i=0; i < tmp.length; i++) {
				dd = "std_"+tmp[i];
				$('input[name=student_no]').attr("checked",true);
				$('input[name=student_no]').prop("checked",true);
			}
		}	else {
			for (var i=0; i < tmp.length; i++) {
				dd = "std_"+tmp[i];
				$('input[name=student_no]').attr("checked",false);
				$('input[name=student_no]').prop("checked",false);
			}
		} */
		checkboxes = document.getElementsByName('student_no');
		  for(var i=0, n=checkboxes.length;i<n;i++) {
		    checkboxes[i].checked = scr.checked;
		  }
	}
 	/* 
	function lcns_print() {
 		
		var st_cnt = mainform.st.value;
		
		var tmp = st_cnt.split('|');
		var dd = "";
		var lcns = "";
		
		for (var i=0; i < tmp.length; i++) {
			dd = "std_"+tmp[i];
			if($('input[name="'+dd+'"]').prop("checked")) {
				lcns = lcns + "`" + $('input[name="'+dd+'"]').val();
			}
		}
		
		lcns = lcns.substring(1);
		
		if(lcns == "") {
			alert("1개 이상 선택하셔야 합니다.");
			return;
		}
		else {
 			$('#lcns_print').val(lcns);
		    document.mainform.action = 'lcns_print.do';
		    document.mainform.submit();
		}
 	} */
	
	function excel_down() {
 		
		/* var st_cnt = mainform.st.value;
		
		var tmp = st_cnt.split('|');
		var dd = "";
		var lcns = "";
		
		for (var i=0; i < tmp.length; i++) {
			dd = "std_"+tmp[i];
			if($('input[name="'+dd+'"]').prop("checked")) {
				lcns = lcns + "," + $('input[name="'+dd+'"]').val();
			}
		}
		 */
		var chkbox = document.getElementsByName("student_no");
		var chkCnt = 0;
		for(var i=0;i<chkbox.length; i++){
			if(chkbox[i].checked){
				chkCnt++;
			}
		}
		
		if(chkCnt == 0 ){
			alert("1개 이상 선택하십시요.");
			obj.checked = false;
			return false;
		}
		
		else {
		    document.mainform.action = 'lcns_print_excel_down.do';
		    document.mainform.submit();
		}
 	}
	
	/*  function downloadAll(){
		 
		 var st_cnt = mainform.st.value;
		 
		 var tmp = st_cnt.split('|');
			var dd = "";

			for (var i=0; i < tmp.length; i++) {
				dd = "std_"+tmp[i];
				if($('input[name="'+dd+'"]').prop("checked")) {
					var lcns = $('input[name="'+dd+'"]').val();
					var img = lcns.split('#') ;
					//downloadURL("http://127.0.0.1:8080/Dumin/files/image/" + img[5]);
					window.open("http://127.0.0.1:8080/Dumin/files/image/" + img[5]);
					
				}
			} 
	 }
	 
     function downloadURL(url) {
    	 var iframe = $('<iframe style="visibility: collapse;"></iframe>');
         $('body').append(iframe);
         var content = iframe[0].contentDocument;
         var form = '<form action="' + url + '" method="GET"></form>';
         content.write(form);
         $('form', content).submit();
         setTimeout((function(iframe) {
           return function() { 
             iframe.remove(); 
           }
         })(iframe), 2000);
    }
	  */
	 
	
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

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />


<form id="mainform" name="mainform" action="" method="post">
<input type="hidden" id="pageNum" name="pageNum"  value="" />
<input type="hidden" id="stdt_no" name="stdt_no"/>
<input type="hidden" id="l_cd" name="l_cd" value="${info.lecture_code }"/>
<input type="hidden" id="st" name="st" />
<input type="hidden" id="lcns_print" name="lcns_print" />
<input type="hidden" id="re_url" name="re_url" value="edu_lcns_stdt_list.do"/>

<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>

		<div class="contents">

			<div class="contents-top">
				<h2>수강생 < ${info.lecture_nm} / ${info.edu_inst_nm}</h2>
			</div>

			<table class="talbe-list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:15%" />
					<col style="width:30%" />
					<col style="width:10%"/>
					<col style="width:10%"/>
					<col style="width:10%"/>
				</colgroup>
				<thead>
					<tr>
						<th>
							<div class="pos-relative">
								<input type="checkbox" id="chk_all" name="chk_all" value="Y" onclick="javascript:CheckAll(this)"/>
								<label for="chk_all"><span>전체</span></label>
							</div>
						</th>
						<th>성명</th>
						<th>연락처</th>
						<th>주소</th>
						<th>자격번호</th>
						<th>출력여부</th>
						<th>출력일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="c" varStatus="status">
					<c:if test="${c.qlfc_issue_dt ne ''}"><c:set var="s_dt" value="${fn:substring(c.qlfc_issue_dt,0,4)}년 ${fn:substring(c.qlfc_issue_dt,5,7)}월 ${fn:substring(c.qlfc_issue_dt,8,10)}일" /></c:if>
					<tr>
						<td>
							<div class="pos-relative">
								<c:if test="${c.qlfc_no ne '' and c.qlfc_no ne null}" >
									<%-- <input type="checkbox" id="std_${c.student_no}_${c.row_num}" name="std_${c.student_no}_${c.row_num}" value="${c.qlfc_no}#${c.student_name}#${c.lecture_nm}#${s_dt}#${c.student_no}#${c.image_path}#${c.resist_no}" --%>
									<input type="checkbox" id="std_${c.student_no}_${c.row_num}" name="student_no" value="${c.student_no}"
									<c:if test="${c.lcns_print_yn eq 'Y'}">checked="checked"</c:if> />
									<label for="std_${c.student_no}_${c.row_num}"><span>출력여부</span></label>
								</c:if>
							</div>
						</td>
						<td><a href="javascript:stdt_info('${c.student_no}')">${c.student_name}</a></td>
						<td>${c.phone}</td>
						<td class="text-left">${c.sido_code_nm} ${c.gugun_code_nm} ${c.address }</td>
						<td>${c.qlfc_no}</td>
						<td>${c.lcns_print_yn}</td>
						<td>${c.lcns_print_dt}</td>
					</tr>
					</c:forEach>
				</tbody>
				
			</table>
			
			<div class="btn-block">
				<!-- <a href="javascript:downloadAll()" class="abr"><span>다운</span></a> -->
				<a href="javascript:go_back()" class="btn-negative abl"><span>리스트</span></a>
				<!-- <a href="javascript:lcns_print()"><span>출력</span></a> -->
				<a href="javascript:excel_down()" class="abr"><span>엑셀다운</span></a>
			</div>
			
			
		</div>
	</form>	

		</div><!--// contents -->
	</div><!--// container -->


</body>
</html>