package com.sweetk.kcti.board.mapper;

import java.util.ArrayList;

import com.sweetk.kcti.board.vo.BoardVo;

public interface BoardMapper {
	public int board_list_count(BoardVo bvo);
	
	public ArrayList<BoardVo> board_list(BoardVo bvo);
	
	public BoardVo board_info(int board_seq);
	
	public ArrayList<BoardVo> board_file_list(int board_seq);
	
	public int board_insert(BoardVo bvo);
	
	public void board_file_insert(BoardVo bvo);
	
	public void board_update(BoardVo bvo);
	
	public void board_delete(BoardVo bvo);
	
	public void board_files_delete(BoardVo bvo);
	
	public int qna_list_count(BoardVo bvo);
	
	public ArrayList<BoardVo> qna_list(BoardVo bvo);
	
	public BoardVo qna_info(int qna_seq);
	public ArrayList<BoardVo> qna_file_list(int qna_seq);
	
	public int qna_insert(BoardVo bvo);
	public void qna_file_insert(BoardVo bvo);
	
	public void qna_update(BoardVo bvo);
	
	public void qna_delete(BoardVo bvo);
	public void qna_files_delete(BoardVo bvo);
	
	public ArrayList<BoardVo> faq_list(BoardVo bvo);
	
	public int faq_list_count(BoardVo bvo);
	public BoardVo faq_info(int faq_seq);
	public int faq_insert(BoardVo bvo);
	public void faq_update(BoardVo bvo);
	public void faq_delete(BoardVo bvo);
	
	public int comm_list_count(BoardVo bvo);
	
	public ArrayList<BoardVo> comm_list(BoardVo bvo);
	
	public int comm_save(BoardVo bvo);
	public void comm_sido_save(BoardVo bvo);
	
	public BoardVo comm_info(BoardVo bvo);
	public ArrayList<BoardVo> comm_ans_list(BoardVo bvo);

	public int comm_mylist_count(BoardVo bvo);
	
	public ArrayList<BoardVo> comm_mylist(BoardVo bvo);
	public BoardVo comm_myinfo(BoardVo bvo);
	
	public void comm_mysave(BoardVo bvo);
	
	public int comm_update(BoardVo bvo);
	public void comm_sido_delete(BoardVo bvo);
	
	public void comm_close(BoardVo bvo);
	
	public String sido_email_info(String sido_cd);
	public void comm_delete(String cSeq);
	public void comm_ans_delete(String cSeq);
}
