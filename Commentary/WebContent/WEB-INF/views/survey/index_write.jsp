<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>survey_write</title>
<link rel="shortcut icon" type="image/png" href=""/>
<link rel="stylesheet" href="/surveySrc/css/style.css">
<link rel="stylesheet" href="/surveySrc/css/survey_style.css">
<script type="text/javascript" src="/surveySrc/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
$(function(){
	
	// 하단 버튼 선택시 (임시저장 , 저장하기)
	$("button[name=saveBtn]").on("click",function(){
		
		var $selElId = $(this).attr("id");
		/* console.log("$selElId: "+ $selElId); */
		/* 상단 val */
		var $stDate = $("input[id=start_s]").val(); // 시작일
		var $endDate = $("input[id=end_s]").val();  // 종료일
		var $surveyTarget1 = $("input[name=surveyTarget_1]:checked").val(); // 설문대상 - 지자체 
		var $surveyTarget2 = $("input[name=surveyTarget_2]:checked").val(); // 설문대상 - 해설사
		
		// 임시저장
		if($selElId=="temp"){
			//console.log("임시저장")
		
		// 저장하기
		}else if($selElId=="save"){
			//console.log("저장하기")
		} 
	}); //..하단버튼선End
	
	
	
	//객관식 버튼 선택시
	$(".objective.close.sort_bt").on("click",function(){
		//alert("객관식 버튼 선택");
		var hasClassFlag = $(this).hasClass("close");
		console.log("hasClassFlag : " + hasClassFlag);
		
		// 버튼 css 변경 토글 
		if(hasClassFlag){ 
			$(this).attr("class","objective open sort_bt"); // 객관식 글씨 활성
			$(this).find("p").attr("class","o_open"); // 객관식 이미지 활성
			$(this).next().attr("class","subjective close sort_bt"); // 주관식 글씨 비활성
			$(this).next().find("p").attr("class","s_close"); //주관식 이미지 비활성
			$(this).parent().next().css("display","inline-block");
		}
	});
	
	
	//주관식 버튼 선택시
	$(".subjective.open.sort_bt").on("click",function(){
		
		var hasClassFlag = $(this).hasClass("close");
		console.log("hasClassFlag : " + hasClassFlag);
		
		// 버튼 css 변경 토글 
		if(hasClassFlag){ 
			$(this).attr("class","subjective open sort_bt"); // 주관식 글씨 활성
			$(this).find("p").attr("class","s_open"); // 주관식 이미지 활성
			$(this).prev().attr("class","objective close sort_bt"); // 객관식 글씨 비활성
			$(this).prev().find("p").attr("class","o_close"); // 객관식 이미지 비활성
			$(this).parent().next().css("display","none");
		}
		
	});
	
	
	
})// endDomReady
</script>
</head>
<body>
    <div id="s_head">
        설문조사
    </div>
    <div id="sw_data">
        2017.1.24 오후 1:32분 임시저장 함
    </div>
    <div id="sw_title">
        해설 인력 관리 실태 설문 조사
    </div>
    <form action="#" id="survey_write">
        <fieldset class="basic_s">
            <ul>
                <li id="se_date">
                    <label for="start_s">시작일<input type="date" id="start_s" placeholder="연도-월-일"></label>
                    ~
                    <label for="end_s">종료일<input type="date" id="end_s"placeholder="연도-월-일"></label>
                </li>
                <li id="sort_s">
                    <span>설문대상</span>
                    <label><input type="checkbox" value="group" name="surveyTarget_1">지자체</label>
                    <label><input type="checkbox" value="commentator" name="surveyTarget_2">해설사</label>
                </li>
            </ul>           
        </fieldset><!--2017.02.10 추가-->
        
        
        <!-- 1번 예시 -->
        <!-- <fieldset class="article">
            <div>
                <p class="a_number">1</p>
                <p class="aq_text">관리 담당 지역은 어디입니까?</p>
            </div>
            <div class="clear">                
               2017.02.10 삭제
                <input type="text" class="t_input" id="chargeLocText">
            </div>            
        </fieldset> -->
        <!-- .1번 -->
        
        
        <!-- 2번 예시 -->
        <!-- <fieldset class="article">
            <div>
                <p class="a_number">2</p>
                <p class="aq_text">관리하고 계신 해설 인력은 몇 명 입니까?</p>
            </div>
            <div class="clear">                
                2017.02.10 삭제
                <ul class="s_radio">
                    <li>
                        <label><input type="radio" class="r_li" value="r_01" name="chrgPcnt"> 1~10명</label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_02" name="chrgPcnt"> 11~20명</label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_03" name="chrgPcnt"> 21~30명</label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_04" name="chrgPcnt"> 31~40명</label>
                    </li>
                    <li>
                        <label><input type="radio" class="r_li" value="r_05" name="chrgPcnt"> 41명 이상</label>
                    </li>
                </ul>
            </div>            
        </fieldset> -->
        <!-- .2번 -->
        
        
        <!-- 질문 작성 영역 -->
        <fieldset class="m_article mb60">
            <div>
                <p class="am_number">3</p>
                <input type="text" class="qw" placeholder="질문을 입력해주세요.">
                <button class="b_del"></button>
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
	                        <input type="radio" class="m_radio" value="r_01"> 
	                        <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(필수)" required>
	                    </li>
	                    <li>
	                        <input type="radio" class="m_radio" value="r_02"> 
	                        <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(필수)" required>
	                    </li>
	                    <li>
	                        <input type="radio" class="m_radio" value="r_03"> 
	                        <input type="text"  class="tm_input" placeholder="객관식 답변을 입력해주세요(선택)">
	                        <button type="button" class="r_delete"></button>
	                    </li>
	                    <li>
	                        <input type="radio" class="m_radio" value="r_04"> 
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
            <button class="w_add"></button>
        </fieldset>
        
        
        <!-- 버튼 영역 -->
        <fieldset id="sending">
            <button type="button" name="saveBtn" id="temp">임시저장</button>
            <button type="submit" name="saveBtn" id="save" class="save">저장하기</button>
        </fieldset>
        <!-- .버튼 영역 -->
        
    </form>
</body>
</html>