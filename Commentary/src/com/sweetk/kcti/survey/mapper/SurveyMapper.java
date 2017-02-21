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

}
