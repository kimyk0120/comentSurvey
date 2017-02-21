<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>survey_list</title>
<link rel="shortcut icon" type="image/png" href=""/>
<link rel="stylesheet" href="/surveySrc/css/style.css">
<link rel="stylesheet" href="/surveySrc/css/survey_style.css">
<script type="text/javascript" src="/surveySrc/js/jquery-1.11.3.min.js"></script>
<!-- alertify -->
<link rel="stylesheet" href="/surveySrc/css/alertify.css">
<!-- jquery UI -->
<script src="/surveySrc/js/jquery-ui.js"></script>
<link rel="stylesheet" href="/surveySrc/css/jquery-ui.css">
<!-- font-awesome -->
<link rel="stylesheet" href="/surveySrc/css/font-awesome.min.css">
<script type="text/javascript">
// alertify 예시
//alertify.alert("Message");
/* alertify.log("Standard log message");
alertify.success("Success log message");
alertify.error("Error log message"); */
$(function(){
	// init
	var sListLength = $("#sListLength").val(); // 리스트 개수
	//console.log("init sListLength : " + sListLength);
	
	// 질문생성 선택시 - 질문 작성 페이지로 이동
	$("#s_button").on("click",function(e){
		$(location).prop("href","survey_write.do");		
	});
	
	// 수정버튼 선택시 - 수정 페이지로 이동
	$("button[name=mod_ing]").on("click",function(e){
		var $surveyKey = $(this).parent().parent().prev("input[name=surveyKey]").val();  // 설문번호
		//console.log("$surveyKey : " + $surveyKey);
		alertify.okBtn("수정").cancelBtn("취소").confirm("수정하시겠습니까?", function () {
			$(location).attr("href","survey_mod.do?surveyKey="+$surveyKey);				
		}, function() {
		});
	});
	
	// 삭제버튼 선택시 
	$("button[name=deleteBtn]").on("click",function(e){
		e.preventDefault();
		var delEl = $(this).parent().parent();
		//alertify.alert("삭제실행");
		var $surveyKey = $(this).parent().parent().prev("input[name=surveyKey]").val();  // 설문번호
		//console.log("$surveyKey : " + $surveyKey);
		alertify.okBtn("삭제").cancelBtn("취소").confirm("삭제하시겠습니까?", function () {
			// css
			$(delEl).hide(function(){
				$(this).prev("input[name=surveyKey]").remove();
				$(this).remove();
			});
			// ajax
			$.ajax({
				method:"GET",
				data:{"surveyKey":$surveyKey},
				url:"/survey_delete.ajax",
				cache: false }).done(function(result){
					console.log(result);
					alertify.success("삭제되었습니다.");
					// null 화면 처리 css
					sListLength--; 
					//console.log("sListLength : " + sListLength);
					if(sListLength == 0){
						var str = "<p class='noDataMsg'>데이터가 없습니다.</p>";
						$("body").append(str);
					}
				}); 
		}, function() {});
	});
	
	// 결과저장버튼 선택시 
	$("button[name=saveBtn]").on("click",function(e){
		//alertify.alert("결과저장");
		var $surveyKey = $(this).parent().parent().prev("input[name=surveyKey]").val();  // 설문번호
		//console.log("$surveyKey : " + $surveyKey);
		alertify.okBtn("저장").cancelBtn("취소").confirm("결과를 저장하시겠습니까?", function () {
			
			// ajax
			
		}, function() {});
	});
	
})//endDomReady
</script>
</head>
<body>
	<input type="hidden" value="${sList.size()}" id="sListLength">
    <div id="s_head">
        설문조사
    </div>
    <div id="s_contents">
    <button type="button" id="s_button">
        질문생성
    </button>
    <div class="clearfix"></div>
    <table id="survey_table">
        <tr id="survey_title">
            <th>진행상태</th>
            <th>제목</th>
            <th>응답수</th>
            <th>수정일</th>
          <!--   <th>미리보기</th> -->
            <th>수정</th>
            <th>삭제</th>
            <th>결과저장</th>
        </tr>
        
        <!-- tr 단위 -->
        <c:forEach items="${sList}" var="sl" >
        	<c:choose>
        		<c:when test="${sl.proc_stat eq '진행중'}">
        			<c:set var="procStat" value="ing"></c:set>
        			<c:set var="modStat" value="2"></c:set>
        		</c:when>
        		<c:otherwise>
        			<c:set var="procStat" value="end"></c:set>
        			<c:set var="modStat" value="1"></c:set>
        		</c:otherwise>
        	</c:choose>
        	<input type="hidden" value="${sl.survey_key}" name="surveyKey">
	        <tr class="${procStat}">
	            <td class="situation">${sl.proc_stat}</td>
	            <td class="t_title"><p class="s_contents">${sl.survey_title}</p><p class="t_data">${sl.reg_dt_sv} 등록</p></td>
	            <td class="p_number">${sl.answer_cnt}</td>
	            <c:choose>
	        		<c:when test="${sl.mod_dt eq '' or sl.mod_dt eq null}">
	        			<c:set var="modDt" value="."></c:set>
	        		</c:when>
	        		<c:otherwise>
	        			<c:set var="modDt" value="${sl.mod_dt}"></c:set>
	        		</c:otherwise>
	        	</c:choose>
	            <td class="m_data">${modDt}</td>
	            <!-- <td class="preview">
	                <button type="button"><img src="/surveySrc/img/preview.png" alt="preview"></button>
	            </td> -->
	            <td class="modification">
	                <button type="button" name="mod_${procStat}"><img src="/surveySrc/img/modification_${modStat}.png" alt="modification"></button>
	            </td>
	            <td class="delete">
	                <button type="button" name="deleteBtn"><img src="/surveySrc/img/delete.png" alt="delete"></button>
	            </td>
	            <td class="save">
	                <button type="button" name="saveBtn"><img src="/surveySrc/img/download.png" alt="save"></button>
	            </td>
	        </tr>
        </c:forEach>
        <!-- end tr 단위 -->
    </table>
   </div>
   <c:if test="${empty sList}">
        	<p class="noDataMsg">데이터가 없습니다.</p>
   </c:if>
<!-- aelrt.js library -->
<script src="/surveySrc/js/alertify.js"></script>
</body>
</html>