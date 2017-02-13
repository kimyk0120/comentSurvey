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
<title>수강생 등록 </title>
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
			$("a.btn-negative", $dialog).one("click", function(event) {
				$dialog.hide()
					.prev("div.dim-warp").remove();
			});
		}

		function dialogInitPos($dialog) {
			var left = Math.floor(($(window).width() - $dialog.width()) / 2 + 60),
				top = Math.floor(($(window).height() - $dialog.height()) / 2);
			$dialog.css({left:left < 0 ? 0 : left, top:top < 0 ? 0 : top});
		}

		
			
	});

	
	function get_gugun() {
		
		var e = document.getElementById("sido_code");
		var s_sido = e.options[e.selectedIndex].value;
				
		$.ajax({ 
			   url: "srch_gugun.do", 
			   type: "POST", 
			   data: {"s_sido" : s_sido},
			   dataType:"text",
			   cache: false,
			   success: function(msg){
				   var tmp = msg.split('|');
				   
				   var str = "<select class=\"formSelect\" id=\"gugun_code\" name=\"gugun_code\" style=\"width:100px;\" title=\"\">";
				   for(var i = 0; i < tmp.length ; i++) {
					   var tmp_sub = tmp[i].split(",");
        				str = str+"<option value=\""+tmp_sub[0]+"\">"+tmp_sub[1]+"</option>";
				   }
				   str = str+"</select>";
				   document.getElementById("srch_gugun_div").innerHTML=str;
				   
				   $('.formSelect').sSelect();
			   }
			   , error: function (xhr, ajaxOptions, thrownError) {
			      }
			}); 
	}
	
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
		
		
	function edu_save() {
		if(mainform.student_name.value == "" ) {
			alert("이름을 입력하여 주십시요.");
			// $("#lecture_code").focus();
			return;
		} 
		
		var ph1 = mainform.phone1.value;
		var ph2 = mainform.phone2.value;
		var ph3 = mainform.phone3.value;
		
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
		
		if ( confirm("저장 하시겠습니까?") ) {

			$.ajax({ 
				   url: "student_check.do", 
				   type: "POST", 
				   data: {"eSeq": mainform.e_seq.value, "nm" : mainform.student_name.value, "resist" : mainform.resist_no.value, "ph" : mainform.phone.value},
				   dataType:"text",
				   cache: false,
				   success: function(msg){
					   
				   	   if(msg == "no") {
				   		 alert("해당 강의에 동일한 수강생이 존재합니다.");
				   		 return;
				   		   
				   	   } else if( msg.length > 0  ) {
					   	
						   showModalDialog($("#stdt_info"));
						   
						   var tmp = msg.split('|');
						   
						   var str = "<table class=\"talbe-list\"><colgroup><col style=\"width:20%\" /><col style=\"width:40%\" /><col style=\"width:20%\" /><col style=\"width:20%\" /></colgroup><thead><tr><th>수강생명</th><th>지역</th><th>자격정보</th><th>연락처</th></tr></thead><tbody>";
						   for(var i = 0; i < tmp.length ; i++) {
							   var si = "";
							   var gu = "";
							   var info = "";
							   var ph = "";
							   var tmp_sub = tmp[i].split(",");
							   if(tmp_sub[3] != 'null') si =tmp_sub[3];
							   if(tmp_sub[4] != 'null') gu =tmp_sub[4];
							   if(tmp_sub[5] != 'null') info =tmp_sub[5];
							   if(tmp_sub[2] != 'null') ph =tmp_sub[2];
							   
		        				str = str+"<tr><td><a href=\"javascript:pick_stdt('"+tmp_sub[0]+"')\">"+tmp_sub[1]+"</a></td><td>"+si+" "+gu+"</td><td>"+info+"</td><td>"+ph+"</td></tr>";
						   }
						   str = str+"</tbody></table>";
						   document.getElementById("div_stdt").innerHTML=str;
					   }
					   else {
							document.mainform.target = "_self";
							/* document.mainform.action = "student_save.do"; */
							document.mainform.action = "student_save2.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
							document.mainform.submit();
					   }
					   
				   }
				   , error: function (xhr, ajaxOptions, thrownError) {
				      }
				}); 
			

		
		}
	}
	
	function pick_stdt(no) {
		document.mainform2.target = "_self";
		mainform2.st_no.value=no;
		document.mainform2.action = "student_save.do";
		document.mainform2.submit();
	}
	
	function save_stdt() {
		document.mainform.target = "_self";
		/* document.mainform.action = "student_save.do"; */
		document.mainform.action = "student_save2.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
		document.mainform.submit();
	}
	
	function img_del() {
		var str = "<label class=\"custom-file-upload\"><input type=\"file\" id=\"stdt_img\" name=\"stdt_img\" size=\"12\" onchange=\"readURL(this)\"/><img id=\"img_view\" src=\"#\" /></label>";
		
		document.getElementById("div_img").innerHTML=str;
	    mainform.img_change.value="Y";
	}
	
	function readURL(input) {

		var  str_dotlocation,str_ext,str_low;
		str_value  = $('#stdt_img').val();
		str_low   = str_value.toLowerCase(str_value);
		str_dotlocation = str_low.lastIndexOf(".");
		str_ext   = str_low.substring(str_dotlocation+1);

		if (str_ext != "png" && str_ext != "jpg" && str_ext != "gif" && str_ext != "jpeg") {
		     alert("파일 형식이 맞지 않습니다.\n png,jpg,gif,jpeg 만\n 업로드가 가능합니다!");
		  	 $('#stdt_img').val('');
		     return;
		}
		
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();

	        reader.onload = function (e) {
	            $('#img_view').attr('src', e.target.result);
	        }

	        reader.readAsDataURL(input.files[0]);
	        
	        document.getElementById("img_view").height = "80";
	        $("#img_change").val("Y");
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
<!-- 
<style type="text/css">
	input[type="file"] {
	    display: none;
	}
	
	.custom-file-upload {
	    display: inline-block;
	    cursor: pointer;
	    font-weight:bold;
	    color:#fff;
	    text-align:center;
	    line-height:20px;padding:2px 24px 0;
	    min-width:30px;
	    background:#00bcae;
	    border-radius:5px
	}

</style> -->

</head>
<body>

<form id="mainform2" name="mainform2" method="post">
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="phone" name="phone" />
<input type="hidden" id="email" name="email" />
<input type="hidden" id="st_no" name="st_no"/>
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
</form>

<form id="mainform" name="mainform" method="post" enctype="multipart/form-data">
<input type="hidden" id="e_seq" name="e_seq" value="${info.edu_proc_seq }"/>
<input type="hidden" id="phone" name="phone" />
<input type="hidden" id="email" name="email" />
<input type="hidden" id="st_no" name="st_no"/>
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }"/>
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }"/>
<input type="hidden" id="srch_stat" name="srch_stat" value="${srch.srch_stat }"/>
<input type="hidden" id="srch_lecture_prt" name="srch_lecture_prt" value="${srch.srch_lecture_prt }"/>
<input type="hidden" id="srch_edu_inst" name="srch_edu_inst" value="${srch.srch_edu_inst }"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp" flush="false" />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp" flush="false" />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">수강생 등록  &lt; ${info.lecture_nm } / ${info.edu_inst_nm } </h2><!-- 타이틀과 콘텐츠 하단 간격이 없을 때 class="mb0" 적용 -->
			</div>

			<table class="talbe-view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:20%" />
					<col style="width:15%" />
					<col style="width:50%" />
				</colgroup>
				<tbody>
					<tr>
						<th style="height:50px">성명</th>
						<td>
							<input type="text" id="student_name" name="student_name" placeholder="" style="width:150px" />
						</td>
						<th rowspan="2">사진</th>
						<td rowspan="2" class="inner">
							<div id="div_img" style="display:inline;" >
								<img id="img_view" src=""/>
								<br/>
								<!-- <label class="custom-file-upload"> -->
									<input type="file" id="stdt_img" name="stdt_img" size="12" onchange="readURL(this)"/>
								<!-- </label> -->
							</div>
						</td>
					</tr>
					<tr>
						<th style="height:50px">생년월일</th>
						<td>
							<input type="text" id="resist_no" name="resist_no" placeholder="6자리로 입력하세요" style="width:150px" maxlength="6"/>
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3">
							<select class="formSelect" style="width:120px" title="" id="phone1" name="phone1">
								<option value="010" selected="selected">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="txt-symbol">-</span><input type="text" id="phone2" name="phone2" style="width:120px" maxlength="4"/>
							<span class="txt-symbol">-</span><input type="text" id="phone3" name="phone3" style="width:120px" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3">
						    <select class="formSelect" id="sido_code" name="sido_code" style="width:100px;" onchange="get_gugun()">
								<option value="" selected="selected">시도</option>
								<c:forEach items="${s_list}" var="s">
									<option value="${s.sido_code}">${s.sido_code_nm}</option>
								</c:forEach>
							</select>
							<div id="srch_gugun_div"  style="display:inline;">
								<select class="formSelect" style="width:100px;" id="gugun_code" name="gugun_code">
									<option value="" selected="selected">구군</option>
								</select>
							</div>
							<input type="text" id="address" name="address" placeholder="나머지 주소를 입력하세요" style="width:200px" />
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3">
							<input type="text" id="email1" name="email1" style="width:150px" />
							<span class="txt-symbol">@</span>
							<select class="formSelect" style="width:150px" id="email2" name="email2" onchange="email_select()">
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
								<input type="text" id="email3" name="email3" style="width:150px" />
							</div>
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
<div id="stdt_info" class="layer-warp">
	<div class="layer-inner">
		<div class="top-bar">
			<h2>수강생확인</h2>
			<!-- <div class="btn-close"><a href="#a"><img src="image/btn_close.png" alt="Close"></a></div> -->
		</div>

		<div class="contents" style="margin-left:5px;padding:5px">
			<h3 style="font-size:1.4em">동일한 정보의 수강생이 존재합니다. <br/> 입력한 수강생과 같은 수강생을 클릭하시면 해당 수강생이 등록되고, <br/> 별도의 수강생으로 등록하시려면 '닫기'버튼을 눌러주세요.</h3>
			<div id="div_stdt">
			<table class="talbe-list">
				<colgroup>
					<col style="width:20%" />
					<col style="width:40%" />
					<col style="width:20%" />
					<col style="width:20%" />
				</colgroup>
				<thead>
					<tr>
						<th>수강생명</th>
						<th>지역</th>
						<th>자격정보</th>
						<th>연락처</th>
					</tr>
				</thead>
					<tbody>
					</tbody>
			</table>
			</div>

			<div class="btn-block">				
				<a href="javascript:save_stdt()" class="btn-negative" id="btn_pop_close"><span>닫기</span></a>
			</div><!--// btn-block -->

		</div><!--// layer-content -->

	</div><!--// layer-inner -->
</div><!--// layer-pop -->
</form>

</body>
</html>