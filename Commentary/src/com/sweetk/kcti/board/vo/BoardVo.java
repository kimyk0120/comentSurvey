package com.sweetk.kcti.board.vo;

public class BoardVo {
	int board_seq;
	int qna_seq;
	int file_seq;
	int qna_file_seq;
	
	String title 				= null;
	String sido_cd				= null;
	String sido_cd_nm			= null;
	String cntn					= null;
	String reg_dt				= null;
	String id					= null;
	String nm					= null;
	String file_nm				= null;
	String org_file_nm			= null;
	
	private int startRow;
	private int endRow;
	
	String srch_title		 	 = null;
	String srch_cntn		 	 = null;
	String srch_str_dt		 	 = null;
	String srch_end_dt		 	 = null;
	String srch_nm				= null;
	String srch_sido_cd			= null;
	String row_num				 = null;
	String pageNum			 	 = null;
	String page					 = null;
	String[] file_seqs			= null;
	
	String file_cnt				= null;
	
	int up_qna_seq ;
	String open_yn				= null;
	String auth_no				= null;
	String user_sido_cd			= null;
	String user_id				= null;
	
	int faq_seq;
	String qstn					= null;
	String answ					= null;
	
	int comm_seq;
	String reg_yn				= "";
	String submit_yn			= "";
	String submit_dt			= "";
	String cnt					= "";
	
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public int getQna_seq() {
		return qna_seq;
	}
	public void setQna_seq(int qna_seq) {
		this.qna_seq = qna_seq;
	}
	public int getFile_seq() {
		return file_seq;
	}
	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}
	public int getQna_file_seq() {
		return qna_file_seq;
	}
	public void setQna_file_seq(int qna_file_seq) {
		this.qna_file_seq = qna_file_seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getCntn() {
		return cntn;
	}
	public void setCntn(String cntn) {
		this.cntn = cntn;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getOrg_file_nm() {
		return org_file_nm;
	}
	public void setOrg_file_nm(String org_file_nm) {
		this.org_file_nm = org_file_nm;
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
	public String getSrch_title() {
		return srch_title;
	}
	public void setSrch_title(String srch_title) {
		this.srch_title = srch_title;
	}
	public String getSrch_cntn() {
		return srch_cntn;
	}
	public void setSrch_cntn(String srch_cntn) {
		this.srch_cntn = srch_cntn;
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
	public String getSrch_nm() {
		return srch_nm;
	}
	public void setSrch_nm(String srch_nm) {
		this.srch_nm = srch_nm;
	}
	public String getSrch_sido_cd() {
		return srch_sido_cd;
	}
	public void setSrch_sido_cd(String srch_sido_cd) {
		this.srch_sido_cd = srch_sido_cd;
	}
	public String getRow_num() {
		return row_num;
	}
	public void setRow_num(String row_num) {
		this.row_num = row_num;
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
	public String[] getFile_seqs() {
		return file_seqs;
	}
	public void setFile_seqs(String[] file_seqs) {
		this.file_seqs = file_seqs;
	}
	public int getUp_qna_seq() {
		return up_qna_seq;
	}
	public void setUp_qna_seq(int up_qna_seq) {
		this.up_qna_seq = up_qna_seq;
	}
	public String getFile_cnt() {
		return file_cnt;
	}
	public void setFile_cnt(String file_cnt) {
		this.file_cnt = file_cnt;
	}
	public String getOpen_yn() {
		return open_yn;
	}
	public void setOpen_yn(String open_yn) {
		this.open_yn = open_yn;
	}
	public String getAuth_no() {
		return auth_no;
	}
	public void setAuth_no(String auth_no) {
		this.auth_no = auth_no;
	}
	public String getUser_sido_cd() {
		return user_sido_cd;
	}
	public void setUser_sido_cd(String user_sido_cd) {
		this.user_sido_cd = user_sido_cd;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getFaq_seq() {
		return faq_seq;
	}
	public void setFaq_seq(int faq_seq) {
		this.faq_seq = faq_seq;
	}
	public String getQstn() {
		return qstn;
	}
	public void setQstn(String qstn) {
		this.qstn = qstn;
	}
	public String getAnsw() {
		return answ;
	}
	public void setAnsw(String answ) {
		this.answ = answ;
	}
	public int getComm_seq() {
		return comm_seq;
	}
	public void setComm_seq(int comm_seq) {
		this.comm_seq = comm_seq;
	}
	public String getSubmit_yn() {
		return submit_yn;
	}
	public void setSubmit_yn(String submit_yn) {
		this.submit_yn = submit_yn;
	}
	public String getSubmit_dt() {
		return submit_dt;
	}
	public void setSubmit_dt(String submit_dt) {
		this.submit_dt = submit_dt;
	}
	public String getReg_yn() {
		return reg_yn;
	}
	public void setReg_yn(String reg_yn) {
		this.reg_yn = reg_yn;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	
	
}
