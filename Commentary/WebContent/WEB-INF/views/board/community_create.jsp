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
<link href="common/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="common/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="common/js/jquery.form.stylishSelect.js"></script><!-- Design For Select -->
<script type="text/javascript" src="common/js/ui.js"></script>

<script type="text/javascript" src="common/js/HuskyEZCreator.js" charset="utf-8"></script>

<!-- // jQuery UI CSS파일 --> 
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />

<script type="text/javascript">

	$(document).ready(function(){
	  var fileTarget = $('.filebox .upload-hidden');

	  fileTarget.on('change', function(){  // 값이 변경되면
	    if(window.FileReader){  // modern browser
	      var filename = $(this)[0].files[0].name;
	    } 
	    else {  // old IE
	      var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
	    }
	    
	    // 추출한 파일명 삽입
	    $(this).siblings('.upload-name').val(filename);
	  });
	}); 
	
	var oEditors = [];
	
	$(function() {
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "_contents",
			sSkinURI: "common/SmartEditor2Skin.html",
			fCreator: "createSEditorInIFrame"
		});
		
		$("#chkAll").click(function(){
			//$(".seqs:enabled").attr("checked",$(this).is(":checked"));
			
			if($("#chkAll").prop("checked")) {
				$(".seqs").prop("checked",true);
			} else {
				$(".seqs").prop("checked",false);
			}
		});
		
		$(".seqs").click(function(){
			if($(".seqs:checked").size() == $(".seqs").size()){
				$("#chkAll:enabled").attr("checked", true);
			}
			else {
				$("#chkAll:enabled").attr("checked", false);		
			}
		});
	});
	
	function board_save() {
		
		var ttl = $('#title').val();
		oEditors.getById["_contents"].exec("UPDATE_CONTENTS_FIELD", []);
		
		var cnt = $(".seqs:checked").size();
		
		if(ttl == "") {
			alert("제목을 입력하세요");
			return;
		} else if(mainform2.contents.value == "") {
			alert("내용을 입력하세요");
			return;
		} else if(cnt == "0") {
			alert("한 개 이상 지역을 선택하세요.");
			return;
		} else {
			if(confirm("저장하시겠습니까?")) {
				document.mainform2.action = "community_save.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
				document.mainform2.submit();
			}
		}
	}
	
	function board_list() {
		document.mainform.action = "board_list.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
		document.mainform.submit();
	}
	
</script>
<style type="text/css">

.input03 { font-size: 13px; border:1px solid #e7e7e7; line-height:160%; padding:20px; width:93%; height:250px;}

input[type=checkbox] {
        width:14px;height:20px;position:absolute;opacity:0;left:0;top:0
}
input[type=checkbox] + label{
    display:inline-block;width:auto;height:18px;padding-left:20px;color:#bbb;margin-right:10px;margin-bottom:5px;background:url(image/bg_check.png) no-repeat 0 0;
} 
input[type=checkbox] + label:hover {background-position:0 -20px;color:#999}
input[type="checkbox"]:checked + label, input[type="checkbox"]:hover:checked + label, input[type="checkbox"]:focus:checked + label {background-position:0 -20px;color:#999}

.filebox input[type="file"] {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip:rect(0,0,0,0);
  border: 0;
}

.filebox label {
  display: inline-block;
  padding: 4px 20px;
  color: #999;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
	width:500px;
  display: inline-block;
  padding: 2px 10px;  /* label의 패딩값과 일치 */
  font-size: inherit;
  font-family: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none; /* 네이티브 외형 감추기 */
  -moz-appearance: none;
  appearance: none;
}
</style>

</head>
<body>

<div id="wrapper">

	<form id="mainform" name="mainform" action="" method="post">
		<jsp:include page="../main/topMenu.jsp"  />
	</form>

<form id="mainform2" name="mainform2" method="post" enctype="multipart/form-data">
<input type="hidden" id="srch_title" name="srch_title" value="${srch.srch_title }" />
<input type="hidden" id="srch_str_dt" name="srch_str_dt" value="${srch.srch_str_dt }" />
<input type="hidden" id="srch_end_dt" name="srch_end_dt" value="${srch.srch_end_dt }" />
<input type="hidden" id="srch_nm" name="srch_nm" value="${srch.srch_nm}" />

	<div id="container" class="colum1">

		<div class="contents">

			<h2>커뮤니티 등록 <span style="font-size:10px">(*는 필수입력사항입니다.)</span></h2>

			<div class="shadow-box" style="padding-top:20px">

				<table class="talbe-view">
					<colgroup>
						<col style="width:20%" />
						<col style="width:80%" />
					</colgroup>
					<tbody>
						<tr>
							<th>제목 <span>*</span></th>
							<td><input type="text" id="title" name="title" style="width:95%" title="제목"/></td>
						</tr>
						<tr>
							<th>내용 <span>*</span></th>
							<td>
								<!-- <textarea id="cntn" name="cntn" rows="10" cols="100" style="width:766px; height:412px; display:none;"></textarea> -->
								<textarea name="contents" id="_contents" class="input03" ></textarea>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<div class="filebox">
								  <input class="upload-name" value="파일선택" disabled="disabled" />
								  <label for="ex_filename">업로드</label> 
								  <input type="file" id="ex_filename" name="ex_filename" class="upload-hidden" /> 
								</div>
							</td>
						</tr>
						<tr>
							<th>열람가능지역</th>
							<td>
								<input type="checkbox" name="chkAll" id="chkAll" value="" /><label for="chkAll">전체</label> 
								<c:forEach items="${s_list}" var="s">
									<input type="checkbox" class="seqs" name="sido_${s.sido_cd}" id="${s.sido_cd}" value="${s.sido_cd}" /><label for="${s.sido_cd}">${s.sido_cd_nm}</label>
								</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="btn-block text-center mt20">
					<a href="javascript:board_save()" class="btn-blue"><span>내역 등록</span></a>
					<a href="javascript:history.back()" class="btn-orange"><span>취소</span></a>
				</div>
			</div>
			
		</div><!--// layer-content -->

		</div><!--// contents -->
</form>
	</div><!--// container -->
	


</body>
</html>