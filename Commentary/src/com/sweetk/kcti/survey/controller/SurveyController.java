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
import com.sweetk.kcti.survey.util.AES256Util;
import com.sweetk.kcti.survey.util.SendEmail;
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
    		out.print(vo.getSurvey_key()); // 저장된 설문번호
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
	
	// 설문 수정 선택시 - 설문 작성 페이지에서 설문 수정 
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
	@Transactional
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
			// 행 삭제일때
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
	
	// 이메일, sms 발송처리 - 유저에게 url 전송
	@RequestMapping(value="/send_survey.ajax",method={RequestMethod.GET})
	protected void send_survey(HttpServletRequest req, HttpSession session, HttpServletResponse resp
			,@RequestParam(value="surveyKey",required=true) int surveyKey) throws Exception  {
		//System.out.println("surveyKey : " + surveyKey);
		//System.out.println("send_survey.ajax called");
		PrintWriter out = resp.getWriter();
		SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
		SurveyVo vo = new SurveyVo();
		vo.setSurvey_key(surveyKey);
		try {
			// 설문대상 , 발송방법 select    
			vo = mapper.select_send_targetAndMethod(vo);
//			System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
//			System.out.println("vo.getSurvey_target() : " + vo.getSurvey_target());
//			System.out.println("vo.getSend_method(): " + vo.getSend_method());
			List<SurveyVo> userList = mapper.user_list(vo);
			
			if(vo.getSend_method().equals("email")){  // 이메일 발송 
				send_survey_mail(req,session,resp,vo,userList);
			}else if(vo.getSend_method().equals("textMassage")){ // 메세지 발송 TODO
				
			}else if(vo.getSend_method().equals("both")){  // 이메일, 메세지 발송 TODO
				send_survey_mail(req,session,resp,vo,userList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("send_survey error");
		} finally {
			out.close();
		}
	}//end send
	
	// 메일 송신
    protected void send_survey_mail(HttpServletRequest req, HttpSession session, HttpServletResponse resp,
    		SurveyVo vo, List<SurveyVo> userList) throws Exception {
    	
    	System.out.println("send_survey_mail methid called");
    	resp.setContentType("text/xml; charset=utf-8");
    	
    	SendEmail SendEmail = new SendEmail();
//    	String content = "<div class=\"_wcpushTag\" id=\"pushTag_82a073a72331565\" style=\"padding: 0px;\"><img src=\"http://ctgs.kr/image/login_m.png\">";
//    	content += "안녕하십니까</div><div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\"><strong>문화관광해설사 관리 페이지</strong>입니다.</div><div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\">요청하신 비밀번호는 <em>abcdef </em>입니다.</div>";
//    	content += "<div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\"><a href=\"http://www.ctgs.kr\">www.ctgs.kr</a> 로 접속하셔서 <strong>비밀번호 변경 후</strong> 이용하여 주시길 바랍니다.</div>";
//    	content += "<div class=\"_wcSign\" style=\"padding: 15px 0px 0px;\">감사합니다.</div><div align=\"center\" class=\"_wcSign\" style=\"background: rgb(222, 222, 222); padding: 15px 0px 0px;\"><img src=\"http://ctgs.kr/image/login_logo_mcst.png\"></div>";
    	
    	// 설문번호, 아이디 encode TODO
//    	System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
//    	System.out.println("userList.get(0).getUser_id() : " + userList.get(0).getUser_id());
//    	System.out.println("userList.get(0).getEmail() : " + userList.get(0).getEmail());
    	AES256Util aes = new AES256Util("commentary123456");
    	String encodeStr = aes.aesEncode(vo.getSurvey_key()+"#"+userList.get(0).getUser_id()); 
//    	System.out.println("encodeStr : " + encodeStr);
//    	String decodeStr  = aes.aesDecode(encodeStr); 
//    	System.out.println("decodeStr : " + decodeStr);
    	
    	// 이메일 내용 + send
    	String content = ""; 
    	String url ="192.168.0.189:8080/survey_result.do?"+encodeStr;
    	content += "<div style='text-align: center;'>                                                                                  ";
    	content += "<div class='_wcpushTag' id='pushTag_82a073a72331565' style='padding: 0px; margin-top: 2em;'>안녕하십니까</div>     ";
    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'><strong>문화관광해설사 관리 페이지</strong>입니다.</div>       ";
    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'>새로운 설문이 등록되었습니다.</div>                            ";
    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'>                       	 									   ";
    	content += "<a href='" + url + "'> 설문조사 페이지로 이동 </a></div>                       											   ";
    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'>위 링크로 접속하셔서 설문에 응해주시면 감사하겠습니다.</div>   ";
    	content += "<div class='_wcSign' style='padding: 15px 0px 0px; margin-bottom: 1em;'>감사합니다.</div>                          ";
    	content += "<div align='center' class='_wcSign' style='background: rgb(222, 222, 222); padding: 15px 0px 0px;'>          	   ";
    	content += "<img src='http://ctgs.kr/image/login_logo_mcst.png'></div>                                                   	   ";
    	content += "</div>                                                                                                       	   ";
    	SendEmail.Email("ctgs@hanmail.net", "kimyk0120@naver.com", "한국문화관광해설사 테스트 이메일 입니다", content);
    }
	
	
	// 설문지 
	@RequestMapping(value="/survey_result.do",method={RequestMethod.POST,RequestMethod.GET})
	protected ModelAndView survey_result(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		//SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
		ModelAndView mav = new ModelAndView("survey/s_result");
		return mav;
	}

	// 이메일 UI 테스트
	@RequestMapping(value="/emailui_test.do",method={RequestMethod.POST,RequestMethod.GET})
	protected ModelAndView emailui_test(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		ModelAndView mav = new ModelAndView("survey/emailui_test");
		return mav;
	}
}//endClass
