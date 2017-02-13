<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" />
<title>문화관광해설사 통합예약페이지</title>
<meta name="author" content="문화관광해설사 통합예약" />
<meta name="description" content="문화관광해설사 통합예약" />
<meta name="keywords" content="문화관광해설사 통합예약" />
<link rel="stylesheet" href="reservation/css/main.css" type="text/css" />

<script type="text/javascript" src="reservation/scripts/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="reservation/scripts/TweenMax.min.js"></script>

<script>
	$(function(){
		var whole_index = -1;
		var select_wholeName = "";
		var select_wholeCode = "";
		var area_index = -1;
		var select_areaName = "";
		var whole_map = $(".btn_whole");
		var area_map = $(".btn_area");
		
		var seoul_url = "http://korean.visitseoul.net/walking-tour";
		var seoul_info = "http://korean.visitseoul.net/index";
		var busan_url = "http://bto.or.kr/renewal/06_visitor/g02.php";
		var busan_info = "https://bto.or.kr/renewal/main/main.php";
		var daegu_url = "http://tour.kro.kr/Chims/content/001001000/form.do";
		var daegu_info = "http://tour.daegu.go.kr/";
		var incheon_url = "https://culture-tour.incheon.go.kr//";
		var incheon_info = "http://itour.incheon.go.kr/";
		var gwangju_url = "http://tour.gwangju.go.kr/home/tour/guide.cs?m=86";
		var gwangju_info = "http://tour.gwangju.go.kr/home/main.cs";
		var daejeon_url = "http://cafe.daum.net/munhwayusan";
		var daejeon_info = "http://www.daejeon.go.kr/tou/index.do";
		var ulsan_url = "http://tour.ulsan.go.kr/board/list.ulsan?boardId=BBS_0000026&menuCd=DOM_000000105003000000&contentsSid=234";
		var ulsan_info = "http://tour.ulsan.go.kr/index.ulsan";
		var sejong_url = "http://www.sejong.go.kr/tour/sub04_04.do";
		var sejong_info = "http://www.sejong.go.kr/tour.do";
		// 경기도
			var gapyeong_url = "http://www.gptour.go.kr/guide/culture.jsp?menu=guide&submenu=culture";
			var gapyeong_info = "http://www.gptour.go.kr/";
			var goyang_url = "http://www.visitgoyang.net/contents/information/explain_guide_reserv.asp";
			var goyang_info = "http://www.visitgoyang.net/index.asp";
			var gwacheon_url = "http://www.gccity.go.kr/app/tourExplain.do?mCode=E030000000";
			var gwacheon_info = "http://www.gccity.go.kr/tour/main.do";
			var gwangmyeong_url = "http://www.gm.go.kr/tr/trtg/tg2/TG52120.jsp";
			var gwangmyeong_info = "http://www.gm.go.kr/tr/index.do";
			var gwangjusi_url = "http://cafe.daum.net/welcomens";
			var gwangjusi_info = "http://tour.gjcity.go.kr/";
			var guri_url = "http://www.guri.go.kr/cms/content/view/2101";
			var guri_info = "http://www.guri.go.kr/brd/board/1045/L/menu/2091";
			var gimpo_url = "http://tour.gimpo.go.kr/culture/content.do?menu_cd=102699";
			var gimpo_info = "http://www.gimpo.go.kr/culture/main.do";
			var namyangju_url = "http://www.nyj.go.kr/culture/tour/07_01.jsp";
			var namyangju_info = "http://www.nyj.go.kr/culture/index.jsp";
			var dongducheon_url = "http://www.ddc.go.kr/ddc/cms/contents.asp?conNum=472";
			var dongducheon_info = "http://www.ddc.go.kr/ddc/cms/contents.asp?conNum=19";
			var bucheon_url = "http://www.bucheonculture.or.kr/bcc/bbs/write.php?bo_table=E010202";
			var bucheon_info = "http://www.bucheonculture.or.kr/file/menu5/menu1.html";
			var seongnam_url = "http://www.seongnam.go.kr/city/1000758/30257/bbsList.do";
			var seongnam_info = "http://www.seongnam.go.kr/city/1000486/30209/bbsList.do";
			var suwon_url = "http://www.swcf.or.kr/?p=71";
			var suwon_info = "http://www.suwon.go.kr/web/tour/travelTourInfo/butiNature.do?categoryCd=123";
			var siheung_url = "http://www.siheung.go.kr/culture/%EB%AC%B8%ED%99%94%EA%B4%80%EA%B4%91%ED%95%B4%EC%84%A4-%EC%98%88%EC%95%BD-";
			var siheung_info = "http://www.siheung.go.kr/culture/";
			var ansan_info = "http://tourinfo.iansan.net/main.do";
			var ansung_url = "http://tour.anseong.go.kr/bbs/apply/list.html";
			var ansung_info = "http://tour.anseong.go.kr/main/index.php";
			var anyang_url = "http://www.anyang.go.kr/anyang/m15/m15_10/m15_10_02.jsp";
			var anyang_info = "http://www.anyang.go.kr/anyang/m15/m15_10/m15_10_02.jsp";
			var yangju_url = "http://tour.yangju.go.kr/site/tour/sub.do?Key=582";
			var yangju_info = "http://tour.yangju.go.kr/site/tour/main.do";
			var yangpyeong_url = "http://tour.yp21.net/gcontent/gcontent05_new.asp?Mcode=501";
			var yangpyeong_info = "http://tour.yp21.net/gcontent/intro.asp";
			var yeoju_url = "http://www.yj21.net/cms/content/view/1808";
			var yeoju_info = "http://www.yeoju.go.kr/main/culture";
			var yeoncheon_url = "http://tour.yeoncheon.go.kr:8090/web/cms/?MENUMST_ID=10148";
			var yeoncheon_info = "http://tour.yeoncheon.go.kr:8090/web/main";
			var osan_url = "http://osanculture.inckorea.net/?doc=common/06_01.php";
			var osan_info = "http://www.osan.go.kr/osanCulture/main.do";
			var yongin_url = "https://tour.yongin.go.kr/tour/ctgresve/BD_selectCtgResveInfo.do";
			var yongin_info = "https://tour.yongin.go.kr/tour/index.do";
			var uijeongbu_info = "http://culture.ui4u.go.kr/";
			var icheon_url = "http://tour.icheon.go.kr/site/tour/boardList.do?boardSeq=4535&key=1919";
			var icheon_info = "http://tour.icheon.go.kr/site/tour/main.do";
			var paju_url = "https://tour.paju.go.kr/tour/tourInfo/tourInfo01.jsp";
			var paju_info = "https://tour.paju.go.kr/user/tour/main/index.do";
			var pyeongtaek_url = "http://www.pyeongtaek.go.kr/tour/contents.do?mId=0606000000";
			var pyeongtaek_info = "http://www.pyeongtaek.go.kr/tour/main.do";
			var pocheon_url = "http://www.pocheon.go.kr/ktour/contents.do?key=7018";
			var pocheon_info = "http://www.pocheon.go.kr/ktour/index.do";
			var hwaseong_url = "http://tour.hscity.go.kr/Guide/register.jsp";
			var hwaseong_info = "http://tour.hscity.go.kr/index.jsp";
		//강원도
			var gangwon_url = "http://www.gangwon.to/culture/reservation.html";
			var gangneung_info= "http://www.gntour.go.kr/";
			var goseong_info= "http://tour.gwgs.go.kr/site/tour/page/index.jsp";
			var donghae_url= "http://www.dhtour.go.kr/korean/guide/10.htm";
			var donghae_info= "http://www.dhtour.go.kr/korean/index.html";
			var samcheok_url= "http://tour.samcheok.go.kr/05guide/06.jsp";
			var samcheok_info= "http://tour.samcheok.go.kr/main/";
			var sokcho_info= "http://www.sokchotour.com/";
			var yanggu_info= "http://www.ygtour.kr/";
			var yangyang_info= "http://tour.yangyang.go.kr/site/tourism/index.jsp";
			var yeongwol_url= "http://www.ywtour.com/Guide/Commentator?g=7&b=125&m=20&s=51";
			var yeongwol_info= "http://www.ywtour.com/Home/Index";
			var wonju_info= "http://www.wonju.go.kr/www/index.do#move3";
			var jeongseon_info= "http://www.ariaritour.com/hb/tour";
			var cheorwon_info= "http://www.cwg.go.kr/site/tour/main.do";
			var chuncheon_info= "http://tour.chuncheon.go.kr/";
			var taebaek_url= "http://tour.taebaek.go.kr/site/ko/pages/sub07/sub07_05.jsp?mode=writeForm&curPage=1";
			var taebaek_info= "http://tour.taebaek.go.kr/site/ko/pages/index.jsp";
			var pyeonchang_info= "http://tour.pc.go.kr/";
			var hongcheon_info= "https://www.great.go.kr/index.asp";
			var hoengseong_info= "http://www.hsg.go.kr/tour.web";
			var hwacheon_info= "http://tour.ihc.go.kr/hb/portal";
			var inje_info= "http://tour.inje.go.kr/main/main.asp";
			
		// 충청북도
			var chungbuk_url = "http://tour.chungbuk.go.kr/home/sub.php?menukey=237";
			var chungbuk_info = "http://tour.chungbuk.go.kr/home/sub.php?menukey=235";
			var cheongju_url = "http://www.cheongju.go.kr/tour/contents.do?key=817";
			var cheongju_info = "http://www.cheongju.go.kr/tour/index.do";
			var chungju_url = "https://www.chungju.go.kr/tour/html/sub06/0605.html";
			var chungju_info = "https://www.chungju.go.kr/tour/";
			var jecheon_url = "http://tour.jecheon.go.kr/ktour/selectTursmResveList.do?key=137";
			var jecheon_info = "http://tour.jecheon.go.kr/ktour/index.do";
			var boeun_url = "http://www.tourboeun.go.kr/prog/tursmExplnaReqst/tour/sub03_04_01/list.do";
			var boeun_info = "http://www.tourboeun.go.kr/tour.do";
			var okcheon_url = "http://tour.oc.go.kr/html/tour/helper/helper_0510.html";
			var okcheon_info = "http://tour.oc.go.kr/html/tour/";
			var yeongdong_url = "http://tour.yd21.go.kr/html/tour/asstn/asstn_0405.html";
			var yeongdong_info = "http://tour.yd21.go.kr/html/tour/";
			var jeungpyeong_url = "http://tour.jp.go.kr/html/kr/help/help_02.html";
			var jeungpyeong_info = "http://tour.jp.go.kr/html/kr/";
			var jincheon_url = "http://www.jincheon.go.kr/site/tour/sub.do?menukey=1630";
			var jincheon_info = "http://www.jincheon.go.kr/site/tour/main.do";
			var goesan_url = "http://tour.goesan.go.kr/home/sub.do?menukey=70";
			var goesan_info = "http://tour.goesan.go.kr/home/index.do";
			var eumseong_url = "http://www.eumseong.go.kr/tour/contents.do?key=568";
			var eumseong_info = "http://www.eumseong.go.kr/tour/index.do";
			var danyang_url = "http://tour.dy21.net/home/?menu=010802&boardid=dytour7";
			var danyang_info = "http://tour.dy21.net/home/?menu=0101";
			
		// 충청남도
			var gyeryong_url = "http://www.army.mil.kr/event/visit/sub/sub_03_1.jsp";
			var gyeryong_info = "http://www.gyeryong.go.kr/html/tour/";
			var gongju_url = "http://tour.gongju.go.kr/html/kr/sub7/sub7_070203.html";
			var gongju_info = "http://tour.gongju.go.kr/html/kr/";
			var geumsan_url = "http://www.geumsan.go.kr/_prog/_board/?code=sub04_040602&site_dvs_cd=tour&menu_dvs_cd=040602";
			var geumsan_info = "http://tour.gongju.go.kr/html/kr/";
			var geumsan_url = "http://www.geumsan.go.kr/_prog/_board/?code=sub04_040602&site_dvs_cd=tour&menu_dvs_cd=040602";
			var geumsan_info = "http://www.geumsan.go.kr/html/tour/";
			var nonsan_url = "http://tour.nonsan.go.kr/tour.do?mno=sub05_05";
			var nonsan_info = "http://tour.nonsan.go.kr/tour.do";
			var dangjin_url = "http://27.101.65.60/_prog/gboard/board.php?code=tour_0604";
			var dangjin_info = "http://dangjin.go.kr/tour.do";
			var boryeong_url = "http://www.brcn.go.kr/tour/sub05_04.do";
			var boryeong_info = "http://www.brcn.go.kr/tour.do";
			var buyeo_url = "http://tour.buyeo.go.kr/_prog/inter_app/?mode=W&site_dvs_cd=tour&menu_dvs_cd=0408";
			var buyeo_info = "http://tour.buyeo.go.kr/html/tour/";
			var seosan_url = "http://www.seosan.go.kr/tour/selectBbsNttList.do?bbsNo=28&key=983";
			var seosan_info = "http://www.seosan.go.kr/tour/index.do";
			var seocheon_url = "http://tour.seocheon.go.kr/tour/sub06_02_01.do";
			var seocheon_info = "http://www.seosan.go.kr";
			var asan_url = "http://www.asan.go.kr/culture/node/13379";
			var asan_info = "http://www.asan.go.kr/culture/";
			var yesan_url = "http://www.yesan.go.kr/tour/sub04_02.do";
			var yesan_info = "http://www.yesan.go.kr/tour/index.do";
			var cheonan_url = "https://www.cheonan.go.kr/tour/sub03_06.do";
			var cheonan_info = "https://www.cheonan.go.kr/tour.do";
			var cheongyang_url = "http://tour.cheongyang.go.kr/tour/sub05_09.do";
			var cheongyang_info = "http://tour.cheongyang.go.kr/tour.do";
			var taean_url = "http://www.taean.go.kr/tour/sub05_07.do";
			var taean_info = "http://www.taean.go.kr/tour.do";
			var hongseong_url = "http://tour.hongseong.go.kr/tour/sub05_07_01.do";
			var hongseong_info = "http://tour.hongseong.go.kr/tour.do";
		// 전라남도
			var gangjin_url = "http://www.gangjin.go.kr/culture/selectBbsNttList.do?bbsNo=56&key=1346";
			var gangjin_info = "http://www.gangjin.go.kr/culture/index.do";
			var goheung_url = "http://tour.goheung.go.kr/pgmlist?site_id=7&menu_id=92&mng_no=1";
			var goheung_info = "http://tour.goheung.go.kr/web?site_id=7";
			var gokseong_url = "http://www.gokseong.go.kr/tour/?pid=198";
			var gokseong_info = "http://www.gokseong.go.kr/tour/";
			var gwangyang_info = "http://www.gwangyang.go.kr/tour_culture/index.gwangyang";
			var gurye_url = "http://tour.gurye.go.kr/jcms/guryetours/take_part/0014/0001/";
			var gurye_info = "http://tour.gurye.go.kr/jcms/guryetours/";
			var naju_url = "http://naju-tour.acego.net/tour/html/sub05/0505.html";
			var naju_info = "http://naju-tour.acego.net/tour/";
			var damyang_url = "http://tour.damyang.go.kr/index.damyang?menuCd=DOM_000002705003000000";
			var damyang_info = "http://tour.damyang.go.kr/index.damyang";
			var mokpo_info = "http://tour.mokpo.go.kr/";
			var muan_url = "http://tour.muan.go.kr/tour/operation_guide/tour_interpreter";
			var muan_info = "http://tour.muan.go.kr/";
			var boseong_info = "http://tour.boseong.go.kr/index.boseong";
			var suncheon_url = "http://tour.suncheon.go.kr/tour/rest/0008/";
			var suncheon_info = "http://tour.suncheon.go.kr/tour/";
			var shinan_info = "http://tour.shinan.go.kr/";
			var yeosu_url = "http://tour.yeosu.go.kr/tour/information/tour_interpreter";
			var yeosu_info = "http://tour.yeosu.go.kr";
			var yeonggwang_url = "http://www.yeonggwang.go.kr/bbs/?b_id=tour_guid2&site=tour&mn=1724";
			var yeonggwang_info = "http://www.yeonggwang.go.kr/main/?site=tour";
			var yeongam_url = "http://tour.yeongam.go.kr/home/tour/guide/guide_01/guide_01_02";
			var yeongam_info = "http://tour.yeongam.go.kr/";
			var wando_url = "http://www.wando.go.kr/tour/tour_intro/commentator";
			var wando_info = "http://www.wando.go.kr/tour/";
			var jangseong_url = "http://tour.jangseong.go.kr/home/tour/guide/guide/guide_01";
			var jangseong_info = "http://tour.jangseong.go.kr/home/tour";
			var jangheung_url = "http://travel.jangheung.go.kr/html/BoardView.jsp?menu_cd=0610";
			var jangheung_info = "http://travel.jangheung.go.kr/index.jsp";
			var jindo_url = "http://tour.jindo.go.kr/tour/sub.cs?m=54";
			var jindo_info = "http://tour.jindo.go.kr/tour/main.cs";
			var hampyeong_info = "http://tour.hampyeong.go.kr/";
			var haenam_url = "http://tour.haenam.go.kr/planweb/board/list.9is?boardUid=4a94e38a4a505566014a50bb6e42000f&contentUid=18e3368f4d025697014df5b144771ac9&layoutUid=4a94e38a478f462d01479f3b458d0217";
			var haenam_info = "http://www.haenam.go.kr/tour/index.9is?contentUid=4a94e38a478f462d01479e907bd10125";
			var hwasun_url = "http://www.hwasun.go.kr/contents.do?S=S09&M=070201000000";
			var hwasun_info = "http://www.hwasun.go.kr/index.do?S=S09";
		// 전라북도	
			var gochang_url = "http://www.gochang.go.kr/index.gochang?menuCd=DOM_000000607005000000";
			var gochang_info = "http://www.gochang.go.kr/culture/index.gochang";
			var gunsan_url = "http://www.gunsan.go.kr/tour/board/list.gunsan?boardId=BBS_0000260&menuCd=DOM_000000706007007000&contentsSid=4115&cpath=%2Ftour";
			var gunsan_info = "http://www.gunsan.go.kr/tour/index.gunsan";
			var gimje_url = "http://tour.gimje.go.kr/board/list.gimje;jsessionid=dRdYM20aQDGdGBDa8TMV8LxS4hPgb4KgFmLvqQLYWXiHukOFQIDw3vzIS5qz8n5D.was02_servlet_engine8?boardId=BBS_0000183&menuCd=DOM_000000306007000000&contentsSid=2000&cpath=";
			var gimje_info = "http://tour.gimje.go.kr/index.gimje";
			var namwon_url = "http://www.namwon.go.kr/tour/board/list.do?boardId=BBS_0000039&menuCd=DOM_000000305003001000&contentsSid=2378&cpath=%2Ftour";
			var namwon_info = "http://www.namwon.go.kr/tour/index.do";
			var muju_url = "http://tour.muju.go.kr/planweb/board/list.9is?boardUid=000000003716454f0137165e81a50001&contentUid=0000000036ec657201371068687200b3&layoutUid=00000000382b7452013859a7e5a10bdc";
			var muju_info = "http://tour.muju.go.kr/index.9is";
			var buan_url = "http://www.buan.go.kr/tour/board/list.buan?boardId=BBS_0000039&menuCd=DOM_000000206005002000&contentsSid=332&cpath=%2Ftour";
			var buan_info = "http://www.buan.go.kr/tour/index.buan";
			var sunchang_url = "http://tour.sunchang.go.kr/index.sunchang?menuCd=DOM_000001706003000000";
			var sunchang_info = "http://tour.sunchang.go.kr/index.sunchang";
			var wanju_url = "http://www.wanju.go.kr/tour/board/list.wanju?boardId=BBS_0000084&menuCd=DOM_000000806002000000&contentsSid=284&cpath=%2Ftour";
			var wanju_info = "http://www.wanju.go.kr/tour/index.wanju";
			var iksan_url = "http://www.iksan.go.kr/tour/board/list.iksan?boardId=BBS_TOUR_HASU&menuCd=DOM_000001508006002000&contentsSid=645&cpath=%2Ftour";
			var iksan_info = "http://www.iksan.go.kr/tour/index.iksan";
			var imsil_url = "http://imsil.gojb.net/guide/explain_apply.jsp?menu=guide&submenu=apply";
			var imsil_info = "http://tour.imsil.go.kr/";
			var jangsu_url = "http://tour.jangsu.go.kr/index.do";
			var jangsu_info = "http://tour.jangsu.go.kr/index.do";
			var jeonju_url = "http://www.jeonju.go.kr/index.9is?contentUid=9be517a754aa2d000154f10caa0f3270";
			var jeonju_info = "http://tour.jeonju.go.kr/index.9is";
			var jeongeup_url = "http://culture.jeongeup.go.kr/new/07guide/commentary/01/";
			var jeongeup_info = "http://culture.jeongeup.go.kr/";
			var jinan_url = "http://tour.jinan.go.kr/sub_5/?p=2&n=3&nn=1";
			var jinan_info = "http://tour.jinan.go.kr/";
		// 경상남도
			var gyeongnam_url = "http://tour.gyeongnam.go.kr/html/kr/sub04/sub04_0406.html";
			var geoje_url = "http://tour.geoje.go.kr/index.geoje?menuCd=DOM_000000705001005000";
			var geoje_info = "http://tour.geoje.go.kr/index.geoje";
			var geochang_url = "http://www.geochang.go.kr/tour/Index.do?c=TU1006000000";
			var geochang_info = "http://www.geochang.go.kr/tour/Index.do";
			var goseong_url = "https://visit.goseong.go.kr/index.goseong?menuCd=DOM_000000306001000000";
			var goseong_info = "https://visit.goseong.go.kr/index.goseong";
			var gimhae_url = "http://tour.gimhae.go.kr/05info/05_01.jsp";
			var gimhae_info = "http://tour.gimhae.go.kr/main/";
			var namhae_url = "http://tour.namhae.go.kr/00003006/00003009/00003034.web";
			var namhae_info = "http://tour.namhae.go.kr/main.web";
			var miryang_url = "http://tour.miryang.go.kr/program/tour/tourcalender/schedule.php";
			var miryang_info = "http://tour.miryang.go.kr/main/";
			var sacheon_url = "http://www.toursacheon.net/homepage/Kor/guide/interpreter_rev.jsp#.V4ROyLiLSUk";
			var sacheon_info = "http://www.toursacheon.net/homepage/Kor/index.jsp";
			var sancheong_url = "http://www.sancheong.go.kr/tour/contents.do?key=679";
			var sancheong_info = "http://www.sancheong.go.kr/tour/index.do";
			var yangsan_url = "http://www.yangsan.go.kr/tour/contents.do?mId=0503000000";
			var yangsan_info = "http://www.yangsan.go.kr/tour/main.do";
			var uiryeong_url = "http://www.uiryeong.go.kr/tour/board/list.uiryeong?boardId=commentator&menuCd=DOM_000000508003003000&contentsSid=3078&cpath=%2Ftour";
			var uiryeong_info = "http://www.uiryeong.go.kr/tour/index.uiryeong";
			var jinju_url = "http://tour.jinju.go.kr/01tour/09_01.jsp";
			var jinju_info = "http://tour.jinju.go.kr/main/";
			var changnyeong_url = "http://www.cng.go.kr/tour/request/00001374.web";
			var changnyeong_info = "http://www.cng.go.kr/main.web";
			var changwon_url = "http://culture.changwon.go.kr/index.changwon?menuId=17010000";
			var changwon_info = "http://culture.changwon.go.kr/index.changwon?contentId=9";
			var tongyeong_url = "http://tour.tongyeong.go.kr/06/02.asp";
			var tongyeong_info = "http://tour.tongyeong.go.kr/main/";
			var hadong_url = "http://tour.hadong.go.kr/program/tour/tourguide/lstTourguide.asp";
			var hadong_info = "http://tour.hadong.go.kr/main/";
			var haman_url = "https://tour.haman.go.kr/sub/05/04_02.jsp";
			var haman_info = "https://tour.haman.go.kr/main/";
			var hamyang_url = "http://www.hygn.go.kr/01235/01247/01251.web?amode=rn%5Ename%5Eins&rn_url=";
			var hamyang_info = "http://www.hygn.go.kr/tour.web";
			var hapcheon_url = "http://culture.hc.go.kr/sub/06_06.jsp";
			var hapcheon_info = "http://culture.hc.go.kr/main/";
		// 경상북도
			var gyeongbuk_url = "http://tour.gb.go.kr/page.do?mnu_uid=168&";
			var gyeongsan_url = "http://gbgs.go.kr/open_content/tour/page.do?mnu_uid=2520";
			var gyeongsan_info = "http://gbgs.go.kr/open_content/tour/index.do";
			var gyeongju_url = "http://guide.gyeongju.go.kr/cul_speak/";
			var gyeongju_info = "http://guide.gyeongju.go.kr/deploy/";
			var goryeong_url = "http://www.daegaya.net/program/receive/lstCalendar.asp";
			var goryeong_info = "http://utour.goryeong.go.kr/kor/";
			var gumi_url = "http://www.gumi.go.kr/tour/contents.do?mId=0602000000";
			var gumi_info = "http://www.gumi.go.kr/tour/main.do";
			var gunwi_info = "http://www.gunwi.go.kr/tour/main.htm";
			var gimcheon_url = "http://www.gc.go.kr/culture/page.htm?mnu_siteid=tour&mnu_uid=1157&#";
			var gimcheon_info = "http://www.gc.go.kr/culture/";
			var munkyeong_url = "http://tour.gbmg.go.kr/open.content/ko/guide/tour.explain/commentator.request/";
			var munkyeong_info = "http://tour.gbmg.go.kr/open.content/ko/";
			var bonghwa_url = "http://www.bonghwa.go.kr/open.content/tour/tour.info/tour.guide/";
			var bonghwa_info = "http://www.bonghwa.go.kr/open.content/tour/";
			var sangju_url = "http://www.sangju.go.kr/tour/main/main.jsp?home_url=tour&code=TOUR_TOUR_8";
			var sangju_info = "http://www.sangju.go.kr/tour/index.jsp";
			var seongju_url = "http://www.seongju.go.kr/tour/page.jsp?site_id=tour&mnu_uid=1663&";
			var seongju_info = "http://www.seongju.go.kr/tour/index.jsp";
			var andong_url = "http://www.tourandong.com/public/sub2/sub7.cshtml";
			var andong_info = "http://www.tourandong.com/public/";
			var yeongdeok_url = "http://tour.yd.go.kr/kor/part/commentator.aspx?MC=603006";
			var yeongdeok_info = "http://tour.yd.go.kr/";
			var yeongyang_info = "http://tour.yyg.go.kr/";
			var yeongju_url = "http://www.yeongju.go.kr/open_content/tour/page.do?mnu_uid=1244&app_type=1";
			var yeongju_info = "http://www.yeongju.go.kr/open_content/tour/index.do";
			var yeongcheon_url = "http://tour.yc.go.kr/program/publicboard/lstBoardDoc.asp?cidx=1012";
			var yeongcheon_info = "http://tour.yc.go.kr/main/";
			var yeocheon_url = "http://tour.ycg.kr/open.content/ko/community/commentator/";
			var yeocheon_info = "http://tour.ycg.kr/open.content/ko/";
			var ulleung_info = "http://www.ulleung.go.kr/tour/";
			var uljin_info = "http://www.uljin.go.kr/tour/index.uljin";
			var uiseong_url = "http://tour.usc.go.kr/guide/interpreter";
			var uiseong_info = "http://tour.usc.go.kr/";
			var cheongdo_info = "http://tour.cd.go.kr/open.content/ko/";
			var cheongsong_url = "http://tour.cs.go.kr/program/tour/culexpounder/ins_culexpounder.asp";
			var cheongsong_info = "http://tour.cs.go.kr/";
			var chilgok_info = "http://www.chilgok.go.kr/tour/main/";
			var pohang_info = "http://phtour.pohang.go.kr/phtour";
		
		whole_map.on({
			click:function(){
				var tg = $(this);
				var index = tg.index();
				if( index != whole_index ){
					$(".whole_map .map" + whole_index).removeClass( "on" );
					$(".whole_map .area_name li.txt" + whole_index).removeClass( "on" );
					whole_index = index;
					$(".whole_map .map" + whole_index).addClass( "on" );
					$(".whole_map .area_name li.txt" + whole_index).addClass( "on" );

					if( select_wholeCode !="" ){
						$( "." + select_wholeCode + " .map" + area_index ).removeClass( "on" );
						area_index = -1;
					}

					select_wholeCode = $(this).attr("data-code");
					select_wholeName = $(this).attr("alt");
					move_map();
					selectMap(select_wholeName);

					return false;
				}
			},
			mouseover:function(){
				var index = $(this).index();
				if( index != whole_index ){
					$(".whole_map .map" + index).addClass( "on" );
					$(".whole_map .area_name li.txt" + index).addClass( "on" );
				}
			},
			mouseout:function(){
				var index = $(this).index();
				if( index != whole_index ){
					$(".whole_map .map" + index).removeClass( "on" );
					$(".whole_map .area_name li.txt" + index).removeClass( "on" );
				}
			},
		});

		function selectMap( _area ){
			var area_name = _area;
			$(".resul_info .area").text( "'" + area_name + "'" );
			$(".data_table").show();
			
			show_list(area_name);
			
			//reservation_list
		}

		var visual = $('.area_map .map_list > li');
		var current = -1;

		function move_map(){
			if(current == whole_index) return;
			var currentEl = visual.eq(current);
			var nextEl = visual.eq(whole_index);
			if( current != -1 ){
				TweenLite.fromTo(currentEl, 0.8, {left:"0px"}, {left:"-100%", ease:Expo.easeOut});
			}
			TweenLite.fromTo(nextEl, 0.8, {left:"100%"}, {left:"0px", ease:Expo.easeOut});
			current = whole_index;
		}

		//지역맵
		area_map.on({
			click:function(){
				var index = $(this).index();
				if( index != area_index ){
					$( "." + select_wholeCode + " .map" + area_index ).removeClass( "on" );
					$( "." + select_wholeCode + " .area_name li.txt" + area_index).removeClass( "on" );
					area_index = index;
					$( "." + select_wholeCode + " .map" + area_index).addClass( "on" );
					$( "." + select_wholeCode + " .area_name li.txt" + area_index).addClass( "on" );
					select_areaName = $(this).attr("alt");
					if(confirm(select_areaName+" 예약 페이지로 이동합니다.")){
						if(select_areaName == "서울") {
							window.open(seoul_url,'_blank');
						} else if(select_areaName == "부산") {
							window.open(busan_url,'_blank');
						} else if(select_areaName == "대구") {
							window.open(daegu_url,'_blank');
						} else if(select_areaName == "인천" || select_areaName == "강화" ||select_areaName == "옹진") {
							if(select_areaName != "인천" ) {alert("전화 예약만 가능합니다.");}
							window.open(incheon_url,'_blank');
						} else if(select_areaName == "광주") {
							window.open(gwangju_url,'_blank');
						} else if(select_areaName == "대전") {
							window.open(daejeon_url,'_blank');
						} else if(select_areaName == "울산") {
							window.open(ulsan_url,'_blank');
						} else if(select_areaName == "세종시") {
							window.open(sejong_url,'_blank');
						} else if(select_areaName == "가평군") {
							window.open(gapyeong_url,'_blank');
						} else if(select_areaName == "고양시") {
							window.open(goyang_url,'_blank');
						} else if(select_areaName == "과천") {
							window.open(gwacheon_url,'_blank');
						} else if(select_areaName == "광명") {
							window.open(gwangmyeong_url,'_blank');
						} else if(select_areaName == "광주시") {
							window.open(gwangjusi_url,'_blank');
						} else if(select_areaName == "구리시") {
							window.open(guri_url,'_blank');
						} else if(select_areaName == "김포시") {
							window.open(gimpo_url,'_blank');
						} else if(select_areaName == "남양주") {
							window.open(namyangju_url,'_blank');
						} else if(select_areaName == "동두천") {
							window.open(dongducheon_url,'_blank');
						} else if(select_areaName == "부천") {
							window.open(bucheon_url,'_blank');
						} else if(select_areaName == "성남시") {
							window.open(seongnam_url,'_blank');
						} else if(select_areaName == "수원") {
							window.open(suwon_url,'_blank');
						} else if(select_areaName == "시흥") {
							window.open(siheung_url,'_blank');
						} else if(select_areaName == "안산") {
							alert("사이트 구축전입니다.");
						} else if(select_areaName == "안성시") {
							window.open(ansung_url,'_blank');
						} else if(select_areaName == "안양") {
							window.open(anyang_url,'_blank');
						} else if(select_areaName == "양주시") {
							window.open(yangju_url,'_blank');
						} else if(select_areaName == "양평시") {
							window.open(yangpyeong_url,'_blank');
						} else if(select_areaName == "여주시") {
							window.open(yeoju_url,'_blank');
						} else if(select_areaName == "연천군") {
							window.open(yeoncheon_url,'_blank');
						} else if(select_areaName == "오산") {
							window.open(osan_url,'_blank');
						} else if(select_areaName == "용인시") {
							window.open(yongin_url,'_blank');
						} else if(select_areaName == "의정부") {
							alert("사이트 구축전입니다.");
						} else if(select_areaName == "이천시") {
							window.open(icheon_url,'_blank');
						} else if(select_areaName == "파주시") {
							window.open(paju_url,'_blank');
						} else if(select_areaName == "평택시") {
							window.open(pyeongtaek_url,'_blank');
						} else if(select_areaName == "포천시") {
							window.open(pocheon_url,'_blank');
						} else if(select_areaName == "화성시") {
							window.open(hwaseong_url,'_blank');
						} else if(select_areaName == "의왕") {
							alert("사이트 구축전입니다.");
						} else if(select_areaName == "군포") {
							alert("사이트 구축전입니다.");
						} else if(select_areaName == "하남") {
							alert("사이트 구축전입니다.");
						} else if(select_areaName == "강릉시") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "강원도 고성군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "동해시") {
							window.open(donghae_url,'_blank');
						} else if(select_areaName == "삼척시") {
							window.open(samcheok_url,'_blank');
						} else if(select_areaName == "속초시") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "양구군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "양양군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "영월군") {
							window.open(yeongwol_url,'_blank');
						} else if(select_areaName == "원주시") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "정선군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "철원군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "춘천시") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "태백시") {
							window.open(taebaek_url,'_blank');
						} else if(select_areaName == "평창군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "홍천군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "횡성군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "화천군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "인제군") {
							window.open(gangwon_url,'_blank');
						} else if(select_areaName == "청주시") {
							window.open(cheongju_url,'_blank');
						} else if(select_areaName == "충주시") {
							window.open(chungju_url,'_blank');
						} else if(select_areaName == "제천시") {
							window.open(jecheon_url,'_blank');
						} else if(select_areaName == "보은군") {
							window.open(boeun_url,'_blank');
						} else if(select_areaName == "옥천군") {
							window.open(okcheon_url,'_blank');
						} else if(select_areaName == "영동군") {
							window.open(yeongdong_url,'_blank');
						} else if(select_areaName == "증평군") {
							window.open(jeungpyeong_url,'_blank');
						} else if(select_areaName == "진천군") {
							window.open(jincheon_url,'_blank');
						} else if(select_areaName == "괴산군") {
							window.open(goesan_url,'_blank');
						} else if(select_areaName == "음성군") {
							window.open(eumseong_url,'_blank');
						} else if(select_areaName == "단양군") {
							window.open(danyang_url,'_blank');
						} else if(select_areaName == "계룡시") {
							window.open(gyeryong_url,'_blank');
						} else if(select_areaName == "공주시") {
							window.open(gongju_url,'_blank');
						} else if(select_areaName == "금산군") {
							window.open(geumsan_url,'_blank');
						} else if(select_areaName == "논산시") {
							window.open(nonsan_url,'_blank');
						} else if(select_areaName == "당진시") {
							window.open(dangjin_url,'_blank');
						} else if(select_areaName == "보령시") {
							window.open(boryeong_url,'_blank');
						} else if(select_areaName == "부여군") {
							window.open(buyeo_url,'_blank');
						} else if(select_areaName == "서산시") {
							window.open(seosan_url,'_blank');
						} else if(select_areaName == "서천군") {
							window.open(seocheon_url,'_blank');
						} else if(select_areaName == "아산시") {
							window.open(asan_url,'_blank');
						} else if(select_areaName == "예산군") {
							window.open(yesan_url,'_blank');
						} else if(select_areaName == "천안시") {
							window.open(cheonan_url,'_blank');
						} else if(select_areaName == "청양군") {
							window.open(cheongyang_url,'_blank');
						} else if(select_areaName == "태안군") {
							window.open(taean_url,'_blank');
						} else if(select_areaName == "홍성군") {
							window.open(hongseong_url,'_blank');
						} else if(select_areaName == "강진군") {
							window.open(gangjin_url,'_blank');
						} else if(select_areaName == "고흥군") {
							window.open(goheung_url,'_blank');
						} else if(select_areaName == "곡성군") {
							window.open(gokseong_url,'_blank');
						} else if(select_areaName == "광양시") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "구례군") {
							window.open(gurye_url,'_blank');
						} else if(select_areaName == "나주시") {
							window.open(naju_url,'_blank');
						} else if(select_areaName == "담양군") {
							window.open(damyang_url,'_blank');
						} else if(select_areaName == "목포시") {
							alert("사이트 구축 전입니다.")
						} else if(select_areaName == "무안군") {
							window.open(muan_url,'_blank');
						} else if(select_areaName == "보성군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "순천시") {
							window.open(suncheon_url,'_blank');
						} else if(select_areaName == "신안군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "여수시") {
							window.open(yeosu_url,'_blank');
						} else if(select_areaName == "영광군") {
							window.open(yeonggwang_url,'_blank');
						} else if(select_areaName == "영암군") {
							window.open(yeongam_url,'_blank');
						} else if(select_areaName == "완도군") {
							window.open(wando_url,'_blank');
						} else if(select_areaName == "장성군") {
							window.open(jangseong_url,'_blank');
						} else if(select_areaName == "장흥군") {
							window.open(jangheung_url,'_blank');
						} else if(select_areaName == "진도군") {
							window.open(jindo_url,'_blank');
						} else if(select_areaName == "함평군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "해남군") {
							window.open(haenam_url,'_blank');
						} else if(select_areaName == "화순군") {
							window.open(hwasun_url,'_blank');
						} else if(select_areaName == "고창군") {
							window.open(gochang_url,'_blank');
						} else if(select_areaName == "군산시") {
							window.open(gunsan_url,'_blank');
						} else if(select_areaName == "김제시") {
							window.open(gimje_url,'_blank');
						} else if(select_areaName == "남원시") {
							window.open(namwon_url,'_blank');
						} else if(select_areaName == "무주군") {
							window.open(muju_url,'_blank');
						} else if(select_areaName == "부안군") {
							window.open(buan_url,'_blank');
						} else if(select_areaName == "순창군") {
							window.open(sunchang_url,'_blank');
						} else if(select_areaName == "완주군") {
							window.open(wanju_url,'_blank');
						} else if(select_areaName == "익산시") {
							window.open(iksan_url,'_blank');
						} else if(select_areaName == "임실군") {
							window.open(imsil_url,'_blank');
						} else if(select_areaName == "장수군") {
							window.open(jangsu_url,'_blank');
						} else if(select_areaName == "전주시") {
							window.open(jeonju_url,'_blank');
						} else if(select_areaName == "정읍시") {
							window.open(jeongeup_url,'_blank');
						} else if(select_areaName == "진안군") {
							window.open(jinan_url,'_blank');
						} else if(select_areaName == "거제시") {
							window.open(geoje_url,'_blank');
						} else if(select_areaName == "거창군") {
							window.open(geochang_url,'_blank');
						} else if(select_areaName == "고창군") {
							window.open(goseong_url,'_blank');
						} else if(select_areaName == "김해시") {
							window.open(gimhae_url,'_blank');
						} else if(select_areaName == "남해군") {
							window.open(namhae_url,'_blank');
						} else if(select_areaName == "밀양시") {
							window.open(miryang_url,'_blank');
						} else if(select_areaName == "사천시") {
							window.open(sacheon_url,'_blank');
						} else if(select_areaName == "산청군") {
							window.open(sancheong_url,'_blank');
						} else if(select_areaName == "양산시") {
							window.open(yangsan_url,'_blank');
						} else if(select_areaName == "의령군") {
							window.open(uiryeong_url,'_blank');
						} else if(select_areaName == "진주시") {
							window.open(jinju_url,'_blank');
						} else if(select_areaName == "창녕군") {
							window.open(changnyeong_url,'_blank');
						} else if(select_areaName == "창원시") {
							window.open(changwon_url,'_blank');
						} else if(select_areaName == "통영시") {
							window.open(tongyeong_url,'_blank');
						} else if(select_areaName == "하동군") {
							window.open(hadong_url,'_blank');
						} else if(select_areaName == "함안군") {
							window.open(haman_url,'_blank');
						} else if(select_areaName == "함양군") {
							window.open(hamyang_url,'_blank');
						} else if(select_areaName == "합천군") {
							window.open(hapcheon_url,'_blank');
						} else if(select_areaName == "경산시") {
							window.open(gyeongsan_url,'_blank');
						} else if(select_areaName == "경주시") {
							window.open(gyeongju_url,'_blank');
						} else if(select_areaName == "고령군") {
							window.open(goryeong_url,'_blank');
						} else if(select_areaName == "구미시") {
							window.open(gumi_url,'_blank');
						} else if(select_areaName == "군위군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "김천시") {
							window.open(gimcheon_url,'_blank');
						} else if(select_areaName == "문경시") {
							window.open(munkyeong_url,'_blank');
						} else if(select_areaName == "봉화군") {
							window.open(bonghwa_url,'_blank');
						} else if(select_areaName == "상주시") {
							window.open(sangju_url,'_blank');
						} else if(select_areaName == "성주군") {
							window.open(seongju_url,'_blank');
						} else if(select_areaName == "안동시") {
							window.open(andong_url,'_blank');
						} else if(select_areaName == "영덕군") {
							window.open(yeongdeok_url,'_blank');
						} else if(select_areaName == "영양군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "영주시") {
							window.open(yeongju_url,'_blank');
						} else if(select_areaName == "영천시") {
							window.open(yeongcheon_url,'_blank');
						} else if(select_areaName == "예천군") {
							window.open(yeocheon_url,'_blank');
						} else if(select_areaName == "울릉군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "울진군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "의성군") {
							window.open(uiseong_url,'_blank');
						} else if(select_areaName == "청도군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "청송군") {
							window.open(cheongsong_url,'_blank');
						} else if(select_areaName == "칠곡군") {
							alert("사이트 구축 전입니다.");
						} else if(select_areaName == "포항시") {
							alert("사이트 구축 전입니다.");
						}
					}
					return false;
				}
			},
			mouseover:function(){
				var index = $(this).index();
				if( index != area_index ){
					$( "." + select_wholeCode + " .map" + index ).addClass( "on" );
					$( "." + select_wholeCode + " .area_name li.txt" + index).addClass( "on" );
				}
			},
			mouseout:function(){
				var index = $(this).index();
				if( index != area_index ){
					$( "." + select_wholeCode + " .map" + index ).removeClass( "on" );
					$( "." + select_wholeCode + " .area_name li.txt" + index).removeClass( "on" );
				}
			},
		});
		
		function show_list(nm) {
			
			var str = "<table summary=\"문화관광해설사 예약사이트 검색결과 테이블입니다.\"><caption>문화관광해설사 예약사이트 검색 결과</caption><colgroup><col width=\"50%\" /><col width=\"15%\" /><col width=\"15%\" /><col width=\"20%\" /></colgroup>";
            str = str + "<thead><tr><th scope=\"col\">지역</th><th scope=\"col\">예약</th><th scope=\"col\">안내</th><th scope=\"col\">전화번호</th></tr></thead><tbody>";
			if(nm == "서울") {
				str = str + "<tr><td>서울도보관광예약</td><td><a href=\""+seoul_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+seoul_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>02)6925-0777</td></tr>";
			} else if(nm == "부산") {
				str = str + "<tr><td>부산관광공사</td><td><a href=\""+busan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+busan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>051)780-2168</td></tr>";
			} else if(nm == "대구") {
				str = str + "<tr><td>대구광역시 관광협회</td><td><a href=\""+daegu_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+daegu_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>053)746-6407</td></tr>";
			} else if(nm == "인천" || nm == "강화" || nm == "옹진") {
				str = str + "<tr><td>인천시내</td><td><a href=\""+incheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+incheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>032)440-4055</td></tr>";
				str = str + "<tr><td>강화권</td><td><a href=\""+incheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+incheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>032)930-3524,4339</td></tr>";
				str = str + "<tr><td>옹진권</td><td><a href=\""+incheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+incheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>032)899-2214</td></tr>";
			} else if(nm == "광주") {
				str = str + "<tr><td>광주관광 진흥과</td><td><a href=\""+gwangju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gwangju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>062)613-3634</td></tr>";
			} else if(nm == "대전") {
				str = str + "<tr><td>대전광역시 관광협회</td><td><a href=\""+daejeon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+daejeon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>042)226-8413</td></tr>";
			} else if(nm == "울산") {
				str = str + "<tr><td>울산 관광</td><td><a href=\""+ulsan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+ulsan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>052)120</td></tr>";
			} else if(nm == "세종시") {
				str = str + "<tr><td>세종특별자치시</td><td><a href=\""+sejong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+sejong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>044)120</td></tr>";
			} else if(nm == "경기도") {
				str = str + "<tr><td>수원시</td><td><a href=\""+suwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+suwon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)290-3623</td></tr>";
				str = str + "<tr><td>성남시</td><td><a href=\""+seongnam_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+seongnam_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)729-2992</td></tr>";
				str = str + "<tr><td>의정부</td><td></td>";
				str = str + "<td><a href=\""+uijeongbu_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>828-2692</td></tr>";
				str = str + "<tr><td>안양시</td><td><a href=\""+anyang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+anyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)8045-2449</td></tr>";
				str = str + "<tr><td>부천시</td><td><a href=\""+bucheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+bucheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>032)651-3739</td></tr>";
				str = str + "<tr><td>광명시 문화관광</td><td><a href=\""+gwangmyeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gwangmyeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>02)2680-0761</td></tr>";
				str = str + "<tr><td>평택 문화관광</td><td><a href=\""+pyeongtaek_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+pyeongtaek_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)8024-3232</td></tr>";
				str = str + "<tr><td>동두천시 문화관광</td><td><a href=\""+dongducheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+dongducheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)860-2067</td></tr>";
				str = str + "<tr><td>안산시</td><td></td>";
				str = str + "<td><a href=\""+ansan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td></td></tr>";
				str = str + "<tr><td>고양시 문화관광</td><td><a href=\""+goyang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+goyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)8075-3412</td></tr>";
				str = str + "<tr><td>과천시 문화관광</td><td><a href=\""+gwacheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gwacheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>02)3677-2476</td></tr>";
				str = str + "<tr><td>구리시 문화관광</td><td><a href=\""+guri_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+guri_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)550-8353,2565</td></tr>";
				str = str + "<tr><td>남양주시 문화관광</td><td><a href=\""+namyangju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+namyangju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)590-4243</td></tr>";
				str = str + "<tr><td>오산문화원</td><td><a href=\""+osan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+osan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)375-7755</td></tr>";
				str = str + "<tr><td>시흥시</td><td><a href=\""+siheung_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+siheung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)310-6743</td></tr>";
				str = str + "<tr><td>군포시</td><td></td>";
				str = str + "<td><a href=\""+siheung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)310-6743</td></tr>";
				str = str + "<tr><td>의왕시</td><td></td>";
				str = str + "<td><a href=\""+siheung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)310-6743</td></tr>";
				str = str + "<tr><td>하님시</td><td></td>";
				str = str + "<td><a href=\""+siheung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)310-6743</td></tr>";
				str = str + "<tr><td>투어용인</td><td><a href=\""+yongin_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yongin_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)324-2068</td></tr>";
				str = str + "<tr><td>파주 문화관광</td><td><a href=\""+paju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+paju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)953-4744</td></tr>";
				str = str + "<tr><td>이천 문화관광</td><td><a href=\""+icheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+icheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)634-6770</td></tr>";
				str = str + "<tr><td>안성문화관광</td><td><a href=\""+ansung_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+ansung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)677-1330</td></tr>";
				str = str + "<tr><td>김포시 문화관광</td><td><a href=\""+gimpo_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gimpo_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)980-2481</td></tr>";
				str = str + "<tr><td>화성시 문화관광</td><td><a href=\""+hwaseong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hwaseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)369-6018</td></tr>";
				str = str + "<tr><td>광주시 문화관광</td><td><a href=\""+gwangjusi_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gwangjusi_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)746-1088</td></tr>";
				str = str + "<tr><td>양주시</td><td><a href=\""+yangju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yangju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)840-3357</td></tr>";
				str = str + "<tr><td>포천시 문화관광</td><td><a href=\""+pocheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+pocheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)538-2069</td></tr>";
				str = str + "<tr><td>여주시 문화관광</td><td><a href=\""+yeoju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeoju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)887-2868</td></tr>";
				str = str + "<tr><td>연천군 문화관광</td><td><a href=\""+yeoncheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeoncheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)839-2063</td></tr>";
				str = str + "<tr><td>가평군</td><td><a href=\""+gapyeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gapyeong_url+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)580-2066~7</td></tr>";
				str = str + "<tr><td>양평관광</td><td><a href=\""+yangpyeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yangpyeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>031)770-2069</td></tr>";
			} else if(nm == "강원도") {
				str = str + "<tr><td>강원도 통합 예약페이지</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td></td><td></td></tr>";
				str = str + "<tr><td>춘천시</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+chuncheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)250-3269</td></tr>";
				str = str + "<tr><td>원주시</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+wonju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)737-5103</td></tr>";
				str = str + "<tr><td>강릉시</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gangneung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)640-5132</td></tr>";
				str = str + "<tr><td>동해시</td><td><a href=\""+donghae_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+donghae_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)530-2232</td></tr>";
				str = str + "<tr><td>태백시</td><td><a href=\""+taebaek_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+taebaek_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)550-2379</td></tr>";
				str = str + "<tr><td>속초시</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+sokcho_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)570-3545</td></tr>";
				str = str + "<tr><td>삼척시</td><td><a href=\""+samcheok_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+samcheok_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)570-3545</td></tr>";
				str = str + "<tr><td>홍천군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hongcheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)430-2472</td></tr>";
				str = str + "<tr><td>횡성군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hoengseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)340-2547</td></tr>";
				str = str + "<tr><td>영월군</td><td><a href=\""+yeongwol_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeongwol_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)370-2931</td></tr>";
				str = str + "<tr><td>평창군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+pyeonchang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)330-2762</td></tr>";
				str = str + "<tr><td>정선군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jeongseon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)560-2362</td></tr>";
				str = str + "<tr><td>철원군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+cheorwon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)450-5558</td></tr>";
				str = str + "<tr><td>화천군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hwacheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)440-2529</td></tr>";
				str = str + "<tr><td>양구군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yanggu_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)570-3545</td></tr>";
				str = str + "<tr><td>인제군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+inje_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)460-2082</td></tr>";
				str = str + "<tr><td>고성군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+goseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)680-3362</td></tr>";
				str = str + "<tr><td>양양군</td><td><a href=\""+gangwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yangyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>033)670-2722</td></tr>";
			} else if(nm == "충청북도") {
				str = str + "<tr><td>충청북도 문화관광</td><td><a href=\""+chungbuk_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+chungbuk_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)220-4003</td></tr>";
				str = str + "<tr><td>청주시 문화관광</td><td><a href=\""+cheongju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+cheongju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)201-2043</td></tr>";
				str = str + "<tr><td>충주시 문화관광</td><td><a href=\""+chungju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+chungju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)850-6724</td></tr>";
				str = str + "<tr><td>제천시 문화관광</td><td><a href=\""+jecheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jecheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)641-6731</td></tr>";
				str = str + "<tr><td>보은군 문화관광</td><td><a href=\""+boeun_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+boeun_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)540-3392</td></tr>";
				str = str + "<tr><td>옥천군 문화관광</td><td><a href=\""+okcheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+okcheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)730-3415</td></tr>";
				str = str + "<tr><td>영동군 문화관광</td><td><a href=\""+yeongdong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeongdong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)740-3205</td></tr>";
				str = str + "<tr><td>증평군 문화관광</td><td><a href=\""+jeungpyeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jeungpyeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)835-4161</td></tr>";
				str = str + "<tr><td>진천군 문화관광</td><td><a href=\""+jincheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jincheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)539-3602</td></tr>";
				str = str + "<tr><td>괴산군 문화관광</td><td><a href=\""+goesan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+goesan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)542-5268~9</td></tr>";
				str = str + "<tr><td>음성군 문화관광</td><td><a href=\""+eumseong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+eumseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)871-3403</td></tr>";
				str = str + "<tr><td>단양군 문화관광</td><td><a href=\""+danyang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+danyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>043)420-2553</td></tr>";
			} else if(nm == "충청남도") {
				str = str + "<tr><td>천안시 문화관광</td><td><a href=\""+cheonan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+cheonan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)521-5158</td></tr>";
				str = str + "<tr><td>공주시 문화관광</td><td><a href=\""+gongju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gongju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>010-5024-2421</td></tr>";
				str = str + "<tr><td>보령시 문화관광</td><td><a href=\""+boryeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+boryeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)930-3872</td></tr>";
				str = str + "<tr><td>아산시 문화관광</td><td><a href=\""+asan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+asan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)540-2110</td></tr>";
				str = str + "<tr><td>서산시 문화관광</td><td><a href=\""+seosan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+seosan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)660-2114</td></tr>";
				str = str + "<tr><td>논산시 문화관광</td><td><a href=\""+nonsan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+nonsan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)746-5403</td></tr>";
				str = str + "<tr><td>나라사랑 계룡대견학</td><td><a href=\""+gyeryong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gyeryong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>042)551-1920</td></tr>";
				str = str + "<tr><td>당진시 문화관광</td><td><a href=\""+dangjin_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+dangjin_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)358-3357</td></tr>";
				str = str + "<tr><td>금산군 문화관광</td><td><a href=\""+geumsan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+geumsan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)750-2391~3</td></tr>";
				str = str + "<tr><td>부여시 문화관광</td><td><a href=\""+buyeo_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+buyeo_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)830-2242</td></tr>";
				str = str + "<tr><td>서천군 문화관광</td><td><a href=\""+seocheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+seocheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)950-4256</td></tr>";
				str = str + "<tr><td>청양군 문화관광</td><td><a href=\""+cheongyang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+cheongyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)940-2493</td></tr>";
				str = str + "<tr><td>홍성군 문화관광</td><td><a href=\""+hongseong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hongseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)633-1141</td></tr>";
				str = str + "<tr><td>예산군 문화관광</td><td><a href=\""+yesan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yesan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)339-7321~3</td></tr>";
				str = str + "<tr><td>태안군 문화관광</td><td><a href=\""+taean_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+taean_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>041)670-2766</td></tr>";
			} else if(nm == "전라남도") {
				str = str + "<tr><td>목포시 문화관광</td><td></td>";
				str = str + "<td><a href=\""+mokpo_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)270-8567,3256</td></tr>";
				str = str + "<tr><td>여수시 문화관광</td><td><a href=\""+yeosu_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeosu_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)659-3876</td></tr>";
				str = str + "<tr><td>순천시 문화관광</td><td><a href=\""+suncheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+suncheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)749-5810</td></tr>";
				str = str + "<tr><td>나주시 문화관광</td><td><a href=\""+naju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+naju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)339-8592</td></tr>";
				str = str + "<tr><td>광양시 문화관광</td><td></td>";
				str = str + "<td><a href=\""+gwangyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)797-2721</td></tr>";
				str = str + "<tr><td>담양군 문화관광</td><td><a href=\""+damyang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+damyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)380-3154</td></tr>";
				str = str + "<tr><td>곡성군 문화관광</td><td><a href=\""+gokseong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gokseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)360-8379</td></tr>";
				str = str + "<tr><td>구례군 문화관광</td><td><a href=\""+gurye_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gurye_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)780-2450</td></tr>";
				str = str + "<tr><td>고흥군 문화관광</td><td><a href=\""+goheung_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+goheung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)830-5347</td></tr>";
				str = str + "<tr><td>보성군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+boseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)850-5212</td></tr>";
				str = str + "<tr><td>화순군 문화관광</td><td><a href=\""+hwasun_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hwasun_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)379-3501</td></tr>";
				str = str + "<tr><td>장흥군 문화관광</td><td><a href=\""+jangheung_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jangheung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>(주간)061)860-0224,0380<br/>(야간, 토일)061)863-7071</td></tr>";
				str = str + "<tr><td>강진군 문화관광</td><td><a href=\""+gangjin_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gangjin_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)430-3316</td></tr>";
				str = str + "<tr><td>해남군 문화관광</td><td><a href=\""+haenam_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+haenam_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)530-5917</td></tr>";
				str = str + "<tr><td>영암군 문화관광</td><td><a href=\""+yeongam_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeongam_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)470-2255</td></tr>";
				str = str + "<tr><td>무안군 문화관광</td><td><a href=\""+muan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+muan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)450-5114</td></tr>";
				str = str + "<tr><td>함평군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+hampyeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)320-3733</td></tr>";
				str = str + "<tr><td>영광군 문화관광</td><td><a href=\""+yeonggwang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeonggwang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)350-5752</td></tr>";
				str = str + "<tr><td>장성군 문화관광</td><td><a href=\""+jangseong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jangseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)390-7242</td></tr>";
				str = str + "<tr><td>완도군 문화관광</td><td><a href=\""+wando_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+wando_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)550-5413</td></tr>";
				str = str + "<tr><td>진도군 문화관광</td><td><a href=\""+jindo_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jindo_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)540-3405,3408</td></tr>";
				str = str + "<tr><td>신안군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+shinan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>061)240-8359</td></tr>";
			} else if(nm == "전라북도") {
				str = str + "<tr><td>전주시 문화관광</td><td><a href=\""+jeonju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jeonju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)281-5046</td></tr>";
				str = str + "<tr><td>군산시 문화관광</td><td><a href=\""+gunsan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gunsan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)454-3335</td></tr>";
				str = str + "<tr><td>익산시 문화관광</td><td><a href=\""+iksan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+iksan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)859-5824</td></tr>";
				str = str + "<tr><td>정읍시 문화관광</td><td><a href=\""+jeongeup_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jeongeup_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)539-5231</td></tr>";
				str = str + "<tr><td>남원시 문화관광</td><td><a href=\""+namwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+namwon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)620-6165</td></tr>";
				str = str + "<tr><td>김제시 문화관광</td><td><a href=\""+gimje_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gimje_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)540-3241</td></tr>";
				str = str + "<tr><td>완주군 문화관광</td><td><a href=\""+wanju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+wanju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)290-2623</td></tr>";
				str = str + "<tr><td>진안군 문화관광</td><td><a href=\""+jinan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jinan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)430-8709 </td></tr>";
				str = str + "<tr><td>무주군 문화관광</td><td><a href=\""+muju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+muju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)320-2570</td></tr>";
				str = str + "<tr><td>장수군 문화관광</td><td><a href=\""+jangsu_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jangsu_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)350-5557</td></tr>";
				str = str + "<tr><td>임실군 문화관광</td><td><a href=\""+imsil_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+imsil_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)640-2344</td></tr>";
				str = str + "<tr><td>순창군 문화관광</td><td><a href=\""+sunchang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+sunchang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)650-1648</td></tr>";
				str = str + "<tr><td>고창군 문화관광</td><td><a href=\""+gochang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gochang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)560-2458</td></tr>";
				str = str + "<tr><td>부안군 문화관광</td><td><a href=\""+buan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+buan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>063)580-4395</td></tr>";
			} else if(nm == "경상남도") {
				str = str + "<tr><td>경상남도 문화관광</td><td><a href=\""+gyeongnam_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td></td><td>1330</td></tr>";
				str = str + "<tr><td>창원시 문화관광</td><td><a href=\""+changwon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+changwon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)225-3701</td></tr>";
				str = str + "<tr><td>진주시 문화관광</td><td><a href=\""+jinju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+jinju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)749-5321</td></tr>";
				str = str + "<tr><td>통영시 문화관광</td><td><a href=\""+tongyeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+tongyeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)650-0510</td></tr>";
				str = str + "<tr><td>사천시 문화관광</td><td><a href=\""+sacheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+sacheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)831-2727</td></tr>";
				str = str + "<tr><td>김해시 문화관광</td><td><a href=\""+gimhae_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gimhae_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)338-1330</td></tr>";
				str = str + "<tr><td>밀양시 문화관광</td><td><a href=\""+miryang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+miryang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)359-5646</td></tr>";
				str = str + "<tr><td>거제시 문화관광</td><td><a href=\""+geoje_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+geoje_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)639-4174</td></tr>";
				str = str + "<tr><td>양산시 문화관광</td><td><a href=\""+yangsan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yangsan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)374-5211</td></tr>";
				str = str + "<tr><td>의령군 문화관광</td><td><a href=\""+uiryeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+uiryeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)570-2444</td></tr>";
				str = str + "<tr><td>함안군  문화관광</td><td><a href=\""+haman_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+haman_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)580-2344</td></tr>";
				str = str + "<tr><td>창녕군 문화관광</td><td><a href=\""+changnyeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+changnyeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)530-1999</td></tr>";
				str = str + "<tr><td>고성군 문화관광</td><td><a href=\""+goseong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+goseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)670-3173</td></tr>";
				str = str + "<tr><td>남해군 문화관광</td><td><a href=\""+namhae_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+namhae_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)860-8606</td></tr>";
				str = str + "<tr><td>하동군  문화관광</td><td><a href=\""+hadong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hadong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)880-2379</td></tr>";
				str = str + "<tr><td>산청군 문화관광</td><td><a href=\""+sancheong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+sancheong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)970-6421~3</td></tr>";
				str = str + "<tr><td>함양군  문화관광</td><td><a href=\""+hamyang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hamyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)960-5163</td></tr>";
				str = str + "<tr><td>거창시 문화관광</td><td><a href=\""+geochang_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+geochang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)940-3420</td></tr>";
				str = str + "<tr><td>합천군  문화관광</td><td><a href=\""+hapcheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+hapcheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>055)930-4667</td></tr>";
			} else if(nm == "경상북도") {
				str = str + "<tr><td>경상북도 문화관광</td><td><a href=\""+gyeongbuk_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td></td><td>054)745-0753</td></tr>";
				str = str + "<tr><td>포항시 문화관광</td><td></td>";
				str = str + "<td><a href=\""+pohang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)270-2374</td></tr>";
				str = str + "<tr><td>경주시 문화관광</td><td><a href=\""+gyeongju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gyeongju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>053)741-2594</td></tr>";
				str = str + "<tr><td>김천시 문화관광</td><td><a href=\""+gimcheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gimcheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)439-1330</td></tr>";
				str = str + "<tr><td>안동시 문화관광</td><td><a href=\""+andong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+andong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)856-3013,840-6591</td></tr>";
				str = str + "<tr><td>구미시 문화관광</td><td><a href=\""+gumi_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gumi_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)480-6613</td></tr>";
				str = str + "<tr><td>영주시 문화관광</td><td><a href=\""+yeongju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeongju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)639-6606</td></tr>";
				str = str + "<tr><td>영천시 문화관광</td><td><a href=\""+yeongcheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeongcheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)330-6585</td></tr>";
				str = str + "<tr><td>상주시 문화관광</td><td><a href=\""+sangju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+sangju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)537-7108</td></tr>";
				str = str + "<tr><td>문경시 문화관광</td><td><a href=\""+munkyeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+munkyeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)550-6391</td></tr>";
				str = str + "<tr><td>경산시 문화관광</td><td><a href=\""+gyeongsan_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+gyeongsan_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>053)810-5363</td></tr>";
				str = str + "<tr><td>군위군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+gunwi_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)380-6915</td></tr>";
				str = str + "<tr><td>의성군 문화관광</td><td><a href=\""+uiseong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+uiseong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)830-6550</td></tr>";
				str = str + "<tr><td>청송군 문화관광</td><td><a href=\""+cheongsong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+cheongsong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)870-6240</td></tr>";
				str = str + "<tr><td>영양군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+yeongyang_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)680-6413</td></tr>";
				str = str + "<tr><td>영덕군 문화관광</td><td><a href=\""+yeongdeok_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeongdeok_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)730-6533</td></tr>";
				str = str + "<tr><td>청도군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+cheongdo_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)370-2378</td></tr>";
				str = str + "<tr><td>고령군 문화관광</td><td><a href=\""+goryeong_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+goryeong_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)950-7103</td></tr>";
				str = str + "<tr><td>성주군 문화관광</td><td><a href=\""+seongju_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+seongju_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)930-6772</td></tr>";
				str = str + "<tr><td>칠곡군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+chilgok_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)979-6093</td></tr>";
				str = str + "<tr><td>예천군 문화관광</td><td><a href=\""+yeocheon_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+yeocheon_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)650-6902</td></tr>";
				str = str + "<tr><td>봉화군 문화관광</td><td><a href=\""+bonghwa_url+"\" class=\"link btn_reservation\" title=\"예약\" target=\"_blank\">예약</a></td>";
				str = str + "<td><a href=\""+bonghwa_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)679-6343</td></tr>";
				str = str + "<tr><td>울진군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+uljin_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)789-6902</td></tr>";
				str = str + "<tr><td>울릉군 문화관광</td><td></td>";
				str = str + "<td><a href=\""+ulleung_info+"\" class=\"link btn_guide\" title=\"안내\" target=\"_blank\">안내</a></td><td>054)790-6392</td></tr>";
			} 
			str = str + "</tbody></table>"
			document.getElementById("reservation_list").innerHTML=str;
		}
		
		

	});
</script>

</head>

<body>
	<div class="wrap">
    	<header>
        	<section class="head">
            	<h1 class="logo"><img src="reservation/images/logo.png" alt="문화관광해설사 통합예약사이트"></h1>
                <div class="info_title">
                	<p class="title_t">여행을 보다 쉽고 풍요롭게</p>
                    <p class="title_b">문화관광해설사가 여행을 더욱 즐겁고 유익하게 만들어 드립니다.</p>
                </div>
            </section>
        </header>
        <section class="main_contents">
        	<article class="info_txt"><span class="txt">˙지역을 선택해 주세요.</span></article>
        	<article class="maps">
            	<div class="whole_map">
                	<div class="map">
                    	<span class="map0"></span>
                        <span class="map1"></span>
                        <span class="map2"></span>
                        <span class="map3"></span>
                        <span class="map4"></span>
                        <span class="map5"></span>
                        <span class="map6"></span>
                        <span class="map7"></span>
                        <span class="map8"></span>
                        <span class="map9"></span>
                        <span class="map10"></span>
                        <span class="map11"></span>
                        <span class="map12"></span>
                        <span class="map13"></span>
                        <span class="map14"></span>
                        <span class="map15"></span>
                        <span class="map16"></span>
                        <ul class="area_name">
                            <li class="txt0">인천</li>
                            <li class="txt1">서울</li>
                            <li class="txt2">경기도</li>
                            <li class="txt3">강원도</li>
                            <li class="txt4">충청남도</li>
                            <li class="txt5">세종시</li>
                            <li class="txt6">대전</li>
                            <li class="txt7">충청북도</li>
                            <li class="txt8">경상북도</li>
                            <li class="txt9">대구</li>
                            <li class="txt10">전라북도</li>
                            <li class="txt11">전라남도</li>
                            <li class="txt12">광주</li>
                            <li class="txt13">경상남도</li>
                            <li class="txt14">울산</li>
                            <li class="txt15">부산</li>
                            <li class="txt16">제주도</li>
                        </ul>
                        <div class="map_btns">
                        	<img src="reservation/images/blank_corver.png" width="347" height="480" alt="전체맵 버튼" usemap="#WholeMap" hidefocus="true" >
                            <map name="WholeMap" id="WholeMap">
                                <area class="btn_whole" data-code="m_incheon" alt="인천" title="인천" href="#" shape="poly" coords="55,96,43,100,42,111,46,124,55,134,61,115" />
                                <area class="btn_whole" data-code="m_seoul" alt="서울" title="서울" href="#" shape="poly" coords="88,94,78,92,72,97,70,103,60,105,63,112,70,118,80,115,85,120,94,119,95,108" />
                                <area class="btn_whole" data-code="m_gyeonggi" alt="경기도" title="경기도" href="#" shape="poly" coords="93,47,75,43,68,48,59,64,44,63,35,71,32,84,27,82,20,85,16,94,22,100,28,106,37,108,54,93,58,97,63,99,73,93,84,91,94,91,95,98,98,105,100,115,95,123,83,125,70,123,64,120,62,131,55,135,56,142,55,145,45,149,52,160,56,171,62,180,69,179,83,180,99,183,118,171,130,161,138,154,135,132,137,119,137,110,123,88,120,74,114,64" />
                                <area class="btn_whole m3" data-code="m_gangwon" alt="강원도" title="강원도" href="#" shape="poly" coords="191,1,187,16,174,28,157,35,147,32,138,31,126,30,110,31,102,32,86,39,94,42,102,48,110,56,122,67,127,80,130,95,135,100,141,111,140,132,142,145,151,150,167,149,180,152,186,159,199,163,206,162,210,168,224,160,235,166,246,160,254,159,269,163,278,142,257,100" />
                                <area class="btn_whole" data-code="m_chungnam" alt="충청남도" title="충청남도" href="#" shape="poly" coords="102,187,85,186,77,184,65,183,60,190,54,184,50,180,44,175,36,174,27,171,19,176,20,179,24,183,19,186,14,184,8,184,3,190,2,198,8,208,20,208,34,216,32,223,34,232,32,238,34,243,32,255,36,266,45,274,58,272,72,266,84,270,92,272,100,273,104,278,111,285,116,290,122,282,128,280,132,274,128,266,127,260,125,250,122,248,118,255,116,258,107,261,102,258,99,254,96,248,90,241,85,234,84,228,82,218,81,210,83,205,88,205,96,206,100,210,106,206,107,197" />
                                <area class="btn_whole" data-code="m_sejong" alt="세종시" title="세종시" href="#" shape="poly" coords="92,207,86,206,83,216,83,229,90,238,102,230,100,220" />
                                <area class="btn_whole" data-code="m_daejeon" alt="대전" title="대전" href="#" shape="poly" coords="101,232,94,243,97,256,111,259,119,252,120,242,113,234" />
                                <area class="btn_whole" data-code="m_chungbuk" alt="충청북도" title="충청북도" href="#" shape="poly" coords="163,153,142,155,115,175,104,185,108,201,105,209,100,212,106,228,117,241,124,249,130,264,131,276,144,283,155,280,162,258,163,197,176,196,191,193,202,181,208,172,203,165,183,161,178,155,171,153" />
                                <area class="btn_whole" data-code="m_gyeongbuk" alt="경상북도" title="경상북도" href="#" shape="poly" coords="279,147,270,168,263,167,255,164,245,169,231,169,223,164,212,171,198,187,188,195,179,193,162,194,151,209,147,230,152,247,162,255,160,273,152,283,154,297,163,307,176,308,179,324,192,324,200,323,199,307,199,299,195,294,203,287,215,281,230,281,236,288,236,296,237,305,231,312,226,312,218,319,215,328,239,325,254,319,271,317,298,321,302,295,304,277,291,273,288,257,290,239,288,219,291,206,288,191,287,170,284,155" />
                                <area class="btn_whole" data-code="m_daegu" alt="대구" title="대구" href="#" shape="poly" coords="222,281,211,283,206,288,198,291,194,291,200,304,202,309,204,312,202,321,206,324,212,324,219,317,222,313,228,307,236,300,235,294,232,287,228,281" />
                                <area class="btn_whole" data-code="m_jeonbuk" alt="전라북도" title="전라북도" href="#" shape="poly" coords="140,281,134,281,118,291,115,297,107,292,101,282,98,277,86,277,76,274,71,269,53,278,47,280,43,285,44,292,52,295,54,297,55,304,55,308,51,311,43,311,37,311,34,317,34,329,42,331,39,336,34,336,28,344,20,356,32,359,44,352,51,347,63,348,74,345,81,353,91,356,100,360,118,356,124,359,130,345,128,335,131,323,130,314,138,304,144,297,154,293,155,283" />
                                <area class="btn_whole" data-code="m_jeonnam" alt="전라남도" title="전라남도" href="#" shape="poly" coords="51,368,42,372,38,378,41,390,50,400,62,400,75,387,76,379,65,370,78,356,90,359,108,364,113,360,126,366,136,378,141,390,142,399,135,402,132,404,138,411,139,417,127,423,124,420,124,407,114,406,106,412,112,433,106,442,92,438,97,430,98,420,92,423,86,428,77,433,76,440,70,447,58,448,52,442,50,447,46,452,34,458,26,450,26,440,21,440,13,435,6,425,14,423,22,424,24,416,22,412,18,408,16,400,10,398,11,392,14,386,8,378,16,376,14,372,13,364,14,358,34,359,42,360,48,352,54,348,70,346,76,350,82,359,68,372" />
                                <area class="btn_whole" data-code="m_gwangju" alt="광주" title="광주" href="#" shape="poly" coords="56,367,46,368,38,381,45,393,51,401,68,396,73,388,77,378,67,373" />
                                <area class="btn_whole" data-code="m_gyeongnam" alt="경상남도" title="경상남도" href="#" shape="poly" coords="211,328,199,327,191,327,182,328,173,327,172,316,173,308,164,305,158,299,146,298,143,301,134,312,132,320,134,332,131,341,134,351,130,360,128,368,145,394,154,403,164,393,175,399,184,401,196,400,210,416,219,423,229,407,227,399,216,399,212,389,216,384,216,378,212,375,225,367,239,366,252,358,259,353,260,348,255,339,252,332,252,325,238,328,224,330,184,325" />
                                <area class="btn_whole" data-code="m_ulsan" alt="울산" title="울산" href="#" shape="poly" coords="294,322,283,324,270,324,266,324,259,324,254,327,254,333,261,343,266,346,274,347,277,351,278,359,278,363,283,353,290,347" />
                                <area class="btn_whole" data-code="m_busan" alt="부산" title="부산" href="#" shape="poly" coords="268,350,263,352,260,357,251,361,244,366,242,370,237,371,230,371,221,372,218,378,224,383,235,384,242,384,250,390,260,385,270,376,273,367,273,360,272,353" />
                                <area class="btn_whole" data-code="m_jeju" alt="제주도" title="제주도" href="#" shape="poly" coords="334,440,328,441,319,444,306,444,291,445,280,455,282,469,289,476,292,478,305,480,316,475,327,471,337,472,343,465,346,459,346,449,340,445" />
						</map>
                      </div>
                    </div>
                </div>
                <div class="area_map">
                	<div class="map">
                    	<ul class="map_list">
                        	<li class="area m_incheon" data-name="인천" >
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">강화</li>
                                        <li class="txt1">인천</li>
                                        <li class="txt2">옹진</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="221" height="256" alt="인천맵 버튼" usemap="#incheonMap" hidefocus="true" >
                                        <map name="incheonMap" id="incheonMap">
                                            <area class="btn_area" alt="강화" title="강화" href="#" shape="poly" coords="108,14,102,12,94,16,88,16,85,11,80,6,72,3,64,3,55,4,51,7,44,14,37,16,36,30,37,36,36,49,38,54,30,50,25,45,28,37,25,34,12,40,8,44,6,47,4,53,10,58,18,69,26,74,28,80,32,83,44,78,45,70,46,61,50,68,56,76,48,82,41,82,48,99,56,103,80,103,88,104,98,102,102,108,108,108,112,98,118,92,115,79,116,72,110,64,110,48,115,38,108,32" />
                                            <area class="btn_area" alt="인천" title="인천" href="#" shape="poly" coords="191,95,175,82,164,82,150,93,138,98,134,101,128,106,121,112,96,122,75,126,61,124,31,120,16,119,1,110,2,122,14,130,28,133,45,140,25,147,24,159,38,170,45,178,43,191,49,211,70,204,65,186,79,168,102,160,118,148,137,154,140,166,152,172,162,178,172,190,196,190,217,176,218,154,212,137,214,122,214,112,214,102,196,98" />
                                            <area class="btn_area" alt="옹진" title="옹진" href="#" shape="poly" coords="88,226,76,230,67,242,71,252,88,254,97,242,100,230" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_seoul" data-name="서울">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">서울</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="320" height="290" alt="서울맵 버튼" usemap="#seoulMap" >
                                        <map name="seoulMap" id="seoulMap">
                                        	<area class="btn_area" alt="서울" title="서울" href="javascript:;" shape="poly" coords="244,2,231,6,225,13,220,11,208,10,204,2,196,1,189,6,181,18,177,27,172,37,171,44,169,56,169,66,161,73,149,74,149,64,153,54,144,46,134,46,122,51,111,56,111,69,109,82,104,110,96,115,84,124,71,130,56,124,32,95,19,101,20,115,15,130,5,144,1,153,4,161,18,166,31,163,40,164,40,177,37,202,37,218,32,237,40,242,48,240,65,222,76,222,76,229,84,246,94,269,95,278,106,280,120,268,126,275,141,276,162,262,179,254,180,264,199,253,204,271,209,283,232,290,247,270,264,258,290,234,300,215,286,208,290,188,301,176,312,170,316,152,308,130,295,137,275,138,266,156,256,151,256,135,263,115,267,103,269,90,262,85,267,76,265,63,260,58,253,54,256,38,256,31,250,23,253,19,250,8" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_gyeonggi" data-name="경기도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                        <span class="map11"></span>
                                        <span class="map12"></span>
                                        <span class="map13"></span>
                                        <span class="map14"></span>
                                        <span class="map15"></span>
                                        <span class="map16"></span>
                                        <span class="map17"></span>
                                        <span class="map18"></span>
                                        <span class="map19"></span>
                                        <span class="map20"></span>
                                        <span class="map21"></span>
                                        <span class="map22"></span>
                                        <span class="map23"></span>
                                        <span class="map24"></span>
                                        <span class="map25"></span>
                                        <span class="map26"></span>
                                        <span class="map27"></span>
                                        <span class="map28"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">연천군</li>
                                        <li class="txt1">파주시</li>
                                        <li class="txt2">양주시</li>
                                        <li class="txt3">동두천</li>
                                        <li class="txt4">포천시</li>
                                        <li class="txt5">김포시</li>
                                        <li class="txt6">고양시</li>
                                        <li class="txt7">의정부</li>
                                        <li class="txt8">부천</li>
                                        <li class="txt9">광명</li>
                                        <li class="txt10">과천</li>
                                        <li class="txt11">시흥</li>
                                        <li class="txt12">안양</li>
                                        <li class="txt13">의왕</li>
                                        <li class="txt14">수원</li>
                                        <li class="txt15">화성시</li>
                                        <li class="txt16">오산</li>
                                        <li class="txt17">평택시</li>
                                        <li class="txt18">가평군</li>
                                        <li class="txt19">남양주</li>
                                        <li class="txt20">구리시</li>
                                        <li class="txt21">양평군</li>
                                        <li class="txt22">성남시</li>
                                        <li class="txt23">광주시</li>
                                        <li class="txt24">여주시</li>
                                        <li class="txt25">이천시</li>
                                        <li class="txt26">용인시</li>
                                        <li class="txt27">안성시</li>
                                        <li class="txt28">안산</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="304" height="295" alt="경기맵 버튼" usemap="#gyeonggiMap" hidefocus="true" >
                                        <map name="gyeonggiMap" id="gyeonggiMap">
                                            <area class="btn_area" alt="연천군" title="연천군" href="#" shape="poly" coords="155,8,148,8,143,1,134,2,119,13,114,22,110,30,98,40,85,47,81,58,96,62,112,56,123,58,120,66,124,67,134,62,146,64,151,57,144,49,146,41,155,40,156,28" />
                                            <area class="btn_area" alt="파주시" title="파주시" href="#" shape="poly" coords="116,59,101,63,95,65,82,62,74,62,64,59,48,59,44,64,51,76,51,90,50,103,56,118,86,113,97,113,105,108,100,100,100,91,107,86,108,74,118,63" />
                                            <area class="btn_area" alt="양주시" title="양주시" href="#" shape="poly" coords="119,70,112,78,109,86,106,93,105,99,110,107,104,123,113,122,119,119,128,108,143,108,143,90,135,86,123,78" />
                                            <area class="btn_area" alt="동두천" title="동두천" href="#" shape="poly" coords="139,68,130,67,124,72,131,78,139,80,144,85,150,80,146,76,142,68" />
                                            <area class="btn_area" alt="포천시" title="포천시" href="#" shape="poly" coords="183,20,179,21,168,27,165,27,162,20,160,32,160,41,159,46,150,46,148,49,154,55,149,71,152,80,152,87,147,98,147,111,167,105,178,103,183,81,187,75,199,71,198,59,215,46,212,38,202,33,191,36,183,32" />
                                            <area class="btn_area" alt="김포시" title="김포시" href="#" shape="poly" coords="46,105,35,108,17,102,18,108,22,115,23,127,27,144,36,152,57,142,62,150,73,150,76,139,63,132,51,121" />
                                            <area class="btn_area" alt="고양시" title="고양시" href="#" shape="poly" coords="102,114,95,116,88,116,60,122,64,130,77,134,82,140,88,144,99,143,102,134,111,131,113,135,115,134,120,128,112,124,106,126,100,126" />
                                            <area class="btn_area" alt="의정부" title="의정부" href="#" shape="poly" coords="146,114,131,113,126,115,124,123,134,124,141,123" />
                                            <area class="btn_area" alt="부천" title="부천" href="#" shape="poly" coords="82,156,73,153,67,156,68,171,80,166" />
                                            <area class="btn_area" alt="광명" title="광명" href="#" shape="poly" coords="95,164,85,169,90,180,102,177" />
                                            <area class="btn_area" alt="과천" title="과천" href="#" shape="poly" coords="126,170,119,170,115,175,117,184,128,178" />
                                            <area class="btn_area" alt="시흥" title="시흥" href="#" shape="poly" coords="80,171,70,174,68,181,60,189,54,205,68,194,74,183,85,179,84,174" />
                                            <area class="btn_area" alt="안양" title="안양" href="#" shape="poly" coords="112,175,106,176,102,180,87,184,88,194,93,200,102,207,104,196,110,195,114,185" />
                                            <area class="btn_area" alt="의왕" title="의왕" href="#" shape="poly" coords="130,180,118,186,114,198,122,198,130,196" />
                                            <area class="btn_area" alt="수원" title="수원" href="#" shape="poly" coords="128,199,117,202,111,203,107,210,120,216,130,215,136,211" />
                                            <area class="btn_area" alt="화성시" title="화성시" href="#" shape="poly" coords="91,202,79,206,64,214,54,212,40,218,32,211,28,211,19,224,22,232,43,230,47,241,57,247,71,241,70,251,68,266,85,264,103,251,118,252,118,238,114,225,123,222,136,226,142,234,144,241,154,230,151,224,142,227,134,219,114,219,102,212" />
                                            <area class="btn_area" alt="오산" title="오산" href="#" shape="poly" coords="135,230,126,223,118,226,122,234,131,234" />
                                            <area class="btn_area" alt="평택시" title="평택시" href="#" shape="poly" coords="138,235,123,238,120,256,108,255,97,259,88,268,78,268,104,292,124,286,140,287,148,279,152,264,142,264,142,258,143,250" />
                                            <area class="btn_area" alt="가평군" title="가평군" href="#" shape="poly" coords="216,52,206,62,204,70,191,79,189,88,183,91,183,100,194,111,201,127,213,128,223,136,226,147,239,143,237,130,242,123,236,107,235,93,251,87,250,70,235,65,231,58" />
                                            <area class="btn_area" alt="남양주" title="남양주" href="#" shape="poly" coords="182,105,174,108,162,110,151,114,148,120,143,127,143,135,152,133,159,141,167,143,186,160,192,146,195,131,194,119" />
                                            <area class="btn_area" alt="구리시" title="구리시" href="#" shape="poly" coords="166,149,163,144,154,144,148,136,146,136,145,147,157,151,157,156,151,160,159,167,167,168,178,162" />
                                            <area class="btn_area" alt="양평군" title="양평군" href="#" shape="poly" coords="256,134,251,131,246,132,243,136,242,146,225,150,220,145,218,137,211,131,200,132,195,143,193,152,203,157,204,166,203,174,207,176,215,174,230,175,238,181,255,182,268,180,289,195,290,169,304,159,295,150,282,146,270,144" />
                                            <area class="btn_area" alt="성남시" title="성남시" href="#" shape="poly" coords="163,169,151,169,144,173,136,175,135,194,144,197,154,187,160,183" />
                                            <area class="btn_area" alt="광주시" title="광주시" href="#" shape="poly" coords="199,160,192,159,186,165,167,172,163,181,161,188,152,194,162,196,182,195,183,207,191,212,200,199,214,192,214,180,206,180,196,175,201,170" />
                                            <area class="btn_area" alt="여주시" title="여주시" href="#" shape="poly" coords="270,192,265,185,258,186,248,185,236,184,227,180,217,179,218,191,229,199,237,204,236,211,235,232,243,231,246,226,251,232,266,242,280,230,285,218,283,202,282,195" />
                                            <area class="btn_area" alt="이천시" title="이천시" href="#" shape="poly" coords="217,195,207,202,200,204,194,218,198,227,207,232,214,240,231,244,235,250,228,260,229,266,240,266,255,255,258,244,244,232,240,234,231,233,230,224,231,215,231,206,233,204" />
                                            <area class="btn_area" alt="용인시" title="용인시" href="#" shape="poly" coords="178,198,166,200,160,200,154,198,148,202,132,198,139,207,139,218,146,223,155,223,156,229,154,238,147,244,148,247,156,249,172,238,177,234,183,242,188,246,196,243,206,247,210,242,206,235,195,231,188,226,187,215" />
                                            <area class="btn_area" alt="안성시" title="안성시" href="#" shape="poly" coords="214,244,210,248,199,249,187,250,180,246,175,240,159,251,149,254,146,259,157,262,154,272,152,278,162,283,185,294,200,287,207,285,208,275,225,270,220,258,231,250,223,245" />
                                            <area class="btn_area" alt="안산" title="안산" href="#" shape="poly" coords="82,184,78,187,75,196,71,200,63,201,58,204,60,210,72,204,82,200,86,196" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_gangwon" data-name="강원도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                        <span class="map11"></span>
                                        <span class="map12"></span>
                                        <span class="map13"></span>
                                        <span class="map14"></span>
                                        <span class="map15"></span>
                                        <span class="map16"></span>
                                        <span class="map17"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">철원군</li>
                                        <li class="txt1">화천군</li>
                                        <li class="txt2">양구군</li>
                                        <li class="txt3">인제군</li>
                                        <li class="txt4">춘천시</li>
                                        <li class="txt5">홍천군</li>
                                        <li class="txt6">황성군</li>
                                        <li class="txt7">평창군</li>
                                        <li class="txt8">원주시</li>
                                        <li class="txt9">영월군</li>
                                        <li class="txt10">정선군</li>
                                        <li class="txt11">태백시</li>
                                        <li class="txt12">고성군</li>
                                        <li class="txt13">속초시</li>
                                        <li class="txt14">양양군</li>
                                        <li class="txt15">강릉시</li>
                                        <li class="txt16">동해시</li>
                                        <li class="txt17">삼척시</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="350" height="244" alt="강원맵 버튼" usemap="#gangwonMap" hidefocus="true" >
                                        <map name="gangwonMap" id="gangwonMap">
                                            <area class="btn_area" alt="철원군" title="철원군" href="#" shape="poly" coords="120,44,110,44,93,42,83,41,69,49,62,48,54,45,47,43,33,43,14,45,2,50,2,55,10,57,11,61,15,67,22,70,27,64,28,70,29,75,37,79,49,75,58,73,61,64,70,57,73,54,81,51,93,53,102,47,119,52" />
                                            <area class="btn_area" alt="화천군" title="화천군" href="#" shape="poly" coords="115,55,100,54,95,58,83,55,76,59,67,64,63,74,53,80,58,94,70,88,73,79,86,84,95,88,106,90,111,92,120,89,125,84" />
                                            <area class="btn_area" alt="양구군" title="양구군" href="#" shape="poly" coords="160,44,150,47,140,45,129,45,122,49,120,62,124,68,127,83,127,90,138,87,142,92,153,88,157,85,153,81,159,54,162,52,166,48" />
                                            <area class="btn_area" alt="인제군" title="인제군" href="#" shape="poly" coords="166,41,172,46,167,56,163,57,157,79,161,86,159,89,153,91,147,96,142,100,148,103,161,108,169,115,174,122,187,114,195,119,208,112,214,112,214,102,217,95,218,87,205,86,203,78,211,75,205,66,209,60,202,59,197,54,192,52,187,44,174,36" />
                                            <area class="btn_area" alt="춘천시" title="춘천시" href="#" shape="poly" coords="72,94,76,89,77,84,84,89,94,92,103,95,110,96,124,94,133,92,136,94,134,112,132,118,122,115,115,120,115,131,97,135,88,140,83,143,75,136,66,135,68,120,79,111,81,99,69,96" />
                                            <area class="btn_area" alt="홍천군" title="홍천군" href="#" shape="poly" coords="144,106,139,110,135,119,130,123,125,119,117,122,118,130,118,137,103,140,85,146,73,140,69,147,72,151,80,148,96,156,115,160,138,152,162,142,173,148,182,151,191,139,205,140,216,135,224,126,231,123,231,114,217,113,211,116,198,120,190,123,187,119,175,126,167,124,162,115" />
                                            <area class="btn_area" alt="황성군" title="황성군" href="#" shape="poly" coords="166,150,158,150,147,155,135,156,122,162,107,167,106,176,115,181,130,174,145,178,155,183,155,193,150,200,157,202,167,195,177,187,179,176,187,166,181,153" />
                                            <area class="btn_area" alt="평창군" title="평창군" href="#" shape="poly" coords="233,127,223,133,222,138,210,142,199,144,188,146,186,154,190,165,187,176,181,184,190,192,197,200,211,196,224,202,233,206,225,188,222,178,239,168,243,160,255,146,253,132" />
                                            <area class="btn_area" alt="원주시" title="원주시" href="#" shape="poly" coords="142,181,131,179,119,187,114,186,106,190,103,210,105,228,123,224,129,212,140,211,146,219,161,216,174,210,161,208,153,203,146,200,149,191,151,185" />
                                            <area class="btn_area" alt="영월군" title="영월군" href="#" shape="poly" coords="226,207,217,204,214,200,207,200,204,204,199,205,190,203,190,194,184,189,173,192,171,198,163,202,170,206,178,208,186,219,187,226,199,227,207,232,225,234,243,242,257,242,271,239,281,241,275,229,258,220,246,224,234,219" />
                                            <area class="btn_area" alt="정선군" title="정선군" href="#" shape="poly" coords="279,160,274,172,263,169,252,168,242,166,234,174,226,180,231,194,235,206,239,215,257,215,270,219,279,224,277,208,272,195,282,180,293,175,289,168" />
                                            <area class="btn_area" alt="태백시" title="태백시" href="#" shape="poly" coords="295,202,287,215,286,222,282,233,291,238,303,240,307,232,302,225,295,217" />
                                            <area class="btn_area" alt="강원도 고성군" title="고성군" href="#" shape="poly" coords="198,2,193,2,188,11,189,18,186,26,178,32,190,42,195,50,207,54,214,59,225,60,232,59,220,43,209,26" />
                                            <area class="btn_area" alt="속초시" title="속초시" href="#" shape="poly" coords="234,63,225,63,213,64,210,67,215,73,229,67,236,68" />
                                            <area class="btn_area" alt="양양군" title="양양군" href="#" shape="poly" coords="238,73,230,71,225,75,218,76,210,78,207,80,209,83,219,83,221,98,218,103,219,110,231,111,245,111,264,104,247,84" />
                                            <area class="btn_area" alt="강릉시" title="강릉시" href="#" shape="poly" coords="268,109,251,115,239,115,236,119,239,127,254,128,259,136,261,147,257,154,251,163,262,164,270,168,275,156,284,157,290,164,302,160,306,155,303,143" />
                                            <area class="btn_area" alt="동해시" title="동해시" href="#" shape="poly" coords="311,159,303,166,294,168,295,178,294,181,305,176,321,176,315,170" />
                                            <area class="btn_area" alt="삼척시" title="삼척시" href="#" shape="poly" coords="299,185,289,184,283,184,278,192,278,202,283,213,296,196,300,207,302,220,313,227,315,236,325,240,334,242,348,226,348,208,334,195,324,183" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_chungnam" data-name="충청남도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                        <span class="map11"></span>
                                        <span class="map12"></span>
                                        <span class="map13"></span>
                                        <span class="map14"></span>
                                        <span class="map15"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">태안군</li>
                                        <li class="txt1">서산시</li>
                                        <li class="txt2">당진군</li>
                                        <li class="txt3">홍성군</li>
                                        <li class="txt4">예산군</li>
                                        <li class="txt5">아산시</li>
                                        <li class="txt6">천안시</li>
                                        <li class="txt7">보령시</li>
                                        <li class="txt8">청양군</li>
                                        <li class="txt9">공주시</li>
                                        <li class="txt10">연기군</li>
                                        <li class="txt11">서천군</li>
                                        <li class="txt12">부여군</li>
                                        <li class="txt13">논산시</li>
                                        <li class="txt14">계룡시</li>
                                        <li class="txt15">금산군</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="351" height="252" alt="충남맵 버튼" usemap="#chungnamMap" hidefocus="true" >
                                        <map name="chungnamMap" id="chungnamMap">
                                            <area class="btn_area" alt="태안군" title="태안군" href="#" shape="poly" coords="38,33,33,42,22,43,22,37,14,44,11,50,9,55,2,63,6,71,12,81,3,82,12,92,24,84,34,88,35,100,33,112,44,120,47,126,46,136,54,146,55,152,72,152,65,138,61,128,57,116,55,109,50,97,48,82,52,66,46,42,43,28,39,20" />
                                            <area class="btn_area" alt="서산시" title="서산시" href="#" shape="poly" coords="72,14,67,11,58,13,52,18,54,28,63,31,62,38,57,46,52,51,56,61,56,73,51,87,56,105,68,111,76,92,86,99,108,94,110,77,122,70,113,59,106,54,94,55,88,48,78,40,82,29,82,20" />
                                            <area class="btn_area" alt="당진군" title="당진군" href="#" shape="poly" coords="140,19,124,20,108,17,99,11,86,2,75,12,85,19,88,28,86,38,95,48,106,51,117,57,122,65,138,59,149,66,164,64,163,52,166,42,151,28" />
                                            <area class="btn_area" alt="홍성군" title="홍성군" href="#" shape="poly" coords="138,94,126,94,117,99,117,105,108,104,107,100,88,102,78,98,74,111,81,125,84,144,93,141,101,134,116,135,126,139,145,136,148,125,140,122,146,110,149,108" />
                                            <area class="btn_area" alt="예산군" title="예산군" href="#" shape="poly" coords="146,73,140,67,137,64,130,68,119,74,115,85,110,99,126,93,137,91,150,96,153,110,147,114,146,120,158,126,168,114,179,112,192,95,192,84,170,82,164,72,158,70" />
                                            <area class="btn_area" alt="아산시" title="아산시" href="#" shape="poly" coords="220,28,205,32,190,34,179,40,172,44,166,49,168,58,169,68,174,78,186,79,198,83,196,91,205,94,220,77,232,68,222,60,228,51,220,46" />
                                            <area class="btn_area" alt="천안시" title="천안시" href="#" shape="poly" coords="276,42,264,32,249,25,229,23,224,33,226,46,230,48,230,59,236,65,232,76,224,80,210,93,224,94,231,90,236,98,240,88,234,80,243,73,256,75,268,82,279,82,282,70,297,74,300,70,294,59" />
                                            <area class="btn_area" alt="보령시" title="보령시" href="#" shape="poly" coords="127,144,118,142,108,138,93,148,85,149,84,163,90,172,91,187,90,198,102,204,126,204,144,194,136,190,126,174,136,160,128,152" />
                                            <area class="btn_area" alt="청양군" title="청양군" href="#" shape="poly" coords="177,116,166,118,164,127,161,130,153,127,144,140,134,142,132,144,136,152,146,160,154,163,164,156,168,164,172,170,187,175,202,168,208,151,203,142,188,143,172,134,176,128" />
                                            <area class="btn_area" alt="공주시" title="공주시" href="#" shape="poly" coords="230,96,224,99,196,95,189,111,181,119,180,132,189,139,202,136,210,148,214,158,204,172,210,181,219,179,230,170,240,174,258,162,268,169,268,148,262,144,261,136,256,126,251,122,254,114,245,112" />
                                            <area class="btn_area" alt="연기군" title="연기군" href="#" shape="poly" coords="271,87,260,86,249,78,241,80,244,90,242,102,252,109,260,114,256,119,264,126,264,137,271,147,281,146,288,135,289,122,278,111,268,99,263,92,271,91" />
                                            <area class="btn_area" alt="서천군" title="서천군" href="#" shape="poly" coords="152,206,134,207,124,212,104,210,92,205,90,213,104,220,113,227,125,247,152,239,167,234,173,231,162,220" />
                                            <area class="btn_area" alt="부여군" title="부여군" href="#" shape="poly" coords="161,162,152,166,140,164,132,171,136,186,146,191,138,202,156,202,162,212,170,223,184,214,196,211,203,208,200,198,210,196,218,187,201,180,199,174,188,176,179,176,168,174" />
                                            <area class="btn_area" alt="논산시" title="논산시" href="#" shape="poly" coords="234,178,230,178,221,184,217,193,210,201,205,214,219,228,232,231,249,224,273,220,280,218,275,207,279,202,280,196,268,189,256,193,248,188,240,187" />
                                            <area class="btn_area" alt="계룡시" title="계룡시" href="#" shape="poly" coords="269,172,255,168,242,175,245,185,252,185,259,190,269,182" />
                                            <area class="btn_area" alt="금산군" title="금산군" href="#" shape="poly" coords="290,184,288,196,282,202,282,214,287,240,302,240,310,250,326,250,326,236,345,245,346,232,350,226,340,214,346,201,332,188,312,196,304,202" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_sejong" data-name="세종시">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">세종시</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="195" height="280" alt="세종맵 버튼" usemap="#sejongMap" hidefocus="true" >
                                        <map name="sejongMap" id="sejongMap">
                                        	<area class="btn_area" alt="세종" title="세종" href="#" shape="poly" coords="123,65,125,56,127,46,119,42,107,38,96,36,85,34,71,20,56,9,45,3,30,1,21,5,9,17,3,22,9,30,23,37,23,44,23,59,17,73,20,90,17,102,29,120,43,127,53,130,49,137,47,150,34,160,29,173,29,187,41,198,41,219,43,238,59,252,77,270,85,280,104,274,129,268,146,255,156,240,165,218,171,208,185,208,192,205,193,188,193,175,188,162,179,163,173,154,173,146,165,143,157,148,145,142,136,131,122,128,123,114,115,96,115,84,106,82,114,68" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_daejeon" data-name="대전">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">대전</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="258" height="275" alt="대전맵 버튼" usemap="#daejeonMap" hidefocus="true" >
                                        <map name="daejeonMap" id="daejeonMap">
                                            <area class="btn_area" alt="대전" title="대전" href="#" shape="poly" coords="214,40,205,40,196,36,194,29,199,23,191,19,179,28,180,42,172,44,159,42,154,38,136,41,129,38,126,26,130,21,128,11,114,2,106,7,96,10,94,18,95,25,90,37,89,46,81,46,74,60,59,68,50,63,30,76,26,93,25,101,25,111,22,121,21,134,16,144,11,154,10,170,4,179,3,188,12,197,21,202,32,206,27,218,28,225,39,234,39,240,50,241,60,250,64,259,72,266,70,276,82,270,89,250,97,245,94,225,96,211,96,200,109,200,120,207,120,220,124,233,132,240,148,253,156,262,174,263,179,251,188,240,199,234,202,222,202,210,204,196,210,188,204,177,212,164,215,149,220,136,232,133,234,116,232,102,237,98,243,90,254,89,256,86,247,76,250,67,242,69,234,70,229,68,223,68,218,74,215,79,212,70,206,67,206,58,217,49" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_chungbuk" data-name="충청북도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">진천군</li>
                                        <li class="txt1">음성군</li>
                                        <li class="txt2">충주시</li>
                                        <li class="txt3">제천시</li>
                                        <li class="txt4">단양군</li>
                                        <li class="txt5">괴산군</li>
                                        <li class="txt6">청주시</li>
                                        <li class="txt7">청원군</li>
                                        <li class="txt8">보은군</li>
                                        <li class="txt9">옥천군</li>
                                        <li class="txt10">영동군</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="350" height="321" alt="충북맵 버튼" usemap="#chungbukMap" hidefocus="true" >
                                        <map name="chungbukMap" id="chungbukMap">
                                            <area class="btn_area" alt="진천군" title="진천군" href="#" shape="poly" coords="42,64,33,67,31,74,25,81,13,80,5,87,9,104,27,111,32,116,33,128,53,125,71,122,66,116,73,109,73,98,60,89,45,78,41,78" />
                                            <area class="btn_area" alt="음성군" title="음성군" href="#" shape="poly" coords="107,30,92,27,88,33,91,43,83,47,74,51,63,52,53,54,47,65,47,74,63,85,78,92,77,102,88,104,111,94,127,93,129,79,115,79,107,74,94,68,94,57,101,52,103,42,113,37" />
                                            <area class="btn_area" alt="충주시" title="충주시" href="#" shape="poly" coords="119,10,111,25,117,36,109,44,107,55,99,60,107,70,131,77,145,80,149,86,163,95,173,94,177,98,179,106,188,112,197,108,192,102,199,89,193,80,200,75,209,78,209,71,202,66,205,60,204,47,197,41,185,42,176,26,169,21,144,23,127,25" />
                                            <area class="btn_area" alt="제천시" title="제천시" href="#" shape="poly" coords="190,4,184,1,166,7,169,14,178,23,187,38,198,36,207,40,212,62,207,66,215,70,213,81,201,80,198,82,203,91,197,103,200,106,207,104,216,107,228,110,229,115,243,112,245,102,246,81,253,80,245,68,245,62,240,51,248,39,257,41,264,38,261,27,257,20,272,15,263,9,256,14,248,10,239,4,230,10,222,6,212,17,195,16" />
                                            <area class="btn_area" alt="단양군" title="단양군" href="#" shape="poly" coords="289,26,281,28,265,26,266,37,265,43,252,44,245,52,249,56,251,60,253,70,259,82,254,85,250,88,252,98,265,110,279,117,294,112,295,104,294,93,298,81,333,61,335,54,348,55,344,48,317,40,312,35,301,38,291,32" />
                                            <area class="btn_area" alt="괴산군" title="괴산군" href="#" shape="poly" coords="163,100,153,96,145,92,141,84,131,84,131,96,113,102,99,106,87,110,80,108,74,116,79,128,86,134,94,142,109,140,117,146,117,157,134,168,149,168,157,156,160,168,171,158,159,150,170,140,178,135,188,137,194,142,206,142,193,132,197,119,198,115,184,116,173,108,174,104,169,99" />
                                            <area class="btn_area" alt="청주시" title="청주시" href="#" shape="poly" coords="51,138,41,147,29,151,25,164,27,177,37,168,49,168,57,175,73,162,69,152,53,147" />
                                            <area class="btn_area" alt="청원군" title="청원군" href="#" shape="poly" coords="47,137,41,145,25,146,23,170,27,181,38,172,46,173,57,178,75,166,73,154,65,146,53,138,52,128,69,126,81,134,88,146,95,150,101,145,111,145,113,154,123,164,124,171,111,171,95,169,85,175,81,184,71,190,69,203,61,213,49,204,39,212,25,202,19,186,13,177,5,161,1,151,13,136,25,130,48,131,57,127,57,135" />
                                            <area class="btn_area" alt="보은군" title="보은군" href="#" shape="poly" coords="137,172,131,170,126,174,111,174,100,174,92,174,89,182,83,188,74,192,77,200,71,210,60,218,65,224,84,217,99,208,111,215,115,222,131,220,144,226,157,226,153,214,159,202,152,197,159,186,145,174" />
                                            <area class="btn_area" alt="옥천군" title="옥천군" href="#" shape="poly" coords="161,232,139,230,127,225,113,228,107,218,99,212,87,220,64,228,64,239,57,253,65,263,80,271,94,274,107,263,113,252,139,244" />
                                            <area class="btn_area" alt="영동군" title="영동군" href="#" shape="poly" coords="147,246,117,257,109,267,101,274,91,283,80,282,82,297,93,308,109,315,126,318,142,315,166,312,179,299,183,284,181,273,201,273,201,264,195,264,193,256,187,256,178,260,167,256,163,252,152,256" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_gyeongbuk" data-name="경상북도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                        <span class="map11"></span>
                                        <span class="map12"></span>
                                        <span class="map13"></span>
                                        <span class="map14"></span>
                                        <span class="map15"></span>
                                        <span class="map16"></span>
                                        <span class="map17"></span>
                                        <span class="map18"></span>
                                        <span class="map19"></span>
                                        <span class="map20"></span>
                                        <span class="map21"></span>
                                        <span class="map22"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">문경시</li>
                                        <li class="txt1">예천군</li>
                                        <li class="txt2">영주시</li>
                                        <li class="txt3">봉화군</li>
                                        <li class="txt4">울진군</li>
                                        <li class="txt5">상주시</li>
                                        <li class="txt6">의성군</li>
                                        <li class="txt7">안동시</li>
                                        <li class="txt8">영양군</li>
                                        <li class="txt9">김천시</li>
                                        <li class="txt10">구미시</li>
                                        <li class="txt11">군위군</li>
                                        <li class="txt12">청송군</li>
                                        <li class="txt13">영덕군</li>
                                        <li class="txt14">성주군</li>
                                        <li class="txt15">칠곡군</li>
                                        <li class="txt16">고령군</li>
                                        <li class="txt17">영천시</li>
                                        <li class="txt18">포항시</li>
                                        <li class="txt19">경산군</li>
                                        <li class="txt20">청도군</li>
                                        <li class="txt21">경주시</li>
                                        <li class="txt22">울릉군</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="348" height="233" alt="경북맵 버튼" usemap="#gyeongbukMap" hidefocus="true" >
                                        <map name="gyeongbukMap" id="gyeongbukMap">
                                            <area class="btn_area" alt="문경시" title="문경시" href="#" shape="poly" coords="81,50,76,50,72,44,65,45,58,50,50,48,44,51,40,50,36,56,40,63,31,64,25,64,18,69,19,77,20,87,25,91,38,84,38,80,49,76,60,80,63,89,74,86,65,78,78,71,78,59,82,57" />
                                            <area class="btn_area" alt="예천군" title="예천군" href="#" shape="poly" coords="96,47,87,52,84,60,81,63,81,72,74,79,76,86,70,90,73,99,84,92,92,91,108,77,118,69,109,58,103,58,98,52" />
                                            <area class="btn_area" alt="영주시" title="영주시" href="#" shape="poly" coords="130,14,117,20,110,21,95,38,100,46,104,54,113,55,118,66,134,65,137,57,136,44,126,43,124,31,130,23" />
                                            <area class="btn_area" alt="봉화군" title="봉화군" href="#" shape="poly" coords="201,14,189,8,187,15,177,12,166,10,158,18,150,14,146,9,138,16,135,23,130,30,129,42,139,43,140,49,151,49,162,52,174,55,185,49,196,40,193,32,188,30,186,20,194,16,200,17" />
                                            <area class="btn_area" alt="울진군" title="울진군" href="#" shape="poly" coords="230,2,225,3,221,6,209,12,202,19,196,20,190,23,191,30,199,30,200,38,213,40,217,40,218,44,224,52,222,58,220,64,220,70,229,72,240,73,246,66,245,53,237,42,239,34,235,20,238,13" />
                                            <area class="btn_area" alt="상주시" title="상주시" href="#" shape="poly" coords="13,75,3,80,2,84,11,88,15,92,14,99,13,107,13,119,9,126,12,128,17,126,32,127,40,130,48,130,49,123,61,123,70,115,77,112,74,104,66,99,68,97,65,95,60,95,60,87,52,82,43,80,40,86,32,90,25,94,18,90" />
                                            <area class="btn_area" alt="의성군" title="의성군" href="#" shape="poly" coords="109,96,102,96,95,99,89,96,83,96,78,102,80,111,77,117,84,118,91,124,101,123,123,127,126,135,132,139,144,139,158,138,157,128,159,121,155,112,150,104,138,99,133,106,120,108,113,107" />
                                            <area class="btn_area" alt="안동시" title="안동시" href="#" shape="poly" coords="172,60,168,58,161,56,153,53,149,53,140,54,138,70,130,68,123,67,119,70,110,83,103,86,97,94,110,92,112,96,118,104,133,102,141,96,154,101,160,111,161,124,170,111,172,99,174,95,169,88,173,80" />
                                            <area class="btn_area" alt="영양군" title="영양군" href="#" shape="poly" coords="214,43,211,45,200,42,193,48,184,52,177,56,176,61,178,78,186,86,199,93,207,94,213,92,208,80,212,71,214,68,213,59,220,52" />
                                            <area class="btn_area" alt="김천시" title="김천시" href="#" shape="poly" coords="64,139,53,134,40,135,30,142,26,152,22,163,10,170,17,178,15,186,32,194,40,190,34,183,36,176,45,174,51,172,58,161,71,161,68,154,72,151,69,143" />
                                            <area class="btn_area" alt="구미시" title="구미시" href="#" shape="poly" coords="85,123,79,121,73,119,68,120,63,124,52,126,52,131,62,133,73,139,76,149,73,154,81,158,91,156,104,150,113,152,110,144,102,142,98,136,92,136,89,129" />
                                            <area class="btn_area" alt="군위군" title="군위군" href="#" shape="poly" coords="92,124,113,129,122,133,124,139,135,142,146,142,157,142,160,146,153,152,145,155,138,153,131,159,128,168,124,167,123,160,120,155,114,157,115,150,112,143,108,136,102,138,98,131,93,131" />
                                            <area class="btn_area" alt="청송군" title="청송군" href="#" shape="poly" coords="180,85,176,86,175,91,178,98,176,102,171,117,169,123,161,127,162,139,168,143,178,143,184,134,186,129,195,128,201,134,209,127,213,120,205,118,206,110,201,106,196,98,192,92,185,90" />
                                            <area class="btn_area" alt="영덕군" title="영덕군" href="#" shape="poly" coords="237,76,229,74,225,77,216,74,211,77,213,88,215,93,202,98,202,100,207,105,211,112,212,116,222,120,222,127,233,130,233,119,244,103,240,92" />
                                            <area class="btn_area" alt="성주군" title="성주군" href="#" shape="poly" coords="74,164,61,165,53,172,48,178,44,182,40,181,47,198,58,195,65,199,74,192,83,197,90,182,80,179,75,173" />
                                            <area class="btn_area" alt="칠곡군" title="칠곡군" href="#" shape="poly" coords="113,160,110,156,102,155,93,159,87,159,75,158,77,168,82,176,95,179,100,181,102,185,114,174,120,170,120,159,114,162" />
                                            <area class="btn_area" alt="고령군" title="고령군" href="#" shape="poly" coords="98,194,89,190,84,199,76,200,72,198,68,203,62,201,56,199,54,202,57,210,50,210,46,208,44,220,52,219,69,220,80,220,83,227,95,222,101,222,102,215,92,219,86,217,82,210,92,211,89,204,90,198,97,195" />
                                            <area class="btn_area" alt="영천시" title="영천시" href="#" shape="poly" coords="181,147,172,147,164,147,157,152,150,157,139,158,134,161,134,171,150,172,157,174,158,183,164,191,176,193,182,180,192,177,193,167,196,160" />
                                            <area class="btn_area" alt="포항시" title="포항시" href="#" shape="poly" coords="232,134,222,131,218,127,218,122,210,126,205,135,198,136,193,132,187,134,184,140,187,149,200,160,209,163,218,157,223,168,229,178,232,188,245,189,253,190,256,178,260,168,261,159,255,158,249,163,242,168,233,163,231,154,234,147" />
                                            <area class="btn_area" alt="경산군" title="경산군" href="#" shape="poly" coords="152,176,142,175,138,174,140,187,134,203,136,209,149,207,165,203,169,196,161,194,155,188" />
                                            <area class="btn_area" alt="청도군" title="청도군" href="#" shape="poly" coords="173,197,161,206,148,209,138,213,129,210,123,212,116,208,108,211,113,226,121,230,133,228,144,231,164,222,174,225,189,220,180,217,170,210" />
                                            <area class="btn_area" alt="경주시" title="경주시" href="#" shape="poly" coords="215,162,208,166,201,164,197,168,196,174,198,179,196,182,190,180,185,183,180,192,176,204,184,215,199,210,214,212,218,219,229,217,240,218,252,194,240,190,233,190,222,186" />
                                            <area class="btn_area" alt="울릉군" title="울릉군" href="#" shape="poly" coords="309,3,301,8,305,15,315,16,316,1,311,2" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_daegu" data-name="대구">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">대구</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="261" height="258" alt="대구맵 버튼" usemap="#daeguMap" hidefocus="true" >
                                        <map name="daeguMap" id="daeguMap">
                                              <area class="btn_area" alt="대구" title="대구" href="#" shape="poly" coords="231,6,218,1,202,2,175,4,160,14,151,24,139,22,131,26,129,30,120,23,110,20,113,36,114,47,109,57,99,71,98,80,90,76,82,75,74,70,74,65,82,56,83,52,70,48,57,47,47,56,40,65,38,74,32,82,28,91,27,104,50,104,72,108,82,118,80,129,64,129,44,129,35,140,34,149,32,158,25,161,32,172,44,179,54,192,46,200,30,198,17,198,9,194,2,196,4,208,8,220,27,233,36,241,21,258,34,257,43,253,56,242,64,237,78,238,96,242,106,233,102,214,111,212,120,200,116,190,130,181,150,176,166,175,166,184,168,196,180,197,198,192,207,189,216,173,218,163,212,150,210,141,220,141,234,135,227,119,235,110,245,104,258,103,260,92,258,75,256,68,248,58,244,52,251,47,247,40,248,30,243,15" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_jeonbuk" data-name="전라북도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                        <span class="map11"></span>
                                        <span class="map12"></span>
                                        <span class="map13"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">군산시</li>
                                        <li class="txt1">익산시</li>
                                        <li class="txt2">완주군</li>
                                        <li class="txt3">김제시</li>
                                        <li class="txt4">전주시</li>
                                        <li class="txt5">진안군</li>
                                        <li class="txt6">무주군</li>
                                        <li class="txt7">부안군</li>
                                        <li class="txt8">정읍시</li>
                                        <li class="txt9">고창군</li>
                                        <li class="txt10">임실군</li>
                                        <li class="txt11">순창군</li>
                                        <li class="txt12">장수군</li>
                                        <li class="txt13">남원시</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="351" height="248" alt="전북맵 버튼" usemap="#jeonbukMap" hidefocus="true" >
                                        <map name="jeonbukMap" id="jeonbukMap">
                                            <area class="btn_area" alt="군산시" title="군산시" href="#" shape="poly" coords="92,23,82,32,68,36,59,38,46,42,37,40,32,48,38,59,44,68,51,74,59,79,72,76,83,69,99,58,106,54,112,42,116,34,103,26" />
                                            <area class="btn_area" alt="익산시" title="익산시" href="#" shape="poly" coords="149,22,144,12,140,5,126,4,116,1,110,3,99,4,94,16,104,19,118,27,120,37,116,49,110,59,120,62,136,64,150,56,159,58,166,46,163,37,169,30,164,23" />
                                            <area class="btn_area" alt="완주군" title="완주군" href="#" shape="poly" coords="219,8,208,14,200,18,192,15,186,19,171,20,172,30,171,34,168,37,169,50,163,59,159,63,151,60,146,65,160,67,172,66,178,72,182,78,189,82,196,92,194,99,191,101,184,104,182,108,174,109,172,113,164,118,157,123,156,136,162,139,163,151,168,149,170,132,168,127,183,116,193,123,198,130,203,130,199,119,200,112,197,110,205,104,213,92,218,78,217,66,225,58,218,38,234,30,226,17" />
                                            <area class="btn_area" alt="김제시" title="김제시" href="#" shape="poly" coords="142,67,127,68,114,64,99,64,86,72,81,77,60,83,68,94,83,100,87,110,95,120,106,120,110,110,120,111,124,119,134,122,140,128,144,136,145,141,154,136,150,119,156,116,147,107,150,100,138,97,135,88,140,86,138,80" />
                                            <area class="btn_area" alt="전주시" title="전주시" href="#" shape="poly" coords="170,70,162,70,146,70,143,80,153,84,159,93,155,104,153,109,158,116,176,106,182,100,190,98,193,92,187,84,178,81" />
                                            <area class="btn_area" alt="진안군" title="진안군" href="#" shape="poly" coords="270,46,264,45,257,47,251,40,248,36,234,38,223,42,228,52,226,63,222,68,222,76,218,87,216,97,206,106,212,118,214,134,226,138,239,140,246,152,254,155,253,142,254,122,263,115,262,102,267,94,281,96,290,91,289,78,281,74,277,68,282,62,276,62" />
                                            <area class="btn_area" alt="무주군" title="무주군" href="#" shape="poly" coords="338,32,323,36,314,34,310,32,304,32,306,38,293,40,286,37,280,31,279,38,274,48,278,57,287,63,284,71,292,78,295,88,301,94,312,99,318,90,326,86,338,78,342,69,350,65,349,49" />
                                            <area class="btn_area" alt="부안군" title="부안군" href="#" shape="poly" coords="80,104,65,98,58,100,49,102,46,108,48,114,41,124,26,132,12,144,10,160,16,168,36,160,50,158,55,166,68,164,68,145,80,133,94,134,96,129,90,122,83,113" />
                                            <area class="btn_area" alt="정읍시" title="정읍시" href="#" shape="poly" coords="116,114,112,118,108,124,98,124,100,133,96,138,82,136,74,147,72,166,82,166,82,180,83,207,101,200,112,192,120,192,132,169,140,174,149,179,152,187,160,186,164,177,158,169,157,162,163,161,158,150,159,141,154,141,147,142,139,139,138,135,134,127,122,122" />
                                            <area class="btn_area" alt="고창군" title="고창군" href="#" shape="poly" coords="75,172,63,170,48,170,34,173,25,176,14,181,2,190,2,203,11,218,31,244,46,238,60,233,74,224,77,195,78,179" />
                                            <area class="btn_area" alt="임실군" title="임실군" href="#" shape="poly" coords="202,136,196,134,194,130,189,124,184,122,174,129,174,139,172,148,167,154,166,160,165,166,163,168,169,177,167,186,174,190,174,200,182,204,185,192,193,191,197,196,206,201,215,190,225,188,220,180,228,166,232,156,243,153,236,145,224,143,212,138,210,130,210,120,204,110" />
                                            <area class="btn_area" alt="순창군" title="순창군" href="#" shape="poly" coords="173,204,172,194,167,190,158,189,147,188,144,180,142,178,134,177,126,186,122,193,118,196,109,199,106,206,118,211,121,222,135,212,140,214,150,206,157,212,159,223,160,232,160,243,169,246,180,238,186,225,193,218,201,212,210,212,214,202,212,198,204,205,198,201,194,202,192,194,182,205" />
                                            <area class="btn_area" alt="장수군" title="장수군" href="#" shape="poly" coords="307,101,293,95,288,98,283,103,271,98,268,100,270,113,265,121,258,128,257,136,258,152,256,158,242,158,236,158,232,167,235,176,247,173,258,176,266,186,270,201,281,190,278,178,284,172,284,151,292,147,288,132,296,127,295,111" />
                                            <area class="btn_area" alt="남원시" title="남원시" href="#" shape="poly" coords="274,208,266,202,263,191,258,183,252,178,246,180,238,178,229,174,225,180,228,190,218,195,218,210,210,216,200,222,188,238,196,244,207,242,228,234,259,233,275,241,282,246,288,232,284,217,290,203,299,200,292,190,287,181,283,178,281,182,282,192" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_jeonnam" data-name="전라남도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                        <span class="map11"></span>
                                        <span class="map12"></span>
                                        <span class="map13"></span>
                                        <span class="map14"></span>
                                        <span class="map15"></span>
                                        <span class="map16"></span>
                                        <span class="map17"></span>
                                        <span class="map18"></span>
                                        <span class="map19"></span>
                                        <span class="map20"></span>
                                        <span class="map21"></span>
                                        <span class="map22"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">신안군</li>
                                        <li class="txt1">진도군</li>
                                        <li class="txt2">영광군</li>
                                        <li class="txt3">장성군</li>
                                        <li class="txt4">담양군</li>
                                        <li class="txt5">함평군</li>
                                        <li class="txt6">광주</li>
                                        <li class="txt7">목포시</li>
                                        <li class="txt8">무안군</li>
                                        <li class="txt9">나주시</li>
                                        <li class="txt10">영암군</li>
                                        <li class="txt11">화순군</li>
                                        <li class="txt12">곡성군</li>
                                        <li class="txt13">구례군</li>
                                        <li class="txt14">해남군</li>
                                        <li class="txt15">강진군</li>
                                        <li class="txt16">장흥군</li>
                                        <li class="txt17">보성군</li>
                                        <li class="txt18">순천시</li>
                                        <li class="txt19">광양시</li>
                                        <li class="txt20">완도군</li>
                                        <li class="txt21">고흥군</li>
                                        <li class="txt22">여수시</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="348" height="225" alt="전남맵 버튼" usemap="#jeonnamMap" hidefocus="true" >
                                        <map name="jeonnamMap" id="jeonnamMap">
                                            <area class="btn_area" alt="신안군" title="신안군" href="#" shape="poly" coords="47,102,41,105,35,103,37,99,39,94,34,91,25,95,17,102,25,104,31,108,24,113,17,112,5,118,1,123,6,132,16,135,26,130,23,127,18,122,29,118,33,123,38,130,50,130,53,126,54,116,49,110" />
                                            <area class="btn_area" alt="진도군" title="진도군" href="#" shape="poly" coords="68,150,60,158,51,163,45,166,41,174,52,182,62,185,72,179,77,180,86,166,87,158,75,151" />
                                            <area class="btn_area" alt="영광군" title="영광군" href="#" shape="poly" coords="118,26,112,22,108,14,101,12,95,17,91,23,85,32,79,40,77,46,85,49,89,51,106,47,114,51,124,46,125,36,130,33,135,24,120,28" />
                                            <area class="btn_area" alt="장성군" title="장성군" href="#" shape="poly" coords="181,2,172,2,163,6,155,10,153,16,143,24,135,31,129,38,133,44,141,47,151,42,160,40,166,42,180,41,173,34,176,22,182,15,188,10" />
                                            <area class="btn_area" alt="담양군" title="담양군" href="#" shape="poly" coords="211,4,206,6,202,8,192,11,188,17,182,22,176,31,184,37,190,43,192,47,204,51,206,56,213,58,213,48,220,46,213,42,214,27,216,15,213,11" />
                                            <area class="btn_area" alt="함평군" title="함평군" href="#" shape="poly" coords="129,45,126,49,119,52,114,55,110,51,103,51,90,55,94,58,99,63,100,70,106,67,110,75,117,87,126,80,124,70,130,63,137,61,139,52,133,50" />
                                            <area class="btn_area" alt="광주" title="광주" href="#" shape="poly" coords="142,51,150,48,156,43,165,46,177,44,185,43,192,53,202,54,196,62,185,65,169,67,166,69,157,65,142,62" />
                                            <area class="btn_area" alt="목포시" title="목포시" href="#" shape="poly" coords="81,102,84,107,84,115,83,123,86,126,95,120,97,110,93,104,88,102" />
                                            <area class="btn_area" alt="무안군" title="무안군" href="#" shape="poly" coords="102,74,94,74,86,82,80,80,78,75,82,66,80,60,72,57,67,62,52,63,51,70,58,70,64,70,65,76,74,75,75,83,79,93,82,99,93,98,102,108,110,115,117,108,115,96,110,92,113,88,109,82,106,74" />
                                            <area class="btn_area" alt="나주시" title="나주시" href="#" shape="poly" coords="178,70,170,70,168,73,162,72,156,68,142,65,134,65,128,69,130,81,130,84,114,90,121,97,126,91,133,92,137,96,145,88,149,93,161,95,168,100,176,95,177,85" />
                                            <area class="btn_area" alt="영암군" title="영암군" href="#" shape="poly" coords="170,103,161,100,155,100,149,98,144,92,139,100,132,99,130,95,122,102,114,116,108,118,100,114,93,124,110,126,121,131,140,128,140,121,145,115,154,120,163,114,162,106" />
                                            <area class="btn_area" alt="화순군" title="화순군" href="#" shape="poly" coords="233,50,225,52,222,51,215,55,215,64,204,62,194,69,184,71,177,79,179,90,181,102,194,106,208,104,213,102,212,94,217,84,229,82,229,75" />
                                            <area class="btn_area" alt="곡성군" title="곡성군" href="#" shape="poly" coords="266,30,256,30,244,30,235,30,226,28,221,32,218,41,228,47,234,47,236,54,244,62,257,69,268,61,270,53,261,47,265,42,269,40,265,36" />
                                            <area class="btn_area" alt="구례군" title="구례군" href="#" shape="poly" coords="305,30,295,27,286,21,272,26,271,35,272,43,265,46,270,51,285,55,294,62,303,59,308,50,312,43,306,38" />
                                            <area class="btn_area" alt="해남군" title="해남군" href="#" shape="poly" coords="144,132,128,134,118,135,108,130,97,128,87,128,80,124,81,119,65,113,69,124,66,130,73,138,78,146,90,151,103,154,105,165,105,170,114,171,110,177,110,188,118,186,113,195,122,197,130,186,129,175,145,171,139,163,144,153,140,145" />
                                            <area class="btn_area" alt="강진군" title="강진군" href="#" shape="poly" coords="166,118,161,119,157,124,148,122,145,120,144,125,147,131,147,138,145,146,149,153,145,159,148,167,162,153,165,162,164,168,158,175,161,183,166,179,178,183,189,184,190,175,183,179,181,174,169,168,172,159,178,154,176,133" />
                                            <area class="btn_area" alt="장흥군" title="장흥군" href="#" shape="poly" coords="201,109,194,107,190,108,184,108,178,101,174,104,167,107,165,114,174,122,178,130,181,153,176,159,174,164,182,168,193,166,192,156,195,144,201,139,205,140,204,135,198,131,192,126,196,120,202,118" />
                                            <area class="btn_area" alt="보성군" title="보성군" href="#" shape="poly" coords="238,96,238,90,235,85,224,88,217,88,216,100,213,108,205,111,208,120,201,122,197,127,205,134,209,138,232,130,241,120,249,122,257,115,273,111,264,105,261,102,255,99,249,102" />
                                            <area class="btn_area" alt="순천시" title="순천시" href="#" shape="poly" coords="291,65,286,60,277,55,273,59,269,64,263,68,257,72,245,67,238,62,234,64,233,76,236,84,240,91,244,96,257,96,267,100,273,108,284,104,284,95,289,96,296,95,304,94,296,90" />
                                            <area class="btn_area" alt="광양시" title="광양시" href="#" shape="poly" coords="313,51,311,61,302,64,295,66,299,74,298,87,314,95,323,92,333,85,334,72,327,66,320,61,318,52" />
                                            <area class="btn_area" alt="완도군" title="완도군" href="#" shape="poly" coords="150,177,141,176,136,181,140,190,154,195,160,191,153,185" />
                                            <area class="btn_area" alt="고흥군" title="고흥군" href="#" shape="poly" coords="269,118,257,121,257,127,257,134,253,137,252,128,242,128,238,149,225,147,221,155,234,159,248,159,259,164,277,159,285,163,286,174,292,179,299,174,292,164,287,158,278,151,280,150,289,147,292,139,283,139,278,127,270,128" />
                                            <area class="btn_area" alt="여수시" title="여수시" href="#" shape="poly" coords="337,91,330,104,322,104,313,103,302,99,299,98,297,100,289,99,288,103,292,106,297,112,300,122,302,133,313,140,313,130,318,123,325,124,331,124,334,129,327,135,326,142,336,147,341,148,344,134,337,119,336,108,340,104,344,103,342,94" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_gwangju" data-name="광주">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">광주</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="319" height="186" alt="광주맵 버튼" usemap="#gwangjuMap" hidefocus="true" >
                                        <map name="gwangjuMap" id="gwangjuMap">
                                           <area class="btn_area" alt="광주" title="광주" href="#" shape="poly" coords="232,4,220,1,211,2,200,12,191,8,177,17,157,29,147,32,134,42,111,42,95,30,83,25,92,18,89,12,71,19,59,26,57,45,51,54,34,54,21,61,19,70,9,75,1,80,10,87,13,94,5,100,2,112,6,128,17,144,38,149,58,141,79,142,100,154,110,167,103,175,99,182,115,184,129,184,151,182,180,169,197,156,228,148,239,146,249,153,268,154,280,139,297,129,309,109,310,91,309,79,318,69,309,59,291,55,277,58,265,53,265,46,255,36,252,26" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_gyeongnam" data-name="경상남도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                        <span class="map1"></span>
                                        <span class="map2"></span>
                                        <span class="map3"></span>
                                        <span class="map4"></span>
                                        <span class="map5"></span>
                                        <span class="map6"></span>
                                        <span class="map7"></span>
                                        <span class="map8"></span>
                                        <span class="map9"></span>
                                        <span class="map10"></span>
                                        <span class="map11"></span>
                                        <span class="map12"></span>
                                        <span class="map13"></span>
                                        <span class="map14"></span>
                                        <span class="map15"></span>
                                        <span class="map16"></span>
                                        <span class="map17"></span>
                                        <span class="map18"></span>
                                        <span class="map19"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">함양군</li>
                                        <li class="txt1">거창군</li>
                                        <li class="txt2">하동군</li>
                                        <li class="txt3">산청군</li>
                                        <li class="txt4">합천군</li>
                                        <li class="txt5">사천시</li>
                                        <li class="txt6">진주시</li>
                                        <li class="txt7">의령군</li>
                                        <li class="txt8">창녕군</li>
                                        <li class="txt9">고성군</li>
                                        <li class="txt10">마산시</li>
                                        <li class="txt11">함안군</li>
                                        <li class="txt12">창원시</li>
                                        <li class="txt13">밀양시</li>
                                        <li class="txt14">진해시</li>
                                        <li class="txt15">김해시</li>
                                        <li class="txt16">양산시</li>
                                        <li class="txt17">남해군</li>
                                        <li class="txt18">통영시</li>
                                        <li class="txt19">거제시</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="348" height="261" alt="경남맵 버튼" usemap="#gyeongnamMap" hidefocus="true" >
                                        <map name="gyeongnamMap" id="gyeongnamMap">
                                            <area class="btn_area" alt="함양군" title="함양군" href="#" shape="poly" coords="61,53,53,51,35,40,28,40,21,33,19,40,14,49,14,60,5,75,17,85,19,98,19,105,8,112,23,120,34,109,41,97,55,74" />
        <area class="btn_area" alt="거창군" title="거창군" href="#" shape="poly" coords="101,14,91,14,84,12,76,8,67,3,59,1,51,10,41,12,30,20,26,28,33,37,42,37,49,41,57,46,65,50,65,62,62,66,68,75,79,80,84,63,91,53,105,44,97,26,101,20" />
        <area class="btn_area" alt="하동군" title="하동군" href="#" shape="poly" coords="64,140,53,146,32,141,24,136,20,126,10,123,2,123,0,128,7,135,9,142,10,149,20,158,29,165,33,175,39,178,42,183,46,191,44,200,53,203,58,199,70,195,72,184,68,177,66,164,61,161,65,155,71,159,73,155,64,148" />
        <area class="btn_area" alt="산청군" title="산청군" href="#" shape="poly" coords="79,84,71,82,66,81,60,78,57,76,53,86,51,94,43,102,39,110,36,119,27,126,29,132,37,136,59,141,72,138,84,131,93,123,100,121,109,121,108,113,96,109,88,99,82,98" />
        <area class="btn_area" alt="합천군" title="합천군" href="#" shape="poly" coords="164,55,153,52,140,54,129,55,124,51,128,44,131,35,120,26,114,22,115,16,108,19,103,24,102,32,106,42,108,46,102,53,92,62,88,73,84,82,92,97,98,100,108,108,118,108,129,98,134,86,145,84,157,81,170,82,164,76,165,69" />
        <area class="btn_area" alt="사천시" title="사천시" href="#" shape="poly" coords="119,170,108,169,89,168,86,164,73,161,66,162,69,171,72,175,76,181,76,188,79,194,92,193,98,188,98,198,102,206,109,209,118,197,124,190" />
        <area class="btn_area" alt="진주시" title="진주시" href="#" shape="poly" coords="130,137,127,131,124,122,113,124,103,126,94,131,87,137,83,141,75,142,71,147,76,156,84,160,93,164,105,162,122,166,125,174,126,182,131,171,134,165,145,164,159,163,168,158,167,151,160,149,151,142" />
        <area class="btn_area" alt="의령군" title="의령군" href="#" shape="poly" coords="173,85,161,85,150,85,141,88,138,93,135,99,130,110,125,112,113,111,114,119,128,120,132,127,133,135,146,137,151,127,154,118,155,112,167,115,178,115,181,107,173,105,168,99,168,93" />
        <area class="btn_area" alt="창녕군" title="창녕군" href="#" shape="poly" coords="200,47,199,54,191,55,182,59,171,59,168,67,171,76,179,84,182,89,175,96,175,102,183,106,191,108,204,108,218,110,226,110,226,100,217,99,212,93,211,86,214,81,214,70" />
        <area class="btn_area" alt="고성군" title="고성군" href="#" shape="poly" coords="174,172,163,168,151,167,137,168,134,173,132,181,129,188,123,199,117,209,123,215,138,204,146,208,149,212,158,202,167,203,179,193,192,195,192,187" />
        <area class="btn_area" alt="마산시" title="마산시" href="#" shape="poly" coords="214,134,199,140,193,143,196,152,191,156,184,156,170,153,171,165,179,174,191,176,209,176,217,180,221,171,218,166,225,169,216,155" />
        <area class="btn_area" alt="함안군" title="함안군" href="#" shape="poly" coords="209,113,195,112,183,114,177,120,170,122,159,120,154,131,153,139,163,146,173,150,179,152,189,152,191,142,199,134,209,133,211,123" />
        <area class="btn_area" alt="창원시" title="창원시" href="#" shape="poly" coords="248,119,242,116,234,111,224,116,213,115,214,129,222,137,219,145,224,152,240,153,249,157,244,147,241,134,243,124" />
        <area class="btn_area" alt="밀양시" title="밀양시" href="#" shape="poly" coords="254,73,241,68,229,65,220,69,217,82,216,91,222,97,228,98,231,105,231,109,242,109,250,116,256,118,269,108,279,103,286,93,294,87,295,79,300,79,304,70,304,62,294,60,283,57,271,70" />
        <area class="btn_area" alt="진해시" title="진해시" href="#" shape="poly" coords="267,162,251,160,243,160,237,157,224,157,233,168,234,174,256,176,267,177" />
        <area class="btn_area" alt="김해시" title="김해시" href="#" shape="poly" coords="302,135,298,130,289,122,281,117,273,113,268,111,261,116,254,121,244,128,246,140,249,147,251,154,259,155,276,156,278,149,287,144,297,144" />
        <area class="btn_area" alt="양산시" title="양산시" href="#" shape="poly" coords="323,86,312,80,301,83,295,93,290,98,280,109,288,115,297,122,305,131,320,128,327,118,333,114,341,116,347,109,346,98,334,98" />
        <area class="btn_area" alt="남해군" title="남해군" href="#" shape="poly" coords="73,203,62,204,53,217,52,230,58,238,61,247,71,240,80,248,92,248,104,242,105,236,106,225,100,214,93,210" />
        <area class="btn_area" alt="통영시" title="통영시" href="#" shape="poly" coords="187,200,178,198,172,204,168,209,162,207,156,209,163,215,167,222,170,229,175,245,181,238,181,225,178,219,181,213,179,210" />
        <area class="btn_area" alt="거제시" title="거제시" href="#" shape="poly" coords="236,184,229,192,216,203,216,212,210,209,203,202,193,219,200,235,210,241,218,239,214,251,217,258,230,245,234,235,242,237,249,221" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_ulsan" data-name="울산">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">울산</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="302" height="245" alt="울산맵 버튼" usemap="#ulsanMap" hidefocus="true" >
                                        <map name="ulsanMap" id="ulsanMap">
                                            <area class="btn_area" alt="울산" title="울산" href="#" shape="poly" coords="230,33,208,41,201,51,190,46,179,44,171,41,174,30,177,15,163,14,154,8,138,6,120,5,102,4,80,10,68,19,58,32,64,47,62,53,54,50,48,44,38,56,30,54,18,62,27,70,29,83,16,92,6,98,1,101,5,111,17,121,36,123,48,121,66,138,83,141,92,156,105,172,126,178,140,179,148,191,146,203,151,213,171,211,186,215,190,226,194,241,206,242,226,225,236,226,228,212,232,206,235,194,234,178,239,180,227,165,235,164,244,150,254,144,247,136,254,126,259,136,265,144,265,153,280,150,289,139,295,121,299,102,295,90,300,82,299,66,294,56,290,44,250,35" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_busan" data-name="부산">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">부산</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="315" height="236" alt="부산맵 버튼" usemap="#busanMap" hidefocus="true" >
                                        <map name="busanMap" id="busanMap">
                                            <area class="btn_area" alt="부산" title="부산" href="#" shape="poly" coords="283,2,267,6,261,8,257,2,247,2,247,12,245,17,237,23,225,18,211,16,204,25,201,44,193,53,179,60,168,63,151,73,135,78,131,99,119,107,99,110,81,115,71,112,53,122,49,127,52,140,57,150,45,153,35,150,25,156,16,152,6,154,1,156,5,164,15,173,23,174,31,189,19,192,12,198,18,202,29,205,43,208,55,210,57,199,61,180,67,180,68,187,66,194,66,206,80,206,89,188,87,205,97,194,97,209,102,233,107,237,115,222,120,232,129,234,127,222,125,209,130,204,131,216,133,227,139,215,143,208,146,198,152,208,161,216,167,222,172,231,187,232,188,218,179,212,175,203,169,193,173,185,183,188,185,196,199,193,201,197,209,187,203,172,199,167,203,158,219,156,233,154,241,158,247,154,254,140,263,140,270,125,269,116,275,114,283,99,283,86,273,86,285,80,289,72,288,54,290,46,299,43,307,47,315,42,311,33,300,30,301,14,287,3" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                            <li class="area m_jeju" data-name="제주도">
                            	<div class="map_box">
                                    <div class="detail_map">
                                        <span class="map0"></span>
                                    </div>
                                    <ul class="area_name">
                                        <li class="txt0">제주도</li>
                                    </ul>
                                    <div class="map_btns">
                                        <img src="reservation/images/blank_corver.png" width="311" height="187" alt="제주맵 버튼" usemap="#jejuMap" hidefocus="true" >
                                        <map name="jejuMap" id="jejuMap">
                                            <area class="btn_area" alt="제주도" title="제주도" href="#" shape="poly" coords="284,22,272,19,264,16,257,6,247,3,236,0,211,3,191,6,169,12,115,19,101,28,68,35,51,49,29,70,17,84,9,97,3,105,4,124,10,141,29,154,35,167,47,177,57,164,69,158,103,162,134,162,158,158,190,145,221,135,259,125,273,95,287,85,295,56,294,30" />
                                        </map>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </article>

            <article class="data_table">
            	<div class="resul_info"><strong class="area">‘’</strong><span>의 문화관광해설사 예약사이트 검색 결과</span></div>
            	<div id="reservation_list">
	            	<table summary="문화관광해설사 예약사이트 검색결과 테이블입니다.">
	                	<caption>문화관광해설사 예약사이트 검색 결과</caption>
	                    <colgroup>
	                    	<col width="50%" />
	                        <col width="15%" />
	                        <col width="15%" />
	                        <col width="20%" />
	                    </colgroup>
	                    <thead>
	                    	<tr>
	                        	<th scope="col">지역</th>
	                            <th scope="col">예약</th>
	                            <th scope="col">안내</th>
	                            <th scope="col">전화번호</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<!-- <tr>
	                        	<td>괴산군</td>
	                            <td><a href="#" class="link btn_reservation" title="예약">예약</a></td>
	                            <td><a href="#" class="link btn_guide" title="안내">안내</a></td>
	                            <td>043-1234-1234</td>
	                        </tr>
	                        <tr>
	                        	<td>괴산군</td>
	                            <td><a href="#" class="link btn_reservation" title="예약">예약</a></td>
	                            <td></td>
	                            <td>043-1234-1234</td>
	                        </tr>
	                        <tr>
	                        	<td>보은군</td>
	                            <td></td>
	                            <td><a href="#" class="link btn_guide" title="안내">안내</a></td>
	                            <td>043-1234-1234</td>
	                        </tr>
	                        <tr>
	                        	<td>옥천군</td>
	                            <td><a href="#" class="link btn_reservation" title="예약">예약</a></td>
	                            <td><a href="#" class="link btn_guide" title="안내">안내</a></td>
	                            <td>043-1234-1234</td>
	                        </tr> -->
	                    </tbody>
	                </table>
                </div>
            </article>

        </section>
    	<footer>
        	<div class="copy_area">
            	<div class="logos">
                	<img src="reservation/images/copy_logo1.png" alt="문화체육관광부">
                    <img src="reservation/images/copy_logo2.png" alt="한국문화관광연구원">
                    <img src="reservation/images/copy_logo3.png" alt="한국관광공사">
                </div>
                <div class="inofo">본 시스템을 통해 보다 체계화된 관광안내표지 관리를 실천하여<br>관광객으로 하여금 목적지에 보다 쉽게 찾아갈 수 있도록 하고자 합니다.</div>
            </div>
        </footer>
    </div>
</body>
</html>

</html>
