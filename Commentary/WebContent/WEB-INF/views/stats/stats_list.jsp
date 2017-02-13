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
<script type="text/javascript">
	$(function() {
		$('.formSelect').sSelect();
		$('#tabs').tabs();
	});
</script>
</head>
<body>
<div id="wrapper">

	<!-- navigation -->
	<div id="gnb" class="clearfix">
		<h1><a href="#a"><img src="image/logo.png" alt="문화관광해설사 관리시스템" /></a></h1>
		<ul class="clearfix">
			<li class="on"><a href="#a">문화관광해설사 관리</a><!-- 선택 메뉴에 클래스 on 삽입, 메인은 해당 없음, 샘플로 넣어둔 겁니다. -->
				<ul class="clearfix" style="width:300px;left:-70px"><!-- 메뉴가 떨어지지 않게 width 조절, 서브 메뉴 위치 조정은 left 값 조정 -->
					<li><a href="#a">정보등록</a></li><!-- 서브 선택 메뉴에 클래스 on 삽입, 메인은 해당 없음, 샘플로 넣어둔 겁니다. -->
					<li><a href="#a">정보수정</a></li>
					<li><a href="#a">조회</a></li>
					<li><a href="#a">전근내역</a></li>
				</ul>
			</li>
			<li><a href="#a">교육 관리</a>
				<ul class="clearfix" style="width:250px;left:0">
					<li><a href="#a">서브1</a></li>
					<li><a href="#a">서브2</a></li>
					<li><a href="#a">서브3</a></li>
					<li><a href="#a">서브4</a></li>
				</ul>
			</li>
			<li><a href="#a">커뮤니케이션 관리</a>
				<ul class="clearfix" style="width:250px;left:0">
					<li><a href="#a">서브1</a></li>
					<li><a href="#a">서브2</a></li>
					<li><a href="#a">서브3</a></li>
					<li><a href="#a">서브4</a></li>
				</ul>
			</li>
			<li><a href="#a">이용자 관리</a>
				<ul class="clearfix" style="width:250px;left:0">
					<li><a href="#a">서브1</a></li>
					<li><a href="#a">서브2</a></li>
					<li><a href="#a">서브3</a></li>
					<li><a href="#a">서브4</a></li>
				</ul>
			</li>
			<li><a href="#a">통계분석</a>
				<ul class="clearfix" style="width:250px;left:0">
					<li class="on"><a href="#a">활동현황통계</a></li>
				</ul>
			</li>
		</ul>


		<div class="top-menu">
			<a href="#a" class="btn-user" title="사용자 정보"><span class="text-hidden">사용자 정보</span></a>
<!-- 로그인, 로그아웃 버튼은 style="display:none" 으로 조정 -->
			<a href="#a" class="btn-logout" title="로그아웃"><span class="text-hidden">로그아웃</span></a>
			<a href="#a" class="btn-login" title="로그인" style="display:none"><span class="text-hidden">로그인</span></a>
		</div>

	</div>

	<div id="container" class="main"><!-- 메인 페이지에 클래스 main 삽입 -->

		<div class="user-info">
			<div class="shadow-box">
				<div class="comment">안녕하세요.</div>
				<div class="view-content">
					<div class="user-photo">
						<div class="photo"><img src="image/user_default_70.png" alt="문지식님" /></div>
						<div class="cover"><a href="#a"><img src="image/user_cover_70.png" alt="문지식님" /></a></div><!-- 클릭했을 때 사용자 정보로 이동하지 않으면 a 태그 삭제 -->
					</div>
					<p class="name"><strong>문 지식</strong> 님</p>
					<p>현재 업데이트 현황입니다.</p>
				</div>
			</div><!--// shadow-box -->

			<div class="shadow-box">
				<div class="btn">
					<a href="#a"><span class="text1">문화관광해설사</span><span class="text2">관 리 시 스 템</span><span class="text3">안내</span></a>
				</div>
			</div><!--// shadow-box -->

		</div><!--// user-info -->

		<div class="contents">

			<div class="set-period">
				<span class="set-date">
					<input type="text" id="srch_str_dt" name="srch_str_dt" title="시작일" placeholder="시작일" style="width:65px;" class="calendar" /> 
				</span>
				<span class="txt-symbol">~</span>
				<span class="set-date mr7">
					<input type="text" id="srch_end_dt" name="srch_end_dt" title="종료일" placeholder="종료일" style="width:65px;" class="calendar" />
				</span>
				<span class="btn-term mr7"><a href="#a" class="btn-week" title="주 단위 선택"><span class="text-hidden">주 단위 선택</span></a></span>
				<span class="btn-term on mr7"><a href="#a" class="btn-month" title="월 단위 선택"><span class="text-hidden">월 단위 선택</span></a></span>
				<span class="btn-term"><a href="#a" class="btn-year" title="년 단위 선택"><span class="text-hidden">년 단위 선택</span></a></span><!-- 선택된 보기 설정에 믈래스 on 삽입-->
			</div>

			<div class="col2 clearfix">
				<div class="shadow-box float-left">
					<div class="top-bar">
						<h2>이용 관광객 수</h2>
						<div class="btn-box"><a href="#a" class="btn-more" title="더보기"><span class="text-hidden">더보기</span></a></div>
					</div>
					<div class="section">
						<div class="criteria">
							<p>2015년 06월 10일</p>
							<p>00:00 기준</p>
						</div>
						<p class="index">전국<span>9,428,271</span>명</p>
					</div>
				</div><!-- // shadow-box -->

				<div class="shadow-box float-right">
					<div class="top-bar">
						<h2>활동 해설사 수</h2>
						<div class="btn-box"><a href="#a" class="btn-more" title="더보기"><span class="text-hidden">더보기</span></a></div>
					</div>
					<div class="section">
						<div class="criteria">
							<p>2015년 06월 10일</p>
							<p>00:00 기준</p>
						</div>
						<p class="index">전국<span>9,428,271</span>명</p>
					</div>
				</div><!-- // shadow-box -->
			</div><!-- // col2 -->

			<div class="shadow-box">
				<div class="top-bar">
					<h2>각 시도별 월별 해설사 정보 업데이트 현황</h2>
					<div class="btn-box">
						<a href="#a" class="btn-view-graph on" title="그래프로 보기"></a><!-- 선택된 보기에 클래스 on 삽입 -->
						<a href="#a" class="btn-view-table" title="테이블로 보기"></a>
					</div>
				</div>
				<div class="view-content">
					그래프나 테이블 영역
				</div>
			</div><!-- // shadow-box -->

			<div class="shadow-box">
				<div class="top-bar">
					<h2>각 시도별 월별 로그인 현황</h2>
					<div class="btn-box">
						<a href="#a" class="btn-view-graph" title="그래프로 보기"></a>
						<a href="#a" class="btn-view-table on" title="테이블로 보기"></a><!-- 선택된 보기에 클래스 on 삽입 -->
					</div>
				</div>
				<div class="view-content">
					그래프나 테이블 영역
				</div>
			</div><!-- // shadow-box -->

			<div class="shadow-box">
				<div id="tabs" class="clearfix">
				  <ul class="title float-left">
					<li><a href="#tabs-1" class="tab1">공지사항</a></li>
					<li><a href="#tabs-2" class="tab2">Q&amp;A</a></li>
				  </ul>
				  <div id="tabs-1" class="content float-left">
					<table class="talbe-list">
						<colgroup>
							<col style="width:12%" />
							<col style="width:*" />
							<col style="width:12%"/>
							<col style="width:12%"/>
							<col style="width:14%"/>
						</colgroup>
						<thead>
							<tr>
								<th>시도</th>
								<th>제목</th>
								<th>첨부파일</th>
								<th>작성자</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>경기</td>
								<td><a href="#a" title="교육 이수 현황 안내 교육 이수 현황 안내 교육 이수 현황 안내 교육 이수 현황 안내 교육 이수 현황 안내">교육 이수 현황 안내 교육 이수 현황 안내 교육 이수 현황 안내 교육 이수 현황 안내 교육 이수 현황 안내</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
							<tr>
								<td>제주</td>
								<td><a href="#a" title="제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항">제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
							<tr>
								<td>경기</td>
								<td><a href="#a" title="교육 이수 현황 안내">교육 이수 현황 안내</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
							<tr>
								<td>제주</td>
								<td><a href="#a" title="제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항">제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
							<tr>
								<td>경기</td>
								<td><a href="#a" title="교육 이수 현황 안내">교육 이수 현황 안내</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
							<tr>
								<td>제주</td>
								<td><a href="#a" title="제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항">제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
							<tr>
								<td>경기</td>
								<td><a href="#a" title="교육 이수 현황 안내">교육 이수 현황 안내</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
							<tr>
								<td>제주</td>
								<td><a href="#a" title="제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항">제주 신규 관광컨텐츠 및 신사업에 대한 숙지사항</a></td>
								<td><img src="image/ico_file.png" alt="첨부파일" /></td>
								<td>관리자</td>
								<td>2015.06.09</td>
							</tr>
						</tbody>
					</table>
				  </div>
				  <div id="tabs-2" class="content float-left">
					<table class="talbe-list faq">
						<tbody>
							<tr>
								<td><a href="#a" title="질문 1"><span class="icon">Q.</span>질문 1</a></td>
							</tr>
							<tr>
								<td><a href="#a" title="질문 2"><span class="icon">Q.</span>질문 2</a></td>
							</tr>
							<tr>
								<td><a href="#a" title="질문 3"><span class="icon">Q.</span>질문 3</a></td>
							</tr>
							<tr>
								<td><a href="#a" title="질문 4"><span class="icon">Q.</span>질문 4</a></td>
							</tr>
							<tr>
								<td><a href="#a" title="질문 5"><span class="icon">Q.</span>질문 5</a></td>
							</tr>
							<tr>
								<td><a href="#a" title="질문 6"><span class="icon">Q.</span>질문 6</a></td>
							</tr>
							<tr>
								<td><a href="#a" title="질문 7"><span class="icon">Q.</span>질문 7</a></td>
							</tr>
							<tr>
								<td><a href="#a" title="질문 1"><span class="icon">Q.</span>질문 8</a></td>
							</tr>
						</tbody>
					</table>
				  </div>
				</div>
			</div><!-- // shadow-box -->

		</div><!--// contents -->
	</div><!--// container -->
</div>


</body>
</html>


