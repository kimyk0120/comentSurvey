<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>survey_write</title>
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
$(function(){
	
	//init
	$("#start_s,#end_s").datepicker({
	    dateFormat: 'yy-mm-dd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    dayNames: ['일','월','화','수','목','금','토'],
	    dayNamesShort: ['일','월','화','수','목','금','토'],
	    dayNamesMin: ['일','월','화','수','목','금','토'],
	    showMonthAfterYear: true,
	    changeMonth: true,
	    changeYear: true
	});
	var qlLength = $("#qlLength").val(); // 수정시 설문 리스트 개수 
	var Qnum = 1; // 생성되는 문제 시작 번호
	if(!!qlLength){
		Qnum = parseInt(qlLength) + 1;
		//console.log("Qnum : " + Qnum);
	}
	var QmNum = 1; // 생성되는 객관식 라디오 name 증가값
	
	// 하단 버튼 선택시 (임시저장 , 저장하기)  , *설문대상과 발송방법은 하나라도 체크되어야함
	$("button[name=saveBtn]").on("click",function(){
		
		var $selElId = $(this).attr("id");
		/* console.log("$selElId: "+ $selElId); */
		var $rTitle = $("#rTitle").val(); // 설문제목
		var $stDate = $("input[id=start_s]").val(); // 시작일  format yyyy-mm-dd
		var $endDate = $("input[id=end_s]").val();  // 종료일  format yyyy-mm-dd
		var $surveyTarget1 = $("input[name=surveyTarget_1]:checked").val(); // 설문대상 - 지자체 
		var $surveyTarget2 = $("input[name=surveyTarget_2]:checked").val(); // 설문대상 - 해설사
		var $surveyMethod1 = $("input[name=surveyMethod_1]:checked").val(); // 설문방법 - 문자 
		var $surveyMethod2 = $("input[name=surveyMethod_2]:checked").val(); // 설문방법 - 이메일
		var $aLength = $(".a_number").length; // 질문 등록 개수 - 질문등록여부
		var $surveyUpdateKey = $("#surveyUpdateKey").val(); // 수정시 설문번호 
		var parseStartDt = parseInt($stDate.replace(/\-/g,''));
		var parseEndtDt = parseInt($endDate.replace(/\-/g,''));
		/* console.log("$surveyMethod1 : " + $surveyMethod1);
		console.log("$surveyMethod2 : " + $surveyMethod2); */
		if(!$rTitle){
			alertMsg("설문 제목을 입력해주세요."); 
			$("#rTitle").focus();
			return false;
		}else if($stDate == "" || $stDate ==null){
			alertMsg("시작일을 선택해주세요."); 
			$("input[id=start_s]").focus();
			return false;
		}else if($endDate == "" || $endDate == null){
			alertMsg("종료일을 선택해주세요"); 
			$("input[id=end_s]").focus();
			return false;
		}else if(parseStartDt>parseEndtDt){
			alertMsg("설정 기간이 올바르지 않습니다.");
			$("input[id=start_s]").focus();
			return false;
		}else if(!$surveyTarget1 && !$surveyTarget2){
			alertMsg("설문 대상을 선택해주세요.");
			//$("input[name=surveyTarget_1]").focus();
			return false;
		}else if(!$surveyMethod1 && !$surveyMethod2){
			alertMsg("발송 방법을 선택해주세요.");
			//$("input[name=surveyMethod_1]").focus();
			return false;
		}else if($aLength<=0){
			alertMsg("질문을 1개 이상 등록해주세요.");
			//$("input[name=surveyMethod_1]").focus();
			return false;
		}else{
			
			// 설문대상  A:전체 B:지자체 C:해설사
			var surveyTarget = "";
			if(!!$surveyTarget1 && !!$surveyTarget2){
				surveyTarget ="A";
			}else if(!!$surveyTarget1){
				surveyTarget="B";
			}else{
				surveyTarget="C";
			}
			
			// 발송방법 : 문자, 이메일 , 둘다
			var sendMethod = "";
			if(!!$surveyMethod1 && !!$surveyMethod2){
				sendMethod ="both";
			}else if(!!$surveyMethod1){
				sendMethod="textMassage";
			}else{
				sendMethod="email";
			}
			
			// 문제 데이터 
			var qArray = [];
			$(".a_number").each(function(i,e){
				var aArray = []; // 답변 리스트
				var qType = "1"; // 문제 타입 , 1: 주관식 , 2:객관식
				var qNum =  $(this).text(); // 문제번호			
				var qText =  $(this).next().text(); // 문제
				var liEl = $(this).parent().next().find("ul").find("li"); // 객관식 하위 답변 element
				var saOrMcFlag = $(this).hasClass("mc"); // 주관식 또는 객관식 여부 , true : 객관식 , flase :주관식
				console.log("saOrMcFlag : " + saOrMcFlag);
				//console.log("qNum : " + qNum);
				//console.log("qText : " + qText);
				var qDt = {};
				qDt.qNo = qNum; 			
				qDt.qType = qType;
				qDt.qText = qText;
				// 객관식일때			
				if(saOrMcFlag){
					qDt.qType = "2";
					//console.log("liEl.length : " + liEl.length);
	 				for(var i=1;i<liEl.length+1;i++){
						var qSubDt = {};
						var subText = $(this).parent().next().find("ul").find("li:nth-child("+i+")").find("span").text(); // 객관식 하위 답변 string
						qSubDt.answerNo = i;
						qSubDt.answerText = subText; 
						aArray.push(qSubDt);
					}
	 				/* str = JSON.stringify(aArray);
	 				console.log("str : " + str); */
	 				qDt.answerList = aArray; 
				}
				qArray.push(qDt); 
			}); // endForEach
			
			var str = JSON.stringify(qArray); // 문제데이터
			//console.log("str : " + str);			
			str = "{'qList':"+str+"}";	// json 형식 
			
			var tempSaveYn = ""; // 임시저장여부
			var updateYn = "N"; // 수정 인지 여부
			if($selElId=="temp"){ // 임시저장일때
				tempSaveYn = "Y";
			}else if($selElId=="save"){ // 저장하기 선택시 - 발송까지 완료 후 리스트에서 수정 및 삭제 안되게
				tempSaveYn = "N";
			}else if($selElId=="update"){
				updateYn = "Y";
				tempSaveYn = "Y";
			}
			alertify
			  .okBtn("저장")
			  .cancelBtn("취소")
			  .confirm("저장하시겠습니까?", function (ev) {
			        ev.preventDefault();
					$.ajax({
						  method: 'POST',
						  url: "survey_save.ajax", 
						  data: {
								  'tempSaveYn':tempSaveYn,
								  'updateYn':updateYn,
								  'surveyTitle':$rTitle,
								  'qArray':str,
								  'sDate':$stDate, // 시작일
								  'eDate':$endDate, // 종료일
								  'surveyTarget':surveyTarget,
								  'sendMethod':sendMethod,
								  'surveyUpdateKey':$surveyUpdateKey //수정시 설문번호
							  },
						  cache: false	  
					}).done(function(surveyKey){
						//console.log("surveyKey : " + surveyKey);
						if(tempSaveYn!="Y"){ // 저장하기 선택시
							//console.log("저장하기 선택됨");
							//발송처리
							$.ajax({
								method:"GET",
								url:"send_survey.ajax",
								data:{"surveyKey":surveyKey}
							}).done(function(result){
								// 리스트로 이동
								//$(location).attr("href","survey_list.do");								
							});
						}else if(tempSaveYn=="Y"){ // 임시저장하기 선택시 
							// 리스트로 이동
							$(location).attr("href","survey_list.do");
						}
					});	
			  }, function(ev) {
			      ev.preventDefault();
				  return false;
			  });
		}  
	}); //..하단버튼선택End
	
	var ObOrSubFlag=false; // 객관식, 주관식 여부 판단 flag , true :객관식, false:주관식
	
	//객관식 버튼 선택시 css
	$(".objective.close.sort_bt").on("click",function(){
		//alert("객관식 버튼 선택");
		var hasClassFlag = $(this).hasClass("close");
		//console.log("hasClassFlag : " + hasClassFlag);
		ObOrSubFlag = true;
		
		// 버튼 css 변경 토글 
		if(hasClassFlag){ 
			$(this).attr("class","objective open sort_bt"); // 객관식 글씨 활성
			$(this).find("p").attr("class","o_open"); // 객관식 이미지 활성
			$(this).next().attr("class","subjective close sort_bt"); // 주관식 글씨 비활성
			$(this).next().find("p").attr("class","s_close"); //주관식 이미지 비활성
			$(this).parent().next().show(); // 객관식 히든 영역 노출
		}
	});
	
	//주관식 버튼 선택시 css
	$(".subjective.open.sort_bt").on("click",function(){
		var hasClassFlag = $(this).hasClass("close");
		//console.log("hasClassFlag : " + hasClassFlag);
		ObOrSubFlag = false;
		
		// 버튼 css 변경 토글 
		if(hasClassFlag){ 
			$(this).attr("class","subjective open sort_bt"); // 주관식 글씨 활성
			$(this).find("p").attr("class","s_open"); // 주관식 이미지 활성
			$(this).prev().attr("class","objective close sort_bt"); // 객관식 글씨 비활성
			$(this).prev().find("p").attr("class","o_close"); // 객관식 이미지 비활성
			$(this).parent().next().hide(); // 객관식 히든 영역 숨김
		}
	});
	
	// 객관식 영역에서 항목 삭제버튼 선택시 css
	$(document).on("click",".r_delete",function(){
		$(this).parent().remove();		
	});
	
	// 객관식 영역에서 항목 추가버튼 선택시 css
	$(".r_add").on("click",function(){
		var liStr="";
		liStr += "<li>";
		liStr +=	"<input type='radio' class='m_radio' value='' name='r_rardio'>"; 
		liStr +=	"<input type='text'  class='tm_input' placeholder='객관식 답변을 입력해주세요(선택)'>";
		liStr +=	"<button type='button' class='r_delete'></button>";
		liStr += "</li>";
		$(this).parent().before(liStr);
	});
	
	// 문제 추가 버튼 선택시
	$("#wAdd").on("click",function(){
		var $rTopVal = $("#r_topQ").val(); // 작성 질문
		//console.log("ObOrSubFlag :  " + ObOrSubFlag); // 객관식, 주관식 여부 판단 flag , true :객관식, false:주관식
		if($rTopVal == "" || $rTopVal == null){ // 질문이 입력 안되었을때
				alertMsg("질문을 입력해주세요"); 
				$(this).focus();
				return false;
		}
		
		if(ObOrSubFlag){ // 객관식일 때
			//console.log("객관식 선택");
			var leng = $("input[name=r_rardio]").length 
			//console.log("leng : " + leng);
			var rArray = [];
			$("input[name=r_rardio]").each(function(){
				var obResult = $(this).next().val();
				//console.log("obResult : " + obResult);
				if(obResult == "" || obResult == null){
					alertMsg("객관식 답변을 모두 입력해주세요"); 
					return false;
				}else{
					rArray.push(obResult);
				}
			});
			/* console.log("rArray.length : " + rArray.length);
			console.log("leng : " + leng);
			console.log("rArray : " + rArray); */
			if(rArray.length == leng){
				var qStr="";
				qStr+="<fieldset class='article'>"
				qStr+=    "<div>";
				qStr+=        "<p class='a_number mc'>"+Qnum+"</p>"
				qStr+=        "<p class='aq_text'>"+$rTopVal+"</p>";
				qStr+=        "<button class='b_del'></button>";
				qStr+=    "</div>";
				qStr+=    "<div class='clear'>";                
				qStr+=        "<ul class='s_radio'>";
				for(var i=0;i<rArray.length;i++){
					qStr+= "<li><label><input type='radio' class='r_li' value='' name='QmNum"+QmNum+"'><span class='rText'>"+rArray[i]+"</span></label></li>";
				}			
				qStr+=        "</ul>";
				qStr+=    "</div>";            
				qStr+="</fieldset>"; 
				$(".m_article.mb2").before(qStr);
				Qnum++; 
				QmNum++;
				// 항목 초기화
				setDefault();
				alertify.success("질문이 생성되었습니다.");
			}
		}else{ // 주관식일 때
			//console.log("주관식 선택");
			//console.log("$rTopVal : " + $rTopVal);
			//alert("질문은? : " + $rTopVal);
			var qStr="";
			qStr+="<fieldset class='article'>";
			qStr+=    "<div>";
			qStr+=        "<p class='a_number sa'>"+Qnum+"</p>"
			qStr+=        "<p class='aq_text'>"+$rTopVal+"</p>";
			qStr+=        "<button class='b_del'></button>";
			qStr+=    "</div>";
			qStr+=    "<div class='clear'>";                
			qStr+=        "<input type='text' class='t_input' id=''>";
			qStr+=    "</div>";            
			qStr+="</fieldset>";
			$(".m_article.mb2").before(qStr);
			Qnum++;
			// 항목 초기화
			setDefault();
			alertify.success("질문이 생성되었습니다.");
		}
		
	});// .문제추가버튼선택
	
	// 추가된 문제에서 우측 삭제버튼 선택시 - 선택 항목 삭제
	$(document).on("click",".b_del",function(){
		$(this).parent().parent().remove();
		Qnum--;
		/* var pLeng = $("p.a_number").length;
		console.log("pLeng : " + pLeng); */
		// 삭제후에 문제번호 재배열
		$("p.a_number").each(function(index,element){
			$(this).text(index+1);
		});
		alertify.log("질문이 삭제되었습니다.");
	});
	
	// 문제 항목 초기화 func
	function setDefault(){
		$("#r_topQ").val("");
		$("input[name=r_rardio]").each(function(index,element){
			$(this).next().val("");
		});		
	}
	
	// 미선택시 알럿메세지 func
	function alertMsg(str){
		alertify.alert(str);
		alertify.error(str); 
	}
	function getActualFullDate() {
	    var d = new Date();
	    var day = addZero(d.getDate());
	    var month = addZero(d.getMonth()+1);
	    var year = addZero(d.getFullYear());
	    var h = addZero(d.getHours());
	    var m = addZero(d.getMinutes());
	    var s = addZero(d.getSeconds());
	    return year + ". " + month + ". " + day + " (" + h + ":" + m + ")";
	}
	function addZero(i) {
	    if (i < 10) {
	        i = "0" + i;
	    }
	    return i;
	}
	// alertify 예시
	//alertify.alert("Message");
	/* alertify.log("Standard log message");
	alertify.success("Success log message");
	alertify.error("Error log message"); */
})// endDomReady
</script>
</head>
<body>
	<input type="hidden" value="${qlLength}" id="qlLength">
    <div id="s_head">
        설문조사
    </div>
    <div id="sw_data">&nbsp;</div>  <!-- 임시저장 표시 공간 -->
    <div id="sw_title">
        <!-- 해설 인력 관리 실태 설문 조사 -->
		<c:if test="${sVo ne null}">
			<c:set value="${sVo.survey_title}" var="sTitle"></c:set>
			<c:set value="${sVo.start_dt}" var="sDt" ></c:set>
			<c:set value="${sVo.end_dt}" var="eDt" ></c:set>
			<input type="hidden" value="${sVo.survey_key}" id="surveyUpdateKey">
		</c:if>
        <input type="text" class="qw" placeholder="제목을 입력해주세요." id="rTitle" value="${sTitle}">
    </div>
    <form action="#" id="survey_write">
        <fieldset class="basic_s">
            <ul>
                <li id="se_date">
                    <label for="start_s" class="mr15">시작일<input type="text" id="start_s" placeholder="연도 - 월 - 일" value="${sDt}">
                    <i class="fa fa-calendar" aria-hidden="true"></i>
                    </label>
                    ~
                    <label for="end_s">종료일<input type="text" id="end_s"placeholder="연도 - 월 - 일" value="${eDt}">
                    <i class="fa fa-calendar" aria-hidden="true"></i>
                    </label>
                </li>
                <li id="sort_s">
                    <span>설문대상</span>
               	    <label><input type="checkbox" value="group" name="surveyTarget_1" 
               	  	 	${(sVo ne null and sVo.survey_target eq 'B') or (sVo ne null and sVo.survey_target eq 'A' )?'checked':''}>지자체</label>
                    <label><input type="checkbox" value="commentator" name="surveyTarget_2" 
                   		${(sVo ne null and sVo.survey_target eq 'C') or (sVo ne null and sVo.survey_target eq 'A' )?'checked':''}>해설사</label>
                </li>
                <li id="sort_s">
                    <span>발송방법</span>
                   	<label><input type="checkbox" value="textMassage" name="surveyMethod_1" 
                   		${(sVo ne null and sVo.send_method eq 'textMassage') or (sVo ne null and sVo.send_method eq 'both' )?'checked':''}>문자</label>
                   	<label><input type="checkbox" value="email" name="surveyMethod_2" 
                   		${(sVo ne null and sVo.send_method eq 'email') or (sVo ne null and sVo.send_method eq 'both' )?'checked':''}>이메일</label>
                </li>
            </ul>           
        </fieldset>
        
        <!-- 수정 시 문제정보 -->
        <c:if test="${qList ne null}">
        	<c:forEach items="${qList}" var="ql" varStatus="qlStat">
				<fieldset class="article">
		            <div>
		            	<c:choose>
		            		<c:when test="${ql.multi_yn eq 'Y'}">
		            			<c:set var="mqClassStat" value="mc"></c:set>	
		            		</c:when>
		            		<c:otherwise>
		            			<c:set var="mqClassStat" value="sa"></c:set>
		            		</c:otherwise>
		            	</c:choose>
		                <p class="a_number ${mqClassStat}">${ql.question_seq}</p>
		                <p class="aq_text">${ql.question}</p>
		                <button class="b_del"></button>
		            </div>
		            <div class="clear">                
		                <c:choose>
		            		<c:when test="${ql.multi_yn eq 'Y'}">
		            			<ul class="s_radio">
		            				<c:forEach items="${mqList}" var="mql" varStatus="mqlStat" >
			            				<c:if test="${ql.question_seq eq mql.question_seq }">
							                    <li>
								                    <label>
								                    	<input type="radio" class="r_li" value="" name="QmUpNo${qlStat.index}">
								                    	<span class="rText">${mql.multi_question}</span>
								                    </label>
							                    </li>
			            				</c:if>
		            				</c:forEach>
				                </ul>
		            		</c:when>
		            		<c:otherwise>
		            			<input type="text" class="t_input" id="chargeLocText">
		            		</c:otherwise>
		            	</c:choose>
		            </div>            
		        </fieldset>        		
        	</c:forEach>
        </c:if>
        
        
        <!-- 1번 예시 -->
        <!-- <fieldset class="article">
            <div>
                <p class="a_number sa">1</p>
                <p class="aq_text">관리 담당 지역은 어디입니까?</p>
                <button class="b_del"></button>
            </div>
            <div class="clear">                
                <input type="text" class="t_input" id="chargeLocText">
            </div>            
        </fieldset>  -->
        <!-- .1번 -->
        
        <!-- 2번 예시 -->
       <!-- <fieldset class="article">
            <div>
                <p class="a_number mc">2</p>
                <p class="aq_text">관리하고 계신 해설 인력은 몇 명 입니까?</p>
                <button class="b_del"></button>
            </div>
            <div class="clear">                
                <ul class="s_radio">
                    <li>
                        <label><input type="radio" class="r_li" value="r_01" name=""> <span>1~10명</span></label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_02" name=""> 11~20명</label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_03" name=""> 21~30명</label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_04" name=""> 31~40명</label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_05" name=""> 41명 이상</label>
                    </li>
                </ul>
            </div>            
        </fieldset>  -->
        <!-- .2번 -->
        
        <!-- 질문 작성 영역 -->
        <fieldset class="m_article mb2">
            <div>
                <p class="am_number"></p>
                <input type="text" class="qw" placeholder="질문을 입력해주세요." id="r_topQ">
            </div>
            <div class="clear">                
                <div class="sort">
                    <p>설문 유형을 선택해주세요.</p>
                    <div class="clear"></div>
                    <button type="button" class="objective close sort_bt">
                        <p class="o_close"></p> 객관식 (단일) 
                    </button>
                    <button type="button" class="subjective open sort_bt">
                        <p class="s_open"></p> 주관식 (단일) 
                    </button>
                </div>
                
                <!-- 객관식영역 -->
                 <div class="addObDiv" style="display: none;">
	                <div class="clear"></div>
	                <ul class="w_radio">
	                    <li>
	                        <input type="radio" class="m_radio" value="" name="r_rardio"> 
	                        <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(필수)" required>
	                    </li>
	                    <li>
	                        <input type="radio" class="m_radio" value="" name="r_rardio"> 
	                        <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(필수)" required>
	                    </li>
	                    <li>
	                        <input type="radio" class="m_radio" value="" name="r_rardio"> 
	                        <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(선택)">
	                        <button type="button" class="r_delete"></button>
	                    </li>
	                    <li>
	                        <input type="radio" class="m_radio" value="" name="r_rardio"> 
	                        <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(선택)">
	                        <button type="button" class="r_delete"></button>
	                    </li>
						
	                    <li class="pl220">
	                        <button type="button" class="r_add"></button>
	                    </li> 
	                </ul>
	                
                </div>
            </div>
            <div class="clear"></div>
        </fieldset>
        
        <!-- 문제추가버튼 -->
        <button type="button" class="w_add" name="addQBtn" id="wAdd"></button>
        
        <!-- 버튼 영역 -->
        <fieldset id="sending">
			<c:choose>
				<c:when test="${sVo ne null}">
					<c:set value="update" var="btnStat"></c:set>
				</c:when>
				<c:otherwise>
					<c:set value="temp" var="btnStat"></c:set>
				</c:otherwise>			
			</c:choose>
            <button type="button" name="saveBtn" id="${btnStat}">임시저장</button>
            <button type="button" name="saveBtn" id="save" class="save">저장하기</button>
        </fieldset>
        <!-- .버튼 영역 -->
    </form>
    
 <!-- aelrt.js library -->
<script src="/surveySrc/js/alertify.js"></script>
    
</body>
</html>