package com.sweetk.kcti.commentary.vo;

public class CommentaryVo {
	String user_id =null;
	
	String cmntor_no 		= null;
	String name				= null;
	String birth_dt			= null;
	String lunar_yn			= null;
	String gender			= null;
	String eng_name 		= null;
	String eng_name2 		= null;
	String rgst_dt 			= null;
	String act_yn			= null;
	String act_prt_cd 		= null;
	String act_prt_nm 		= null;
	String arrg_place 		= null;
	String sido_cd 			= null; 
	String sido_cd_nm 		= null; 
	String gugun_cd 		= null;
	String gugun_cd_nm 		= null;
	String home_zip 		= null;
	String home_addr1 		= null;
	String home_addr2 		= null;
	String home_phone 		= null;
	String hand_phone 		= null;
	String email 			= null;
	String prfl_img 		= null;
	String last_edu_cd		= null;
	String last_edu_nm		= null;
	String hope_place		= null;
	String job				= null;
	String job_nm			= null;
	String etc_job_nm		= null;
	String eng_test_nm		= null;
	String eng_test_yy		= null;
	String eng_test_pnt		= null;
	String chn_test_nm 		= null;
	String chn_test_yy 		= null;
	String chn_test_pnt		= null;
	String jpn_test_nm 		= null;
	String jpn_test_yy 		= null;
	String jpn_test_pnt		= null;
	String etc_test_nm 		= null;
	String etc_test_yy 		= null;
	String etc_test_pnt		= null;
	String etc_lang_nm		= null;
	String etc_lang			= null;
	
	String lang_cd			= null;
	String lang_nm			= null;
	String grade			= null;
	
	String row_num				 = null;
	int cnt;
	
	private int startRow;
	private int endRow;
	
	String srch_str_dt		 	 = null;
	String srch_end_dt		 	 = null;
	String srch_act_prt_cd	 	 = null;
	String srch_act_yn	 	 	 = null;
	String srch_sido		 	 = null;
	String srch_gugun		 	 = null;
	String srch_nm			 	= null;
	String srch_area			 = null;
	String pageNum			 	 = null;
	String page					 = null;
	
	String srch_ym				= null;
	String seq					= null;
	String work_ym				= null;
	String work_tm				= null;
	String work_dt_cnt			= null;
	String work_place			= null;
	int visitor_cnt;
	int cmmt_cnt;
	
	String act_ym				= null;
	String act_fee				= null;
	String pay_info				= null;
	String pay_yn				= null;
	
	String home_ph1				= null;
	String home_ph2				= null;
	String home_ph3				= null;
	String hand_ph1				= null;
	String hand_ph2				= null;
	String hand_ph3				= null;
	String email1				= null;
	String email2				= null;
	
	String lang_cd1				= null;
	String lang_cd2				= null;
	String lang_cd3				= null;
	String lang_cd4				= null;
	String lang_cd9				= null;
	String lang_cd2_grade		= null;
	String lang_cd3_grade		= null;
	String lang_cd4_grade		= null;
	String lang_cd9_grade		= null;
	
	int edu_seq;
	String edu_prt				= null;
	String edu_prt_nm			= null;
	String yyyy					= null;
	String edu_place			= null;
	String edu_nm				= null;
	String edu_tm				= null;
	String edu_cmpl				= null;
	
	String id					= null;
	String auth_no				= null;
	
	String inpt_usr				= null;
	String srch_order			= null;
	String order_prt			= null;
	String age					= null;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCmntor_no() {
		return cmntor_no;
	}
	public void setCmntor_no(String cmntor_no) {
		this.cmntor_no = cmntor_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth_dt() {
		return birth_dt;
	}
	public void setBirth_dt(String birth_dt) {
		this.birth_dt = birth_dt;
	}
	public String getLunar_yn() {
		return lunar_yn;
	}
	public void setLunar_yn(String lunar_yn) {
		this.lunar_yn = lunar_yn;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEng_name() {
		return eng_name;
	}
	public void setEng_name(String eng_name) {
		this.eng_name = eng_name;
	}
	public String getEng_name2() {
		return eng_name2;
	}
	public void setEng_name2(String eng_name2) {
		this.eng_name2 = eng_name2;
	}
	public String getRgst_dt() {
		return rgst_dt;
	}
	public void setRgst_dt(String rgst_dt) {
		this.rgst_dt = rgst_dt;
	}
	public String getAct_yn() {
		return act_yn;
	}
	public void setAct_yn(String act_yn) {
		this.act_yn = act_yn;
	}
	public String getAct_prt_cd() {
		return act_prt_cd;
	}
	public void setAct_prt_cd(String act_prt_cd) {
		this.act_prt_cd = act_prt_cd;
	}
	public String getAct_prt_nm() {
		return act_prt_nm;
	}
	public void setAct_prt_nm(String act_prt_nm) {
		this.act_prt_nm = act_prt_nm;
	}
	public String getArrg_place() {
		return arrg_place;
	}
	public void setArrg_place(String arrg_place) {
		this.arrg_place = arrg_place;
	}
	public String getSido_cd() {
		return sido_cd;
	}
	public void setSido_cd(String sido_cd) {
		this.sido_cd = sido_cd;
	}
	public String getSido_cd_nm() {
		return sido_cd_nm;
	}
	public void setSido_cd_nm(String sido_cd_nm) {
		this.sido_cd_nm = sido_cd_nm;
	}
	public String getGugun_cd() {
		return gugun_cd;
	}
	public void setGugun_cd(String gugun_cd) {
		this.gugun_cd = gugun_cd;
	}
	public String getGugun_cd_nm() {
		return gugun_cd_nm;
	}
	public void setGugun_cd_nm(String gugun_cd_nm) {
		this.gugun_cd_nm = gugun_cd_nm;
	}
	public String getHome_zip() {
		return home_zip;
	}
	public void setHome_zip(String home_zip) {
		this.home_zip = home_zip;
	}
	public String getHome_addr1() {
		return home_addr1;
	}
	public void setHome_addr1(String home_addr1) {
		this.home_addr1 = home_addr1;
	}
	public String getHome_addr2() {
		return home_addr2;
	}
	public void setHome_addr2(String home_addr2) {
		this.home_addr2 = home_addr2;
	}
	public String getHome_phone() {
		return home_phone;
	}
	public void setHome_phone(String home_phone) {
		this.home_phone = home_phone;
	}
	public String getHand_phone() {
		return hand_phone;
	}
	public void setHand_phone(String hand_phone) {
		this.hand_phone = hand_phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPrfl_img() {
		return prfl_img;
	}
	public void setPrfl_img(String prfl_img) {
		this.prfl_img = prfl_img;
	}
	public String getLast_edu_cd() {
		return last_edu_cd;
	}
	public void setLast_edu_cd(String last_edu_cd) {
		this.last_edu_cd = last_edu_cd;
	}
	public String getLast_edu_nm() {
		return last_edu_nm;
	}
	public void setLast_edu_nm(String last_edu_nm) {
		this.last_edu_nm = last_edu_nm;
	}
	public String getHope_place() {
		return hope_place;
	}
	public void setHope_place(String hope_place) {
		this.hope_place = hope_place;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getJob_nm() {
		return job_nm;
	}
	public void setJob_nm(String job_nm) {
		this.job_nm = job_nm;
	}
	public String getEtc_job_nm() {
		return etc_job_nm;
	}
	public void setEtc_job_nm(String etc_job_nm) {
		this.etc_job_nm = etc_job_nm;
	}
	public String getEng_test_nm() {
		return eng_test_nm;
	}
	public void setEng_test_nm(String eng_test_nm) {
		this.eng_test_nm = eng_test_nm;
	}
	public String getEng_test_pnt() {
		return eng_test_pnt;
	}
	public void setEng_test_pnt(String eng_test_pnt) {
		this.eng_test_pnt = eng_test_pnt;
	}
	public String getChn_test_nm() {
		return chn_test_nm;
	}
	public void setChn_test_nm(String chn_test_nm) {
		this.chn_test_nm = chn_test_nm;
	}
	public String getChn_test_pnt() {
		return chn_test_pnt;
	}
	public void setChn_test_pnt(String chn_test_pnt) {
		this.chn_test_pnt = chn_test_pnt;
	}
	public String getJpn_test_nm() {
		return jpn_test_nm;
	}
	public void setJpn_test_nm(String jpn_test_nm) {
		this.jpn_test_nm = jpn_test_nm;
	}
	public String getJpn_test_pnt() {
		return jpn_test_pnt;
	}
	public void setJpn_test_pnt(String jpn_test_pnt) {
		this.jpn_test_pnt = jpn_test_pnt;
	}
	public String getEtc_test_nm() {
		return etc_test_nm;
	}
	public void setEtc_test_nm(String etc_test_nm) {
		this.etc_test_nm = etc_test_nm;
	}
	public String getEtc_test_pnt() {
		return etc_test_pnt;
	}
	public void setEtc_test_pnt(String etc_test_pnt) {
		this.etc_test_pnt = etc_test_pnt;
	}
	public String getEtc_lang_nm() {
		return etc_lang_nm;
	}
	public void setEtc_lang_nm(String etc_lang_nm) {
		this.etc_lang_nm = etc_lang_nm;
	}
	public String getEtc_lang() {
		return etc_lang;
	}
	public void setEtc_lang(String etc_lang) {
		this.etc_lang = etc_lang;
	}
	public String getLang_cd() {
		return lang_cd;
	}
	public void setLang_cd(String lang_cd) {
		this.lang_cd = lang_cd;
	}
	public String getLang_nm() {
		return lang_nm;
	}
	public void setLang_nm(String lang_nm) {
		this.lang_nm = lang_nm;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getRow_num() {
		return row_num;
	}
	public void setRow_num(String row_num) {
		this.row_num = row_num;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public String getSrch_str_dt() {
		return srch_str_dt;
	}
	public void setSrch_str_dt(String srch_str_dt) {
		this.srch_str_dt = srch_str_dt;
	}
	public String getSrch_end_dt() {
		return srch_end_dt;
	}
	public void setSrch_end_dt(String srch_end_dt) {
		this.srch_end_dt = srch_end_dt;
	}
	public String getSrch_act_prt_cd() {
		return srch_act_prt_cd;
	}
	public void setSrch_act_prt_cd(String srch_act_prt_cd) {
		this.srch_act_prt_cd = srch_act_prt_cd;
	}
	public String getSrch_act_yn() {
		return srch_act_yn;
	}
	public void setSrch_act_yn(String srch_act_yn) {
		this.srch_act_yn = srch_act_yn;
	}
	public String getSrch_sido() {
		return srch_sido;
	}
	public void setSrch_sido(String srch_sido) {
		this.srch_sido = srch_sido;
	}
	public String getSrch_gugun() {
		return srch_gugun;
	}
	public void setSrch_gugun(String srch_gugun) {
		this.srch_gugun = srch_gugun;
	}
	
	public String getSrch_nm() {
		return srch_nm;
	}
	public void setSrch_nm(String srch_nm) {
		this.srch_nm = srch_nm;
	}
	public String getSrch_area() {
		return srch_area;
	}
	public void setSrch_area(String srch_area) {
		this.srch_area = srch_area;
	}
	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getSrch_ym() {
		return srch_ym;
	}
	public void setSrch_ym(String srch_ym) {
		this.srch_ym = srch_ym;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	
	public String getWork_ym() {
		return work_ym;
	}
	public void setWork_ym(String work_ym) {
		this.work_ym = work_ym;
	}
	public String getWork_tm() {
		return work_tm;
	}
	public void setWork_tm(String work_tm) {
		this.work_tm = work_tm;
	}
	public String getWork_dt_cnt() {
		return work_dt_cnt;
	}
	public void setWork_dt_cnt(String work_dt_cnt) {
		this.work_dt_cnt = work_dt_cnt;
	}
	public String getWork_place() {
		return work_place;
	}
	public void setWork_place(String work_place) {
		this.work_place = work_place;
	}
	public int getVisitor_cnt() {
		return visitor_cnt;
	}
	public void setVisitor_cnt(int visitor_cnt) {
		this.visitor_cnt = visitor_cnt;
	}
	public int getCmmt_cnt() {
		return cmmt_cnt;
	}
	public void setCmmt_cnt(int cmmt_cnt) {
		this.cmmt_cnt = cmmt_cnt;
	}
	public String getAct_ym() {
		return act_ym;
	}
	public void setAct_ym(String act_ym) {
		this.act_ym = act_ym;
	}
	public String getAct_fee() {
		return act_fee;
	}
	public void setAct_fee(String act_fee) {
		this.act_fee = act_fee;
	}
	public String getPay_info() {
		return pay_info;
	}
	public void setPay_info(String pay_info) {
		this.pay_info = pay_info;
	}
	public String getPay_yn() {
		return pay_yn;
	}
	public void setPay_yn(String pay_yn) {
		this.pay_yn = pay_yn;
	}
	
	public String getHome_ph1() {
		return home_ph1;
	}
	public void setHome_ph1(String home_ph1) {
		this.home_ph1 = home_ph1;
	}
	public String getHome_ph2() {
		return home_ph2;
	}
	public void setHome_ph2(String home_ph2) {
		this.home_ph2 = home_ph2;
	}
	public String getHome_ph3() {
		return home_ph3;
	}
	public void setHome_ph3(String home_ph3) {
		this.home_ph3 = home_ph3;
	}
	public String getHand_ph1() {
		return hand_ph1;
	}
	public void setHand_ph1(String hand_ph1) {
		this.hand_ph1 = hand_ph1;
	}
	public String getHand_ph2() {
		return hand_ph2;
	}
	public void setHand_ph2(String hand_ph2) {
		this.hand_ph2 = hand_ph2;
	}
	public String getHand_ph3() {
		return hand_ph3;
	}
	public void setHand_ph3(String hand_ph3) {
		this.hand_ph3 = hand_ph3;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getLang_cd1() {
		return lang_cd1;
	}
	public void setLang_cd1(String lang_cd1) {
		this.lang_cd1 = lang_cd1;
	}
	public String getLang_cd2() {
		return lang_cd2;
	}
	public void setLang_cd2(String lang_cd2) {
		this.lang_cd2 = lang_cd2;
	}
	public String getLang_cd3() {
		return lang_cd3;
	}
	public void setLang_cd3(String lang_cd3) {
		this.lang_cd3 = lang_cd3;
	}
	public String getLang_cd4() {
		return lang_cd4;
	}
	public void setLang_cd4(String lang_cd4) {
		this.lang_cd4 = lang_cd4;
	}
	public String getLang_cd9() {
		return lang_cd9;
	}
	public void setLang_cd9(String lang_cd9) {
		this.lang_cd9 = lang_cd9;
	}
	public String getLang_cd2_grade() {
		return lang_cd2_grade;
	}
	public void setLang_cd2_grade(String lang_cd2_grade) {
		this.lang_cd2_grade = lang_cd2_grade;
	}
	public String getLang_cd3_grade() {
		return lang_cd3_grade;
	}
	public void setLang_cd3_grade(String lang_cd3_grade) {
		this.lang_cd3_grade = lang_cd3_grade;
	}
	public String getLang_cd4_grade() {
		return lang_cd4_grade;
	}
	public void setLang_cd4_grade(String lang_cd4_grade) {
		this.lang_cd4_grade = lang_cd4_grade;
	}
	public String getLang_cd9_grade() {
		return lang_cd9_grade;
	}
	public void setLang_cd9_grade(String lang_cd9_grade) {
		this.lang_cd9_grade = lang_cd9_grade;
	}
	public int getEdu_seq() {
		return edu_seq;
	}
	public void setEdu_seq(int edu_seq) {
		this.edu_seq = edu_seq;
	}
	public String getEdu_prt() {
		return edu_prt;
	}
	public void setEdu_prt(String edu_prt) {
		this.edu_prt = edu_prt;
	}
	public String getEdu_prt_nm() {
		return edu_prt_nm;
	}
	public void setEdu_prt_nm(String edu_prt_nm) {
		this.edu_prt_nm = edu_prt_nm;
	}
	public String getYyyy() {
		return yyyy;
	}
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	public String getEdu_place() {
		return edu_place;
	}
	public void setEdu_place(String edu_place) {
		this.edu_place = edu_place;
	}
	public String getEdu_nm() {
		return edu_nm;
	}
	public void setEdu_nm(String edu_nm) {
		this.edu_nm = edu_nm;
	}
	public String getEdu_tm() {
		return edu_tm;
	}
	public void setEdu_tm(String edu_tm) {
		this.edu_tm = edu_tm;
	}
	public String getEdu_cmpl() {
		return edu_cmpl;
	}
	public void setEdu_cmpl(String edu_cmpl) {
		this.edu_cmpl = edu_cmpl;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuth_no() {
		return auth_no;
	}
	public void setAuth_no(String auth_no) {
		this.auth_no = auth_no;
	}
	public String getEng_test_yy() {
		return eng_test_yy;
	}
	public void setEng_test_yy(String eng_test_yy) {
		this.eng_test_yy = eng_test_yy;
	}
	public String getChn_test_yy() {
		return chn_test_yy;
	}
	public void setChn_test_yy(String chn_test_yy) {
		this.chn_test_yy = chn_test_yy;
	}
	public String getJpn_test_yy() {
		return jpn_test_yy;
	}
	public void setJpn_test_yy(String jpn_test_yy) {
		this.jpn_test_yy = jpn_test_yy;
	}
	public String getEtc_test_yy() {
		return etc_test_yy;
	}
	public void setEtc_test_yy(String etc_test_yy) {
		this.etc_test_yy = etc_test_yy;
	}
	public String getInpt_usr() {
		return inpt_usr;
	}
	public void setInpt_usr(String inpt_usr) {
		this.inpt_usr = inpt_usr;
	}
	public String getSrch_order() {
		return srch_order;
	}
	public void setSrch_order(String srch_order) {
		this.srch_order = srch_order;
	}
	public String getOrder_prt() {
		return order_prt;
	}
	public void setOrder_prt(String order_prt) {
		this.order_prt = order_prt;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	
}
