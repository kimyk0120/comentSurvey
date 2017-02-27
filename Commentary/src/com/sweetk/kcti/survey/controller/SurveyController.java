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
	@Transactional
	@RequestMapping(value="/send_survey.ajax",method={RequestMethod.GET})
	protected void send_survey(HttpServletRequest req, HttpSession session, HttpServletResponse resp
			,@RequestParam(value="surveyKey",required=true) String surveyKey) throws Exception  {
		//System.out.println("surveyKey : " + surveyKey);
		//System.out.println("send_survey.ajax called");
		PrintWriter out = resp.getWriter();
		SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
		SurveyVo vo = new SurveyVo();
		vo.setSurvey_key(Integer.parseInt(surveyKey));
		try {
			// 설문대상 , 발송방법 select    
			vo = mapper.select_send_targetAndMethod(vo);
//			System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
//			System.out.println("vo.getSurvey_target() : " + vo.getSurvey_target());
//			System.out.println("vo.getSend_method(): " + vo.getSend_method());
			List<SurveyVo> userList = mapper.user_list(vo);
			for(int i=0;i<userList.size();i++){ 
				vo.setUser_id(userList.get(i).getUser_id());
				mapper.insert_user(vo);	 // survey_target 에 유저등록
			}
			if(vo.getSend_method().equals("email")){  // 이메일 발송 
				send_survey_mail(req,session,resp,vo,userList);
				vo.setEmail_yn("Y");
				vo.setSms_yn("N");
			}else if(vo.getSend_method().equals("textMassage")){ // 메세지 발송 TODO
				vo.setEmail_yn("N");
				vo.setSms_yn("Y");
			}else if(vo.getSend_method().equals("both")){  // 이메일, 메세지 발송 TODO
				send_survey_mail(req,session,resp,vo,userList);
				vo.setEmail_yn("N");
				vo.setSms_yn("Y");
			}
			mapper.update_emailYn_smsYn(vo);
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
    	
    	// 설문번호, 아이디 encode 
//    	System.out.println("vo.getSurvey_key() : " + vo.getSurvey_key());
//    	System.out.println("userList.get(0).getUser_id() : " + userList.get(0).getUser_id());
//    	System.out.println("userList.get(0).getEmail() : " + userList.get(0).getEmail());
    	AES256Util aes = new AES256Util("commentary123456");
//    	System.out.println("encodeStr : " + encodeStr);
//    	String decodeStr  = aes.aesDecode(encodeStr); 
//    	System.out.println("decodeStr : " + decodeStr);

    	// 이메일 내용 + send
    	for(int i=0;i<userList.size();i++){
    		// 이메일 유효성 체크
    		if(SendEmail.isEmail(userList.get(i).getEmail())){
    			String content = "";
    	    	String encodeStr = aes.aesEncode(vo.getSurvey_key()+"#"+userList.get(i).getUser_id());
    	    	String url ="http://localhost:8080/survey_result.do?userKey="+encodeStr;  // TODO 도메인 변경해야함
    	    	content += "<div style='text-align: center;'>                                                                                  ";
    	    	content += "<div class='_wcpushTag' id='pushTag_82a073a72331565' style='padding: 0px; margin-top: 2em;'>안녕하십니까.</div>     ";
    	    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'><strong>문화관광해설사 관리 페이지</strong>입니다.</div>       ";
    	    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'>새로운 설문이 등록되었습니다.</div>                            ";
    	    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'>                       	 									   ";
    	    	content += "<a href='" + url + "'> 설문조사 페이지로 이동 </a></div>                       									   ";
    	    	content += "<div class='_wcSign' style='padding: 15px 0px 0px;'>위 링크로 접속하셔서 설문에 응해주시면 감사하겠습니다.</div>   ";
    	    	content += "<div class='_wcSign' style='padding: 15px 0px 0px; margin-bottom: 1em;'>감사합니다.</div>                          ";
    	    	content += "<div align='center' class='_wcSign' style='background: rgb(222, 222, 222); padding: 15px 0px 0px;'>          	   ";
    	    	content += "<img src='http://ctgs.kr/image/login_logo_mcst.png'></div>                                                   	   ";
    	    	content += "</div>                                                                                                       	   ";
    	    	SendEmail.Email("ctgs@hanmail.net", userList.get(i).getEmail(), "한국문화관광해설사 설문 조사 이메일 입니다", content);
    		}
    	}//endFOr
    }
    
    // 이메일 UI 테스트
 	@RequestMapping(value="/emailui_test.do",method={RequestMethod.POST,RequestMethod.GET})
 	protected ModelAndView emailui_test(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
 		ModelAndView mav = new ModelAndView("survey/emailui_test");
 		return mav;
 	}
	
	// 설문 답변 페이지  - 각 유저 이메일에서 url 선택시
	@RequestMapping(value="/survey_result.do",method={RequestMethod.POST,RequestMethod.GET})
	protected ModelAndView survey_result(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
		SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
		
		System.out.println("설문 작성자 접속");
		ModelAndView mav = new ModelAndView("survey/s_result");
		AES256Util aes = new AES256Util("commentary123456"); 
		String decodeStr = aes.aesDecode(req.getParameter("userKey"));
		String[] splitArr;
		splitArr = decodeStr.split("#");
		String surveyKey = splitArr[0]; // 설문번호
		String userId = splitArr[1]; // 유저 아이디

		//System.out.println("decodeStr : " + decodeStr);
		System.out.println("surveyKey : " + surveyKey);
		System.out.println("userId : " + userId);
		mav.addObject("surveyKey",surveyKey);
		mav.addObject("userId",userId);
		
		SurveyVo vo = new SurveyVo();
		vo.setSurvey_key(Integer.parseInt(surveyKey));
		vo.setUser_id(userId);
		
		try {
			// 답변 완료 여부체크 , 시작일 종료일 체크- 완료페이지로 이동
			String confirmYn = mapper.select_answer_yn(vo);
			String stdtChkYn = mapper.select_stdt_yn(vo);
			
			System.out.println("confirmYn : " + confirmYn);
			System.out.println("stdtChkYn : " + stdtChkYn);
			
			// 답변 미완료일때 and 설문기간일때
			if((confirmYn==null||confirmYn.equals("N"))&&(stdtChkYn.equals("Y"))){
				
				vo = mapper.survey_detail(vo);
	        	List<SurveyVo> qList = mapper.questionList(vo);
	        	List<SurveyVo> mqList = mapper.multi_questionList(vo);
	        	mav.addObject("sVo",vo);
	        	mav.addObject("qList",qList);
	        	mav.addObject("mqList",mqList);
	        	mav.addObject("qlLength",qList.size());  // 문제 개수
	        	
			}else{ // 답변 완료일때 or 설문기간이 아닐 때 - 완료 페이지로 
				//System.out.println("완료 페이지로 이동");
				if(stdtChkYn.equals("N")){
					mav.addObject("stdtChkYn","N");
				}
				mav.setViewName("survey/s_done");
			}
		} catch (Exception e) {
			//e.printStackTrace();
			System.out.println("survey_result error");
		}
		return mav;
	}
	
	// 설문 답변 저장 ajax
	@RequestMapping(value="/survey_result_save.ajax",method={RequestMethod.POST})
	protected void survey_result_save(HttpServletRequest req, HttpSession session, HttpServletResponse resp
			,@RequestParam(value="surveyKey") String surveyKey 
			,@RequestParam(value="tempYn") String tempYn
			,@RequestParam(value="userId") String userId
			,@RequestParam(value="aArray[]") String[] aArray) throws Exception  { 
		SurveyMapper mapper = sqlSession.getMapper(SurveyMapper.class);
		PrintWriter out = resp.getWriter();
//		System.out.println("survey_result_save.ajax called");
//		System.out.println("surveyKey : " + surveyKey);
//		System.out.println("tempYn : " + tempYn);
//		System.out.println("userId : " + userId);
//		for (int i = 0; i < aArray.length; i++) {System.out.println("aArray["+i+"] : " + aArray[i]);}
		SurveyVo vo = new SurveyVo();
		vo.setSurvey_key(Integer.parseInt(surveyKey)); // 설문번호
		vo.setTemp_yn(tempYn);  // 임시저장여부
		vo.setUser_id(userId); // 유저 아이디
		try {
			mapper.update_tempYn(vo); //임시저장여부 업데이트
			for (int i = 0; i < aArray.length; i++) {
				String qSeq = String.valueOf(i+1);
				vo.setQuestion_seq(qSeq);  // 문제 번호
				//System.out.println(vo.getQuestion_seq());
				vo.setAnswer(aArray[i]);  // 문제 답안
				mapper.insert_answer(vo);  // 답변 저장 및 업데이트
			}
			if(tempYn.equals("N")){
				vo.setConfirm_yn("Y");
				mapper.update_confirm(vo); // 답변완료 여부 저장
			}
		} catch (Exception e) {
			out.print("error");
			System.out.println("survey_result_save error");
		} finally {
			out.close();
		}
	}

	// 답변완료페이지 
 	@RequestMapping(value="/survey_done.do",method={RequestMethod.GET})
 	protected ModelAndView survey_done(HttpServletRequest req, HttpSession session, HttpServletResponse resp) throws Exception  {
 		ModelAndView mav = new ModelAndView("survey/s_done");
 		return mav;
 	}
	
	
}//endClass
