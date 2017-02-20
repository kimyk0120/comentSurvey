package com.sweetk.kcti.survey.mapper;

import java.util.List;

import com.sweetk.kcti.survey.vo.SurveyVo;

public interface SurveyMapper {

	public int survey_save(SurveyVo vo);

	public void survey_q_save(SurveyVo vo);

	public void survey_mq_save(SurveyVo vo);

	public List<SurveyVo> surveyList();

	public void deleteDelYn(SurveyVo vo);

}
