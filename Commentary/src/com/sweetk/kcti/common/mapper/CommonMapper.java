//package com.sweetk.kcti.common.mapper;
//
//import java.util.ArrayList;
//
//import org.apache.ibatis.annotations.Param;
//
//import com.sweetk.kcti.common.vo.CommonVo;
//
//public interface CommonMapper {
//	public ArrayList<CommonVo> sido_list();
//	public ArrayList<CommonVo> gugun_list(CommonVo cvo);
//	public CommonVo gugun_check(String sido);
//	
//	public ArrayList<CommonVo> yyyy_list();
//	public ArrayList<CommonVo> month_list();
//	public ArrayList<CommonVo> month_list2();
//	
//	public void user_act_insert(CommonVo cvo);
//	public void cmmt_info_hist_insert(CommonVo cvo);
//	
//	public CommonVo main_cnt_info(CommonVo cvo);
//	
//	public ArrayList<CommonVo> cmmt_update_info(CommonVo cvo);
//	public ArrayList<CommonVo> login_info(CommonVo cvo);
//	
//	public int dup_check(String cmntor_no, String ym);
//	
//	public int dup_check2(String cmntor_no, String ym);
//	
////	public void sign_input(@Param("name") String name, @Param("addr") String addr, @Param("lat") Double lat, @Param("lon") Double lon);
//}
