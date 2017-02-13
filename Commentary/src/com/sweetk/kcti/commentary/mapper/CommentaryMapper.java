package com.sweetk.kcti.commentary.mapper;

import java.util.ArrayList;

import com.sweetk.kcti.commentary.vo.CommentaryVo;

public interface CommentaryMapper {
	
	public int cmmt_list_count(CommentaryVo cvo);
	
	public ArrayList<CommentaryVo> cmmt_list(CommentaryVo cvo);
	
	public int cmmt_save(CommentaryVo cvo);
	
	public void cmmt_lang_save(CommentaryVo cvo);
	
	public CommentaryVo cmmt_info(CommentaryVo cvo); 
	public CommentaryVo cmmt_lang_info(CommentaryVo cvo); 
	
	public void cmmt_update(CommentaryVo cvo);
	public void cmmt_lang_delete(CommentaryVo cvo);
	
	public void cmmt_delete(CommentaryVo cvo);
	
	public int cmmt_edu_list_count(CommentaryVo cvo);
	public ArrayList<CommentaryVo> cmmt_edu_list(CommentaryVo cvo);
	
	public void cmmt_edu_update(CommentaryVo cvo);
	public void cmmt_edu_insert(CommentaryVo cvo);
	
	public int cmmt_act_list_count(CommentaryVo cvo);
	public ArrayList<CommentaryVo> cmmt_act_list(CommentaryVo cvo);
	
	public void cmmt_act_update(CommentaryVo cvo);
	public void cmmt_act_insert(CommentaryVo cvo);
	public void cmmt_act_delete(String cmntor_no , String seq);
	
	public int cmmt_fee_list_count(CommentaryVo cvo);
	public ArrayList<CommentaryVo> cmmt_fee_list(CommentaryVo cvo);
	
	public void cmmt_fee_update(CommentaryVo cvo);
	public void cmmt_fee_insert(CommentaryVo cvo);
	public void cmmt_fee_delete(String cmntor_no , String seq);
	
	public void cmmt_all_update(CommentaryVo cvo);
	public ArrayList<CommentaryVo> cmmt_all_list();
	
	public int act_list_count(CommentaryVo cvo);
	public ArrayList<CommentaryVo> act_list(CommentaryVo cvo);
	
	public int act_save_check(String ym, String cmntor_no);
	
	public void act_tot_insert(CommentaryVo cvo);
	public void act_tot_update(CommentaryVo cvo);
}
