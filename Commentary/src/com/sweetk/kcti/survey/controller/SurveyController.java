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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
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
    
    
    //  설문 작성 페이지
    @RequestMapping(value="/survey_write.do",method={RequestMethod.GET})
	protected ModelAndView survey_write(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		ModelAndView mav = new ModelAndView("survey/s_write");
		//System.out.println("/survey_write.do called..");
		return mav;
	}
    
    //  설문 저장 및 수정 ajax
    @Transactional
    @RequestMapping(value="/survey_save.ajax", method ={RequestMethod.POST} )
	protected void survey_save_ajax(HttpServletRequest req, HttpSession session, HttpServletResponse resp,
			@RequestParam(value="tempSaveYn") String tempSaveYn // 임시저장여부
			,@RequestParam(value="surveyTitle") String surveyTitle // 설문제목
			,@RequestParam(value="sDate") String sDate // 시작일
			,@RequestParam(value="eDate") String eDate // 종료일
			,@RequestParam(value="surveyTarget") String surveyTarget // 설문대상
			,@RequestParam(value="sendMethod") String sendMethod // 발송방법
			,@RequestParam(value="qArray") String qArray // 설문내용 
			,@RequestParam(value="updateYn") String updateYn // 업데이트인지 여부
			,@RequestParam(value="surveyUpdateKey",required=false // 수정시 설문번호 
			) String surveyUpdateKey) throws Exception  {
    	//System.out.println("/survey_save.ajax called..");
    	PrintWriter out = resp.getWriter();
    	SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
    	SurveyVo vo = new SurveyVo(); 
//    	System.out.println("surveyTitle : " + surveyTitle);
//    	System.out.println("tempSaveYn : " + tempSaveYn);
//    	System.out.println("sDate : " + sDate);
//    	System.out.println("eDate : " + eDate);
//    	System.out.println("surveyTarget : " + surveyTarget);
//    	System.out.println("sendMethod : " + sendMethod);
//    	System.out.println("qArray : " + qArray);
//    	System.out.println("surveyUpdateKey : " + surveyUpdateKey);
    	vo.setSurvey_title(surveyTitle);
    	vo.setTemp_yn(tempSaveYn);
    	vo.setStart_dt(sDate);
    	vo.setEnd_dt(eDate);
    	vo.setSurvey_target(surveyTarget);
    	vo.setSend_method(sendMethod);
    	vo.setReg_id("");  // TODO 등록자 설정해야함
    	try {
    		// 설문 수정시 
    		if(updateYn.equals("Y")){
    			vo.setSurvey_key(Integer.parseInt(surveyUpdateKey)); // 설문번호
    			mapper.surveyDel_sur_mq(vo); // multi_question 테이블 삭제
    			mapper.surveyDel_sur_q(vo); // survey_question 테이블 삭
        		mapper.survey_update(vo); 
            	//System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
        		VoList voList = new Gson().fromJson(qArray, VoList.class);
        		for(int i=0;i<voList.getqList().size();i++){ // 설문 내용 
        			if(voList.getqList().get(i).getqType().equals("1")){  // 주관식일 때
        				vo.setSurvey_key(vo.getSurvey_key());  // 설문번호
        				vo.setQuestion_seq(voList.getqList().get(i).getqNo()); // 질문번호
        				vo.setMulti_yn("N"); // 객관식여부
        				vo.setQuestion(voList.getqList().get(i).getqText()); //  질문
        				mapper.survey_q_save(vo);
        			}else if(voList.getqList().get(i).getqType().equals("2")){ // 객관식일 때
        				vo.setSurvey_key(vo.getSurvey_key());  // 설문번호
        				vo.setQuestion_seq(voList.getqList().get(i).getqNo()); // 질문번호
        				vo.setMulti_yn("Y"); // 객관식여부
        				vo.setQuestion(voList.getqList().get(i).getqText()); //  질문
        				mapper.survey_q_save(vo);
        				for(int j=0;j<voList.getqList().get(i).getAnswerList().size();j++){  // 객관식 질문 
        					vo.setSurvey_key(vo.getSurvey_key());
        					vo.setQuestion_seq(voList.getqList().get(i).getqNo()); // 질문번호
        					vo.setMulti_seq(voList.getqList().get(i).getAnswerList().get(j).getAnswerNo());
        					vo.setMulti_question(voList.getqList().get(i).getAnswerList().get(j).getAnswerText());
        					mapper.survey_mq_save(vo);
        				}
        			}
        		}//endForSave
    		}else{ // 수정이 아닌 임시저장 일때
        		mapper.survey_save(vo); // 설문기본정보  - survey 테이블 인서트
            	//System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
        		VoList voList = new Gson().fromJson(qArray, VoList.class);
        		for(int i=0;i<voList.getqList().size();i++){ // 설문 내용 
        			if(voList.getqList().get(i).getqType().equals("1")){  // 주관식일 때
        				vo.setSurvey_key(vo.getSurvey_key());  // 설문번호
        				vo.setQuestion_seq(voList.getqList().get(i).getqNo()); // 질문번호
        				vo.setMulti_yn("N"); // 객관식여부
        				vo.setQuestion(voList.getqList().get(i).getqText()); //  질문
        				mapper.survey_q_save(vo);
        			}else if(voList.getqList().get(i).getqType().equals("2")){ // 객관식일 때
        				vo.setSurvey_key(vo.getSurvey_key());  // 설문번호
        				vo.setQuestion_seq(voList.getqList().get(i).getqNo()); // 질문번호
        				vo.setMulti_yn("Y"); // 객관식여부
        				vo.setQuestion(voList.getqList().get(i).getqText()); //  질문
        				mapper.survey_q_save(vo);
        				for(int j=0;j<voList.getqList().get(i).getAnswerList().size();j++){  // 객관식 질문 
        					vo.setSurvey_key(vo.getSurvey_key());
        					vo.setQuestion_seq(voList.getqList().get(i).getqNo()); // 질문번호
        					vo.setMulti_seq(voList.getqList().get(i).getAnswerList().get(j).getAnswerNo());
        					vo.setMulti_question(voList.getqList().get(i).getAnswerList().get(j).getAnswerText());
        					mapper.survey_mq_save(vo);
        				}
        			}
        		}//endForSave
    		}//endElse
		} catch (Exception e) {
			System.out.println("survey_save error");
			out.print("error");
		}finally {
			out.close();
		}
    }//end survey_save method
    
    // 설문 리스트 
	@RequestMapping(value="/survey_list.do",method={RequestMethod.GET})
	protected ModelAndView survey_list(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
    	ModelAndView mav = new ModelAndView("survey/s_list");
    	SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
    	List<SurveyVo> sList = mapper.surveyList();
    	mav.addObject("sList",sList);
    	return mav;
    }
	
	// 설문 수정 페이지
	@Transactional
	@RequestMapping(value="/survey_mod.do",method={RequestMethod.GET})
	protected ModelAndView survey_mod(HttpServletRequest req, HttpSession session, HttpServletResponse resp
			,@RequestParam(value="surveyKey",required=true) String surveyKey) throws Exception  {
		//System.out.println("/survey_mod called..");
		//System.out.println("surveyKey : " + surveyKey);
    	ModelAndView mav = new ModelAndView("survey/s_write");
    	SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
    	SurveyVo vo = new SurveyVo();
    	vo.setSurvey_key(Integer.parseInt(surveyKey));
    	//System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
    	try {
    		vo = mapper.survey_detail(vo);
        	List<SurveyVo> qList = mapper.questionList(vo);
        	List<SurveyVo> mqList = mapper.multi_questionList(vo);
        	mav.addObject("sVo",vo);
        	mav.addObject("qList",qList);
        	mav.addObject("mqList",mqList);
        	mav.addObject("qlLength",qList.size());  // 문제 개수
        	//System.out.println("qList.size() : " + qList.size());
		} catch (Exception e) {
			System.out.println("error");
		}
    	return mav;
    }
	
	// 설문 삭제
	@RequestMapping(value="/survey_delete.ajax",method={RequestMethod.GET})
	protected void survey_delete_ajax(HttpServletRequest req, HttpSession session, HttpServletResponse resp
			,@RequestParam(value="surveyKey",required=true) String surveyKey) throws Exception  {
		
		PrintWriter out = resp.getWriter();
		SurveyVo vo = new SurveyVo();
		SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
		//System.out.println("surveyKey : " + surveyKey);
		vo.setSurvey_key(Integer.parseInt(surveyKey));
		vo.setDel_yn("Y");

		try {
			// del yn -> Y로 변경
			mapper.deleteDelYn(vo);
			// 행 삭제 
//			mapper.surveyDel_sur_mq(vo); // multi_question 테이블 삭제
//			mapper.surveyDel_sur_q(vo); // survey_question 테이블 삭제
//			mapper.surveyDel_sur(vo); // survey 테이블 삭제
			out.print("success");
		} catch (Exception e) {
			System.out.println("survey_delete.ajax error");
			out.print("error");
		}finally {
			out.close();
		}
	}
	
	
	@RequestMapping("/survey_result.do")
	protected ModelAndView survey_result(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		//SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
		ModelAndView mav = new ModelAndView("survey/s_result");
		return mav;
	}
	
	
}//endClass
