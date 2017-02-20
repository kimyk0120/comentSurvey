package com.sweetk.kcti.survey.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sweetk.kcti.board.vo.BoardVo;
import com.sweetk.kcti.survey.mapper.SurveyMapper;
import com.sweetk.kcti.survey.vo.SurveyVo;
import com.sweetk.kcti.survey.vo.VoList;

@Controller
public class SurveyController {

	Logger log = Logger.getLogger(SurveyController.class);
	
	@Autowired
    private SqlSession sqlSession;
    
    @SuppressWarnings("unused")
	@Autowired 
    private PlatformTransactionManager transactionManager;
 
    
    //  설문 작성 
    @RequestMapping("/survey_write.do")
	protected ModelAndView survey_write(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		ModelAndView mav = new ModelAndView("survey/index_write");
		System.out.println("/survey_write.do called..");
		return mav;
	}
    
    //  설문 저장 
    @RequestMapping(value="/survey_save.ajax", method ={RequestMethod.POST,RequestMethod.GET} )
	protected void survey_save_ajax(HttpServletRequest req, HttpSession session, HttpServletResponse resp,
			@RequestParam(value="tempSaveYn") String tempSaveYn // 임시저장여부
			,@RequestParam(value="surveyTitle") String surveyTitle // 설문제목
			,@RequestParam(value="sDate") String sDate // 시작일
			,@RequestParam(value="eDate") String eDate // 종료일
			,@RequestParam(value="surveyTarget") String surveyTarget // 설문대상
			,@RequestParam(value="sendMethod") String sendMethod // 발송방법
			,@RequestParam(value="qArray") String qArray // 설문내용 
			) throws Exception  {
    	System.out.println("/survey_save.ajax called..");
    	PrintWriter out = resp.getWriter();
    	SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
    	SurveyVo vo = new SurveyVo(); 
    	
//    	System.out.println("surveyTitle : " + surveyTitle);
//    	System.out.println("tempSaveYn : " + tempSaveYn);
//    	System.out.println("sDate : " + sDate);
//    	System.out.println("eDate : " + eDate);
//    	System.out.println("surveyTarget : " + surveyTarget);
//    	System.out.println("sendMethod : " + sendMethod);
    	System.out.println("qArray : " + qArray);
    	
    	vo.setSurvey_title(surveyTitle);
    	vo.setTemp_yn(tempSaveYn);
    	vo.setStart_dt(sDate);
    	vo.setEnd_dt(eDate);
    	vo.setSurvey_target(surveyTarget);
    	vo.setSend_method(sendMethod);
    	vo.setReg_id(""); 
    	
    	mapper.survey_save(vo);
    	System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
    	
    	VoList voList = new Gson().fromJson(qArray, VoList.class);
    	
    	for(int i=0;i<voList.getqList().size();i++){
    		
    	}
    	
    	
    	//out.print("test");
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
