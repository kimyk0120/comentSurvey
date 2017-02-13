package com.sweetk.kcti.excel.controller;

import java.util.ArrayList;

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

import com.sweetk.kcti.excel.mapper.ExcelMapper;
import com.sweetk.kcti.excel.vo.ExcelVo;

import com.penta.scpdb.*;

@Controller
public class ExcelController {
	
	Logger log = Logger.getLogger(ExcelController.class);
	
	@Autowired
    private SqlSession sqlSession;
    
    @Autowired 
    private PlatformTransactionManager transactionManager;
    
	@RequestMapping("/cmmt_excel_down.do")
    protected ModelAndView cmmt_excel_down(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception {
        ModelAndView mav = new ModelAndView("excel/cmmt_excel_down");
        
        if (session.getAttribute("UserId") == null || session.getAttribute("authNo") == null || "9".equals(session.getAttribute("authNo").toString()) ) { 
			resp.sendRedirect("login.do");
		}
        ExcelMapper mapper = sqlSession.getMapper(ExcelMapper.class);
        String sido = req.getParameter("sido_cd");
         
        System.out.println("sido : " + sido) ;
        
        ExcelVo evo = new ExcelVo();
	       
		try{
			evo.setSido_cd(sido);
			ArrayList<ExcelVo> list = mapper.cmmt_excel_down(evo);
			 
			//String iniFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\scp\\scpdb_agent_win.ini"; //scpdb_agent.ini fullpath
			String iniFilePath = "/usr/local/server/tomcat7/scp/scpdb_agent_unix.ini"; 
		    ScpDbAgent agt = new ScpDbAgent();

		    String addr = "";
		    String b_dt = "";
		    
		    for(int i=0; i<list.size(); i++) {
		    	addr = agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getAddress(), "UTF-8");
				b_dt = agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getBirth_dt(), "UTF-8");
				
				list.get(i).setAddress( agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getAddress(), "UTF-8") );
				list.get(i).setBirth_dt( agt.ScpDecStr( iniFilePath, "KEY1", list.get(i).getBirth_dt(), "UTF-8") );
		    }
			 
			mav.addObject("list", list);
		}
		catch(Exception e) {
	        e.printStackTrace();
	    }
		return mav;
    }
}
