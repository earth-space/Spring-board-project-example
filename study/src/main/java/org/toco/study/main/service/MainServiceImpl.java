package org.toco.study.main.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.toco.study.main.mapper.MainMapper;
import org.toco.study.main.vo.BoardVO;
import org.toco.study.main.vo.MemberVO;
import org.toco.study.main.vo.PageVO;
import org.toco.study.main.vo.ReplyVO;

@Service
public class MainServiceImpl implements MainService {
	
	@Resource
	private MainMapper mainMapper;
	
	@Override
	public void joinProcess(MemberVO vo) {
		mainMapper.joinProcess(vo);
	}
	
	@Override
	public int loginProcess(String userId, String password) {
		return mainMapper.loginProcess(userId, password);
	}
	
	@Override
	public List<BoardVO> viewBoard(PageVO pagevo) {
		return mainMapper.viewBoard(pagevo);
	}
	
	@Override
	public void writeProcess(BoardVO vo) {
		mainMapper.writeProcess(vo);
	}

	@Override
	public BoardVO viewContent(int boardNo) {
		return mainMapper.viewContent(boardNo);
	}
	
	@Override
	public int cntContent() {
		return mainMapper.cntContent();
	}

	@Override
	public void updateProcess(BoardVO vo) {
		mainMapper.updateProcess(vo);
	}
	
	@Override
	public void deleteProcess(int boardNo) {
		mainMapper.deleteProcess(boardNo);
	}
	
	@Override
	public void writeReply(ReplyVO vo) {
		mainMapper.writeReply(vo);
	}
	
	@Override
	public List<ReplyVO> viewReply(int boardNo){
		return mainMapper.viewReply(boardNo);
	}
	
	@Override
	public void updateReply(ReplyVO vo) {
		mainMapper.updateReply(vo);
	}
	
	@Override
	public void deleteReply(int replyNo) {
		mainMapper.deleteReply(replyNo);
	}
	
	@Override
	public MemberVO idCheck(String userId) {
		return mainMapper.idCheck(userId);
	}

}

