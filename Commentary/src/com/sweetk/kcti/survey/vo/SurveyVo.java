package com.sweetk.kcti.survey.vo;

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
	
	
	// getter setter\
	public String getSurvey_target() {
		return survey_target;
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
