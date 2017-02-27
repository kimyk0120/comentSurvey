package com.sweetk.kcti.survey.mapper;

import java.util.List;

import com.sweetk.kcti.survey.vo.SurveyVo;

public interface SurveyMapper {

	public int survey_save(SurveyVo vo);

	public void survey_q_save(SurveyVo vo);

	public void survey_mq_save(SurveyVo vo);

	public List<SurveyVo> surveyList();

	public void deleteDelYn(SurveyVo vo);

	public void surveyDel_sur(SurveyVo vo);

	public void surveyDel_sur_q(SurveyVo vo);

	public void surveyDel_sur_mq(SurveyVo vo);

	public SurveyVo survey_detail(SurveyVo vo);

	public List<SurveyVo> questionList(SurveyVo vo);

	public List<SurveyVo> multi_questionList(SurveyVo vo);

	public void survey_update(SurveyVo vo);

	public void survey_q_update(SurveyVo vo);

	public SurveyVo select_send_targetAndMethod(SurveyVo vo);

	public List<SurveyVo> user_list(SurveyVo vo);

	public String select_answer_yn(SurveyVo vo);

	public String select_stdt_yn(SurveyVo vo);

	public void insert_answer(SurveyVo vo);

	public void insert_user(SurveyVo vo);

	public void update_emailYn(SurveyVo vo);

	public void update_smsYn(SurveyVo vo);

	public void update_emailYn_smsYn(SurveyVo vo);

	public void update_tempYn(SurveyVo vo);

	public void update_confirm(SurveyVo vo);


}
