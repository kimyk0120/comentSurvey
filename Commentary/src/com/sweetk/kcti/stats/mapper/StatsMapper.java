package com.sweetk.kcti.stats.mapper;

import java.util.ArrayList;

import com.sweetk.kcti.stats.vo.StatsVo;

public interface StatsMapper {
	public ArrayList<StatsVo> stats_list(StatsVo svo);
	
	public ArrayList<StatsVo> stats_cmmt_age(StatsVo svo);
	public ArrayList<StatsVo> stats_cmmt_age2(StatsVo svo);

	/**
	 * 전체 권한
	 */
		public ArrayList<StatsVo> stats_cmmt_work(StatsVo svo);
		public ArrayList<StatsVo> stats_cmmt_work2(StatsVo svo);
		public ArrayList<StatsVo> stats_cmmt_edu(StatsVo svo);
	
	/**
	 * 지자체 권한
	 */
		public ArrayList<StatsVo> stats_local_cmmt_work(StatsVo svo);
		public ArrayList<StatsVo> stats_local_cmmt_work2(StatsVo svo);
		public ArrayList<StatsVo> stats_local_cmmt_edu(StatsVo svo);
	
	public StatsVo stats_user_visit(StatsVo svo);
	public ArrayList<StatsVo> stats_visit_url(StatsVo svo);
}

