//package com.sweetk.kcti.common.controller;
//
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileNotFoundException;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.Enumeration;
//import java.util.Iterator;
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.ibatis.session.SqlSession;
//import org.apache.log4j.Logger;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.Row;
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
//import com.sweetk.kcti.board.mapper.BoardMapper;
//import com.sweetk.kcti.board.vo.BoardVo;
//import com.sweetk.kcti.common.vo.CommonVo;
//import com.sweetk.kcti.common.mapper.CommonMapper;
//import com.sweetk.kcti.common.utils.SendEmail;
//
//
//@Controller
//public class CommonController {
//	   Logger log = Logger.getLogger(CommonController.class);
//	    
//	    @Autowired
//	    private SqlSession sqlSession;
//	    
//	    @Autowired 
//	    private PlatformTransactionManager transactionManager;
//
//	    @RequestMapping(value = "/index.do")
//	    public ModelAndView index(HttpServletRequest request) {
//	    	ModelAndView mav = new ModelAndView("main/main");
//
//	        /*if (!SessionUtil.isLogin(request)) {
//	            mav.setViewName("/main/login");
//	            return mav;
//	        }
//	        Boolean Ckeck_bool = CkeckUpdatePnttm(request);
//	        mav.addObject("CkeckUpdatePnttm", Ckeck_bool);*/
//	        return mav;
//	    }
//	    
//	    @RequestMapping("/main.do")
//	    public ModelAndView main(CommonVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) {
//	    	ModelAndView mav = new ModelAndView("main");
//	    	
//	    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//	    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//	    	
//	    	String str = req.getParameter("srch_str_ym");
//	    	String end = req.getParameter("srch_end_ym");
//	    	String prt = req.getParameter("srch_dt_prt");
//	    	
//	    	try {
//		    	CommonVo info = new CommonVo();
//
//		    	Date d = new Date();
//		    	Calendar cal = Calendar.getInstance();
//		    	cal.setTime(new Date());
//		    	cal.add(Calendar.MONTH, -1);
//		    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//		    	
//		        String now_ym = sdf.format(d);
//		        String mon_ym = sdf.format(cal.getTime());
//		        
//		        if("".equals(str) || str == null ) {
//		        	cvo.setSrch_str_ym(mon_ym);
//		        	cvo.setSrch_end_ym(now_ym);
//		        } 
//		        if("".equals(prt) || prt == null ) {
//		        	cvo.setSrch_dt_prt("1");
//		        } 
//		        info = cmapper.main_cnt_info(cvo);
//		        
//		        ArrayList<CommonVo> u_list = cmapper.cmmt_update_info(cvo);
//		        ArrayList<CommonVo> l_list = cmapper.login_info(cvo);
//		        
//		        BoardVo bvo = new BoardVo();
//		        
//		        bvo.setStartRow(0);
//				bvo.setEndRow(6);
//				ArrayList<BoardVo> b_list = mapper.board_list(bvo);
//				ArrayList<BoardVo> q_list = mapper.qna_list(bvo);
//				
//				ArrayList<CommonVo> y_list = cmapper.yyyy_list();
//				ArrayList<CommonVo> m_list = cmapper.month_list2();
//	
//		        mav.addObject("u_list", u_list);
//		        mav.addObject("l_list", l_list);
//		        mav.addObject("b_list", b_list);
//		        mav.addObject("q_list", q_list);
//		        mav.addObject("m_list", m_list);
//		        mav.addObject("info", info);
//		        mav.addObject("srch", cvo);
//		        mav.addObject("y_list", y_list);
//		    }
//	    	catch(Exception e) {
//	    		e.printStackTrace();
//	    	}
//	    	
//	    	return mav;
//	    }
//	    
//	    @RequestMapping("/srch_gugun.do")
//	    protected void srch_gugun(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//	    	
//	    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//	    	
//	    	response.setContentType("text/xml; charset=utf-8");
//	        PrintWriter out = null;
//	        out = new PrintWriter(response.getWriter()); 
//	        
//	        String sidoCode = (String)req.getParameter("s_sido");
//	        
//	        CommonVo cvo = new CommonVo();
//	        cvo.setSido_cd(sidoCode);
//	    	
//	    	ArrayList<CommonVo> g_list = cmapper.gugun_list(cvo);
//	    	
//	    	String str = "";
//	    	for(int i = 0; i<g_list.size() ; i++) {
//	    		if(i>0) str+="|";
//	    		str+=g_list.get(i).getGugun_cd()+","+g_list.get(i).getGugun_cd_nm();
//	    	}
//			out.print(str);
//			out.flush();
//			out.close();
//	    	
//	    }
//	    
//	    @RequestMapping("/dup_check.do")
//	    protected void dup_check(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//	    	
//	    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//	    	
//	    	response.setContentType("text/xml; charset=utf-8");
//	    	PrintWriter out = null;
//	    	out = new PrintWriter(response.getWriter()); 
//	    	
//	    	String yy = (String)req.getParameter("yy");
//	    	String mm = (String)req.getParameter("mm");
//	    	String cNo = (String)req.getParameter("c_no");
//	    	
//	    	int a = cmapper.dup_check(cNo, yy+"-"+mm);
//	    	
//	    	out.print(a);
//	    	out.flush();
//	    	out.close();
//	    }
//	    
//	    @RequestMapping("/dup_check2.do")
//	    protected void dup_check2(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//	    	
//	    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//	    	
//	    	response.setContentType("text/xml; charset=utf-8");
//	    	PrintWriter out = null;
//	    	out = new PrintWriter(response.getWriter()); 
//	    	
//	    	String yy = (String)req.getParameter("yy");
//	    	String mm = (String)req.getParameter("mm");
//	    	String cNo = (String)req.getParameter("c_no");
//	    	
//	    	int a = cmapper.dup_check2(cNo, yy+"-"+mm);
//	    	
//	    	out.print(a);
//	    	out.flush();
//	    	out.close();
//	    }
//	    
//	    @RequestMapping("/uri_save.do")
//	    protected void uri_save(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//	    	
//	    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//
//	    	response.setContentType("text/xml; charset=utf-8");
//	        PrintWriter out = null;
//	        out = new PrintWriter(response.getWriter()); 
//	    	
//    		String uri = (String)req.getParameter("uri");
//    		String id = session.getAttribute("UserId").toString();
//    		
//    		if(session.getAttribute("UserId").toString() != null) {
//	    		CommonVo cvo = new CommonVo();
//	    		cvo.setAct_prt_cd("12");  // 사이트접속
//	    		cvo.setIp_info(uri);
//	    		cvo.setId(session.getAttribute("UserId").toString());
//	    		cmapper.user_act_insert(cvo);
//    		}
//    		
//    		String str = "";
//    		out.print("");
//			out.flush();
//			out.close();
//	    }
//	    
//	    
//	    @RequestMapping("/reservation.do")
//	    public ModelAndView reservation(HttpServletRequest req, HttpSession session, HttpServletResponse response) {
//	    	ModelAndView mav = new ModelAndView("common/reservation");
//	    	
//	    	try {
//		    }
//	    	catch(Exception e) {
//	    		e.printStackTrace();
//	    	}
//	    	
//	    	return mav;
//	    }
//	    
//	    @RequestMapping("/spider.do")
//	    public ModelAndView spider(CommonVo cvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) {
//	    	ModelAndView mav = new ModelAndView("home");
//	    	
//	    	try {
//		    }
//	    	catch(Exception e) {
//	    		e.printStackTrace();
//	    	}
//	    	
//	    	return mav;
//	    }
//	    
//	    @RequestMapping("/mail_test.do")
//	    protected void mail_test(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//	    	
//	    	response.setContentType("text/xml; charset=utf-8");
//	    	PrintWriter out = null;
//	    	out = new PrintWriter(response.getWriter()); 
//	    	
//	    	SendEmail SendEmail = new SendEmail();
//	    	String content = "<div class=\"_wcpushTag\" id=\"pushTag_82a073a72331565\" style=\"padding: 0px;\"><img src=\"http://ctgs.kr/image/login_m.png\">";
//	    	content = content +"안녕하십니까</div><div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\"><strong>문화관광해설사 관리 페이지</strong>입니다.</div><div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\">요청하신 비밀번호는 <em>abcdef </em>입니다.</div>";
//	    	content = content +"<div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\"><a href=\"http://www.ctgs.kr\">www.ctgs.kr</a> 로 접속하셔서 <strong>비밀번호 변경 후</strong> 이용하여 주시길 바랍니다.</div>";
//	    	content = content +"<div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\">감사합니다.</div><div align=\"center\" class=\"_wcSign\" style=\"background: rgb(222, 222, 222); padding: 15px 0px 0px;\"><img src=\"http://ctgs.kr/image/login_logo_mcst.png\"></div>";
//	    	SendEmail.Email("ctgs@hanmail.net", "photojini@empal.com", "한국문화관광해설사 테스트 이메일 입니다", content);
//	    	
//	    	out.print("");
//	    	out.flush();
//	    	out.close();
//	    	
//	    }
//	    
//	    @RequestMapping("/excel_save.do")
//	    protected ModelAndView excel_save(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//	    	
//	    	ModelAndView mav = new ModelAndView("home");
//	    	
//	    	CommonMapper mapper = sqlSession.getMapper(CommonMapper.class);
//	    	
//	    	/*resp.setContentType("text/xml; charset=utf-8");
//	    	PrintWriter out = null;
//	    	out = new PrintWriter(resp.getWriter()); */
//	    	
//	    	String savePath = req.getRealPath("/files/"); 
//			int sizeLimit = 5 * 1024 * 1024 / 2; 
//			String encType = "utf-8"; 
//			MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
//	    	
//			Enumeration formNames = multi.getFileNames(); 
//			String formName = (String) formNames.nextElement(); 
//			String fileName = multi.getFilesystemName(formName);
//			String OfileName = multi.getOriginalFileName(formName); 
//	    	
//			if (fileName != null) {
//				File mFile = multi.getFile(formName);
//				long filesize = mFile.length();
//			}
//			
//			int cnt = 0;
//			
//			ArrayList<Map> list = new ArrayList<Map>();
//
//			try {
//			
//				FileInputStream file = new FileInputStream(new File(savePath+"/"+fileName));
//		        XSSFWorkbook workbook = new XSSFWorkbook(file);
//		        XSSFSheet sheet = workbook.getSheetAt(0);
//		        Iterator<Row> rowIterator = sheet.iterator();
//		        rowIterator.next();
//		        
//		        //int rows = sheet.getPhysicalNumberOfRows(); 
//		        
//		        while(rowIterator.hasNext()) {
//		            Row row = rowIterator.next();
//		            Iterator<Cell> cellIterator = row.cellIterator();
//
//		            /*while(cellIterator.hasNext()) {
//		                Cell cell = cellIterator.next();
//		                cell.setCellType(Cell.CELL_TYPE_STRING);
//		                switch(cell.getCellType()) {
//		                    case Cell.CELL_TYPE_BOOLEAN:
//		                        System.out.println("boolean===>>>"+cell.getBooleanCellValue() + "\t");
//		                        break;
//		                    case Cell.CELL_TYPE_NUMERIC:
//		                        break;
//		                    case Cell.CELL_TYPE_STRING:
//                                 break;
//		                }
//		            }*/
//			        	
//		        	if(row != null && row.getCell(0) != null){
//	            
//			            String name = row.getCell(0).getStringCellValue();
//			            String addr = row.getCell(1).getStringCellValue();
//			            
//			            System.out.println("getCellType() : " + row.getCell(2).getCellType());
//			            
//			            String tp  = Integer.toString(row.getCell(2).getCellType());
//			            
//			            Double lat,lon;
//			            if("0".equals(tp)) {
//			            	lat = row.getCell(2).getNumericCellValue();
//			            } else {
//			            	lat = 0.0;
//			            } 
//			            if("0".equals(tp)) {
//			            	lon = row.getCell(3).getNumericCellValue();
//			            } else {
//			            	lon = 0.0;
//			            }
//			            Map m = new Map();
//			            
//			            m.setName(name);
//			            m.setAddr(addr);
//			            m.setLat(lat);
//			            m.setLon(lon);
//			            
////			            mapper.sign_input(name, addr, lat, lon);
//			            list.add(m);
//		        	}
//		        	
//		        	cnt = cnt+1;
//		        }
//		        
//	        file.close();
//	        
//	        System.out.println("cnt + " + cnt);
//	        
//	        mav.addObject("list", list);
//	        
//		    } catch (FileNotFoundException e) {
//		        e.printStackTrace();
//		    } catch (IOException e) {
//		        e.printStackTrace();
//		    }
//	    	
//	    	return mav;
//	    	
//	    }
//	    
//	    public class Map {
//	    	String name;
//	    	String addr;
//	    	Double lat;
//	    	Double lon;
//			public String getName() {
//				return name;
//			}
//			public void setName(String name) {
//				this.name = name;
//			}
//			public String getAddr() {
//				return addr;
//			}
//			public void setAddr(String addr) {
//				this.addr = addr;
//			}
//			public Double getLat() {
//				return lat;
//			}
//			public void setLat(Double lat) {
//				this.lat = lat;
//			}
//			public Double getLon() {
//				return lon;
//			}
//			public void setLon(Double lon) {
//				this.lon = lon;
//			}
//	    }
//	    
//}