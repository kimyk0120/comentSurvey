package com.sweetk.kcti.survey.controller;

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

import com.sweetk.kcti.board.vo.BoardVo;

@Controller
public class SurveyController {

	Logger log = Logger.getLogger(SurveyController.class);
	
	@SuppressWarnings("unused")
	@Autowired
    private SqlSession sqlSession;
    
    @SuppressWarnings("unused")
	@Autowired 
    private PlatformTransactionManager transactionManager;
 
    
    //  설문 작성 
    @RequestMapping("/survey_write.do")
	protected ModelAndView survey_write(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		ModelAndView mav = new ModelAndView("survey/index_write");
		
		return mav;
	}
    
    // 설문 작성 - 문제 템프 로드
//    @RequestMapping("/survey_write_temp_load.ajax")
//    protected ModelAndView survey_write_temp_load(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
//    	ModelAndView mav = new ModelAndView("survey/index_write_temp");
//    	
//    	return mav;
//    }
    
    
	@RequestMapping("/survey_list.do")
	protected ModelAndView board_list(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
    	ModelAndView mav = new ModelAndView("survey/index_list");
    	
    	
    	return mav;
    }
	@RequestMapping("/survey_result.do")
	protected ModelAndView survey_result(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		ModelAndView mav = new ModelAndView("survey/index_result");
		
		
		return mav;
	}
	
	
	
}
