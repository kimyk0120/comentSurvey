<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>survey_list</title>
    <link rel="shortcut icon" type="image/png" href=""/>
    <link rel="stylesheet" href="/surveySrc/css/style.css">
    <link rel="stylesheet" href="/surveySrc/css/survey_style.css">
    <script type="text/javascript" src="/surveySrc/js/jquery-1.11.3.min.js"></script>
</head>
<body>
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
            <th>미리보기</th>
            <th>수정</th>
            <th>삭제</th>
            <th>결과저장</th>
        </tr>
        <tr class="ing">
            <td class="situation">진행중</td>
            <td class="t_title"><p class="s_contents">문화관광해설사 관리시스템 서비스 만족도 조사</p><p class="t_data">2016-07-01 등록</p></td>
            <td class="p_number">87</td>
            <td class="m_data">2016-07-11</td>
            <td class="preview">
                <button type="button"><img src="/surveySrc/img/preview.png" alt="preview"></button>
            </td>
            <td class="modification">
                <button type="button"><img src="/surveySrc/img/modification_2.png" alt="modification"></button>
            </td>
            <td class="delete">
                <button type="button"><img src="/surveySrc/img/delete.png" alt="delete"></button>
            </td>
            <td class="save">
                <button type="button"><img src="/surveySrc/img/download.png" alt="save"></button>
            </td>
        </tr>
        <tr class="end">
            <td class="situation">종료</td>
            <td class="t_title"><p class="s_contents">신규 서비스 확장영역 조사</p><p class="t_data">2016-05-31 등록</p></td>
            <td class="p_number">452</td>
            <td class="m_data">.</td>
            <td class="preview">
                <button type="button"><img src="/surveySrc/img/preview.png" alt="preview"></button>
            </td>
            <td class="modification">
                <button type="button"><img src="/surveySrc/img/modification_1.png" alt="modification"></button>
            </td>
            <td class="delete">
                <button type="button"><img src="/surveySrc/img/delete.png" alt="delete"></button>
            </td>
            <td class="save">
                <button type="button"><img src="/surveySrc/img/download.png" alt="save"></button>
            </td>
        </tr>
        <tr class="ing">
            <td class="situation">진행중</td>
            <td class="t_title"><p class="s_contents">지자체 교육 만족도 조사</p><p class="t_data">2016-04-01 등록</p></td>
            <td class="p_number">298</td>
            <td class="m_data">.</td>
            <td class="preview">
                <button type="button"><img src="/surveySrc/img/preview.png" alt="preview"></button>
            </td>
            <td class="modification">
                <button type="button"><img src="/surveySrc/img/modification_2.png" alt="modification"></button>
            </td>
            <td class="delete">
                <button type="button"><img src="/surveySrc/img/delete.png" alt="delete"></button>
            </td>
            <td class="save">
                <button type="button"><img src="/surveySrc/img/download.png" alt="save"></button>
            </td>
        </tr>
        <tr class="end">
            <td class="situation">종료</td>
            <td class="t_title"><p class="s_contents">문화관광해설사 활동 지역 조사</p><p class="t_data">2016-03-01 등록</p></td>
            <td class="p_number">1,203</td>
            <td class="m_data">2016-03-02</td>
            <td class="preview">
                <button type="button"><img src="/surveySrc/img/preview.png" alt="preview"></button>
            </td>
            <td class="modification">
                <button type="button"><img src="/surveySrc/img/modification_1.png" alt="modification"></button>
            </td>
            <td class="delete">
                <button type="button"><img src="/surveySrc/img/delete.png" alt="delete"></button>
            </td>
            <td class="save">
                <button type="button"><img src="/surveySrc/img/download.png" alt="save"></button>
            </td>
        </tr>
        <tr class="end">
            <td class="situation">종료</td>
            <td class="t_title"><p class="s_contents">문화관광해설사 보수 교육 만족도 조사</p><p class="t_data">2016-01-23 등록</p></td>
            <td class="p_number">2,073</td>
            <td class="m_data">2016-03-01</td>
            <td class="preview">
                <button type="button"><img src="/surveySrc/img/preview.png" alt="preview"></button>
            </td>
            <td class="modification">
                <button type="button"><img src="/surveySrc/img/modification_1.png" alt="modification"></button>
            </td>
            <td class="delete">
                <button type="button"><img src="/surveySrc/img/delete.png" alt="delete"></button>
            </td>
            <td class="save">
                <button type="button"><img src="/surveySrc/img/download.png" alt="save"></button>
            </td>
        </tr>
        
    </table>
   </div>
</body>
</html>