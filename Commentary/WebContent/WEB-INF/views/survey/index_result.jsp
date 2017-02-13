<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
</head>
<body>
    <div class="bg"></div>
    <div id="sr_header">
        <h1 id="logo">
            <img src="/surveySrc/img/logo.png" alt="logo" class="fl">
            <p class="fl">문화관광해설사<br/>
            인력관리 시스템</p>
        </h1>        
    </div>
    <div id="sr_contents">
        <p class="sr_data">
            설문 기간 : 2017.01.24 부터 ~ 2017.02.24까지
        </p>
        <div id="sr_title">
            해설 인력 관리 실태 설문 조사
        </div>
        <div class="clear"></div>
        <form action="#" id="survey_result">
            <fieldset class="article">
            <div>
                <p class="a_number">1</p>
                <p class="aq_text">관리 담당 지역은 어디입니까?</p>
            </div>
            <div class="clear"><!--2017.02.10 수정-->
                <input type="text" class="t_input">
            </div>            
        </fieldset>
        <fieldset class="article">
            <div>
                <p class="a_number">2</p>
                <p class="aq_text">관리하고 계신 해설 인력은 몇 명 입니까?</p>
            </div>
            <div class="clear"><!--2017.02.10 수정-->
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
        </fieldset>
        <fieldset class="article">
            <div>
                <p class="a_number">3</p>
                <p class="aq_text">
                관리하고 계신 해설 인력의 제공 언어는 무엇입니까?<br/>
                (복수선택 가능) 
                </p>
            </div>
            <div class="clear"><!--2017.02.10 수정-->                
                <ul class="s_checkbox">
                    <li>
                        <input type="checkbox" class="r_li" value="c_01"> 한국어
                    </li>
                    <li>
                        <input type="checkbox" class="r_li" value="c_02"> 영어
                    </li>
                    <li>
                        <input type="checkbox" class="r_li" value="c_03"> 중국어
                    </li>
                    <li>
                        <input type="checkbox" class="r_li"
                        value="c_04"> 일본어
                    </li>
                    <li>
                        <input type="checkbox" class="r_li" value="c_05"> 기타 언어
                    </li>
                </ul>
            </div>            
        </fieldset>
        </form>
    </div>
</body>
</html>