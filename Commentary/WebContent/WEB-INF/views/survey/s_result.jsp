<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>survey_result</title>
<link rel="shortcut icon" type="image/png" href=""/>
<link rel="stylesheet" href="/surveySrc/css/style.css">
<link rel="stylesheet" href="/surveySrc/css/survey_style.css">
<link rel="stylesheet" href="/surveySrc/css/re_style.css">
<script type="text/javascript" src="/surveySrc/js/jquery-1.11.3.min.js"></script>
    <!-- alertify -->
<link rel="stylesheet" href="/surveySrc/css/alertify.css">
<!-- jquery UI -->
<script src="/surveySrc/js/jquery-ui.js"></script>
<link rel="stylesheet" href="/surveySrc/css/jquery-ui.css">
<!-- font-awesome -->
<link rel="stylesheet" href="/surveySrc/css/font-awesome.min.css">
<style type="text/css">
	fieldset#sending{
	    margin-bottom: 8em;
   		text-align: center;
	}
</style>
<script type="text/javascript">
$(function(){
	// 하단 버튼 선택시
	$("button[name=saveBtn]").on("click",function(){
		
		var $surveyUpdateKey = $("#surveyUpdateKey").val(); // 설문번호
		var $selId = $(this).attr("id"); // 하단버튼 id , 
		var $userId = $("#userId").val(); // userId
		var $qlLength = $("#qlLength").val(); // 문제 총 길이
		var $tempYn = ""; // 임시저장여부
		if($selId == "tempSave"){
			$tempYn = "Y";
		}else{
			$tempYn = "N";
		}
		
		//console.log("$selId  : " + $selId );
		//console.log("surveyUpdateKey  : " + $surveyUpdateKey );
		//console.log("userId  : " + $userId );
		//console.log("qlLength  : " + $qlLength );
		
		var aArray = []; // 답변리스트
		$(".article").each(function(i,e){
			//console.log("test : " + i);
			var hasClassChkFlag = $(this).hasClass("sa");
			//console.log("hasClassChkFlag : " + hasClassChkFlag);
			var qVal;
			if(hasClassChkFlag){ // 주관식일때
				qVal = $(this).find("input[type='text']").val();
			}else{ // 객관식일때
				qVal = $(this).find("input[type='radio']:checked").val();				
			}
			aArray.push(qVal);
		});
		//console.log("aArray : " + aArray);
		
		alertify
			  .okBtn("저장")
			  .cancelBtn("취소")
			  .confirm("저장하시겠습니까?", function (ev) {
				$.ajax({
					method:"POST",
					url:"/survey_result_save.ajax",
					data:{
						"surveyKey": $surveyUpdateKey,
						"tempYn": $tempYn,
						"userId": $userId,
						"aArray":aArray  
					}
				}).done(function(result){
					
					if(result=="error"){
						alertify.alert("저장에 실패했습니다.");												
					}else{
						if($selId == "tempSave"){ // 임시저장하기 선택시
							alertify.success("임시 저장하였습니다.");
						}else{ // 저장하기 선택시
							//$(location).prop("replace","survey_done.do");
							 location.replace("survey_done.do"); // 뒤로가기 비활성화시
						}	
					}
				});
		
    	  })//endAlertify
	});//endOnCLick
	
})//endDomReady
//alertify 예시
//alertify.alert("Message");
/* alertify.log("Standard log message");
alertify.success("Success log message");
alertify.error("Error log message"); */
</script>
</head>
<body>
	<input type="hidden" value="${qlLength}" id="qlLength">
	<input type="hidden" value="${userId}" id="userId">
    <div class="bg"></div>
    <div id="sr_header">
        <h1 id="logo">
            <img src="/surveySrc/img/logo.png" alt="logo" class="fl">
            <p class="fl">문화관광해설사<br/>
            인력관리 시스템</p>
        </h1>        
    </div>
    
    <c:if test="${sVo ne null}">
			<c:set value="${sVo.survey_title}" var="sTitle"></c:set>
			<c:set value="${sVo.start_dt}" var="sDt" ></c:set>
			<c:set value="${sVo.end_dt}" var="eDt" ></c:set>
			<input type="hidden" value="${sVo.survey_key}" id="surveyUpdateKey">
		</c:if>
    
    <div id="sr_contents">
        <p class="sr_data">
            설문기간 : ${sDt} 부터 ~ ${eDt}까지
        </p>
        <div id="sr_title">
            ${sTitle}
        </div>
        <div class="clear"></div>
            
        <c:if test="${qList ne null}">
        	<c:forEach items="${qList}" var="ql" varStatus="qlStat">
        		<c:choose>
            		<c:when test="${ql.multi_yn eq 'Y'}">
            			<c:set var="mqClassStat" value="mc"></c:set>	
            		</c:when>
            		<c:otherwise>
            			<c:set var="mqClassStat" value="sa"></c:set>
            		</c:otherwise>
            	</c:choose>
				<fieldset class="article q${ql.question_seq} ${mqClassStat}">
		            <div>
		                <p class="a_number ${mqClassStat}">${ql.question_seq}</p>
		                <p class="aq_text">${ql.question}</p>
		            </div>
		            <div class="clear">                
		                <c:choose>
		            		<c:when test="${ql.multi_yn eq 'Y'}">
		            			<ul class="s_radio">
		            				<c:forEach items="${mqList}" var="mql" varStatus="mqlStat" >
			            				<c:if test="${ql.question_seq eq mql.question_seq }">
							                    <li>
								                    <label>
								                    	<c:choose>
								                    		<c:when test="${ql.answer eq mql.multi_seq}">
								                    			<input type="radio" class="r_li" value="${mql.multi_seq}" name="QmUpNo${qlStat.index}" checked="checked">
								                    		</c:when>
								                    		<c:otherwise>
										                    	<input type="radio" class="r_li" value="${mql.multi_seq}" name="QmUpNo${qlStat.index}" >
								                    		</c:otherwise>
								                    	</c:choose>
								                    	<span class="rText">${mql.multi_question}</span>
								                    </label>
							                    </li>
			            				</c:if>
		            				</c:forEach>
				                </ul>
		            		</c:when>
		            		<c:otherwise>
		            			<input type="text" class="t_input" id="" name="q${ql.question_seq}" value="${ql.answer}" style="color:#6d6a6a;">
		            		</c:otherwise>
		            	</c:choose>
		            </div>            
		        </fieldset>        		
        	</c:forEach>
        </c:if>    
       </div>     
     
        <!-- 버튼 영역 -->
        <fieldset id="sending">
            <button type="button" name="saveBtn" id="tempSave">임시저장</button>
            <button type="button" name="saveBtn" id="save" class="save">저장하기</button>
        </fieldset>
        
        <!-- aelrt.js library -->
		<script src="/surveySrc/js/alertify.js"></script>
</body>
</html>


<!-- <fieldset class="article">
            <div>
                <p class="a_number">1</p>
                <p class="aq_text">관리 담당 지역은 어디입니까?</p>
            </div>
            <div class="clear">
                <input type="text" class="t_input">
            </div>            
        </fieldset>
        
        <fieldset class="article">
            <div>
                <p class="a_number">2</p>
                <p class="aq_text">관리하고 계신 해설 인력은 몇 명 입니까?</p>
            </div>
            <div class="clear">
                <ul class="s_radio">
                    <li>
                        <input type="radio" class="r_li" value="r_01"> 1~10명
                    </li>
                    <li>
                        <input type="radio" class="r_li" value="r_02"> 11~20명
                    </li>
                    <li>
                        <input type="radio" class="r_li" value="r_03"> 21~30명
                    </li>
                    <li>
                        <input type="radio" class="r_li"
                        value="r_04"> 31~40명
                    </li>
                    <li>
                        <input type="radio" class="r_li" value="r_05"> 41명 이상
                    </li>
                </ul>
            </div>            
        </fieldset> -->
        
