//package com.sweetk.kcti.commentary.controller;
//
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.PrintWriter;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.Enumeration;
//import java.util.Random;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.ibatis.session.SqlSession;
//import org.apache.log4j.Logger;
//import org.apache.poi.ss.util.CellRangeAddress;
//import org.apache.poi.xssf.usermodel.XSSFCell;
//import org.apache.poi.xssf.usermodel.XSSFRow;
//import org.apache.poi.xssf.usermodel.XSSFSheet;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.transaction.PlatformTransactionManager;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
//import com.sweetk.kcti.common.utils.SendEmail;
//import com.sweetk.kcti.auth.mapper.AuthMapper;
//import com.sweetk.kcti.auth.vo.AuthVo;
//import com.sweetk.kcti.commentary.mapper.CommentaryMapper;
//import com.sweetk.kcti.commentary.vo.CommentaryVo;
//import com.sweetk.kcti.common.vo.CommonVo;
//import com.sweetk.kcti.common.mapper.CommonMapper;
//
//import com.penta.scpdb.*;
//
//@Controller
//public class CommentaryController {
//	Logger log = Logger.getLogger(CommentaryController.class);
//	
//	@Autowired
//    private SqlSession sqlSession;
//    
//    @Autowired 
//    private PlatformTransactionManager transactionManager;
//	
//    @RequestMapping("/cmmt_list.do")
//    protected ModelAndView cmmt_list(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_list");
//		 
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//		
//		// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		if (pageNum == null || pageNum == "") {
//			 pageNum = "1";
//		}
//		
//		int currentPage = Integer.parseInt(pageNum);
//		int startRow = (currentPage - 1) * pageSize;
//		int endRow = currentPage * pageSize;
//		int count = 0;
//		int number=0;
//		int pageGroupCount = 0;
//		int numPageGroup = 0;
//		
//		ArrayList<CommentaryVo> list = null;
//		
//		try{
//			String auth = session.getAttribute("authNo").toString();
//			String sido = session.getAttribute("sidoCd").toString();
//			String cmntor = session.getAttribute("cmntorNo").toString();
//			
//			String oPrt = req.getParameter("order_prt");
//			if("2".equals(oPrt)) {
//				String sOdr = req.getParameter("srch_order");
//				if("".equals(sOdr) || sOdr == null) sOdr = "1";
//				cvo.setSrch_order(sOdr);
//			} else {
//				cvo.setSrch_order("");
//			}
//			/*
//			System.out.println("odr : " + cvo.getSrch_order());
//			System.out.println("prt : " + cvo.getOrder_prt());*/
//			
//			cvo.setAuth_no(auth);
//			
//			if(!"1".equals(auth) && !"5".equals(auth)){
//				cvo.setSrch_sido(sido);
//				if ("3".equals(auth)) {
//					cvo.setSrch_gugun(session.getAttribute("gugunCd").toString());
//				}
//				cvo.setCmntor_no(cmntor);
//			} 
//			
// 			count = mapper.cmmt_list_count(cvo);
// 			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				cvo.setStartRow(startRow);
//				cvo.setEndRow(pageSize);
//				list = mapper.cmmt_list(cvo);
//				 
//				//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//				String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//			    ScpDbAgent agt = new ScpDbAgent();
//			    
//			    String hdPh = ""; 
//			    for(int i=0; i<list.size(); i++) {
//			    	hdPh = agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getHand_phone(), "UTF-8");
//			    	if(!"".equals(hdPh)) {
//			    		list.get(i).setHand_ph3(hdPh.substring(hdPh.lastIndexOf( '-' )+1 ));
//			    	}
//			    	list.get(i).setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getBirth_dt(), "UTF-8") );
//			    }
//			
//			} else {
//				list = null;
//			}
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			ArrayList<CommonVo> sido_list = cmapper.sido_list();
//    		
//			mav.addObject("count", count);
//    		mav.addObject("list", list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("s_list", sido_list);
//    		    		 
//    		mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
//			mav.addObject("count", count);
//			mav.addObject("pageSize", pageSize);
//			mav.addObject("number", number);
//			mav.addObject("pageGroupSize", pageGroupSize);
//			mav.addObject("numPageGroup", numPageGroup);
//			mav.addObject("pageGroupCount", pageGroupCount);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	return mav;
//	}
//    
//    @RequestMapping("/cmmt_create.do")
//    protected ModelAndView cmmt_create(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_create");
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null ||  "9".equals( session.getAttribute("authNo").toString() ) ) { 
//			resp.sendRedirect("login.do");
//		}
//		if ( "4".equals(session.getAttribute("authNo").toString() )) { 
//			resp.sendRedirect("cmmt_list.do");
//		}
//		
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		try{
//			ArrayList<CommonVo> sido_list = cmapper.sido_list();
//    		mav.addObject("s_list", sido_list);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	 
//    	return mav;
//	} 
//    
//    @RequestMapping("/cmmt_save.do")
//	protected ModelAndView cmmt_save(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_info");
//		
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//
//		String strSaveDir = "/files/image/";
//		
//		String savePath = req.getRealPath(strSaveDir); 
//		
//		File targetDir = null;
//		targetDir = new File(savePath);
//		if(!targetDir.isDirectory()){
//			targetDir.mkdirs();
//		}
//		
//		int sizeLimit = 100 * 1024 * 1024 / 2; 
//		String encType = "utf-8"; 
//		MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
//    	
//		String fileName = "";
//		String newFile = ""; 
//		Enumeration formNames = multi.getFileNames();
//		
//		if(formNames.hasMoreElements()) {
//			String formName = (String) formNames.nextElement(); 
//			fileName = multi.getFilesystemName(formName);
//			
//			if(!"".equals(fileName) && fileName != null) {
//			
//				newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//				int index = fileName.indexOf(".");
//				String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//				newFile = newFile + filename1;
//	
//				File file=new File(savePath+"/"+fileName); //원본파일부르기
//				file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//			}
//		}
//		
//		String imgChange = (String)multi.getParameter("img_change");
//		String imgPath = (String)multi.getParameter("img_path");
//		String cNo = (String)multi.getParameter("cmntor_no");
//		String name = (String)multi.getParameter("name");
//		String bDt = (String)multi.getParameter("birth_dt");
//		String gndr = (String)multi.getParameter("gender");
//		String eNm = (String)multi.getParameter("eng_name");
//		String eNm2 = (String)multi.getParameter("eng_name2");
//		String rDt = (String)multi.getParameter("rgst_dt");
//		String aYn = (String)multi.getParameter("act_yn");
//		String aPrt = (String)multi.getParameter("act_prt_cd");
//		String aPlc = (String)multi.getParameter("arrg_place");
//		String hPlc = (String)multi.getParameter("hope_place");
//		String sCd = (String)multi.getParameter("sido_cd");
//		String gCd = (String)multi.getParameter("gugun_cd");
//		String hZip = (String)multi.getParameter("home_zip");
//		String hAddr1 = (String)multi.getParameter("home_addr1");
//		String hAddr2 = (String)multi.getParameter("home_addr2");
//		String hPh = (String)multi.getParameter("home_phone");
//		String hPh2 = (String)multi.getParameter("hand_phone");
//		String em = (String)multi.getParameter("email");
//		String jb = (String)multi.getParameter("job");
//		String eCd = (String)multi.getParameter("last_edu_cd");
//		String eJob = (String)multi.getParameter("etc_job_nm");
//		String eLang = (String)multi.getParameter("etc_lang");
//		String nTYy = (String)multi.getParameter("eng_test_yy");
//		String nTNm = (String)multi.getParameter("eng_test_nm");
//		String nTPnt = (String)multi.getParameter("eng_test_pnt");
//		String cTYy = (String)multi.getParameter("chn_test_yy");
//		String cTNm = (String)multi.getParameter("chn_test_nm");
//		String cTPnt = (String)multi.getParameter("chn_test_pnt");
//		String jTYy = (String)multi.getParameter("jpn_test_yy");
//		String jTNm = (String)multi.getParameter("jpn_test_nm");
//		String jTPnt = (String)multi.getParameter("jpn_test_pnt");
//		String eTYy = (String)multi.getParameter("etc_test_yy");
//		String eTNm = (String)multi.getParameter("etc_test_nm");
//		String eTPnt = (String)multi.getParameter("etc_test_pnt");
//		String eLNm = (String)multi.getParameter("etc_lang_nm");
//
//		try{
//			
//			if(newFile != "") {
//				cvo.setPrfl_img(newFile);
//			} else {
//				cvo.setPrfl_img(imgPath);
//			}
//			
//			//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//			ScpDbAgent agt = new ScpDbAgent();
//			
//			cvo.setName(name);
//			cvo.setBirth_dt(agt.ScpEncStr( iniFilePath, "KEY1", bDt, "UTF-8" ));
//			/*cvo.setBirth_dt(bDt);*/
//			cvo.setGender(gndr);
//			cvo.setEng_name(eNm);
//			cvo.setEng_name2(eNm2);
//			cvo.setRgst_dt(rDt);
//			cvo.setAct_yn(aYn);
//			cvo.setAct_prt_cd(aPrt);
//			cvo.setArrg_place(aPlc);
//			cvo.setHope_place(hPlc);
//			cvo.setSido_cd(sCd);
//			cvo.setGugun_cd(gCd);
//			cvo.setHome_zip(hZip);
//			cvo.setHome_addr1(agt.ScpEncStr( iniFilePath, "KEY1", hAddr1, "UTF-8" ));
//			cvo.setHome_addr2(agt.ScpEncStr( iniFilePath, "KEY1", hAddr2, "UTF-8" ));
//			cvo.setHome_phone(agt.ScpEncStr( iniFilePath, "KEY1", hPh, "UTF-8" ));
//			cvo.setHand_phone(agt.ScpEncStr( iniFilePath, "KEY1", hPh2, "UTF-8" ));
//			cvo.setEmail(agt.ScpEncStr( iniFilePath, "KEY1", em, "UTF-8" ));
//			/*cvo.setHome_addr1(hAddr1);
//			cvo.setHome_addr2(hAddr2);
//			cvo.setHome_phone(hPh);
//			cvo.setHand_phone(hPh2);
//			cvo.setEmail(em);*/
//			cvo.setJob(jb);
//			cvo.setLast_edu_cd(eCd);
//			cvo.setEtc_job_nm(eJob);
//			cvo.setEng_test_yy(nTYy);
//			cvo.setEng_test_nm(nTNm);
//			cvo.setEng_test_pnt(nTPnt);
//			cvo.setChn_test_yy(cTYy);
//			cvo.setChn_test_nm(cTNm);
//			cvo.setChn_test_pnt(cTPnt);
//			cvo.setJpn_test_yy(jTYy);
//			cvo.setJpn_test_nm(jTNm);
//			cvo.setJpn_test_pnt(jTPnt);
//			cvo.setEtc_test_yy(eTYy);
//			cvo.setEtc_test_nm(eTNm);
//			cvo.setEtc_test_pnt(eTPnt);
//			cvo.setEtc_lang_nm(eLNm);
//			
//			String auth = session.getAttribute("authNo").toString();
//			cvo.setAuth_no(auth);
//			String inptUsr = session.getAttribute("UserId").toString();
//			cvo.setInpt_usr(inptUsr);
//			 
//			int s_no = mapper.cmmt_save(cvo);
// 			
// 			// System.out.println("st_no : " + cvo.getCmntor_no());
// 			
// 			String lng1 = (String)multi.getParameter("lang1");
// 			if(lng1 != null && lng1 != "") {
// 				cvo.setLang_cd(lng1);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng2 = (String)multi.getParameter("lang2");
// 			String lng2Grade = (String)multi.getParameter("lang2_grade");
// 			if(lng2 != null && lng2 != "") {
// 				cvo.setLang_cd(lng2);
// 				cvo.setGrade(lng2Grade);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng3 = (String)multi.getParameter("lang3");
// 			String lng3Grade = (String)multi.getParameter("lang3_grade");
// 			if(lng3 != null && lng3 != "") {
// 				cvo.setLang_cd(lng3);
// 				cvo.setGrade(lng3Grade);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng4 = (String)multi.getParameter("lang4");
// 			String lng4Grade = (String)multi.getParameter("lang4_grade");
// 			if(lng4 != null && lng4 != "") {
// 				cvo.setLang_cd(lng4);
// 				cvo.setGrade(lng4Grade);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng9 = (String)multi.getParameter("lang9");
// 			String lng9Grade = (String)multi.getParameter("lang9_grade");
// 			if(lng9 != null && lng9 != "") {
// 				cvo.setLang_cd(lng9);
// 				cvo.setGrade(lng9Grade);
// 				cvo.setEtc_lang(eLang);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 		   
// 			CommentaryVo info = new CommentaryVo();
//			
//			info = mapper.cmmt_info(cvo);
//			
//			info.setHome_addr1( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr1(), "UTF-8") );
//			info.setHome_addr2( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr2(), "UTF-8") );
//			info.setHome_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_phone(), "UTF-8") );
//			info.setHand_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHand_phone(), "UTF-8") );
//			info.setEmail( agt.ScpDecStr( iniFilePath, "KEY1", info.getEmail(), "UTF-8") );
//			info.setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", info.getBirth_dt(), "UTF-8") );
//			
//			mav.addObject("info", info);
//    		mav.addObject("srch", cvo);
//    		
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//    
//    @RequestMapping("/cmmt_info.do")
//    protected ModelAndView cmmt_info(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_info");
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//		
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		
//		try{
//			//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//		    ScpDbAgent agt = new ScpDbAgent();
//			
//			String cNo = req.getParameter("c_no");
//			
//			cvo.setCmntor_no(cNo);
//			
//			CommentaryVo info = new CommentaryVo();
//			
//			info = mapper.cmmt_info(cvo);
//			
//			info.setHome_addr1( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr1(), "UTF-8") );
//			info.setHome_addr2( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr2(), "UTF-8") );
//			info.setHome_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_phone(), "UTF-8") );
//			info.setHand_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHand_phone(), "UTF-8") );
//			info.setEmail( agt.ScpDecStr( iniFilePath, "KEY1", info.getEmail(), "UTF-8") );
//			info.setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", info.getBirth_dt(), "UTF-8") );
//			
//			mav.addObject("info", info);
//    		mav.addObject("srch", cvo);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	
//    	return mav;
//	}
//    
//    @RequestMapping("/cmmt_user_create.do")
//    protected ModelAndView user_create(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_info");
//		
//		AuthMapper amapper = sqlSession.getMapper(AuthMapper.class);
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		
//		try{
//			
//			String cNo = req.getParameter("c_no");
//			cvo.setCmntor_no(cNo);
//			
//			AuthVo avo = new AuthVo();
//			avo.setId(cvo.getEmail());
//			avo.setSido_cd(cvo.getSido_cd());
//			avo.setGugun_cd(cvo.getGugun_cd());
//			avo.setNm(cvo.getName());
//			avo.setCmntor_no(cNo);
//			avo.setAuth_no(4);  // 해설사 권한 기본 셋팅
//			
//			if(!"".equals(cvo.getHand_phone()) ) {
//				avo.setPhone(cvo.getHand_phone());
//			} else if(!"".equals(cvo.getHome_phone())) {
//				avo.setPhone(cvo.getHome_phone());
//			}
//			/* 비밀번호 랜덤 */
//			String pw = null;
//			pw = makePassword(8);
//			avo.setPw(pw);
//			
//			amapper.user_insert(avo);
//			
//			SendEmail SendEmail = new SendEmail();
//			//SendEmail.Email("master@kcti.co.kr", cvo.getEmail(), "한국문화관광해설사 비밀번호 정보입니다", "임시비밀번호는 "+pw+" 입니다. 로그인 후 비밀번호를 변경하시기 바랍니다.");
//			SendEmail.Email("ctgs@kcti.re.kr", cvo.getEmail(), "한국문화관광해설사 비밀번호 정보입니다", "아이디는 "+cvo.getEmail()+"입니다. 임시비밀번호는 "+pw+" 입니다. 로그인 후 비밀번호를 변경하시기 바랍니다.");
//			
//			CommentaryVo info = new CommentaryVo();
//			
//			info = mapper.cmmt_info(cvo);
//			
//			//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//		    ScpDbAgent agt = new ScpDbAgent();
//			
//			info.setHome_addr1( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr1(), "UTF-8") );
//			info.setHome_addr2( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr2(), "UTF-8") );
//			info.setHome_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_phone(), "UTF-8") );
//			info.setHand_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHand_phone(), "UTF-8") );
//			info.setEmail( agt.ScpDecStr( iniFilePath, "KEY1", info.getEmail(), "UTF-8") );
//			info.setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", info.getBirth_dt(), "UTF-8") );
//			
//			mav.addObject("info", info);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("userYn", "Y");
//    		    		 
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	
//    	return mav;
//	}
//    
//    @RequestMapping("/cmmt_edit.do")
//    protected ModelAndView cmmt_edit(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_edit");
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//		
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		try{
//			String cNo = req.getParameter("c_no");
//			
//			cvo.setCmntor_no(cNo);
//			
//			CommentaryVo info = new CommentaryVo();
//			CommentaryVo lang = new CommentaryVo();
//			
//			info = mapper.cmmt_info(cvo);
//			lang = mapper.cmmt_lang_info(cvo);
//			
//			//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//		    ScpDbAgent agt = new ScpDbAgent();
//			
//			info.setHome_addr1( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr1(), "UTF-8") );
//			info.setHome_addr2( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr2(), "UTF-8") );
//			
//			String hmPh = agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_phone(), "UTF-8");
//			String hdPh = agt.ScpDecStr( iniFilePath, "KEY1", info.getHand_phone(), "UTF-8");
///*			String hmPh = info.getHome_phone();
//			String hdPh = info.getHand_phone();
//*/			info.setHome_phone( hmPh );
//			info.setHand_phone( hdPh );
//			
//			String em = agt.ScpDecStr( iniFilePath, "KEY1", info.getEmail(), "UTF-8");
//			/*String em = info.getEmail();*/
//			info.setEmail( em );
//			info.setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", info.getBirth_dt(), "UTF-8") );
//			
//			if(!"".equals(hmPh)) {
//				info.setHome_ph1(hmPh.substring(0, hmPh.indexOf( '-',1 ) ) );
//				info.setHome_ph2(hmPh.substring(hmPh.indexOf( '-',1 )+1, hmPh.lastIndexOf( '-' ) ));
//				info.setHome_ph3(hmPh.substring(hmPh.lastIndexOf( '-' )+1 ));
//			}
//			if(!"".equals(hdPh)) {
//				info.setHand_ph1(hdPh.substring(0, hdPh.indexOf( '-',1 ) ) );
//				info.setHand_ph2(hdPh.substring(hdPh.indexOf( '-',1 )+1, hdPh.lastIndexOf( '-' ) ));
//				info.setHand_ph3(hdPh.substring(hdPh.lastIndexOf( '-' )+1 ));
//			}
//			if(!"".equals(em)) {
//				info.setEmail1(em.substring(0, em.indexOf( '@',1 )));
//				info.setEmail2(em.substring(em.lastIndexOf( '@')+1));
//			}
//			
//			ArrayList<CommonVo> sido_list = cmapper.sido_list();
//			mav.addObject("info", info);
//			mav.addObject("lang", lang);
//			mav.addObject("s_list", sido_list);
//    		mav.addObject("srch", cvo);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	
//    	return mav;
//	}
//    
//    @RequestMapping("/cmmt_update.do")
//	protected ModelAndView cmmt_update(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_info");
//		
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//
//		String strSaveDir = "/files/image/";
//		
//		String savePath = req.getRealPath(strSaveDir); 
//		
//		File targetDir = null;
//		targetDir = new File(savePath);
//		if(!targetDir.isDirectory()){
//			targetDir.mkdirs();
//		}
//		
//		int sizeLimit = 100 * 1024 * 1024 / 2; 
//		String encType = "utf-8"; 
//		MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
//    	
//		String fileName = "";
//		String newFile = ""; 
//		Enumeration formNames = multi.getFileNames();
//		
//		if(formNames.hasMoreElements()) {
//			String formName = (String) formNames.nextElement(); 
//			fileName = multi.getFilesystemName(formName);
//			//System.out.println("formName : " + formName);
//			//System.out.println("fileName : " + fileName);
//			
//			if(!"".equals(fileName) && fileName != null) {
//			
//				newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//				int index = fileName.indexOf(".");
//				String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//				newFile = newFile + filename1;
//	
//				File file=new File(savePath+"/"+fileName); //원본파일부르기
//				file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//				
//				//System.out.println("newFile : " + newFile);
//			}
//		}
//		
//		String imgPath = (String)multi.getParameter("img_path");
//		String cNo = (String)multi.getParameter("cmntor_no");
//		String name = (String)multi.getParameter("name");
//		String bDt = (String)multi.getParameter("birth_dt");
//		String gndr = (String)multi.getParameter("gender");
//		String eNm = (String)multi.getParameter("eng_name");
//		String eNm2 = (String)multi.getParameter("eng_name2");
//		String rDt = (String)multi.getParameter("rgst_dt");
//		String aYn = (String)multi.getParameter("act_yn");
//		String aPrt = (String)multi.getParameter("act_prt_cd");
//		String aPlc = (String)multi.getParameter("arrg_place");
//		String hPlc = (String)multi.getParameter("hope_place");
//		String sCd = (String)multi.getParameter("sido_cd");
//		String gCd = (String)multi.getParameter("gugun_cd");
//		String hZip = (String)multi.getParameter("home_zip");
//		String hAddr1 = (String)multi.getParameter("home_addr1");
//		String hAddr2 = (String)multi.getParameter("home_addr2");
//		String hPh = (String)multi.getParameter("home_phone");
//		String hPh2 = (String)multi.getParameter("hand_phone");
//		String em = (String)multi.getParameter("email");
//		String jb = (String)multi.getParameter("job");
//		String eCd = (String)multi.getParameter("last_edu_cd");
//		String eJob = (String)multi.getParameter("etc_job_nm");
//		String eLang = (String)multi.getParameter("etc_lang");
//		String nTYy = (String)multi.getParameter("eng_test_yy");
//		String nTNm = (String)multi.getParameter("eng_test_nm");
//		String nTPnt = (String)multi.getParameter("eng_test_pnt");
//		String cTYy = (String)multi.getParameter("chn_test_yy");
//		String cTNm = (String)multi.getParameter("chn_test_nm");
//		String cTPnt = (String)multi.getParameter("chn_test_pnt");
//		String jTYy = (String)multi.getParameter("jpn_test_yy");
//		String jTNm = (String)multi.getParameter("jpn_test_nm");
//		String jTPnt = (String)multi.getParameter("jpn_test_pnt");
//		String eTYy = (String)multi.getParameter("etc_test_yy");
//		String eTNm = (String)multi.getParameter("etc_test_nm");
//		String eTPnt = (String)multi.getParameter("etc_test_pnt");
//		String eLNm = (String)multi.getParameter("etc_lang_nm");
//
//		
//		try{
//			
//			if(newFile != "") {
//				cvo.setPrfl_img(newFile);
//			}
//		    //String strEnc = "";
//		    //String strDec = "";
//
//		/* DAMO SCP API
//		   설정 파일과 키파일의 풀 패스 
//		*/
//		   //String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//		  
//		   ScpDbAgent agt = new ScpDbAgent();
//			
//		   //strEnc = agt.ScpEncStr( iniFilePath, "KEY1", em, "UTF-8" );
//		   //strDec = agt.ScpDecStr( iniFilePath, "KEY1", strEnc, "UTF-8");
//			
//			cvo.setCmntor_no(cNo);
//			cvo.setName(name);
//			cvo.setBirth_dt(agt.ScpEncStr( iniFilePath, "KEY1", bDt, "UTF-8" ));
//			/*cvo.setBirth_dt(bDt);*/
//			cvo.setGender(gndr);
//			cvo.setEng_name(eNm);
//			cvo.setEng_name2(eNm2);
//			cvo.setRgst_dt(rDt);
//			cvo.setAct_yn(aYn);
//			cvo.setAct_prt_cd(aPrt);
//			cvo.setArrg_place(aPlc);
//			cvo.setHope_place(hPlc);
//			cvo.setSido_cd(sCd);
//			cvo.setGugun_cd(gCd);
//			cvo.setHome_zip(hZip);
//			cvo.setHome_addr1(agt.ScpEncStr( iniFilePath, "KEY1", hAddr1, "UTF-8" ));
//			cvo.setHome_addr2(agt.ScpEncStr( iniFilePath, "KEY1", hAddr2, "UTF-8" ));
//			cvo.setHome_phone(agt.ScpEncStr( iniFilePath, "KEY1", hPh, "UTF-8" ));
//			cvo.setHand_phone(agt.ScpEncStr( iniFilePath, "KEY1", hPh2, "UTF-8" ));
//			cvo.setEmail(agt.ScpEncStr( iniFilePath, "KEY1", em, "UTF-8" ));
//			/*cvo.setHome_addr1(hAddr1);
//			cvo.setHome_addr2(hAddr2);
//			cvo.setHome_phone(hPh);
//			cvo.setHand_phone(hPh2);
//			cvo.setEmail(em);*/
//			cvo.setJob(jb);
//			cvo.setLast_edu_cd(eCd);
//			cvo.setEtc_job_nm(eJob);
//			cvo.setEng_test_yy(nTYy);
//			cvo.setEng_test_nm(nTNm);
//			cvo.setEng_test_pnt(nTPnt);
//			cvo.setChn_test_yy(cTYy);
//			cvo.setChn_test_nm(cTNm);
//			cvo.setChn_test_pnt(cTPnt);
//			cvo.setJpn_test_yy(jTYy);
//			cvo.setJpn_test_nm(jTNm);
//			cvo.setJpn_test_pnt(jTPnt);
//			cvo.setEtc_test_yy(eTYy);
//			cvo.setEtc_test_nm(eTNm);
//			cvo.setEtc_test_pnt(eTPnt);
//			cvo.setEtc_lang_nm(eLNm);
//			
//			String inptUsr = session.getAttribute("UserId").toString();
//			cvo.setInpt_usr(inptUsr);
//			 
//			mapper.cmmt_update(cvo);
//			mapper.cmmt_lang_delete(cvo);
// 			
//			String lng1 = (String)multi.getParameter("lang1");
// 			if(lng1 != null && lng1 != "") {
// 				cvo.setLang_cd(lng1);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng2 = (String)multi.getParameter("lang2");
// 			String lng2Grade = (String)multi.getParameter("lang2_grade");
// 			if(lng2 != null && lng2 != "") {
// 				cvo.setLang_cd(lng2);
// 				cvo.setGrade(lng2Grade);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng3 = (String)multi.getParameter("lang3");
// 			String lng3Grade = (String)multi.getParameter("lang3_grade");
// 			if(lng3 != null && lng3 != "") {
// 				cvo.setLang_cd(lng3);
// 				cvo.setGrade(lng3Grade);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng4 = (String)multi.getParameter("lang4");
// 			String lng4Grade = (String)multi.getParameter("lang4_grade");
// 			if(lng4 != null && lng4 != "") {
// 				cvo.setLang_cd(lng4);
// 				cvo.setGrade(lng4Grade);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			String lng9 = (String)multi.getParameter("lang9");
// 			String lng9Grade = (String)multi.getParameter("lang9_grade");
// 			if(lng9 != null && lng9 != "") {
// 				cvo.setLang_cd(lng9);
// 				cvo.setGrade(lng9Grade);
// 				cvo.setEtc_lang(eLang);
// 				mapper.cmmt_lang_save(cvo);
// 			}
// 			
// 			CommonVo cmvo = new CommonVo();
// 			cmvo.setAct_prt_cd("20"); // 정보수정
// 			cmvo.setCmntor_no(cNo);
// 			cmvo.setIp_info(req.getRemoteAddr());
// 			cmvo.setId(session.getAttribute("UserId").toString());
// 			cmapper.cmmt_info_hist_insert(cmvo);
// 			
// 			CommentaryVo info = new CommentaryVo();
//			info = mapper.cmmt_info(cvo);
//			
//			info.setHome_addr1( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr1(), "UTF-8") );
//			info.setHome_addr2( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_addr2(), "UTF-8") );
//			info.setHome_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHome_phone(), "UTF-8") );
//			info.setHand_phone( agt.ScpDecStr( iniFilePath, "KEY1", info.getHand_phone(), "UTF-8") );
//			info.setEmail( agt.ScpDecStr( iniFilePath, "KEY1", info.getEmail(), "UTF-8") );
//			info.setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", info.getBirth_dt(), "UTF-8") );
//			
//			mav.addObject("info", info);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("update", "Y");
//    		
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//    
//    
//    @RequestMapping("/cmmt_delete.do")
//    protected ModelAndView cmmt_delete(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_list");
//		 
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//		
//		// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		if (pageNum == null || pageNum == "") {
//			 pageNum = "1";
//		}
//		
//		String cNo = req.getParameter("c_no");
//		 
//		int currentPage = Integer.parseInt(pageNum);
//		int startRow = (currentPage - 1) * pageSize;
//		int endRow = currentPage * pageSize;
//		int count = 0;
//		int number=0;
//		int pageGroupCount = 0;
//		int numPageGroup = 0;
//		
//		ArrayList<CommentaryVo> list = null;
//		
//		try{
//			cvo.setCmntor_no(cNo);
//			mapper.cmmt_delete(cvo);
//			
//			String auth = session.getAttribute("authNo").toString();
//			String sido = session.getAttribute("sidoCd").toString();
//			String cmntor = session.getAttribute("cmntorNo").toString();
//			
//			cvo.setAuth_no(auth);
//			if(!"1".equals(auth)){
//				cvo.setSrch_sido(sido);
//				cvo.setCmntor_no(cmntor);
//			}
//		 
// 			count = mapper.cmmt_list_count(cvo);
// 			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				cvo.setStartRow(startRow);
//				cvo.setEndRow(pageSize);
//				list = mapper.cmmt_list(cvo);
//				
//				//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//				String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//				   
//			    ScpDbAgent agt = new ScpDbAgent();
//			    
//			    String hdPh = ""; 
//			    for(int i=0; i<list.size(); i++) {
//			    	hdPh = agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getHand_phone(), "UTF-8");
//			    	if(!"".equals(hdPh)) {
//			    		list.get(i).setHand_ph3(hdPh.substring(hdPh.lastIndexOf( '-' )+1 ));
//			    	}
//			    }
//			} else {
//				list = null;
//			}
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			ArrayList<CommonVo> sido_list = cmapper.sido_list();
//    		
//			mav.addObject("count", count);
//    		mav.addObject("list", list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("s_list", sido_list);
//    		    		 
//    		mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
//			mav.addObject("count", count);
//			mav.addObject("pageSize", pageSize);
//			mav.addObject("number", number);
//			mav.addObject("pageGroupSize", pageGroupSize);
//			mav.addObject("numPageGroup", numPageGroup);
//			mav.addObject("pageGroupCount", pageGroupCount);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	return mav;
//	}
//    
//    @RequestMapping("/cmmt_edu_list.do")
//    protected ModelAndView cmmt_edu_list(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_edu_list");
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//		
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		//System.out.println("pageNum : " + pageNum);
//		
//		if (pageNum == null || pageNum == "") {
//			 pageNum = "1";
//		}
//		
//		int currentPage = Integer.parseInt(pageNum);
//		int startRow = (currentPage - 1) * pageSize;
//		int endRow = currentPage * pageSize;
//		int count = 0;
//		int number=0;
//		int pageGroupCount = 0;
//		int numPageGroup = 0;
//		
//		try{
//			
//			ArrayList<CommentaryVo> list = null;
//			Date d = new Date();
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//			String now_ym = sdf.format(d);
//			
//			String cNo = req.getParameter("c_no");
//
//			cvo.setSrch_ym(now_ym);
//			cvo.setCmntor_no(cNo);
//			
//			count = mapper.cmmt_edu_list_count(cvo);
//			
// 			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				cvo.setStartRow(startRow);
//				cvo.setEndRow(pageSize);
//				list = mapper.cmmt_edu_list(cvo);
//			} else {
//				list = null;
//			}
//
//			ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//			
//			CommentaryVo info = new CommentaryVo();
//			info = mapper.cmmt_info(cvo);
// 			
//			mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("now_ym", now_ym);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("info", info);
//    		    		 
//    		mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
//			mav.addObject("count", count);
//			mav.addObject("pageSize", pageSize);
//			mav.addObject("number", number);
//			mav.addObject("pageGroupSize", pageGroupSize);
//			mav.addObject("numPageGroup", numPageGroup);
//			mav.addObject("pageGroupCount", pageGroupCount);
//    		
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	
//    	return mav;
//	}
//    
//    @RequestMapping("/cmmt_edu_save.do")
//    protected ModelAndView cmmt_edu_save(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("commentary/cmmt_edu_list");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//    	int pageGroupSize = 5;
//    	String pageNum =req.getParameter("pageNum");
//    	
//    	//System.out.println("pageNum : " + pageNum);
//    	
//    	if (pageNum == null || pageNum == "") {
//    		pageNum = "1";
//    	}
//    	
//    	int currentPage = Integer.parseInt(pageNum);
//    	int startRow = (currentPage - 1) * pageSize;
//    	int endRow = currentPage * pageSize;
//    	int count = 0;
//    	int number=0;
//    	int pageGroupCount = 0;
//    	int numPageGroup = 0;
//    	
//    	try{
//    		String eSeq = req.getParameter("edu_seq");
//    		
//    		if(!"0".equals(eSeq)) {
//    			mapper.cmmt_edu_update(cvo);
//    		} else { 
//    			mapper.cmmt_edu_insert(cvo);
//    		}
//    		
//    		ArrayList<CommentaryVo> list = null;
//    		
//    		Date d = new Date();
//    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//    		String now_ym = sdf.format(d);
//    		
//    		cvo.setSrch_ym(now_ym);
//    		
//    		count = mapper.cmmt_edu_list_count(cvo);
//    		
//    		if (count > 0) {        
//    			if(endRow>count) endRow = count;
//    			cvo.setStartRow(startRow);
//    			cvo.setEndRow(pageSize);
//    			list = mapper.cmmt_edu_list(cvo);
//    		} else {
//    			list = null;
//    		}
//    		
//    		ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//    		
//    		CommentaryVo info = new CommentaryVo();
//			info = mapper.cmmt_info(cvo);
//    		
//    		number=count-(currentPage-1)*pageSize;
//    		pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//    		numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("now_ym", now_ym);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("info", info);
//    		
//    		mav.addObject("currentPage", currentPage);
//    		mav.addObject("startRow", startRow);
//    		mav.addObject("endRow", endRow);
//    		mav.addObject("count", count);
//    		mav.addObject("pageSize", pageSize);
//    		mav.addObject("number", number);
//    		mav.addObject("pageGroupSize", pageGroupSize);
//    		mav.addObject("numPageGroup", numPageGroup);
//    		mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/cmmt_act_list.do")
//    protected ModelAndView cmmt_act_list(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("commentary/cmmt_act_list");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		//System.out.println("pageNum : " + pageNum);
//		
//		if (pageNum == null || pageNum == "") {
//			 pageNum = "1";
//		}
//		
//		int currentPage = Integer.parseInt(pageNum);
//		int startRow = (currentPage - 1) * pageSize;
//		int endRow = currentPage * pageSize;
//		int count = 0;
//		int number=0;
//		int pageGroupCount = 0;
//		int numPageGroup = 0;
//		
//		try{
//			
//			ArrayList<CommentaryVo> list = null;
//			
//			String cNo = req.getParameter("c_no");
//			String yy = req.getParameter("srch_yy");
//			String mm = req.getParameter("srch_mm");
//			
//			Date d = new Date();
//    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//    		String now_ym = sdf.format(d);
//			
//			// cvo.setSrch_ym(now_ym);
//			cvo.setCmntor_no(cNo);
//			 
//			count = mapper.cmmt_act_list_count(cvo);
//			
// 			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				cvo.setStartRow(startRow);
//				cvo.setEndRow(pageSize);
//				list = mapper.cmmt_act_list(cvo);
//			} else {
//				list = null;
//			}
// 			
//			ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//			 
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//			
//			CommentaryVo info = new CommentaryVo();
//			info = mapper.cmmt_info(cvo);
// 			
//			mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("now_ym", now_ym);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("info", info);
//    		    		 
//    		mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
//			mav.addObject("count", count);
//			mav.addObject("pageSize", pageSize);
//			mav.addObject("number", number);
//			mav.addObject("pageGroupSize", pageGroupSize);
//			mav.addObject("numPageGroup", numPageGroup);
//			mav.addObject("pageGroupCount", pageGroupCount);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/cmmt_act_save.do")
//    protected ModelAndView cmmt_act_save(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) {
//    	ModelAndView mav = new ModelAndView("commentary/cmmt_act_list");
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//    	int pageGroupSize = 5;
//    	String pageNum =req.getParameter("pageNum");
//    	
//    	if (pageNum == null || pageNum == "") {
//    		pageNum = "1";
//    	}
//    	
//    	int currentPage = Integer.parseInt(pageNum);
//    	int startRow = (currentPage - 1) * pageSize;
//    	int endRow = currentPage * pageSize;
//    	int count = 0;
//    	int number=0;
//    	int pageGroupCount = 0;
//    	int numPageGroup = 0;
//    	
//    	try{
//    		String sq = req.getParameter("seq");
//    		String yy = req.getParameter("work_yy");
//    		String mm = req.getParameter("work_mm");
//    		cvo.setWork_ym(yy+"-"+mm);
//    		
//    		cvo.setId(session.getAttribute("UserId").toString());
//    		
//    		if(!"0".equals(sq)) {
//    			mapper.cmmt_act_update(cvo);
//    		} else { 
//    			mapper.cmmt_act_insert(cvo);
//    		}
//    		
//    		ArrayList<CommentaryVo> list = null;
//    		
//    		count = mapper.cmmt_act_list_count(cvo);
//    		
//    		if (count > 0) {        
//    			if(endRow>count) endRow = count;
//    			cvo.setStartRow(startRow);
//    			cvo.setEndRow(pageSize);
//    			list = mapper.cmmt_act_list(cvo);
//    		} else {
//    			list = null;
//    		}
//    		
//    		ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//    		
//    		number=count-(currentPage-1)*pageSize;
//    		pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//    		numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//    		
//    		CommentaryVo info = new CommentaryVo();
//			info = mapper.cmmt_info(cvo);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("info", info);
//    		
//    		mav.addObject("currentPage", currentPage);
//    		mav.addObject("startRow", startRow);
//    		mav.addObject("endRow", endRow);
//    		mav.addObject("count", count);
//    		mav.addObject("pageSize", pageSize);
//    		mav.addObject("number", number);
//    		mav.addObject("pageGroupSize", pageGroupSize);
//    		mav.addObject("numPageGroup", numPageGroup);
//    		mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/act_delete.do")
//    protected ModelAndView act_delete(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) {
//    	ModelAndView mav = new ModelAndView("commentary/cmmt_act_list");
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//    	int pageGroupSize = 5;
//    	String pageNum =req.getParameter("pageNum");
//    	
//    	if (pageNum == null || pageNum == "") {
//    		pageNum = "1";
//    	}
//    	
//    	int currentPage = Integer.parseInt(pageNum);
//    	int startRow = (currentPage - 1) * pageSize;
//    	int endRow = currentPage * pageSize;
//    	int count = 0;
//    	int number=0;
//    	int pageGroupCount = 0;
//    	int numPageGroup = 0;
//    	
//    	try{
//    		String sq = req.getParameter("act_seq");
//    		String cNo = req.getParameter("c_no");
//    		
//			mapper.cmmt_act_delete(cNo, sq);
//    		
//			cvo.setCmntor_no(cNo);
//			
//    		ArrayList<CommentaryVo> list = null;
//    		
//    		count = mapper.cmmt_act_list_count(cvo);
//    		
//    		if (count > 0) {        
//    			if(endRow>count) endRow = count;
//    			cvo.setStartRow(startRow);
//    			cvo.setEndRow(pageSize);
//    			list = mapper.cmmt_act_list(cvo);
//    		} else {
//    			list = null;
//    		}
//    		
//    		ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//    		
//    		number=count-(currentPage-1)*pageSize;
//    		pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//    		numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//    		
//    		CommentaryVo info = new CommentaryVo();
//    		info = mapper.cmmt_info(cvo);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("info", info);
//    		
//    		mav.addObject("currentPage", currentPage);
//    		mav.addObject("startRow", startRow);
//    		mav.addObject("endRow", endRow);
//    		mav.addObject("count", count);
//    		mav.addObject("pageSize", pageSize);
//    		mav.addObject("number", number);
//    		mav.addObject("pageGroupSize", pageGroupSize);
//    		mav.addObject("numPageGroup", numPageGroup);
//    		mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/cmmt_fee_list.do")
//    protected ModelAndView cmmt_fee_list(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("commentary/cmmt_fee_list");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//    	int pageGroupSize = 5;
//    	String pageNum =req.getParameter("pageNum");
//    	
//    	//System.out.println("pageNum : " + pageNum);
//    	
//    	if (pageNum == null || pageNum == "") {
//    		pageNum = "1";
//    	}
//    	
//    	int currentPage = Integer.parseInt(pageNum);
//    	int startRow = (currentPage - 1) * pageSize;
//    	int endRow = currentPage * pageSize;
//    	int count = 0;
//    	int number=0;
//    	int pageGroupCount = 0;
//    	int numPageGroup = 0;
//    	
//    	try{
//    		
//    		ArrayList<CommentaryVo> list = null;
//    		
//    		String cNo = req.getParameter("c_no");
//    		cvo.setCmntor_no(cNo);
//    		
//    		count = mapper.cmmt_fee_list_count(cvo);
//    		
//    		if (count > 0) {        
//    			if(endRow>count) endRow = count;
//    			cvo.setStartRow(startRow);
//    			cvo.setEndRow(pageSize);
//    			list = mapper.cmmt_fee_list(cvo);
//    		} else {
//    			list = null;
//    		}
//    		
//    		ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//    		
//    		number=count-(currentPage-1)*pageSize;
//    		pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//    		numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//    		
//    		Date d = new Date();
//    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//    		String now_ym = sdf.format(d);
//    		
//    		CommentaryVo info = new CommentaryVo();
//			info = mapper.cmmt_info(cvo);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("now_ym", now_ym);
//    		mav.addObject("info", info);
//    		
//    		mav.addObject("currentPage", currentPage);
//    		mav.addObject("startRow", startRow);
//    		mav.addObject("endRow", endRow);
//    		mav.addObject("count", count);
//    		mav.addObject("pageSize", pageSize);
//    		mav.addObject("number", number);
//    		mav.addObject("pageGroupSize", pageGroupSize);
//    		mav.addObject("numPageGroup", numPageGroup);
//    		mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/cmmt_fee_save.do")
//    protected ModelAndView cmmt_fee_save(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("commentary/cmmt_fee_list");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//    	int pageGroupSize = 5;
//    	String pageNum =req.getParameter("pageNum");
//    	 
//    	//System.out.println("pageNum : " + pageNum);
//    	
//    	if (pageNum == null || pageNum == "") {
//    		pageNum = "1";
//    	}
//    	
//    	int currentPage = Integer.parseInt(pageNum);
//    	int startRow = (currentPage - 1) * pageSize;
//    	int endRow = currentPage * pageSize;
//    	int count = 0;
//    	int number=0;
//    	int pageGroupCount = 0;
//    	int numPageGroup = 0;
//    	
//    	try{
//    		String sq =req.getParameter("seq");
//    		String aFee =req.getParameter("act_fee");
//    		String yy =req.getParameter("act_yy");
//    		String mm =req.getParameter("act_mm");
//    		 
//    		if(aFee != null && aFee != "") cvo.setAct_fee(aFee.replaceAll(",", ""));
//    		cvo.setAct_ym(yy+"-"+mm);
//    		
//    		cvo.setId(session.getAttribute("UserId").toString());
//    		
//    		if(!"0".equals(sq)) {
//    			mapper.cmmt_fee_update(cvo);
//    		} else { 
//    			mapper.cmmt_fee_insert(cvo);
//    		}
//    		 
//    		ArrayList<CommentaryVo> list = null;
//    		
//    		count = mapper.cmmt_fee_list_count(cvo);
//    		
//    		if (count > 0) {        
//    			if(endRow>count) endRow = count;
//    			cvo.setStartRow(startRow);
//    			cvo.setEndRow(pageSize);
//    			list = mapper.cmmt_fee_list(cvo);
//    		} else {
//    			list = null;
//    		}
//    		
//    		ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//    		
//    		number=count-(currentPage-1)*pageSize;
//    		pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//    		numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//    		
//    		Date d = new Date();
//    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//    		String now_ym = sdf.format(d);
//    		
//    		CommentaryVo info = new CommentaryVo();
//			info = mapper.cmmt_info(cvo);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("now_ym", now_ym);
//    		mav.addObject("info", info);
//    		
//    		mav.addObject("currentPage", currentPage);
//    		mav.addObject("startRow", startRow);
//    		mav.addObject("endRow", endRow);
//    		mav.addObject("count", count);
//    		mav.addObject("pageSize", pageSize);
//    		mav.addObject("number", number);
//    		mav.addObject("pageGroupSize", pageGroupSize);
//    		mav.addObject("numPageGroup", numPageGroup);
//    		mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/fee_delete.do")
//    protected ModelAndView fee_delete(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("commentary/cmmt_fee_list");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//    		resp.sendRedirect("login.do");
//    	}
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//    	int pageGroupSize = 5;
//    	String pageNum =req.getParameter("pageNum");
//    	
//    	//System.out.println("pageNum : " + pageNum);
//    	
//    	if (pageNum == null || pageNum == "") {
//    		pageNum = "1";
//    	}
//    	
//    	int currentPage = Integer.parseInt(pageNum);
//    	int startRow = (currentPage - 1) * pageSize;
//    	int endRow = currentPage * pageSize;
//    	int count = 0;
//    	int number=0;
//    	int pageGroupCount = 0;
//    	int numPageGroup = 0;
//    	
//    	try{
//    		String sq =req.getParameter("act_seq");
//    		String cNo =req.getParameter("c_no");
//    		
//    		mapper.cmmt_fee_delete(cNo, sq);
//    		
//    		ArrayList<CommentaryVo> list = null;
//    		cvo.setCmntor_no(cNo);
//    		
//    		count = mapper.cmmt_fee_list_count(cvo);
//    		
//    		if (count > 0) {        
//    			if(endRow>count) endRow = count;
//    			cvo.setStartRow(startRow);
//    			cvo.setEndRow(pageSize);
//    			list = mapper.cmmt_fee_list(cvo);
//    		} else {
//    			list = null;
//    		}
//    		
//    		ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//    		
//    		number=count-(currentPage-1)*pageSize;
//    		pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//    		numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
//    		
//    		Date d = new Date();
//    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//    		String now_ym = sdf.format(d);
//    		
//    		CommentaryVo info = new CommentaryVo();
//    		info = mapper.cmmt_info(cvo);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("y_list", y_list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("now_ym", now_ym);
//    		mav.addObject("info", info);
//    		
//    		mav.addObject("currentPage", currentPage);
//    		mav.addObject("startRow", startRow);
//    		mav.addObject("endRow", endRow);
//    		mav.addObject("count", count);
//    		mav.addObject("pageSize", pageSize);
//    		mav.addObject("number", number);
//    		mav.addObject("pageGroupSize", pageGroupSize);
//    		mav.addObject("numPageGroup", numPageGroup);
//    		mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/cmmt_list_excel_down.do")
//    protected ModelAndView excel_down(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//        ModelAndView mav = new ModelAndView("commentary/cmmt_excel_down");
//        
//        if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//        
//        CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		
//		try{
//			cvo.setEndRow(999999);
//			ArrayList<CommentaryVo> list = mapper.cmmt_list(cvo);
//			
//			//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//		    ScpDbAgent agt = new ScpDbAgent();
//		    
//		    String hdPh = ""; 
//		    for(int i=0; i<list.size(); i++) {
//		    	hdPh = agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getHand_phone(), "UTF-8");
//		    	if(!"".equals(hdPh)) {
//		    		list.get(i).setHand_ph3(hdPh.substring(hdPh.lastIndexOf( '-' )+1 ));
//		    	}
//		    	list.get(i).setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getBirth_dt(), "UTF-8") );
//		    }
//			
//			mav.addObject("list", list);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//		return mav;
//    }
//    
//    
//    @RequestMapping("/act_list.do")
//    protected ModelAndView act_list(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/act_list");
//		 
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//		
//		// paging 
//    	int pageSize = 20;
//		int pageGroupSize = 10;
//		String pageNum =req.getParameter("pageNum");
//		
//		if (pageNum == null || pageNum == "") {
//			 pageNum = "1";
//		}
//		
//		int currentPage = Integer.parseInt(pageNum);
//		int startRow = (currentPage - 1) * pageSize;
//		int endRow = currentPage * pageSize;
//		int count = 0;
//		int number=0;
//		int pageGroupCount = 0;
//		int numPageGroup = 0;
//		
//		ArrayList<CommentaryVo> list = null;
//		String srchYm = req.getParameter("srch_ym");
//		String srchSido = req.getParameter("srch_sido");
//		if(!"".equals(srchSido) && srchSido != null) {
//			srchSido = srchSido.substring(1);
//		}
//		String srchGugun = req.getParameter("srch_gugun");
//		String gyn = req.getParameter("gYn");
//		
//		//String gYn = ""; 
//		String sido = ""; 
//		CommonVo mvo = new CommonVo();
//		mvo.setGugun_yn(gyn);
//		
//		System.out.println("srchYm : " + srchYm);
//		System.out.println("srchsido : " + srchSido);
//		System.out.println("srchgugun : " + srchGugun);
//		System.out.println("srchgyn : " + gyn);
//		
//		try{
//			
//			Date d = new Date();
//	    	Calendar cal = Calendar.getInstance();
//	    	cal.setTime(new Date());
//	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//	    	
//	        String now_ym = sdf.format(d);
//	        
//	        if("".equals(srchYm) || srchYm == null ) {
//	        	cvo.setSrch_ym(now_ym);
//	        } 
//			
//			String auth = session.getAttribute("authNo").toString();
////			String cmntor = session.getAttribute("cmntorNo").toString();
//			
//			cvo.setAuth_no(auth);
//			
//			ArrayList<CommonVo> g_list = null;
//			ArrayList<CommonVo> s_list = null;
//			
//			if("2".equals(auth)){
//				sido = session.getAttribute("sidoCd").toString();
//				cvo.setSrch_sido(sido);
//				mvo = cmapper.gugun_check(sido);
//				if("Y".equals(gyn)) {
//					cvo.setSrch_gugun(srchGugun);
//					mvo.setSido_cd(sido);
//					g_list = cmapper.gugun_list(mvo);
//				}
//				cvo.setSrch_area(mvo.getGugun_yn());
//				cvo.setSido_cd_nm(session.getAttribute("sidoCdNm").toString());
//			}
//			else if ("3".equals(auth)) {
//				sido = session.getAttribute("sidoCd").toString();
//				cvo.setSrch_sido(sido);
//				cvo.setSrch_gugun(session.getAttribute("gugunCd").toString());
//				cvo.setSrch_area("Y");
//			} else if ("1".equals(auth)) {
//				s_list = cmapper.sido_list();
//				if(!"".equals(srchSido) && srchSido != null) {
//					cvo.setSrch_sido(srchSido);
//					mvo = cmapper.gugun_check(srchSido);
//					cvo.setSrch_area(gyn);
//					if("Y".equals(gyn)) cvo.setSrch_gugun(srchGugun);
//				}
//			}
//			
//			count = mapper.act_list_count(cvo);
// 			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				cvo.setStartRow(startRow);
//				cvo.setEndRow(pageSize);
//			
//				list = mapper.act_list(cvo);
// 			}
//			ArrayList<CommonVo> m_list = cmapper.month_list2();
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//    		mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
//			mav.addObject("count", count);
//			mav.addObject("pageSize", pageSize);
//			mav.addObject("number", number);
//			mav.addObject("pageGroupSize", pageGroupSize);
//			mav.addObject("numPageGroup", numPageGroup);
//			mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("m_list", m_list);
//    		mav.addObject("s_list", s_list);
//    		mav.addObject("g_list", g_list);
//    		    
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	return mav;
//	}
//    
//    @RequestMapping("/act_save.do")
//    protected ModelAndView act_save(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("commentary/act_list");
//    	
//    	CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//    		resp.sendRedirect("login.do");
//    	}
//    	
//    	// paging 
//    	int pageSize = 20;
//    	int pageGroupSize = 10;
//    	String pageNum =req.getParameter("pageNum");
//    	
//    	if (pageNum == null || pageNum == "") {
//    		pageNum = "1";
//    	}
//    	
//    	int currentPage = Integer.parseInt(pageNum);
//    	int startRow = (currentPage - 1) * pageSize;
//    	int endRow = currentPage * pageSize;
//    	int count = 0;
//    	int number=0;
//    	int pageGroupCount = 0;
//    	int numPageGroup = 0;
//    	
//    	ArrayList<CommentaryVo> list = null;
//		String srchYm = req.getParameter("srch_ym");
//		String sido = req.getParameter("act_sido");
//		String cNo = req.getParameter("cmntor_no");
//		String gugun = req.getParameter("act_gugun");
//		String gyn = req.getParameter("act_gyn");
//		
//		System.out.println("gYn : " + gyn);
//		System.out.println("sido : " + sido);
//		
//		cvo.setSrch_area(gyn);
//		cvo.setSrch_sido(sido);
//		cvo.setSrch_gugun(gugun);
//		
//		try{
//			cvo.setId(session.getAttribute("UserId").toString());
//			int cnt = mapper.act_save_check(srchYm,cNo);
//			if ((cnt+"").equals("0") || cnt == 0) {
//				mapper.act_tot_insert(cvo);
//			} else {
//				mapper.act_tot_update(cvo);
//			}
//			
//			String auth = session.getAttribute("authNo").toString();
//			
//			cvo.setAuth_no(auth);
//			
//			ArrayList<CommonVo> g_list = null;
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			
//			count = mapper.act_list_count(cvo);
// 			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				cvo.setStartRow(startRow);
//				cvo.setEndRow(pageSize);
//			
//				list = mapper.act_list(cvo);
// 			}
//			ArrayList<CommonVo> m_list = cmapper.month_list2();
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//    		mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
//			mav.addObject("count", count);
//			mav.addObject("pageSize", pageSize);
//			mav.addObject("number", number);
//			mav.addObject("pageGroupSize", pageGroupSize);
//			mav.addObject("numPageGroup", numPageGroup);
//			mav.addObject("pageGroupCount", pageGroupCount);
//    		
//    		mav.addObject("list", list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("m_list", m_list);
//    		mav.addObject("s_list", s_list);
//    		mav.addObject("g_list", g_list);
//    		
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	return mav;
//    }
//    
//    
//    private String makePassword(int length) {
//		char[] charaters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'};
//		StringBuilder sb = new StringBuilder("");
//		Random rn = new Random();
//		for( int i = 0 ; i < length ; i++ ){
//		    sb.append( charaters[ rn.nextInt( charaters.length ) ] );
//		}
//		return sb.toString();
//	}
//  /*  
//    @RequestMapping("/cmmt_all_update.do")
//    protected ModelAndView cmmt_all_update(CommentaryVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("commentary/cmmt_list");
//		 
//		CommentaryMapper mapper = sqlSession.getMapper(CommentaryMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//		
//		// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		if (pageNum == null || pageNum == "") {
//			 pageNum = "1";
//		}
//		
//		int currentPage = Integer.parseInt(pageNum);
//		int startRow = (currentPage - 1) * pageSize;
//		int endRow = currentPage * pageSize;
//		int count = 0;
//		int number=0;
//		int pageGroupCount = 0;
//		int numPageGroup = 0;
//		
//		ArrayList<CommentaryVo> list = null;
//		ArrayList<CommentaryVo> list2 = mapper.cmmt_all_list();
//		
//		try{
//			String auth = session.getAttribute("authNo").toString();
//			String sido = session.getAttribute("sidoCd").toString();
//			String cmntor = session.getAttribute("cmntorNo").toString();
//			
//			cvo.setAuth_no(auth);
//			
//			if(!"1".equals(auth)){
//				cvo.setSrch_sido(sido);
//				cvo.setCmntor_no(cmntor);
//			}
//			
//			//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
//			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
//		    ScpDbAgent agt = new ScpDbAgent();
//		    
//		    CommentaryVo upCVo = new CommentaryVo();
//			
//			for(int a=0; a<list2.size(); a++) {
//				upCVo.setCmntor_no(list2.get(a).getCmntor_no());
//				upCVo.setHome_addr1(agt.ScpEncStr( iniFilePath, "KEY1", list2.get(a).getHome_addr1(), "UTF-8"));
//				upCVo.setHome_addr2(agt.ScpEncStr( iniFilePath, "KEY1", list2.get(a).getHome_addr2(), "UTF-8"));
//				upCVo.setHome_phone(agt.ScpEncStr( iniFilePath, "KEY1", list2.get(a).getHome_phone(), "UTF-8"));
//				upCVo.setHand_phone(agt.ScpEncStr( iniFilePath, "KEY1", list2.get(a).getHand_phone(), "UTF-8"));
//				upCVo.setBirth_dt(agt.ScpEncStr( iniFilePath, "KEY1", list2.get(a).getBirth_dt(), "UTF-8"));
//				upCVo.setEmail(agt.ScpEncStr( iniFilePath, "KEY1", list2.get(a).getEmail(), "UTF-8"));
//				
//		    	mapper.cmmt_all_update(upCVo);
//			}
//			 
// 			count = mapper.cmmt_list_count(cvo);
// 			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				cvo.setStartRow(startRow);
//				cvo.setEndRow(pageSize);
//				list = mapper.cmmt_list(cvo);
//			    
//			    String hdPh = ""; 
//			    for(int i=0; i<list.size(); i++) {
//			    	hdPh = agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getHand_phone(), "UTF-8");
//			    	list.get(i).setHand_ph3(hdPh.substring(hdPh.lastIndexOf( '-' )+1 ));
//			    }
//			
//			} else {
//				list = null;
//			}
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			ArrayList<CommonVo> sido_list = cmapper.sido_list();
//    		
//			mav.addObject("count", count);
//    		mav.addObject("list", list);
//    		mav.addObject("srch", cvo);
//    		mav.addObject("s_list", sido_list);
//    		    		 
//    		mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
//			mav.addObject("count", count);
//			mav.addObject("pageSize", pageSize);
//			mav.addObject("number", number);
//			mav.addObject("pageGroupSize", pageGroupSize);
//			mav.addObject("numPageGroup", numPageGroup);
//			mav.addObject("pageGroupCount", pageGroupCount);
//		}
//		catch(Exception e) {
//	        e.printStackTrace();
//	    }
//    	return mav;
//	}
//*/
//}
