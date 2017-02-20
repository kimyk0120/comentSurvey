package com.sweetk.kcti.survey.vo;

import java.util.List;

public class SurveyVo {
	
	int survey_key; // 설문번호
	String survey_target =""; //설문대상
	String survey_title =""; // 설문제목
	String temp_yn = "" ; // 임시저장여부
	String reg_dt=""; // 등록일
	String reg_id=""; // 등록자
	String Start_dt=""; // 시작일
	String end_dt = ""; // 종료일
	String send_method =""; // 발송방법
	String qArray ="";
	
//	
	String qNo="";//qna no
	String qType =""; // qna type :  1 주관식, 2 객관식
	String qText =""; // 질문 
	String answerNo = "" ; // 답변 번호
	String answerText ="" ; // 답변 내용
	List<SurveyVo> answerList=null; // 답변리스트
	
	
	public SurveyVo() {
	}	

	public SurveyVo(SurveyVo vo) {
		survey_key = vo.getSurvey_key();
		survey_target = vo.getSurvey_target();
		temp_yn = vo.getTemp_yn();
		reg_dt = vo.getReg_dt();
		reg_id = vo.getReg_id();
		Start_dt = vo.getStart_dt();
		end_dt = vo.getEnd_dt();
		send_method = vo.getSend_method();
		qArray = vo.getqArray();
		qNo = vo.getqNo();
		qType = vo.getqType();
		qText = vo.getqText();
		answerNo = vo.getAnswerNo();
		answerText = vo.getAnswerText();
	}	
	
	
	// getter setter\
	public String getSurvey_target() {
		return survey_target;
	}


	public List<SurveyVo> getAnswerList() {
		return answerList;
	}

	public void setAnswerList(List<SurveyVo> answerList) {
		this.answerList = answerList;
	}

	public String getqNo() {
		return qNo;
	}
	public void setqNo(String qNo) {
		this.qNo = qNo;
	}
	public String getqType() {
		return qType;
	}
	public void setqType(String qType) {
		this.qType = qType;
	}
	public String getqText() {
		return qText;
	}
	public void setqText(String qText) {
		this.qText = qText;
	}
	public String getAnswerNo() {
		return answerNo;
	}
	public void setAnswerNo(String answerNo) {
		this.answerNo = answerNo;
	}
	public String getAnswerText() {
		return answerText;
	}
	public void setAnswerText(String answerText) {
		this.answerText = answerText;
	}
	
	public int getSurvey_key() {
		return survey_key;
	}
	public void setSurvey_key(int survey_key) {
		this.survey_key = survey_key;
	}
	public String getqArray() {
		return qArray;
	}
	public void setqArray(String qArray) {
		this.qArray = qArray;
	}
	public String getSend_method() {
		return send_method;
	}
	public void setSend_method(String send_method) {
		this.send_method = send_method;
	}
	public void setSurvey_target(String survey_target) {
		this.survey_target = survey_target;
	}
	public String getSurvey_title() {
		return survey_title;
	}
	public void setSurvey_title(String survey_title) {
		this.survey_title = survey_title;
	}
	public String getTemp_yn() {
		return temp_yn;
	}
	public void setTemp_yn(String temp_yn) {
		this.temp_yn = temp_yn;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getStart_dt() {
		return Start_dt;
	}
	public void setStart_dt(String start_dt) {
		Start_dt = start_dt;
	}
	public String getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}
	
	
	
}
