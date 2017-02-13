package com.sweetk.kcti.zip.controller;

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

@Controller
public class ZipController {
	Logger log = Logger.getLogger(ZipController.class);
	
	@Autowired
    private SqlSession sqlSession;
    
    @Autowired 
    private PlatformTransactionManager transactionManager;
	
    @RequestMapping("/zip_test_popup.do")
	protected ModelAndView zip_test(HttpServletRequest req, HttpSession session, HttpServletResponse resp) {
    	ModelAndView mav = new ModelAndView("zip/Sample");
    	
    try {
    	
	}
	catch(Exception e) {
        e.printStackTrace();
    }
	
	return mav;
	}
    
    @RequestMapping("/zip_test_popup2.do")
	protected ModelAndView zip_test_popup2(HttpServletRequest req, HttpSession session, HttpServletResponse resp) {
    	ModelAndView mav = new ModelAndView("zip/jusoPopup");
    	
    try {
    	
	}
	catch(Exception e) {
        e.printStackTrace();
    }
	
	return mav;
	}
}
