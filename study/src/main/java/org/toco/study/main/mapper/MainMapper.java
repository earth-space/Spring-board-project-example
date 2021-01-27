package org.toco.study.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.toco.study.main.vo.BoardVO;

@Mapper
public interface MainMapper {
	
	public List<BoardVO> getBoardTitle();
}
