<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" />
<title>교육계획 l 교육통합관리</title>
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
	});
	
	function file_down(nm, path) { 
		mainform2.fileName.value=nm;
		mainform2.filePath.value=path;
		document.mainform2.action = "edu_file_down.do";
		document.mainform2.submit();
		
	}
	
	function file_del(seq) {
		if( confirm("삭제 하시겠습니까?") ) {
			mainform.fileSeq.value=seq;
			document.mainform.action = "edu_file_del.do";
			document.mainform.submit();
		}
	}
	
	function board_save() {
		
		var prt = "<c:out value="${info.edu_proc_no}"/>";
		
		if( prt.substring(0, 2) == "TC") {
			var f1 =  mainform.fileName1.value;
			if( f1 == null || f1 == "") {
				alert("업로드 할 자료를 선택하세요.");
				return;
			} else if( confirm("저장 하시겠습니까?") ) {
				document.mainform.action = "edu_file_save.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
				document.mainform.submit();
			}
		} 
		if ( prt.substring(0, 2) == "TB") {
			var f1 =  mainform.fileName1.value;
			var f2 =  mainform.fileName2.value;
			var f3 =  mainform.fileName3.value;
			if( (f1 == null || f1 == "") && (f2 == null || f2 == "") && (f3 == null || f3 == "")  ) {
				alert("업로드 할 자료를 선택하세요.");
				return;
			} else if( confirm("저장 하시겠습니까?") ) {
				document.mainform.action = "edu_file_save.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
				document.mainform.submit();
			}
		}  
		if ( prt.substring(0, 2) == "TA") {
			var f4 =  mainform.fileName4.value;
			var f5 =  mainform.fileName5.value;
			var f6 =  mainform.fileName6.value;
			if( (f4 == null || f4 == "") && (f5 == null || f5 == "") && (f6 == null || f6 == "")  ) {
				alert("업로드 할 자료를 선택하세요.");
				return;
			} else if( confirm("저장 하시겠습니까?") ) {
				document.mainform.action = "edu_file_save.do?top="+<%=request.getParameter("top") %>+"&left="+<%=request.getParameter("left") %>;
				document.mainform.submit();
			}
		}
		
		/* 
		if( confirm("저장 하시겠습니까?") ) {
			document.mainform.action = "edu_file_save.do";
			document.mainform.submit();
		} */
	}
	
	function edu_edit() {
			document.mainform2.target = "_self";
			document.mainform2.action = "edu_edit.do";
			document.mainform2.submit();
	}
	function edu_schd_edit() {
			document.mainform2.target = "_self";
			document.mainform2.action = "edu_schd_info.do";
			document.mainform2.submit();
	}
	function edu_list() {
		
		var l = <%=request.getParameter("left") %>;
		
		document.mainform2.target = "_self";
		
		if(l == "4") {
			document.mainform2.action = "edu_list.do";	
			document.mainform2.submit();
		}
		else {
			document.mainform2.action = "edu_plan_list.do";	
			document.mainform2.submit();
		}
		
	}
	
	function edu_confirm() {
		if(confirm("교육승인처리하시겠습니까?")) {
			document.mainform2.target = "_self";
			document.mainform2.action = "edu_confirm.do";
			document.mainform2.submit();
		}
	}
	
	function edu_delete() {
		if(confirm("삭제하시겠습니까?")) {
			if(confirm("해당 강의 수강생도 삭제 됩니다. 삭제하시겠습니까?")) {
				document.mainform2.target = "_self";
				document.mainform2.action = "edu_delete.do";
				document.mainform2.submit();
			}
		}
	}
	
	/* function readURL(input) {
		var nm = "";
		var nm2 = "";
		var inp = document.getElementById('fileName1');
		for (var i = 0; i < inp.files.length; ++i) {
		  nm = inp.files.item(i).name;
		  nm2 = ","+ nm;
		}
		alert("nm : " + nm);
		
		document.getElementById("fileList").innerHTML=name;
	}  */
	
	
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
	    min-height:15px;
	    background:#00bcae;
	    border-radius:5px;
	    margin:5px 1px;
	}

</style> -->

</head>
<body>
<div id="wrapper">

	<jsp:include page="../main/topMenu.jsp"  />

	<div id="container">

		<jsp:include page="../main/leftMenu.jsp"  />

		<div class="contents">

			<div class="contents-top">
				<h2 class="mb0">교육 상세</h2>
					<c:if test="${info.user_auth eq '001' and info.appr_yn eq 'N' }">
						<div class="btn-block">
							<a href="javascript:edu_confirm()"><span>교육 승인</span></a>
						</div>
					</c:if>
					<c:if test="${info.user_auth eq '001' and info.appr_yn eq 'Y' }">
						<div class="btn-block">
							<a href="javascript:edu_delete()" class="btn-negative"><span>교육 삭제</span></a>
						</div>
					</c:if>
				<h3 class="mb0">${info.lecture_nm } / ${info.edu_inst_nm }</h3>
			</div>
<form id="mainform2" name="mainform2" method="post">
<input type="hidden" id="edu_proc_seq" name="edu_proc_seq" value="${info.edu_proc_seq}" />
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
<input type="hidden" id="fileName" name="fileName" />
<input type="hidden" id="filePath" name="filePath" />
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
</form>
<form id="mainform" name="mainform" method="post" enctype="multipart/form-data">
<input type="hidden" name="edu_proc_seq" value="${info.edu_proc_seq}" />
<input type="hidden" name="e_seq" value="${info.edu_proc_seq}" />
<input type="hidden" id="fileSeq" name="fileSeq" value="" />
<input type="hidden" id="page" name="page" value="${srch.page}"/>
<input type="hidden" id="top" name="top" value="<%=request.getParameter("top") %>"/>
<input type="hidden" id="left" name="left"  value="<%=request.getParameter("left") %>"/>
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
						<td colspan="3">${info.lecture_nm }</td>
					</tr>
					<tr>
						<th>교육기관명</th>
						<td colspan="3">${info.edu_inst_nm }</td>
					</tr>
					<tr>
						<th>지점명</th>
						<td colspan="3">${info.branch_name }</td>
					</tr>
					<tr>
						<th>강사명</th>
						<td colspan="3">${info.teacher_nm }</td>
					</tr>
					<tr>
						<th>강의시작일</th>
						<td>${info.start_dt }</td>
						<th>강의종료일</th>
						<td>${info.end_dt }</td>
					</tr>
					<tr>
						<th>수강료</th>
						<td><fmt:formatNumber value="${info.tuition}" pattern="#,###"/>원</td>
						<th>
							<c:choose>
								<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TD'}">수납1급 
								</c:when>
								<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TE'}">수납1급 
								</c:when>
								<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TF'}">수납2급 
								</c:when>
								<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TI'}">수납1급 
								</c:when>
							</c:choose>
							검정료
						</th>
						<td><fmt:formatNumber value="${info.exam_fee}" pattern="#,###"/>원</td>
					</tr>
					<c:choose>
						<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TD'}"> 
							<tr>
								<th>수납2급 검정료</th>
								<td colspan="3"><fmt:formatNumber value="${info.exam_fee2}" pattern="#,###"/>원</td>
							</tr>
						</c:when>
						<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TE'}">
							<tr>
								<th>수납2급 검정료</th>
								<td><fmt:formatNumber value="${info.exam_fee2}" pattern="#,###"/>원</td>
								<th>가정2급 검정료</th>
								<td><fmt:formatNumber value="${info.exam_fee3}" pattern="#,###"/>원</td>
							</tr> 
						</c:when>
						<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TF'}">
							<tr>
								<th>가정2급 검정료</th>
								<td colspan="3"><fmt:formatNumber value="${info.exam_fee2}" pattern="#,###"/>원</td>
							</tr> 
						</c:when>
						<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TI'}">
							<tr>
								<th>코칭 검정료</th>
								<td colspan="3"><fmt:formatNumber value="${info.exam_fee2}" pattern="#,###"/>원</td>
							</tr> 
						</c:when>
					</c:choose>
					<tr>
						<th>총강의시간</th>
						<td>${info.tot_edu_proc_time }</td>
						<th>총회차</th>
						<td>${info.tot_degr }</td>
					</tr>
					<tr>
						<th>정원(수강생)</th>
						<td>${info.max_stdt_cnt }</td>
						<th>교육장소</th>
						<td>${info.edu_place }</td>
					</tr>
					<tr>
						<th>교재비</th>
						<td><fmt:formatNumber value="${info.edu_book_fee}" pattern="#,###"/>원</td>
						<th>재료비</th>
						<td><fmt:formatNumber value="${info.mtrl_fee}" pattern="#,###"/>원</td>
					</tr>
					<c:choose>
						<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TA'}">
							<tr>
								<th>기수</th>
								<td>${info.class_level }</td>
								<th>1/2급 구분</th>
								<td>${info.teacher_prt }</td>
							</tr>
						</c:when>
						<c:when test="${fn:substring(info.edu_proc_no,0,2) eq 'TB'}">
							<tr>
								<th>기수</th>
								<td colspan="3">${info.class_level}</td>
							</tr>
						</c:when>
					</c:choose>
					<tr>
						<th>비고</th>
						<td colspan="3"  class="padding-cell" style="height:50px">${info.bigo}</td>
					</tr>
					<tr>
						<td colspan="4">
						</td>
					</tr>
					<tr>
						<th colspan="4" class="pos-relative">파일 올리기<span class="btn-table green"><a href="javascript:board_save()"><span>저장</span></a></span></th>
					</tr>
				<c:if test="${fn:substring(info.edu_proc_no,0,2) eq 'TC'}">
					<tr>
						<th>실습일지</th>
						<td colspan="3">
							<!--  
							<label class="custom-file-upload"> 
								<input type="file" id="fileName1" name="fileName1" multiple="multiple" style="width:300px" onchange="readURL(this)" class="upload"/> file
							</label>
							<!-- <div id="fileList" style="display:none"> -->
							<div class="multi-upload">
								<input type="file" name="fileName1" multiple="multiple" style="width:300px" class="upload"/>
							</div>
							<ul class="multi-file">
								<c:forEach items="${f_list}" var="f"> 
									<c:if test="${f.file_prt eq '1' }">
											<li><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')" class="attach-file">${f.file_org_nm}</a>
											<a href="javascript:file_del('${f.file_seq}')"><span class="btn-del" title="삭제"></span></a>
											</li>
										<%-- <tr>
											<td align="center"><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')">${f.file_org_nm}</a></td>
											<td align="center"><input type="submit" value="삭제" onclick="javascript:file_del('${f.file_seq}')" /></td>
										</tr> --%>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</c:if>
				<c:if test="${fn:substring(info.edu_proc_no,0,2) eq 'TB'}">
					<tr>
						<th>실습일지</th>
						<td colspan="3">
							<div class="multi-upload">
								<input type="file" name="fileName1" multiple="multiple" style="width:300px" class="upload"/>
							</div>
							<ul class="multi-file">
								<c:forEach items="${f_list}" var="f"> 
									<c:if test="${f.file_prt eq '1' }">
										<li><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')" class="attach-file">${f.file_org_nm}</a>
										<a href="javascript:file_del('${f.file_seq}')"><span class="btn-del" title="삭제"></span></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
					<tr>
						<th>실기자료</th>
						<td colspan="3">
							<div class="multi-upload">
								<input type="file" name="fileName2" multiple="multiple" style="width:300px" class="upload"/>
							</div>
							<ul class="multi-file">
								<c:forEach items="${f_list}" var="f"> 
									<c:if test="${f.file_prt eq '2' }">
										<li><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')" class="attach-file">${f.file_org_nm}</a>
										<a href="javascript:file_del('${f.file_seq}')"><span class="btn-del" title="삭제"></span></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
					<tr>
						<th>실습평가자료</th>
						<td colspan="3">
							<div class="multi-upload">
								<input type="file" name="fileName3" multiple="multiple" style="width:300px" class="upload"/>
							</div>
							<ul class="multi-file">
								<c:forEach items="${f_list}" var="f"> 
									<c:if test="${f.file_prt eq '3' }">
										<li><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')" class="attach-file">${f.file_org_nm}</a>
										<a href="javascript:file_del('${f.file_seq}')"><span class="btn-del" title="삭제"></span></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</c:if>
				<c:if test="${fn:substring(info.edu_proc_no,0,2) eq 'TA'}">
					<tr>
						<th>멘토링자료</th>
						<td colspan="3">
							<div class="multi-upload">
								<input type="file" name="fileName4" multiple="multiple" style="width:300px" class="upload"/>
							</div>
							<ul class="multi-file">
								<c:forEach items="${f_list}" var="f"> 
									<c:if test="${f.file_prt eq '4' }">
										<li><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')" class="attach-file">${f.file_org_nm}</a>
										<a href="javascript:file_del('${f.file_seq}')"><span class="btn-del" title="삭제"></span></a></li>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
					<tr>
						<th>청강자료</th>
						<td colspan="3">
							<div class="multi-upload">
								<input type="file" name="fileName5" multiple="multiple" style="width:300px" class="upload"/>
							</div>
							<ul class="multi-file">
								<c:forEach items="${f_list}" var="f">
									<c:if test="${f.file_prt eq '5' }">
										<li><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')" class="attach-file">${c.file_org_nm}</a>
										<a href="javascript:file_del('${f.file_seq}')" ><span class="btn-del" title="삭제"></span></a></li>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
					<tr>
						<th>강의평가자료</th>
						<td colspan="3">
							<div class="multi-upload">
								<input type="file" name="fileName6" multiple="multiple" style="width:300px" class="upload"/>
							</div>
							<ul class="multi-file">
								<c:forEach items="${f_list}" var="f"> 
									<c:if test="${f.file_prt eq '6' }">
										<li><a href="javascript:file_down('${f.file_org_nm}','${f.file_path}')" class="attach-file">${f.file_org_nm}</a>
										<a href="javascript:file_del('${f.file_seq}')" ><span class="btn-del" title="삭제"></span></a></li>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</c:if>
					<tr>
						<td colspan="4">
						</td>
					</tr>
					<tr>
						<td colspan="4" class="inner">
							<!--  inner table -->
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
										<tr>
											<td> ${c.edu_date }</td>
											<td> ${c.degr }</td>
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
										</tr>
									</c:forEach>
									<c:if test="${fn:length(list) == 0 }">
										<tr>
											<td colspan="7">검색 결과가 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
							<!-- // inner table -->
						</td>
					</tr>
				</tbody>
			</table>			
</form>
			<div class="btn-block">
				<a href="javascript:edu_edit()"><span>교육내용 수정</span></a>
				<a href="javascript:edu_schd_edit()"><span>교육일정 수정</span></a>
				<a href="javascript:edu_list()"><span>리스트</span></a>
			</div><!--// btn-block -->
			

		</div><!--// contents -->
	</div><!--// container -->
</div>


</body>

</html>