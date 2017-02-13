package com.sweetk.kcti.stats.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.penta.scpdb.ScpDbAgent;
import com.sweetk.kcti.commentary.mapper.CommentaryMapper;
import com.sweetk.kcti.commentary.vo.CommentaryVo;
import com.sweetk.kcti.common.mapper.CommonMapper;
import com.sweetk.kcti.common.vo.CommonVo;
import com.sweetk.kcti.stats.mapper.StatsMapper;
import com.sweetk.kcti.stats.vo.StatsVo;


@Controller
public class StatsController {
	Logger log = Logger.getLogger(StatsController.class);
	
	@Autowired
    private SqlSession sqlSession;
    
    @Autowired 
    private PlatformTransactionManager transactionManager;
	
    @RequestMapping("/cmmt_stats.do")
    protected ModelAndView cmmt_list(StatsVo svo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
		
    	ModelAndView mav = new ModelAndView("stats/cmmt_stats");
    	
    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
			resp.sendRedirect("login.do");
		}
		
		StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
		
		String prt = req.getParameter("srch_dt_prt");
		
		/*if( "2".equals(prt)  ) mav = new ModelAndView("stats/cmmt_stats2");
		else if( "3".equals(prt)  ) mav = new ModelAndView("stats/cmmt_stats3");
		else if( "4".equals(prt)  ) mav = new ModelAndView("stats/cmmt_stats4");
		else mav = new ModelAndView("stats/cmmt_stats");*/
		
		try{
			ArrayList<CommonVo> y_list = cmapper.yyyy_list();
			ArrayList<CommonVo> s_list = cmapper.sido_list();
			
			String yy = req.getParameter("srch_yy");
			String mm = req.getParameter("srch_mm");
			
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			
			String now_ym = "";
			if(!"".equals(yy) && yy != null && !"".equals(mm) && mm != null) {
				now_ym = yy+"-"+mm;
			} else {
				now_ym = sdf.format(d);
			}
			svo.setSrch_ym(now_ym);
			 
			if(!"".equals(prt) && prt != null) {svo.setSrch_dt_prt("1");}
			else {svo.setSrch_dt_prt(prt);}
	         
	        ArrayList<StatsVo> a_list = mapper.stats_cmmt_age(svo);
	        ArrayList<StatsVo> a_list2 = mapper.stats_cmmt_age2(svo);
	        ArrayList<StatsVo> w_list = mapper.stats_cmmt_work(svo);
	        ArrayList<StatsVo> w_list2 = mapper.stats_cmmt_work2(svo);
	        ArrayList<StatsVo> e_list = mapper.stats_cmmt_edu(svo);
			
    		mav.addObject("y_list", y_list);
    		mav.addObject("s_list", s_list);
    		mav.addObject("now_ym", now_ym);
    		mav.addObject("a_list", a_list);
    		mav.addObject("a_list2", a_list2);
    		mav.addObject("w_list", w_list);
    		mav.addObject("w_list2", w_list2);
    		mav.addObject("e_list", e_list);
    		mav.addObject("srch", svo);
    		
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
		
		return mav;
	}
    
    @RequestMapping("/cmmt_area_stats.do")
    protected ModelAndView cmmt_area_stats(StatsVo svo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
		
    	ModelAndView mav = new ModelAndView("stats/cmmt_area_stats");
    	
    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
			resp.sendRedirect("login.do");
		}
		
		StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
		
		String auth = session.getAttribute("authNo").toString();
		String sido = session.getAttribute("sidoCd").toString();
		String gugun = session.getAttribute("gugunCd").toString();
		
		String srchSi = req.getParameter("srch_sido_cd");
		String srchGu = req.getParameter("srch_gugun_cd");
		
		/*String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
	    ScpDbAgent agt = new ScpDbAgent();*/
		 
		try{
			
			if( ("".equals(srchSi) || srchSi == null) && ("".equals(srchGu) || srchGu == null)) {
				svo.setSrch_sido_cd(sido);
				svo.setSrch_gugun_cd(gugun);
			} else {
				svo.setSrch_sido_cd(srchSi);
				svo.setSrch_gugun_cd(srchGu);
			}
		 
			ArrayList<CommonVo> s_list = cmapper.sido_list();
	        ArrayList<StatsVo> a_list = mapper.stats_cmmt_age(svo);
	        ArrayList<StatsVo> a_list2 = mapper.stats_cmmt_age2(svo);
	        
	        /*for(int i=0; i<a_list.size(); i++) {
		    	a_list.get(i).setAges( agt.ScpDecStr( iniFilePath, "KEY1", a_list.get(i).getAges(), "UTF-8") );
		    }
	        for(int i=0; i<a_list2.size(); i++) {
	        	a_list2.get(i).setAges( agt.ScpDecStr( iniFilePath, "KEY1", a_list2.get(i).getAges(), "UTF-8") );
	        }*/
	        
			
    		mav.addObject("s_list", s_list);
    		mav.addObject("a_list", a_list);
    		mav.addObject("a_list2", a_list2);
    		mav.addObject("srch", svo);
    		
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
		
		return mav;
	}
    
    @RequestMapping("/cmmt_arrg_stats.do")
    protected ModelAndView cmmt_arrg_stats(StatsVo svo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
		
    	ModelAndView mav = new ModelAndView("stats/cmmt_arrg_stats");
    	
    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
			resp.sendRedirect("login.do");
		}
		
		StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
		
		String auth = session.getAttribute("authNo").toString();
		String sido = session.getAttribute("sidoCd").toString();
		
		String prt = req.getParameter("srch_dt_prt");
		
		try{
			ArrayList<CommonVo> y_list = cmapper.yyyy_list();
			ArrayList<CommonVo> m_list = cmapper.month_list();
			
			String str = req.getParameter("srch_str_ym");
			String end = req.getParameter("srch_end_ym");
			
			ArrayList<StatsVo> w_list = null;
			
			if(!"".equals(prt) && prt != null) {svo.setSrch_dt_prt(prt);}
			else {svo.setSrch_dt_prt("1");}
			
			if("2".equals(auth)) {
				svo.setSido_cd(sido);
				w_list = mapper.stats_local_cmmt_work(svo);
			} else {
				w_list = mapper.stats_cmmt_work(svo);
			}
			
    		mav.addObject("y_list", y_list);
    		mav.addObject("m_list", m_list);
    		mav.addObject("w_list", w_list);
    		mav.addObject("srch", svo);
    		 
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
		
		return mav;
	}
    
    @RequestMapping("/cmmt_work_stats.do")
    protected ModelAndView cmmt_work_stats(StatsVo svo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
		
    	ModelAndView mav = new ModelAndView("stats/cmmt_work_stats");
    	
    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
			resp.sendRedirect("login.do");
		}
    	
    	String auth = session.getAttribute("authNo").toString();
		String sido = session.getAttribute("sidoCd").toString();
		
		StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
		
		String prt = req.getParameter("srch_dt_prt");
		
		try{
			ArrayList<CommonVo> y_list = cmapper.yyyy_list();
			ArrayList<CommonVo> m_list = cmapper.month_list();
			
			/*String str = req.getParameter("srch_str_ym");
			String end = req.getParameter("srch_end_ym");*/
			
			if(!"".equals(prt) && prt != null) {svo.setSrch_dt_prt(prt);}
			else {svo.setSrch_dt_prt("1");}
	         
	        ArrayList<StatsVo> w_list = null;
	        
	        if("2".equals(auth)) {
				svo.setSido_cd(sido);
				w_list = mapper.stats_local_cmmt_work2(svo);
			} else {
				w_list = mapper.stats_cmmt_work2(svo);
			}
			
    		mav.addObject("y_list", y_list);
    		mav.addObject("m_list", m_list);
    		mav.addObject("w_list", w_list);
    		mav.addObject("srch", svo);
    		 
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
		
		return mav;
	}
    
    @RequestMapping("/cmmt_edu_stats.do")
    protected ModelAndView cmmt_edu_stats(StatsVo svo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
		
    	ModelAndView mav = new ModelAndView("stats/cmmt_edu_stats");
    	
    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
			resp.sendRedirect("login.do");
		}

    	String auth = session.getAttribute("authNo").toString();
		String sido = session.getAttribute("sidoCd").toString();
    	
		StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
		
		//String prt = req.getParameter("srch_dt_prt");
		
		try{
			ArrayList<CommonVo> y_list = cmapper.yyyy_list();
			
			String yy = req.getParameter("srch_ym");
			
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			
			String now_ym = "";
			if(!"".equals(yy) && yy != null) {
				now_ym = yy;
			} else {
				now_ym = sdf.format(d);
			}
			svo.setSrch_ym(now_ym);
	         
	        ArrayList<StatsVo> e_list = null;
	        
	        if("2".equals(auth)) {
				svo.setSido_cd(sido);
				e_list = mapper.stats_local_cmmt_edu(svo);
			} else {
				e_list = mapper.stats_cmmt_edu(svo);
			}
			
    		mav.addObject("y_list", y_list);
    		mav.addObject("e_list", e_list);
    		mav.addObject("srch", svo);
    		 
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
		
		return mav;
	}
    
    @RequestMapping("/stats_excel_down.do")
    protected ModelAndView excel_down(StatsVo svo, HttpServletRequest req, HttpSession session) {
        ModelAndView mav = new ModelAndView("stats/stats_excel_down");
    	
        StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
        
        String prt = req.getParameter("excel_prt");
        
        /*String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
	    ScpDbAgent agt = new ScpDbAgent();*/
        
		try{
			ArrayList<StatsVo> list = null; 

			if("1".equals(prt)) {
				list = mapper.stats_cmmt_age(svo);
			} else {
				list = mapper.stats_cmmt_age2(svo);
			}
			
			/*for(int i=0; i<list.size(); i++) {
		    	list.get(i).setAges( agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getAges(), "UTF-8") );
		    }*/
		    
			
    		mav.addObject("list", list);
    		mav.addObject("prt", prt);
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
    	return mav;
    }
    
    @RequestMapping("/stats_arrg_excel_down.do")
    protected ModelAndView stats_arrg_excel_down(StatsVo svo, HttpServletRequest req, HttpSession session) {
    	ModelAndView mav = new ModelAndView("stats/stats_arrg_excel_down");
    	
    	StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
    	
    	String prt = req.getParameter("srch_dt_prt");
    	
    	String auth = session.getAttribute("authNo").toString();
		String sido = session.getAttribute("sidoCd").toString();
		
		try{
			if(!"".equals(prt) && prt != null) {svo.setSrch_dt_prt(prt);}
			else {svo.setSrch_dt_prt("1");}
	         
			ArrayList<StatsVo> list = null;
			
			if(!"".equals(prt) && prt != null) {svo.setSrch_dt_prt(prt);}
			else {svo.setSrch_dt_prt("1");}
			
			if("2".equals(auth)) {
				svo.setSido_cd(sido);
				list = mapper.stats_local_cmmt_work(svo);
			} else {
				list = mapper.stats_cmmt_work(svo);
			}
    		
    		mav.addObject("list", list);
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	return mav;
    }
    
    @RequestMapping("/stats_work_excel_down.do")
    protected ModelAndView stats_work_excel_down(StatsVo svo, HttpServletRequest req, HttpSession session) {
    	ModelAndView mav = new ModelAndView("stats/stats_work_excel_down");
    	
    	StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
    	
    	String prt = req.getParameter("srch_dt_prt");
    	
    	String auth = session.getAttribute("authNo").toString();
		String sido = session.getAttribute("sidoCd").toString();
    	
    	try{
    		if(!"".equals(prt) && prt != null) {svo.setSrch_dt_prt(prt);}
    		else {svo.setSrch_dt_prt("1");}
    		
    		ArrayList<StatsVo> list = null;
	        
	        if("2".equals(auth)) {
				svo.setSido_cd(sido);
				list = mapper.stats_local_cmmt_work2(svo);
			} else {
				list = mapper.stats_cmmt_work2(svo);
			}
    		
    		mav.addObject("list", list);
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	return mav;
    }
    
    @RequestMapping("/stats_edu_excel_down.do")
    protected ModelAndView stats_edu_excel_down(StatsVo svo, HttpServletRequest req, HttpSession session) {
    	ModelAndView mav = new ModelAndView("stats/stats_edu_excel_down");
    	
    	StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
    	
    	String auth = session.getAttribute("authNo").toString();
		String sido = session.getAttribute("sidoCd").toString();
    	
    	try{
    		String yy = req.getParameter("srch_ym");
			
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			
			String now_ym = "";
			if(!"".equals(yy) && yy != null) {
				now_ym = yy;
			} else {
				now_ym = sdf.format(d);
			}
			svo.setSrch_ym(now_ym);
			
			ArrayList<StatsVo> list = null; 
	        
	        if("2".equals(auth)) {
				svo.setSido_cd(sido);
				list = mapper.stats_local_cmmt_edu(svo);
			} else {
				list = mapper.stats_cmmt_edu(svo);
			}
    		
    		mav.addObject("list", list);
    		mav.addObject("srch", svo);
    	}
    	catch(Exception e) {
    		e.printStackTrace();
    	}
    	return mav;
    }
    
    @RequestMapping("/user_stats.do")
    protected ModelAndView user_stats(StatsVo svo, HttpServletRequest req, HttpSession session, HttpServletResponse resp)  throws Exception {
		
    	ModelAndView mav = new ModelAndView("stats/user_stats");
    	
    	if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || !"1".equals(session.getAttribute("authNo").toString()) ) { 
			resp.sendRedirect("login.do");
		}
		
		StatsMapper mapper = sqlSession.getMapper(StatsMapper.class);
		CommonMapper cmapper = sqlSession.getMapper(CommonMapper.class);
		
		String prt = req.getParameter("srch_dt_prt");
		String str = req.getParameter("srch_str_ym");
		String end = req.getParameter("srch_end_ym");
		
		try{
			ArrayList<CommonVo> y_list = cmapper.yyyy_list();
			ArrayList<CommonVo> m_list = cmapper.month_list2();
			
			Date d = new Date();
	    	Calendar cal = Calendar.getInstance();
	    	cal.setTime(new Date());
	    	cal.add(Calendar.MONTH, -1);
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
	    	
	        String now_ym = sdf.format(d);
	        String mon_ym = sdf.format(cal.getTime());
	        
	        if("".equals(str) || str == null ) {
	        	svo.setSrch_str_ym(mon_ym);
	        	svo.setSrch_end_ym(now_ym);
	        } 
	        if("".equals(prt) || prt == null ) {
	        	svo.setSrch_dt_prt("1");
	        } 
	         
	        ArrayList<StatsVo> u_list = mapper.stats_visit_url(svo);
	        
	        StatsVo info = new StatsVo();
	        info = mapper.stats_user_visit(svo);
			
    		mav.addObject("y_list", y_list);
    		mav.addObject("m_list", m_list);
    		mav.addObject("now_ym", now_ym);
    		mav.addObject("u_list", u_list);
    		mav.addObject("info", info);
    		mav.addObject("srch", svo);
    		
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
		
		return mav;
	}
}
