package com.sweetk.kcti.survey.mapper;

import com.sweetk.kcti.survey.vo.SurveyVo;

public interface SurveyMapper {

	public int survey_save(SurveyVo vo);

	public void survey_q_save(SurveyVo vo);

	public void survey_mq_save(SurveyVo vo);
	
}
