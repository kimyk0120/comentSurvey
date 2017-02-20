//package com.sweetk.kcti.board.controller;
//
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.net.URLEncoder;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.Enumeration;
//import java.io.*;
//import java.net.URLEncoder;
//
//import javax.servlet.ServletContext;
//import javax.servlet.ServletOutputStream;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.ibatis.session.SqlSession;
//import org.apache.log4j.Logger;
//import org.aspectj.util.FileUtil;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.transaction.PlatformTransactionManager;
//import org.springframework.util.FileCopyUtils;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.oreilly.servlet.MultipartRequest;
//import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
//import com.sweetk.kcti.board.mapper.BoardMapper;
//import com.sweetk.kcti.board.vo.BoardVo;
//import com.sweetk.kcti.common.mapper.CommonMapper;
//import com.sweetk.kcti.common.utils.SendEmail;
//import com.sweetk.kcti.common.vo.CommonVo;
//
//@Controller
//public class BoardController {
//
//	Logger log = Logger.getLogger(BoardController.class);
//	
//	@Autowired
//    private SqlSession sqlSession;
//    
//    @Autowired 
//    private PlatformTransactionManager transactionManager;
//	
//	@RequestMapping("/board_list.do")
//	protected ModelAndView board_list(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
//    	ModelAndView mav = new ModelAndView("board/board_list");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	// paging 
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
//		String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//		
//		ArrayList<BoardVo> b_list = null;
//		
//		try{
//			
//			count = mapper.board_list_count(bvo);
//			
//			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				bvo.setStartRow(startRow);
//				bvo.setEndRow(pageSize);
//				b_list = mapper.board_list(bvo);
//			}
//			else {
//				b_list = null;
//			}
//			
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("s_list", s_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//    }
//	
//	@RequestMapping("/board_create.do")
//	protected ModelAndView board_create(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/board_create");
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || (!"1".equals(session.getAttribute("authNo").toString()) && !"2".equals(session.getAttribute("authNo").toString()) ) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	try{
//    		ArrayList<CommonVo> s_list = cmapper.sido_list();
//    		
//    		String auth = session.getAttribute("authNo").toString();
//    		String sido = session.getAttribute("sidoCd").toString();
//    		bvo.setAuth_no(auth);
//    		bvo.setUser_sido_cd(sido);
//    		
//    		mav.addObject("s_list", s_list);
//    		mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	
//	/**
//	 * 공지사항 저장
//	 * @param evo
//	 * @param req
//	 * @param session
//	 * @param resp
//	 * @return
//	 */
//	@RequestMapping("/board_save.do")
//	protected ModelAndView board_save(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/board_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		//String dir = "C:/Users/jini/Documents/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Dumin";
//		String strSaveDir = "/files/board/";
//
//		//File de = new File(dir+strSaveDir);
//		//File de = new File(strSaveDir);
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
//		String encType = "UTF-8"; 
//				
//		MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
//		
//		Enumeration formNames = multi.getFileNames(); 
//		
//		try{
//			String sCd = (String)multi.getParameter("sido_cd");
//			String ttl = (String)multi.getParameter("title");
//			String cnt = (String)multi.getParameter("cntn");
//			String yn = (String)multi.getParameter("open_yn");
//			String trCnt = (String)multi.getParameter("file_tr_cnt");
//			String id = session.getAttribute("UserId").toString();
//			
//			bvo.setSido_cd(sCd);
//			bvo.setTitle(ttl);
//			bvo.setCntn(cnt);
//			bvo.setId(id);
//			bvo.setOpen_yn(yn);
//			
//			int a = mapper.board_insert(bvo);
//			
//			/*while(formNames.hasMoreElements()) {
//				String formName = (String) formNames.nextElement(); 
//				String fileName = multi.getFilesystemName(formName);
//				String OfileName = multi.getOriginalFileName(formName);
//				
//				if(fileName != "" && fileName != null) {
//					bvo.setFile_nm(fileName);
//					mapper.board_file_insert(bvo);
//				}
//			}*/
//			
//	    	
//			String fileName = "";
//			String newFile = "";
//			
//			for(int i=0; i < Integer.parseInt(trCnt); i++) {
//			
//				//if(formNames.hasMoreElements()) {
//					//String formName = (String) formNames.nextElement(); 
//					fileName = multi.getFilesystemName("add_file"+(i+1));
//					String OfileName = multi.getOriginalFileName("add_file"+(i+1));
//					
//					System.out.println("fileName : " + fileName);
//					System.out.println("OfileName : " + OfileName);
//					
//					if(!"".equals(fileName) && fileName != null) {
//					
//						newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//						int index = fileName.indexOf(".");
//						String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//						newFile = newFile + filename1;
//			
//						File file=new File(savePath+"/"+fileName); //원본파일부르기
//						file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//						
//						bvo.setFile_nm(newFile);
//						bvo.setOrg_file_nm(fileName);
//						
//						mapper.board_file_insert(bvo);
//					}
//				//}
//			}
//		
//			BoardVo info = new BoardVo();
//			info = mapper.board_info(bvo.getBoard_seq());
//			
//			String cn = info.getCntn();
//			if(cn != null && cn != "") {
// 				info.setCntn(cn.replaceAll("\n", "<br>"));
// 			}
//			
//			ArrayList<BoardVo> f_list = mapper.board_file_list(bvo.getBoard_seq());
//			
//			String userId = session.getAttribute("UserId").toString();
//	    	bvo.setUser_id(userId);
//			
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	
//	@RequestMapping("/board_info.do")
//	protected ModelAndView board_info(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/board_info");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	String b = req.getParameter("b_seq");
//    	String id = session.getAttribute("UserId").toString();
//    	bvo.setUser_id(id);
//    	
//    	try{
//    		BoardVo info = new BoardVo();
//			info = mapper.board_info(Integer.parseInt(b));
//			
//			String cn = info.getCntn();
//			if(cn != null ) {
// 				info.setCntn(cn.replaceAll("\n", "<br>"));
// 			}
//			
//			ArrayList<BoardVo> f_list = mapper.board_file_list(Integer.parseInt(b));
//			
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	@RequestMapping("/file_down.do")
//    protected ModelAndView file_down(HttpServletRequest request, HttpSession session, HttpServletResponse resp) {
//    	
//    	ModelAndView mav = new ModelAndView("fileDownload");
//    	System.out.println("filefile : " + request.getParameter("filePath") + request.getParameter("fileName"));
//        
//        return mav;
//    	
//    }
//	
//	@RequestMapping("/file_download.do")
//    protected void file_download(HttpServletRequest req, HttpSession session, HttpServletResponse response)  throws Exception {
//    	
//        String fileName = (String)req.getParameter("fileName");
//        String orgFileName = (String)req.getParameter("orgFileName");
//        String fPath = (String)req.getParameter("filePath");
//        
//        String saveFolder = "/"+ fPath;
//        
//        // Context에 대한 정보를 알아옴
//        ServletContext context = req.getSession().getServletContext(); // 서블릿에 대한 환경정보를 가져옴
//        
//        // 실제 파일이 저장되어 있는 폴더의 경로
//        String realFolder = context.getRealPath(saveFolder);
//        // 다운받을 파일의 전체 경로를 filePath에 저장
////        String filePath = realFolder + "/" + fileName;
//        String filePath = realFolder + "\\" + fileName;
//        
//        System.out.println("filePath : " +filePath );
//        
//        try{
//        	//out.clear();
//  		    //out = pageContext.pushBody();
//  		  
//  		    File file = new File(filePath);
//  		    byte b[] = new byte[4096];
//  		   
//  		    response.reset();
//  		    response.setContentType("application/octet-stream");
//  		   
//  		    String Encoding = null; 
//  		   
//  		   if(req.getHeader("User-Agent").indexOf("MSIE") == -1) {
//  			   Encoding = URLEncoder.encode(orgFileName,"UTF-8").replaceAll("\\+", "%20");
//  		   } else {
//  		   		Encoding = new String(orgFileName.getBytes("UTF-8"), "8859_1");
//  		   }
//  			response.setHeader("Content-Disposition", "attatchment; filename = " + Encoding);
//  			
//  			FileInputStream is = new FileInputStream(filePath);
//  			ServletOutputStream sos = response.getOutputStream();
//  			
//  			int numRead;
//  			while((numRead = is.read(b,0,b.length)) != -1){
//  				sos.write(b,0,numRead);
//  			}
//  			
//  			sos.flush();
//  			sos.close();
//  			is.close();
//  			} catch(Exception e){
//  				e.printStackTrace();
//  			}
//    }
//	
//	@RequestMapping("/board_edit.do")
//	protected ModelAndView board_edit(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/board_edit");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || session.getAttribute("authNo") == "9" ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	String b = req.getParameter("b_seq");
//    	
//    	try{
//    		BoardVo info = new BoardVo();
//			info = mapper.board_info(Integer.parseInt(b));
//			
//			ArrayList<BoardVo> f_list = mapper.board_file_list(Integer.parseInt(b));
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			
//			String auth = session.getAttribute("authNo").toString();
//			String sido = session.getAttribute("sidoCd").toString();
//			bvo.setAuth_no(auth);
//			bvo.setUser_sido_cd(sido);
//    		
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("s_list", s_list);
//			mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	
//	@RequestMapping("/board_update.do")
//	protected ModelAndView board_update(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/board_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		//String dir = "C:/Users/jini/Documents/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Dumin";
//		String strSaveDir = "/files/board/";
//
//		//File de = new File(dir+strSaveDir);
//		//File de = new File(strSaveDir);
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
//		Enumeration formNames = multi.getFileNames(); 
//		
//		try{
//
//			String sCd = (String)multi.getParameter("sido_cd");
//			String ttl = (String)multi.getParameter("title");
//			String cnt = (String)multi.getParameter("cntn");
//			String b = (String)multi.getParameter("b_seq");
//			String yn = (String)multi.getParameter("open_yn");
//			String trCnt = (String)multi.getParameter("file_tr_cnt");
//			
//			int bSeq = 0;
//			if(!"".equals(b)) bSeq = Integer.parseInt(b);
//			bvo.setBoard_seq(bSeq);
//			
//			String fSeqs = (String)multi.getParameter("del_seq");
//			if(!"".equals(fSeqs) && fSeqs != null) {
//				String[] tmp = fSeqs.split(",");
//			    bvo.setFile_seqs(tmp);
//			    mapper.board_files_delete(bvo);
//			} 
//			
//			String id = session.getAttribute("UserId").toString();
//			
//			bvo.setSido_cd(sCd);
//			bvo.setTitle(ttl);
//			bvo.setCntn(cnt);
//			bvo.setId(id);
//			bvo.setOpen_yn(yn);
//			
//			mapper.board_update(bvo);
//			
//			String fileName = "";
//			String newFile = "";
//			
//			for(int i=0; i < Integer.parseInt(trCnt); i++) {
//			
//				//if(formNames.hasMoreElements()) {
//				
//				fileName = multi.getFilesystemName("add_file"+(i+1));
//				String OfileName = multi.getOriginalFileName("add_file"+(i+1));
//				
//					/*String formName = (String) formNames.nextElement(); 
//					fileName = multi.getFilesystemName(formName);
//					String OfileName = multi.getOriginalFileName(formName);*/
//					
//				if(!"".equals(fileName) && fileName != null) {
//				
//					newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//					int index = fileName.indexOf(".");
//					String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//					newFile = newFile + filename1;
//		
//					File file=new File(savePath+"/"+fileName); //원본파일부르기
//					file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//					
//					bvo.setFile_nm(newFile);
//					bvo.setOrg_file_nm(fileName);
//					
//					mapper.board_file_insert(bvo);
//				}
//				//}
//			}
//		
//			BoardVo info = new BoardVo();
//			info = mapper.board_info(bvo.getBoard_seq());
//			
//			String cn = info.getCntn();
//			if(cn != null && cn != "") {
// 				info.setCntn(cn.replaceAll("\n", "<br>"));
// 			}
//			
//			ArrayList<BoardVo> f_list = mapper.board_file_list(bvo.getBoard_seq());
//			
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	@RequestMapping("/board_delete.do")
//	protected ModelAndView board_delete(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
//    	ModelAndView mav = new ModelAndView("board/board_list");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	// paging 
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
//		String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//		
//		ArrayList<BoardVo> b_list = null;
//		
//		String bSeq = req.getParameter("b_seq");
//		
//		try{
//			bvo.setBoard_seq(Integer.parseInt(bSeq));
//			
//			mapper.board_delete(bvo);
//			
//			count = mapper.board_list_count(bvo);
//			
//			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				bvo.setStartRow(startRow);
//				bvo.setEndRow(pageSize);
//				b_list = mapper.board_list(bvo);
//			}
//			else {
//				b_list = null;
//			}
//			
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("s_list", s_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//    }
//	
//	@RequestMapping("/qna_list.do")
//	protected ModelAndView qna_list(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/qna_list");
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		System.out.println("pageNum : " + pageNum);
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
//		ArrayList<BoardVo> b_list = null;
//		
//		String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//		
//		try{
//			count = mapper.qna_list_count(bvo);
//			
//			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				bvo.setStartRow(startRow);
//				bvo.setEndRow(pageSize);
//				b_list = mapper.qna_list(bvo);
//			}
//			else {
//				b_list = null;
//			}
//			
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("s_list", s_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//	@RequestMapping("/qna_create.do")
//	protected ModelAndView qna_create(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/qna_create");
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ||  session.getAttribute("authNo") == "9") { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	int q = 0;
//    	String qNo = req.getParameter("ori_qna_no");
//    	
//    	String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//    	
//    	try{
//    		ArrayList<CommonVo> s_list = cmapper.sido_list();
//    		BoardVo info = new BoardVo();
//    		
//    		if(!"".equals(qNo) && qNo != null) q = Integer.parseInt(qNo);
//    		info = mapper.qna_info(q);
//    		
//    		mav.addObject("s_list", s_list);
//    		mav.addObject("info", info);
//    		mav.addObject("ori_q_no", q);
//    		mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	
//	/**
//	 * 공지사항 저장
//	 * @param evo
//	 * @param req
//	 * @param session
//	 * @param resp
//	 * @return
//	 */
//	@RequestMapping("/qna_save.do")
//	protected ModelAndView qna_save(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/qna_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		//String dir = "C:/Users/jini/Documents/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Dumin";
//		String strSaveDir = "/files/board/";
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
//		Enumeration formNames = multi.getFileNames(); 
//		
//		try{
//			String sCd = (String)multi.getParameter("sido_cd");
//			String ttl = (String)multi.getParameter("title");
//			String cnt = (String)multi.getParameter("cntn");
//			String oriQ = (String)multi.getParameter("ori_q_no");
//			String trCnt = (String)multi.getParameter("file_tr_cnt");
//			
//			String id = session.getAttribute("UserId").toString();
//			
//			bvo.setSido_cd(sCd);
//			bvo.setTitle(ttl);
//			bvo.setCntn(cnt);
//			bvo.setId(id);
//			int upQ = 0;
//			if(!"0".equals(oriQ) || !"".equals(oriQ) ) {
//				upQ = Integer.parseInt(oriQ);
//				bvo.setUp_qna_seq(upQ);
//			}
//			
//			int a = mapper.qna_insert(bvo);
//			
//			/*while(formNames.hasMoreElements()) {
//				String formName = (String) formNames.nextElement(); 
//				String fileName = multi.getFilesystemName(formName);
//				String OfileName = multi.getOriginalFileName(formName);
//				
//				if(fileName != "" && fileName != null) {
//					bvo.setFile_nm(fileName);
//					mapper.qna_file_insert(bvo);
//				}
//			}*/
//			
//			String fileName = "";
//			String newFile = ""; 
//			
//			for(int i=0; i < Integer.parseInt(trCnt); i++) {
//				
//				fileName = multi.getFilesystemName("add_file"+(i+1));
//				String OfileName = multi.getOriginalFileName("add_file"+(i+1));
//					
//				if(!"".equals(fileName) && fileName != null) {
//				
//					newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//					int index = fileName.indexOf(".");
//					String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//					newFile = newFile + filename1;
//		
//					File file=new File(savePath+"/"+fileName); //원본파일부르기
//					file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//					
//					bvo.setFile_nm(newFile);
//					bvo.setOrg_file_nm(fileName);
//					
//					mapper.qna_file_insert(bvo);
//				}
//				//}
//			}
//		
//			BoardVo info = new BoardVo();
//			info = mapper.qna_info(bvo.getQna_seq());
//			
//			String cn = info.getCntn();
//			if(cn != null && cn != "") {
// 				info.setCntn(cn.replaceAll("\n", "<br>"));
// 			}
//			
//			ArrayList<BoardVo> f_list = mapper.qna_file_list(bvo.getBoard_seq());
//			
//			String userId = session.getAttribute("UserId").toString();
//	    	String auth = session.getAttribute("authNo").toString();
//	    	bvo.setUser_id(userId);
//	    	bvo.setAuth_no(auth);
//			
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	
//	@RequestMapping("/qna_info.do")
//	protected ModelAndView qna_info(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/qna_info");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	String q = req.getParameter("q_seq");
//    	String id = session.getAttribute("UserId").toString();
//    	String auth = session.getAttribute("authNo").toString();
//    	bvo.setUser_id(id);
//    	bvo.setAuth_no(auth);
//    	
//    	try{
//    		BoardVo info = new BoardVo();
//			info = mapper.qna_info(Integer.parseInt(q));
//			
//			String cn = info.getCntn();
//			if(cn != null ) {
// 				info.setCntn(cn.replaceAll("\n", "<br>"));
// 			}
//			
//			ArrayList<BoardVo> f_list = mapper.qna_file_list(Integer.parseInt(q));
//			
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	@RequestMapping("/qna_edit.do")
//	protected ModelAndView qna_edit(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/qna_edit");
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ||  session.getAttribute("authNo") == "9") { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	String q = req.getParameter("q_seq");
//    	
//    	String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//    	
//    	try{
//    		BoardVo info = new BoardVo();
//			info = mapper.qna_info(Integer.parseInt(q));
//			
//			ArrayList<BoardVo> f_list = mapper.qna_file_list(Integer.parseInt(q));
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//    		
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("s_list", s_list);
//			mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	
//	@RequestMapping("/qna_update.do")
//	protected ModelAndView qna_update(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/qna_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		//String dir = "C:/Users/jini/Documents/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Dumin";
//		String strSaveDir = "/files/board/";
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
//		Enumeration formNames = multi.getFileNames(); 
//		
//		try{
//
//			String sCd = (String)multi.getParameter("sido_cd");
//			String ttl = (String)multi.getParameter("title");
//			String cnt = (String)multi.getParameter("cntn");
//			String q = (String)multi.getParameter("q_seq");
//			String trCnt = (String)multi.getParameter("file_tr_cnt");
//			
//			int qSeq = 0;
//			if(!"".equals(q)) qSeq = Integer.parseInt(q);
//			bvo.setQna_seq(qSeq);
//			
//			String fSeqs = (String)multi.getParameter("del_seq");
//			if(!"".equals(fSeqs) && fSeqs != null) {
//				String[] tmp = fSeqs.split(",");
//			    bvo.setFile_seqs(tmp);
//			    mapper.qna_files_delete(bvo);
//			} 
//			
//			String id = session.getAttribute("UserId").toString();
//			
//			bvo.setSido_cd(sCd);
//			bvo.setTitle(ttl);
//			bvo.setCntn(cnt);
//			bvo.setId(id);
//			
//			mapper.qna_update(bvo);
//			
//			String fileName = "";
//			String newFile = ""; 
//			
//			for(int i=0; i < Integer.parseInt(trCnt); i++) {
//				
//				fileName = multi.getFilesystemName("add_file"+(i+1));
//				String OfileName = multi.getOriginalFileName("add_file"+(i+1));
//					
//				if(!"".equals(fileName) && fileName != null) {
//				
//					newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//					int index = fileName.indexOf(".");
//					String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//					newFile = newFile + filename1;
//		
//					File file=new File(savePath+"/"+fileName); //원본파일부르기
//					file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//					
//					bvo.setFile_nm(newFile);
//					bvo.setOrg_file_nm(fileName);
//					
//					mapper.qna_file_insert(bvo);
//				}
//				//}
//			}
//		
//			BoardVo info = new BoardVo();
//			info = mapper.qna_info(bvo.getQna_seq());
//			
//			String cn = info.getCntn();
//			if(cn != null && cn != "") {
// 				info.setCntn(cn.replaceAll("\n", "<br>"));
// 			}
//			
//			ArrayList<BoardVo> f_list = mapper.qna_file_list(bvo.getQna_seq());
//			
//			mav.addObject("info", info);
//			mav.addObject("f_list", f_list);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	@RequestMapping("/qna_delete.do")
//	protected ModelAndView qna_delete(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/qna_list");
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		System.out.println("pageNum : " + pageNum);
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
//		ArrayList<BoardVo> b_list = null;
//		
//		String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//		
//		String qSeq = req.getParameter("q_seq");
//		
//		try{
//			bvo.setQna_seq(Integer.parseInt(qSeq));
//			
//			mapper.qna_delete(bvo);
//			
//			count = mapper.qna_list_count(bvo);
//			
//			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				bvo.setStartRow(startRow);
//				bvo.setEndRow(pageSize);
//				b_list = mapper.qna_list(bvo);
//			}
//			else {
//				b_list = null;
//			}
//			
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("s_list", s_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//	@RequestMapping("/faq_list.do")
//	protected ModelAndView faq_list(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/faq_list");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	// paging 
//    	int pageSize = 10;
//		int pageGroupSize = 5;
//		String pageNum =req.getParameter("pageNum");
//		
//		System.out.println("pageNum : " + pageNum);
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
//		ArrayList<BoardVo> b_list = null;
//		
//		String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//		
//		try{
//			count = mapper.faq_list_count(bvo);
//			
//			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				bvo.setStartRow(startRow);
//				bvo.setEndRow(pageSize);
//				b_list = mapper.faq_list(bvo);
//				
//				for(int i=0; i < b_list.size(); i++) {
//					String an = b_list.get(i).getAnsw();
//					if(an != null && an != "") {
//						b_list.get(i).setAnsw(an.replaceAll("\n", "<br>"));
//					}
//				}
//			}
//			else {
//				b_list = null;
//			}
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//    }
//	
//	@RequestMapping("/faq_create.do")
//	protected ModelAndView faq_create(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/faq_create");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ||  !"1".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//    	
//    	try{
//    		mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	
//	/**
//	 * 공지사항 저장
//	 * @param evo
//	 * @param req
//	 * @param session
//	 * @param resp
//	 * @return
//	 */
//	@RequestMapping("/faq_save.do")
//	protected ModelAndView faq_save(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/faq_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		try{
//			String auth = session.getAttribute("authNo").toString();
//			bvo.setAuth_no(auth);
//			
//			int a = mapper.faq_insert(bvo);
//			
//			BoardVo info = new BoardVo();
//			info = mapper.faq_info(bvo.getFaq_seq());
//			
//			String qs = info.getQstn();
//			if(qs != null && qs != "") {
// 				info.setQstn(qs.replaceAll("\n", "<br>"));
// 			}
//			String an = info.getAnsw();
//			if(an != null && an != "") {
//				info.setAnsw(an.replaceAll("\n", "<br>"));
//			}
//			
//			String userId = session.getAttribute("UserId").toString();
//	    	bvo.setUser_id(userId);
//			
//			mav.addObject("info", info);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	
//	@RequestMapping("/faq_info.do")
//	protected ModelAndView faq_info(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/faq_info");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null  ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	String f = req.getParameter("f_seq");
//    	String id = session.getAttribute("UserId").toString();
//    	String auth = session.getAttribute("authNo").toString();
//    	bvo.setUser_id(id);
//    	bvo.setAuth_no(auth);
//    	
//    	try{
//    		BoardVo info = new BoardVo();
//			info = mapper.faq_info(Integer.parseInt(f));
//			
//			String qs = info.getQstn();
//			if(qs != null && qs != "") {
// 				info.setQstn(qs.replaceAll("\n", "<br>"));
// 			}
//			String an = info.getAnsw();
//			if(an != null && an != "") {
//				info.setAnsw(an.replaceAll("\n", "<br>"));
//			}
//			
//			mav.addObject("info", info);
//			mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	@RequestMapping("/faq_edit.do")
//	protected ModelAndView faq_edit(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/faq_edit");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ||  !"1".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	String f = req.getParameter("f_seq");
//    	
//    	String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//    	
//    	try{
//    		BoardVo info = new BoardVo();
//			info = mapper.faq_info(Integer.parseInt(f));
//			
//			mav.addObject("info", info);
//			mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	
//	@RequestMapping("/faq_update.do")
//	protected ModelAndView faq_update(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/faq_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		try{
//
//			String f = req.getParameter("f_seq");
//			int fSeq = 0;
//			if(!"".equals(f)) fSeq = Integer.parseInt(f);
//			bvo.setFaq_seq(fSeq);
//			
//			String id = session.getAttribute("UserId").toString();
//						
//			mapper.faq_update(bvo);
//					
//			BoardVo info = new BoardVo();
//			info = mapper.faq_info(bvo.getFaq_seq());
//			
//			String qs = info.getQstn();
//			if(qs != null && qs != "") {
// 				info.setQstn(qs.replaceAll("\n", "<br>"));
// 			}
//			String an = info.getAnsw();
//			if(an != null && an != "") {
//				info.setAnsw(an.replaceAll("\n", "<br>"));
//			}
//			
//			mav.addObject("info", info);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	@RequestMapping("/faq_delete.do")
//	protected ModelAndView faq_delete(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/faq_list");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null  || session.getAttribute("authNo") == null ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	// paging 
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
//		ArrayList<BoardVo> b_list = null;
//		
//		String auth = session.getAttribute("authNo").toString();
//		String sido = session.getAttribute("sidoCd").toString();
//		bvo.setAuth_no(auth);
//		bvo.setUser_sido_cd(sido);
//		
//		String fSeq = req.getParameter("f_seq");
//		
//		try{
//			bvo.setFaq_seq(Integer.parseInt(fSeq));
//			mapper.faq_delete(bvo);
//			
//			count = mapper.faq_list_count(bvo);
//			
//			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				bvo.setStartRow(startRow);
//				bvo.setEndRow(pageSize);
//				b_list = mapper.faq_list(bvo);
//				
//				for(int i=0; i < b_list.size(); i++) {
//					String an = b_list.get(i).getAnsw();
//					if(an != null && an != "") {
//						b_list.get(i).setAnsw(an.replaceAll("\n", "<br>"));
//					}
//				}
//			}
//			else {
//				b_list = null;
//			}
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//    }
//	
//	@RequestMapping("/community_list.do")
//	protected ModelAndView community_list(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
//    	ModelAndView mav = null; 
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//    	// paging 
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
//		String auth = session.getAttribute("authNo").toString();
//		
//		if("1".equals(auth)){
//			mav = new ModelAndView("board/community_list");
//		} else {
//			mav = new ModelAndView("board/community_mylist");
//		}
//		
//		bvo.setAuth_no(auth);
//		
//		ArrayList<BoardVo> b_list = null;
//		
//		try{
//			
//			if("1".equals(auth)){
//				count = mapper.comm_list_count(bvo);
//				if (count > 0) {        
//					if(endRow>count) endRow = count;
//					bvo.setStartRow(startRow);
//					bvo.setEndRow(pageSize);
//					b_list = mapper.comm_list(bvo);
//				}
//			} else {
//				String sido = session.getAttribute("sidoCd").toString();
//				bvo.setSido_cd(sido);
//				
//				count = mapper.comm_mylist_count(bvo);
//				
//				if (count > 0) {        
//					if(endRow>count) endRow = count;
//					bvo.setStartRow(startRow);
//					bvo.setEndRow(pageSize);
//					b_list = mapper.comm_mylist(bvo);
//				}
//			}
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//    }
//	
//	@RequestMapping("/community_create.do")
//	protected ModelAndView community_create(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/community_create");
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || !"1".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	try{
//    		ArrayList<CommonVo> s_list = cmapper.sido_list();
//    		
//    		String auth = session.getAttribute("authNo").toString();
//    		
//    		System.out.println("auth : " + auth);
//    		
//    		
//    		bvo.setAuth_no(auth);
//
//    		mav.addObject("s_list", s_list);
//    		mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	/**
//	 * 공지사항 저장
//	 * @param evo
//	 * @param req
//	 * @param session
//	 * @param resp
//	 * @return
//	 */
//	@RequestMapping("/community_save.do")
//	protected ModelAndView community_save(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/community_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		//String dir = "C:/Users/jini/Documents/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Dumin";
//		String strSaveDir = "/files/community/";
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
//		String encType = "UTF-8"; 
//				
//		MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
//		
//		Enumeration formNames = multi.getFileNames(); 
//		
//		try{
//			String ttl = (String)multi.getParameter("title");
//			String cnt = (String)multi.getParameter("contents");
//			
//			String id = session.getAttribute("UserId").toString();
//			
//			bvo.setTitle(ttl);
//			bvo.setCntn(cnt);
//			bvo.setId(id);
//			//int a = mapper.board_insert(bvo);
//			
//			String newFile = "";
//			
//			String fileName = multi.getFilesystemName("ex_filename");
//			String OfileName = multi.getOriginalFileName("ex_filename");
//					
///*			System.out.println("fileName : " + fileName);
//			System.out.println("OfileName : " + OfileName);*/
//			
//			if(!"".equals(fileName) && fileName != null) {
//				newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//				int index = fileName.lastIndexOf(".");
//				String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//				newFile = newFile + filename1;
//	
//				File file=new File(savePath+"/"+fileName); //원본파일부르기
//				file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//				
//				bvo.setFile_nm(newFile);
//				bvo.setOrg_file_nm(fileName);
//			}
//			
//			int a = mapper.comm_save(bvo);
//			
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			
//			String sido = "";
//			
//			String content = "<div style=\"padding: 15px 0px 15px 0px;text-align:center;background:#4b5b9d;color:#FFF\"><img src=\"http://ctgs.kr/image/kcti_logo.png\">";
//	    	content = content +"<div style=\"padding: 15px 0px 0px;\">안녕하십니까</div><div style=\"padding: 15px 0px 0px;\"><strong>문화관광해설사 관리 페이지</strong>입니다.</div>";
//	    	content = content +"<div style=\"padding: 15px 0px 0px;\">새로 등록된 글이 있습니다.</div>";
//	    	content = content +"<div style=\"padding: 15px 0px 0px;\"><a href=\"http://www.ctgs.kr\" target=\"_blank\" style=\"color:#fff\">www.ctgs.kr</a> 로 접속하셔서 새로 등록된 글을 확인하시고 답변 부탁드립니다.</div>";
//	    	content = content +"<div style=\"padding: 15px 0px 0px;\">감사합니다.</div>";
//	    	content = content +"<div style=\"padding: 45px 0px 0px;\"><p>본 메일은 발신 전용 메일입니다.</p><p>문의 및 요청 사항은 <strong>ctgs@kcti.re.kr</strong>로 연락주시면 됩니다.</p></div></div>";
//	    	
//	    	SendEmail SendEmail = new SendEmail();
//	    	String em = "";
//	    	
//			for(int i=0; i < s_list.size(); i++) {
//				sido = (String)multi.getParameter("sido_"+s_list.get(i).getSido_cd());
//				
//				//System.out.println("sido (" + i+") : " + sido);
//				
//				if(sido != null && !"".equals(sido)) {
//					bvo.setSido_cd(sido);
//					mapper.comm_sido_save(bvo);
//					
//					em = mapper.sido_email_info(sido);
//					if(em != null && !"".equals(em)) {
//						SendEmail.Email("ctgs@hanmail.net", em, "한국문화관광해설사 관리시스템에서 알립니다", content);
//					}
//				}
//			}
//			 
//			String titl = (String)multi.getParameter("srch_title");
//			String str = (String)multi.getParameter("srch_str_dt");
//			String end = (String)multi.getParameter("srch_end_dt");
//			String nm = (String)multi.getParameter("srch_nm");
//			
//			bvo.setSrch_title(titl);
//			bvo.setSrch_str_dt(str);
//			bvo.setSrch_end_dt(end);
//			bvo.setSrch_nm(nm);
//			
//			BoardVo info = new BoardVo();
//			
//			info = mapper.comm_info(bvo);
//			 
//			ArrayList<BoardVo> c_list = mapper.comm_ans_list(bvo);
//			
//			String cn ="";
//			for(int i=0; i<c_list.size(); i++) {
//				cn = c_list.get(i).getCntn();
//				if(cn != null ) {
//	 				c_list.get(i).setCntn(cn.replaceAll("\n", "<br>"));
//	 			}
//			}
//			
//			mav.addObject("info", info);
//			mav.addObject("list", c_list);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	@RequestMapping("/community_info.do")
//	protected ModelAndView community_info(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/community_info");
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	String id = session.getAttribute("UserId").toString();
//    	bvo.setUser_id(id);
//    	
//    	try{
//    		//System.out.println("seq : " + bvo.getComm_seq());
//    		BoardVo info = new BoardVo();
//			info = mapper.comm_info(bvo);
//			 
//			ArrayList<BoardVo> c_list = mapper.comm_ans_list(bvo);
//			
//			String cn ="";
//			for(int i=0; i<c_list.size(); i++) {
//				cn = c_list.get(i).getCntn();
//				if(cn != null ) {
//	 				c_list.get(i).setCntn(cn.replaceAll("\n", "<br>"));
//	 			}
//			}
//			
//			mav.addObject("info", info);
//			mav.addObject("list", c_list);
//			mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	@RequestMapping("/community_myinfo.do")
//	protected ModelAndView community_myinfo(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//		ModelAndView mav = new ModelAndView("board/community_myinfo");
//		
//		if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		String id = session.getAttribute("UserId").toString();
//		bvo.setUser_id(id);
//		
//		try {
//			BoardVo info = new BoardVo();
//			info = mapper.comm_info(bvo);
//			
//			BoardVo c_info = mapper.comm_myinfo(bvo);
//			
//			mav.addObject("info", info);
//			mav.addObject("c_info", c_info);
//			mav.addObject("srch", bvo);
//		} 
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	/**
//	 * 공지사항 저장
//	 * @param evo
//	 * @param req
//	 * @param session
//	 * @param resp
//	 * @return
//	 */
//	@RequestMapping("/comm_mysave.do")
//	protected ModelAndView community_mysave(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/community_myinfo");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		String strSaveDir = "/files/community/";
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
//		String encType = "UTF-8"; 
//				
//		MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
//		Enumeration formNames = multi.getFileNames(); 
//		
//		try{
//			String commSeq = (String)multi.getParameter("comm_seq");
//			String sidoCd = (String)multi.getParameter("sido_cd");
//			String cnt = (String)multi.getParameter("cntn");
//			String sYn = (String)multi.getParameter("submit_yn");
//			
//			String id = session.getAttribute("UserId").toString();
//			
//			bvo.setComm_seq(Integer.parseInt(commSeq));
//			bvo.setSido_cd(sidoCd);
//			bvo.setCntn(cnt);
//			bvo.setId(id);
//			bvo.setSubmit_yn(sYn);
//			
//			System.out.println("sYn : " + sYn);
//			
//			String newFile = "";
//			
//			String fileName = multi.getFilesystemName("ex_filename");
////			String OfileName = multi.getOriginalFileName("ex_filename");
//			
//			if(!"".equals(fileName) && fileName != null) {
//				newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//				int index = fileName.lastIndexOf(".");
//				String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//				newFile = newFile + filename1;
//	
//				File file=new File(savePath+"/"+fileName); //원본파일부르기
//				file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//				
//				System.out.println("fileName : " + fileName);
//				
//				bvo.setFile_nm(newFile);
//				bvo.setOrg_file_nm(fileName);
//			}
//			
//			mapper.comm_mysave(bvo);
//			
//			BoardVo info = new BoardVo();
//			info = mapper.comm_info(bvo);
//			
//			BoardVo c_info = mapper.comm_myinfo(bvo);
//			
//			String titl = (String)multi.getParameter("srch_title");
//			String str = (String)multi.getParameter("srch_str_dt");
//			String end = (String)multi.getParameter("srch_end_dt");
//			String nm = (String)multi.getParameter("srch_nm");
//			
//			bvo.setSrch_title(titl);
//			bvo.setSrch_str_dt(str);
//			bvo.setSrch_end_dt(end);
//			bvo.setSrch_nm(nm);
//			
//			mav.addObject("info", info);
//			mav.addObject("c_info", c_info);
//			mav.addObject("srch", bvo);
//			 
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	@RequestMapping("/community_edit.do")
//	protected ModelAndView community_edit(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
//    	ModelAndView mav = new ModelAndView("board/community_edit");
//    	
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || !"1".equals(session.getAttribute("authNo").toString()) ) { 
//			resp.sendRedirect("login.do");
//		}
//    	
//    	try{
//    		ArrayList<CommonVo> s_list = cmapper.sido_list();
//    		ArrayList<BoardVo> list = mapper.comm_ans_list(bvo);
//    		
//    		String auth = session.getAttribute("authNo").toString();
//    		
//    		bvo.setAuth_no(auth);
//    		
//    		BoardVo info = new BoardVo();
//			info = mapper.comm_info(bvo);
//
//    		mav.addObject("list", list);
//    		mav.addObject("s_list", s_list);
//    		mav.addObject("info", info);
//    		mav.addObject("srch", bvo);
//    	}
//    	catch(Exception e) {
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//	}
//	
//	@RequestMapping("/community_update.do")
//	protected ModelAndView community_update(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//		ModelAndView mav = new ModelAndView("board/community_info");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		String strSaveDir = "/files/community/";
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
//		String encType = "UTF-8"; 
//				
//		MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, encType, new DefaultFileRenamePolicy());
//		
//		Enumeration formNames = multi.getFileNames(); 
//		
//		try{
//			String seq = (String)multi.getParameter("comm_seq");
//			String ttl = (String)multi.getParameter("title");
//			String cnt = (String)multi.getParameter("contents");
//			String oldFile = (String)multi.getParameter("old_file_nm");
//			
//			String id = session.getAttribute("UserId").toString();
//			
//			bvo.setComm_seq(Integer.parseInt(seq));
//			bvo.setTitle(ttl);
//			bvo.setCntn(cnt);
//			bvo.setId(id);
//			
//			String newFile = "";
//			
//			String fileName = multi.getFilesystemName("ex_filename");
////			String OfileName = multi.getOriginalFileName("ex_filename");
//			
//			System.out.println("oldFile : " + oldFile);
//			System.out.println("fileName : " + fileName);
//					
//			if(!"".equals(fileName) && fileName != null) {
//				newFile = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
//				int index = fileName.lastIndexOf(".");
//				String filename1 = fileName.substring(index, fileName.length());// .확장자만 남기고 다 삭제
//				newFile = newFile + filename1;
//	
//				File file=new File(savePath+"/"+fileName); //원본파일부르기
//				file.renameTo(new File(savePath+"/"+newFile)); //파일이름변경
//				
//				bvo.setFile_nm(newFile);
//				bvo.setOrg_file_nm(fileName);
//			}
//			
//			mapper.comm_update(bvo);
//			
//			ArrayList<CommonVo> s_list = cmapper.sido_list();
//			String sido = "";
//			mapper.comm_sido_delete(bvo);
//			for(int i=0; i < s_list.size(); i++) {
//				sido = (String)multi.getParameter("sido_"+s_list.get(i).getSido_cd());
//				if(sido != null && !"".equals(sido)) {
//					bvo.setSido_cd(sido);
//					mapper.comm_sido_save(bvo);
//				}
//			}
//			 
//			BoardVo info = new BoardVo();
//			
//			info = mapper.comm_info(bvo);
//			 
//			ArrayList<BoardVo> c_list = mapper.comm_ans_list(bvo);
//			
//			String cn ="";
//			for(int i=0; i<c_list.size(); i++) {
//				cn = c_list.get(i).getCntn();
//				if(cn != null ) {
//	 				c_list.get(i).setCntn(cn.replaceAll("\n", "<br>"));
//	 			}
//			}
//			
//			String titl = (String)multi.getParameter("srch_title");
//			String str = (String)multi.getParameter("srch_str_dt");
//			String end = (String)multi.getParameter("srch_end_dt");
//			String nm = (String)multi.getParameter("srch_nm");
//			
//			bvo.setSrch_title(titl);
//			bvo.setSrch_str_dt(str);
//			bvo.setSrch_end_dt(end);
//			bvo.setSrch_nm(nm);
//			
//			mav.addObject("info", info);
//			mav.addObject("list", c_list);
//			mav.addObject("srch", bvo);
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//	
//	@RequestMapping("/community_close.do")
//	protected ModelAndView community_close(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
//    	ModelAndView mav = new ModelAndView("board/community_list");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//    	// paging 
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
//		String auth = session.getAttribute("authNo").toString();
//		
//		bvo.setAuth_no(auth);
//		
//		ArrayList<BoardVo> b_list = null;
//		
//		try{
//			
//			mapper.comm_close(bvo);
//			
//			count = mapper.comm_list_count(bvo);
//			if (count > 0) {        
//				if(endRow>count) endRow = count;
//				bvo.setStartRow(startRow);
//				bvo.setEndRow(pageSize);
//				b_list = mapper.comm_list(bvo);
//			}
//			
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//    }
//	
//	@RequestMapping("/comm_mail_send.do")
//    protected void comm_mail_send(HttpServletRequest req, HttpSession session, HttpServletResponse response)  throws Exception {
//    	
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//
//    	response.setContentType("text/xml; charset=utf-8");
//        PrintWriter out = null;
//        out = new PrintWriter(response.getWriter()); 
//    	
//        ArrayList<CommonVo> s_list = cmapper.sido_list();
//		
//		String sido = "";
//		
//		String content = "<div style=\"padding: 15px 0px 15px 0px;text-align:center;background:#4b5b9d;color:#FFF\"><img src=\"http://ctgs.kr/image/kcti_logo.png\">";
//    	content = content +"<div style=\"padding: 15px 0px 0px;\">안녕하십니까</div><div style=\"padding: 15px 0px 0px;\"><strong>문화관광해설사 관리 페이지</strong>입니다.</div>";
//    	content = content +"<div style=\"padding: 15px 0px 0px;\">새로 등록된 글이 있습니다.</div>";
//    	content = content +"<div style=\"padding: 15px 0px 0px;\"><a href=\"http://www.ctgs.kr\" target=\"_blank\" style=\"color:#fff\">www.ctgs.kr</a> 로 접속하셔서 새로 등록된 글을 확인하시고 답변 부탁드립니다.</div>";
//    	content = content +"<div style=\"padding: 15px 0px 0px;\">감사합니다.</div>";
//    	content = content +"<div style=\"padding: 45px 0px 0px;\"><p>본 메일은 발신 전용 메일입니다.</p><p>문의 및 요청 사항은 <strong>ctgs@kcti.re.kr</strong>로 연락주시면 됩니다.</p></div></div>";
//    	
//    	SendEmail SendEmail = new SendEmail();
//    	String em = "";
//    	
//		for(int i=0; i < s_list.size(); i++) {
//			sido = req.getParameter("sido_"+s_list.get(i).getSido_cd());
//			
//			if(sido != null && !"".equals(sido)) {
//				em = mapper.sido_email_info(sido);
//				if(em != null && !"".equals(em)) {
//					SendEmail.Email("ctgs@hanmail.net", em, "한국문화관광해설사 관리시스템에서 알립니다", content);
//				}
//			}
//		}
//		
//		out.print("메일 발송되었습니다.");
//		out.flush();
//		out.close();
//  			
//    }
//	
//	@RequestMapping("/community_delete.do")
//	protected ModelAndView community_delete(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
//    	ModelAndView mav =  new ModelAndView("board/community_list");; 
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	
//    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null) { 
//			resp.sendRedirect("login.do");
//		}
//    	// paging 
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
//		String auth = session.getAttribute("authNo").toString();
//		
//		bvo.setAuth_no(auth);
//		
//		ArrayList<BoardVo> b_list = null;
//		
//		String cSeq =req.getParameter("comm_seq");
//		
//		try{
//			mapper.comm_delete(cSeq);
//			mapper.comm_ans_delete(cSeq);
//			
//			if("1".equals(auth)){
//				count = mapper.comm_list_count(bvo);
//				if (count > 0) {        
//					if(endRow>count) endRow = count;
//					bvo.setStartRow(startRow);
//					bvo.setEndRow(pageSize);
//					b_list = mapper.comm_list(bvo);
//				}
//			} else {
//				String sido = session.getAttribute("sidoCd").toString();
//				bvo.setSido_cd(sido);
//				
//				count = mapper.comm_mylist_count(bvo);
//				
//				if (count > 0) {        
//					if(endRow>count) endRow = count;
//					bvo.setStartRow(startRow);
//					bvo.setEndRow(pageSize);
//					b_list = mapper.comm_mylist(bvo);
//				}
//			}
//			
//			number=count-(currentPage-1)*pageSize;
//			pageGroupCount =count/(pageSize*pageGroupSize)+( count %(pageSize*pageGroupSize) == 0 ? 0 : 1);
//			numPageGroup = (int)Math.ceil((double)currentPage/pageGroupSize);
// 			
//			mav.addObject("count", count);
//			mav.addObject("list", b_list);
//			mav.addObject("srch", bvo);
//			
//			mav.addObject("currentPage", currentPage);
//			mav.addObject("startRow", startRow);
//			mav.addObject("endRow", endRow);
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
//    }
//	
//}
