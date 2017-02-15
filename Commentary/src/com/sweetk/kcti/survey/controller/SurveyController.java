package com.sweetk.kcti.survey.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
    
    //  설문 저장 
    @RequestMapping("/survey_save.ajax")
	protected void survey_save_ajax(BoardVo bvo, HttpServletRequest req, HttpSession session, HttpServletResponse resp,
			@RequestParam(value="tempSaveYn") String tempSaveYn // 임시저장여부
			,@RequestParam(value="sDate") String sDate // 시작일
			,@RequestParam(value="eDate") String eDate // 종료일
			,@RequestParam(value="surveyTarget") String surveyTarget // 설문대상
			,@RequestParam(value="sendMethod") String sendMethod // 발송방법
			,@RequestParam(value="qArray") String qArray // 설문내용 
			) throws Exception  {
    	
    	System.out.println("/survey_save.ajax called..");
    	PrintWriter out = resp.getWriter();
    	System.out.println("tempSaveYn : " + tempSaveYn);
    	System.out.println("sDate : " + sDate);
    	System.out.println("eDate : " + eDate);
    	System.out.println("surveyTarget : " + surveyTarget);
    	System.out.println("sendMethod : " + sendMethod);
    	System.out.println("qArray : " + qArray);
    	
    	
    	out.close();
    }
    
    
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
