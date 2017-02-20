//package com.sweetk.kcti.login.controller;
//
//import java.io.PrintWriter;
//import java.util.ArrayList;
//import java.util.Enumeration;
//import java.util.Random;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.ibatis.session.SqlSession;
//import org.apache.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.transaction.PlatformTransactionManager;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.sweetk.kcti.board.mapper.BoardMapper;
//import com.sweetk.kcti.board.vo.BoardVo;
//import com.sweetk.kcti.common.mapper.CommonMapper;
//import com.sweetk.kcti.common.utils.SendEmail;
//import com.sweetk.kcti.common.vo.CommonVo;
//import com.sweetk.kcti.login.mapper.LoginMapper;
//import com.sweetk.kcti.login.vo.LoginVo;
//import com.sweetk.kcti.login.controller.LoginController;
//
//@Controller
//public class LoginController {
//	
//	Logger log = Logger.getLogger(LoginController.class);
//	
//	@Autowired
//    private SqlSession sqlSession;
//    
//    @Autowired 
//    private PlatformTransactionManager transactionManager;
//    
//    @RequestMapping("/")
//    protected ModelAndView login() {
//    	ModelAndView mav = new ModelAndView("login");
//    	
//    	BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	
//    	BoardVo bvo = new BoardVo();
//    	
//    	bvo.setStartRow(0);
//    	bvo.setEndRow(3);
//    	ArrayList<BoardVo> b_list = mapper.board_list(bvo);
//    	ArrayList<CommonVo> sido_list = cmapper.sido_list();
//    	
//    	mav.addObject("b_list", b_list);
//    	mav.addObject("s_list", sido_list);
//    	
//    	return mav;
//    }
//	
//    @RequestMapping("/login.do")
//	protected ModelAndView login_do() {
//		ModelAndView mav = new ModelAndView("login");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		BoardVo bvo = new BoardVo();
//        
//        bvo.setStartRow(0);
//		bvo.setEndRow(3);
//		ArrayList<BoardVo> b_list = mapper.board_list(bvo);
//		ArrayList<CommonVo> sido_list = cmapper.sido_list();
//
//        mav.addObject("b_list", b_list);
//        mav.addObject("s_list", sido_list);
//        
//		return mav;
//	}
//	
//	@RequestMapping("/logout.do")
//	protected ModelAndView logout(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
//		
//		ModelAndView mav = new ModelAndView("login");
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		
//		try{
//			session.setAttribute("UserId", null);
//			session.setAttribute("UserEmail", null);
//			session.setAttribute("UserPhone", null);
//			session.setAttribute("UserNm", null);
//			session.setAttribute("authNo", null);
//			
//			BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//			
//			BoardVo bvo = new BoardVo();
//	        
//	        bvo.setStartRow(0);
//			bvo.setEndRow(3);
//			ArrayList<BoardVo> b_list = mapper.board_list(bvo);
//			ArrayList<CommonVo> sido_list = cmapper.sido_list();
//
//	        mav.addObject("b_list", b_list);
//	        mav.addObject("s_list", sido_list);
//			
//		} catch(Exception e){
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//    
//    
//    @RequestMapping("/login_check.do")
//	protected ModelAndView login_process(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
//		ModelAndView mav = new ModelAndView("login");
//		
//		LoginMapper mapper = sqlSession.getMapper(LoginMapper.class);
//		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//		LoginVo lvo = new LoginVo();
//		CommonVo cvo = new CommonVo();
//		
//		try{
//			String id = req.getParameter("ID");
//			String pw = req.getParameter("PW");
//			String prt = req.getParameter("login_prt");
//			String sido = req.getParameter("srch_sido");
//			String gugun = req.getParameter("srch_gugun");
//			
//			System.out.println("nm : " + lvo.getNm());
//			
//			lvo.setId(id);
//			lvo.setPw(pw);
//			lvo.setNm(prt);
//			lvo.setSido_cd(sido);
//			lvo.setGugun_cd(gugun);
//			
//			String u_id = "";
//			
//			u_id = mapper.login_check(lvo);
//			
//			if ( u_id != null ){
//				
//				lvo.setId(u_id);
//				
//				mapper.groupConcatMaxLenSet(0);
//				lvo = mapper.user_info(lvo);
//				
//				if(lvo != null) {
//					session.setAttribute("UserId", lvo.getId());
//					session.setAttribute("UserEmail", lvo.getEmail());
//					session.setAttribute("UserPhone", lvo.getPhone());
//					session.setAttribute("UserNm", lvo.getNm());
//					session.setAttribute("topMenu", lvo.getTop_menu());
//					session.setAttribute("leftMenu", lvo.getLeft_menu());
//					session.setAttribute("authNo", lvo.getAuth_no());
//					session.setAttribute("sidoCd", lvo.getSido_cd());
//					session.setAttribute("sidoCdNm", lvo.getSido_cd_nm());
//					session.setAttribute("gugunCd", lvo.getGugun_cd());
//					session.setAttribute("gugunCdNm", lvo.getGugun_cd_nm());
//					session.setAttribute("cmntorNo", lvo.getCmntor_no());
//					session.setAttribute("prflImg", lvo.getPrfl_img());
//					session.setAttribute("chkYn", lvo.getMain_chk_yn());
//					
//					cvo.setId(lvo.getId());
//					cvo.setAct_prt_cd("11");   // 로그인
//					cvo.setIp_info(req.getRemoteAddr());
//					cmapper.user_act_insert(cvo);
//				}
//				
//				System.out.println("chk : " +lvo.getMain_chk_yn());
//				
//				if("N".equals(lvo.getMain_chk_yn()) ) {
//					resp.sendRedirect("main_info.do?fst=Y");
//				} else {
//				//resp.sendRedirect("cmmt_list.do");
//					resp.sendRedirect("main.do");
//				}
//			}
//			else {
//				BoardMapper bmapper = sqlSession.getMapper(BoardMapper.class);
//				
//				BoardVo bvo = new BoardVo();
//		        
//		        bvo.setStartRow(0);
//				bvo.setEndRow(3);
//				ArrayList<BoardVo> b_list = bmapper.board_list(bvo);
//				ArrayList<CommonVo> sido_list = cmapper.sido_list();
//
//		        mav.addObject("b_list", b_list);
//		        mav.addObject("s_list", sido_list);
//		        mav.addObject("msg", "아이디 또는 비밀번호가 틀렸습니다.");
//			}
//			
//			Enumeration se = session.getAttributeNames();
//			 
//			  while(se.hasMoreElements()){
//			   String getse = se.nextElement()+"";
//			   System.out.println("@@@@@@@ session : "+getse+" : "+session.getAttribute(getse));
//			  }
//			
//		}
//		catch(Exception e){
//			e.printStackTrace();
//		}
//		
//		return mav;
//	}
//    
//    @RequestMapping("/main_info.do")
//	protected ModelAndView main_info(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
//		ModelAndView mav = new ModelAndView("main/main_info");
//		
//		String fst = req.getParameter("fst");
//		if(!"Y".equals(fst) ) fst = "N";
//		
//		mav.addObject("fstYn", fst);
//		
//		return mav;
//	}
//    
//    @RequestMapping("/non_login_user.do")
//    protected ModelAndView non_login_user(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
//    	ModelAndView mav = new ModelAndView("login");
//    	
//    	LoginMapper mapper = sqlSession.getMapper(LoginMapper.class);
//    	CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
//    	LoginVo lvo = new LoginVo();
//    	CommonVo cvo = new CommonVo();
//    	
//    	String prt = req.getParameter("prt");
//    	String seq = req.getParameter("b_seq");
//    	
//    	try{
//    			
//    		lvo.setId("test@kcti.re.kr");
//    		
//    		mapper.groupConcatMaxLenSet(0);
//    		lvo = mapper.user_info(lvo);
//    			
//			session.setAttribute("UserId", lvo.getId());
//			session.setAttribute("UserEmail", lvo.getEmail());
//			session.setAttribute("UserPhone", lvo.getPhone());
//			session.setAttribute("UserNm", lvo.getNm());
//			session.setAttribute("topMenu", lvo.getTop_menu());
//			session.setAttribute("leftMenu", lvo.getLeft_menu());
//			session.setAttribute("authNo", lvo.getAuth_no());
//			session.setAttribute("sidoCd", "00");
//			
//			cvo.setId(lvo.getId());
//			cvo.setAct_prt_cd("11");   // 로그인
//			cvo.setIp_info(req.getRemoteAddr());
//			cmapper.user_act_insert(cvo);
//			
//			if("1".equals(prt)) {
//				if(!"".equals(seq) && seq != null) {
//					resp.sendRedirect("board_info.do?b_seq="+seq);
//				} else {
//				resp.sendRedirect("board_list.do");
//				}
//			} else if("2".equals(prt)) {
//				resp.sendRedirect("qna_list.do");
//			} else if("3".equals(prt)) {
//				resp.sendRedirect("faq_list.do");
//			} else if("4".equals(prt)) {
//				resp.sendRedirect("main_info.do");
//			}
//    		
//    		Enumeration se = session.getAttributeNames();
//    		
//    		while(se.hasMoreElements()){
//    			String getse = se.nextElement()+"";
//    			System.out.println("@@@@@@@ session : "+getse+" : "+session.getAttribute(getse));
//    		}
//    		
//    	}
//    	catch(Exception e){
//    		e.printStackTrace();
//    	}
//    	
//    	return mav;
//    }
//    
//    @RequestMapping("/find_pass.do")
//	protected ModelAndView find_pass() {
//		ModelAndView mav = new ModelAndView("find_pass");
//		
//		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
//		
//		BoardVo bvo = new BoardVo();
//        
//        bvo.setStartRow(0);
//		bvo.setEndRow(3);
//		ArrayList<BoardVo> b_list = mapper.board_list(bvo);
//
//        mav.addObject("b_list", b_list);
//        
//		return mav;
//	}
//    
//    @RequestMapping("/new_pass.do")
//    protected void new_pass(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//    	
//    	LoginMapper mapper = sqlSession.getMapper(LoginMapper.class);
//    	
//    	response.setContentType("text/xml; charset=utf-8");
//        PrintWriter out = null;
//        out = new PrintWriter(response.getWriter()); 
//        
//        String id = (String)req.getParameter("ID");
//        String em = (String)req.getParameter("email");
//        
//        LoginVo lvo = new LoginVo();
//        lvo.setId(id);
//        lvo.setEmail(em);
//        int cnt = mapper.find_user(lvo);
//        
//        String str = "";
//        
//        if(cnt > 0 ) {
//        	String pw = null;
//        	pw = makePassword(8);
//        	lvo.setPw(pw);
//        	
//        	mapper.user_pass_update(lvo);
//        	
//        	SendEmail SendEmail = new SendEmail();
//        	
//        	String content = "<div style=\"padding: 15px 0px 15px 0px;text-align:center;background:#4b5b9d;color:#FFF\"><img src=\"http://ctgs.kr/image/kcti_logo.png\">";
//        	content = content +"<div style=\"padding: 15px 0px 0px;\">안녕하십니까</div><div style=\"padding: 15px 0px 0px;\"><strong>문화관광해설사 관리 페이지</strong>입니다.</div>";
//        	content = content +"<div style=\"padding: 15px 0px 0px;\">요청하신 비밀번호는 <em>"+pw+"</em>입니다.</div>";
//        	content = content +"<div style=\"padding: 15px 0px 0px;\"><a href=\"http://www.ctgs.kr\" target=\"_blank\" style=\"color:#fff\">www.ctgs.kr</a> 로 접속하셔서 <strong>비밀번호 변경 후</strong> 이용하여 주시길 바랍니다.</div>";
//        	content = content +"<div style=\"padding: 15px 0px 0px;\">감사합니다.</div>";
//        	content = content +"<div style=\"padding: 45px 0px 0px;\"><p>본 메일은 발신 전용 메일입니다.</p><p>문의 및 요청 사항은 <strong>ctgs@kcti.re.kr</strong>로 연락주시면 됩니다.</p></div></div>";
//        	
////        	SendEmail.Email("ctgs@hanmail.net", em, "한국문화관광해설사 비밀번호 정보입니다", "임시비밀번호는 "+pw+" 입니다. 로그인 후 비밀번호를 변경하시기 바랍니다.");
//        	SendEmail.Email("ctgs@hanmail.net", em, "한국문화관광해설사 비밀번호 정보입니다", content);
////        	SendEmail.Email("ctgs@kcti.re.kr", em, "한국문화관광해설사 비밀번호 정보입니다 ["+em+"]", content);
//        	str = "임시 비밀번호를 메일로 발송하였습니다.";
//        } else {
//        	str = "입력하신 아이디와 이메일이 등록된 정보와 일치하지 않습니다. 다시 확인하시고 입력해주세요.";
//        }
//    	out.print(str);
//		out.flush();
//		out.close();
//    	
//    }
//    
//    @RequestMapping("/main_check.do")
//    protected void main_check(HttpServletRequest req, HttpSession session, HttpServletResponse response) throws Exception {
//    	
//    	LoginMapper mapper = sqlSession.getMapper(LoginMapper.class);
//    	
//    	response.setContentType("text/xml; charset=utf-8");
//    	PrintWriter out = null;
//    	out = new PrintWriter(response.getWriter()); 
//    	
//    	String id = session.getAttribute("UserId").toString();
//    	mapper.main_check(id);
//    	
//    	String str = "";
//    	
//    	out.print(str);
//    	out.flush();
//    	out.close();
//    }
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
//
//}
