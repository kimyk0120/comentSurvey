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
	
	$(document).ready(function() {
		
		var sido = "<c:out value="${info.sido_cd}"/>";
		if(sido != null && sido != '') {
			$("#sido_cd").val(sido).change();
		}
		
	});
	
	$(function() {
		$('.formSelect').sSelect();
	});
	
	function board_save() {
		var s_sido = $("select[name=sido_cd]").val();
		var ttl = $('#title').val();
		
		oEditors.getById["cntn"].exec("UPDATE_CONTENTS_FIELD", []);
		
		var sn = $('#cntn').val();
		
		if(s_sido == "") {
			alert("열람가능지역을 선택하세요");
			return;
		} else if(ttl == "") {
			alert("제목을 입력하세요");
			return;
		} else if(sn == "") {
			alert("내용을 입력하세요");
			return;
		} else {
			if(confirm("저장하시겠습니까?")) {
				document.mainform2.action = "qna_update.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
				document.mainform2.submit();
			}
		}
	}
	
	function go_back() {
		document.mainform.action = "qna_info.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
		document.mainform.submit();
	}
	
	function add_new_row() {
		var rw = $("#file_tr_row").val();
		var cnt = $("#file_tr_cnt").val();
		rw = parseInt(rw, 0)+1;
		cnt = parseInt(cnt, 0)+1;
		/* console.log("rw : " + rw); */
		$("#file_tr_row").val(rw);
		$("#file_tr_cnt").val(cnt);
		
	    var tag = "";
	    tag +="<tr id=\"tr_id"+cnt+"\">";
	    tag +="<td><input type=\"file\" id=\"add_file"+cnt+"\" name=\"add_file"+cnt+"\" style=\"width:95%\" class=\"upload\"/></td>";
	    tag +="<td><div class=\"btn-table\" style=\"display:inline\"><a href=\"javascript:deleteRow("+cnt+")\" ><span style=\"min-width:40px\">삭제</span></a></div></td></tr>";
	  
	    $("#table_list").append(tag);
	}
	
	function deleteRow(rw) {
          //  var elementId = $rowToDel;
        $('#tr_id' + rw + '').closest('tr').remove();
        var rowCount = $('#table_list tbody tr').length;
          
        /* console.log("rowCount : " + rowCount); */
    }
	
	function tr_del(rw) {
        $('#tr_f_' + rw + '').closest('tr').remove();
        
        var sq = $('#del_seq').val();
        if(sq != "") {
        	sq = sq +"," + rw;
        } else {
        	sq = sq + rw;
        }
        $('#del_seq').val(sq);
    }
	
	
</script>
</head>
<body>

<div id="wrapper">

<form id="mainform" name="mainform" action="" method="post">
	<input type="hidden" id="q_seq" name="q_seq" value="${info.qna_seq }" />
	<jsp:include page="../main/topMenu.jsp"  />
</form>

<form id="mainform2" name="mainform2" method="post" enctype="multipart/form-data">
<input type="hidden" id="q_seq" name="q_seq" value="${info.qna_seq }" />
<input type="hidden" id="del_seq" name="del_seq" value="" />
<input type="hidden" id="file_tr_row" name="file_tr_row" value="1"/>
<input type="hidden" id="file_tr_cnt" name="file_tr_cnt" value="1"/>


	<div id="container" class="colum1">

		<div class="contents">

			<h2>Q&A 수정</h2>
			
			<div class="shadow-box" style="padding-top:20px">

			<table class="talbe-view">
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>지역</th>
						<td>
							<select class="formSelect" id="sido_cd" name="sido_cd" style="width:170px;" title="">
								<option value="00">전체</option>
								<c:forEach items="${s_list}" var="s">
									<c:choose>
										<c:when test="${srch.auth_no eq '1' }">
											<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
										</c:when>
										<c:otherwise>
											<c:if test="${s.sido_cd eq srch.user_sido_cd}">
												<option value="${s.sido_cd}">${s.sido_cd_nm}</option>
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" id="title" name="title" style="width:95%" value="${info.title }" title="제목"/></td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="padding-cell">
							<textarea id="cntn" name="cntn" rows="10" cols="100" style="width:766px; height:412px; display:none;">${info.cntn}</textarea>
						</td>
					</tr>
					<tr>
						<th>
							첨부파일
						</th>
						<td>
							<table class="talbe-view" id="table_org_list">
								<colgroup>
									<col style="width:90%" />
									<col style="width:10%" />
								</colgroup>
								<tbody>
									<c:forEach items="${f_list}" var="c" varStatus="status">
										<tr id="tr_f_${c.file_seq}">
											<td>
												<a href="javascript:;" class="attach-file">${c.org_file_nm}</a>
											 </td>
											 <td>
											 	<div class="btn-table" style="display:inline">
													<a href="javascript:tr_del('${c.file_seq}');" ><span style="min-width:40px">삭제</span></a>
												</div>
											 </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<th>
							<div class="btn-table" style="display:inline">
								<a href="javascript:add_new_row()" ><span style="min-width:40px">추가</span></a>
							</div>
						</th>
						<td>
							<table class="talbe-view" id="table_list">
								<colgroup>
									<col style="width:90%" />
									<col style="width:10%" />
								</colgroup>
								<tbody>
									<tr>	
										<td><input type="file" id="add_file1" name="add_file1" style="width:95%" class="upload" title="첨부파일"/></td>
										<td>
										</td>
									</tr>
								</tbody>
							</table>
						 </td>
					</tr>
				</tbody>
			</table>

			<div class="btn-block text-center mt20">
				<a href="javascript:board_save()" class="btn-blue"><span>저장</span></a>
				<a href="javascript:go_back()" class="btn-orange"><span>취소</span></a>
			</div>
			
		</div><!--// layer-content -->

		</div><!--// contents -->
	</div><!--// container -->
</form>
	</div><!--// wrapper -->
	
	<script type="text/javascript">
var oEditors = [];

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "cntn",
	sSkinURI: "common/SmartEditor2Skin.html",	
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		var paramCn = "<c:out value="${info.cntn}"/>";
	//	oEditors.getById["cntn"].exec("PASTE_HTML", [paramCn]);
	},
	fCreator: "createSEditor2"
});
</script>

</body>
</html>