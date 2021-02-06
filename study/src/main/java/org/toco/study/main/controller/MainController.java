package org.toco.study.main.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.toco.study.main.service.MainService;
import org.toco.study.main.vo.BoardVO;
import org.toco.study.main.vo.MemberVO;
import org.toco.study.main.vo.PageVO;
import org.toco.study.main.vo.ReplyVO;


@Controller
public class MainController {
	
	@Resource
	private MainService mainService;
	
	
	
	/*
	 * 사용자 정의 함수
	 */
	
	
	//서버시간 표시하기
	public static void date(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate); 
	}
	
	//alert창 띄우기
	public void alert(String notice, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('"+notice+"');");
		out.println("</script>");
		out.flush();
		return;
	}
	
	//로그인 체크하기
	public boolean loginCheck(HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return false;
		}
		else {
			return true;
		}
	}
	
	//첫 페이지
	@RequestMapping(value = {"/","home.do"})
	public String home(Locale locale, Model model) {
		date(locale, model);
		return "index";
	}	
	
	
	
	/*
	 * 회원(member) 관리 부분
	 */
	
	
	//로그인
	@RequestMapping("login.do")
	public String login() {
		return "login";
	}
	
	//로그인 처리
	@RequestMapping(value = "loginProcess.do", method = RequestMethod.POST)
	public String loginProcess(HttpServletResponse response, HttpSession session, HttpServletRequest req, Locale locale, Model model) throws IOException {
		date(locale, model);
		response.setCharacterEncoding("UTF-8");
		String userId = req.getParameter("userId");
		String password = req.getParameter("password");
		
		int loginCheck = mainService.loginProcess(userId, password);
		
		if(loginCheck == 1) {
			session.setAttribute("userId", userId);
			return "redirect:/main.do";
		}
		else {
			alert("아이디 또는 비밀번호가 올바르지 않습니다!", response);
			return "login";
		}
	}
	
	//로그아웃
	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/home.do";
	}
		
	//회원가입 
	@RequestMapping("join.do")
	public String join() {
		return "join";
	}
	
	//회원가입 처리 
	@RequestMapping(value = "joinProcess.do", method = RequestMethod.POST)
	public String joinProcess(HttpServletRequest req, HttpServletResponse response) throws Exception{
		try {
			response.setCharacterEncoding("UTF-8");
			MemberVO vo = new MemberVO();
			
			vo.setName(req.getParameter("name"));
			vo.setUserId(req.getParameter("userId"));
			vo.setPassword(req.getParameter("password"));
		
			mainService.joinProcess(vo);
			
			alert("회원가입이 완료되었습니다!", response);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "login";
	}
	
	//아이디 중복체크
	@ResponseBody
	@RequestMapping(value = "idCheck.do", method = RequestMethod.POST)
	public int idCheck(HttpServletRequest req) throws Exception{
		String userId = req.getParameter("userId");
		MemberVO vo = mainService.idCheck(userId);
		
		int result = 0;
		
		if(vo != null) {
			result = 1;
		}
		
		return result;
	}
	
	
	
	/*
	 * 게시판(board) 관리 부분
	 */
	
	
	//게시판 목록 보기
	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String boardList(PageVO pagevo, Locale locale, Model model, String nowPage, String cntPerPage, HttpSession session) throws Exception{
		if(!loginCheck(session)) {
			return "login";
		}
		date(locale, model);
		
		int total = mainService.cntContent();
		
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}
		
		pagevo = new PageVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		model.addAttribute("paging", pagevo);
		model.addAttribute("board", mainService.viewBoard(pagevo));
		
		return "main";
	}
			
	//글 작성 페이지 
	@RequestMapping("writePage.do")
	public String writePage(HttpSession session) {
		if(!loginCheck(session)) {
			return "login";
		}
		return "write";
	}
			
	//글 작성 후 내용 저장 + 파일 업로드 까지
	@RequestMapping(value = "writeProcess.do", method = RequestMethod.POST)
	public String writeProcess(HttpServletRequest req, HttpSession session, MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		BoardVO vo = new BoardVO();
		vo.setBoardTitle(req.getParameter("boardTitle"));
		vo.setBoardContent(req.getParameter("boardContent"));
		vo.setUserId((String)session.getAttribute("userId"));
		
		String fileName1, fileName2 = null;
		
		MultipartFile file1 = multipartRequest.getFile("file1");
		MultipartFile file2 = multipartRequest.getFile("file2");
		
		if(!file1.isEmpty()) {
			String originalFileName = file1.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);
			
			UUID uuid = UUID.randomUUID();
			fileName1 = uuid + "." + ext;
			file1.transferTo(new File("C:\\upload\\" + fileName1));
			vo.setBoardFile1(fileName1);
		}
		
		if(!file2.isEmpty()) {
			String originalFileName = file2.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);
			
			UUID uuid = UUID.randomUUID();
			fileName2 = uuid + "." + ext;
			file1.transferTo(new File("C:\\upload\\" + fileName2));
			vo.setBoardFile2(fileName2);
		}
		
		mainService.writeProcess(vo);
		
		return "redirect:/main.do";
	}
	
	//글 상세보기
	@RequestMapping(value = "viewContent.do", method = RequestMethod.GET)
	public String viewContent(HttpSession session, Locale locale, Model model, int boardNo) {
		if(!loginCheck(session)) {
			return "login";
		}
		date(locale, model);
		model.addAttribute("content", mainService.viewContent(boardNo));
		model.addAttribute("reply", mainService.viewReply(boardNo));
		return "viewContent";
	}
	
	//글 상세보기 페이지에서 첨부파일 다운로드
	@RequestMapping(value = "fileDownload.do")
	public void fileDownload(HttpServletRequest req, HttpServletResponse response) throws Exception {
		String fileName = req.getParameter("fileName");
		String realFileName = "";
		
		try {
			String browser = req.getHeader("User-Agent");
			//파일 인코딩
			if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
				fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			}
			else {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
			}
		}catch(UnsupportedEncodingException e) {
			System.out.println("UnsupportedEncodingException");
		}
		realFileName = "C:\\upload\\" + fileName;
		File file1 = new File(realFileName);
		if(!file1.exists()) {
			return;
		}
		
		//파일명 지정
		response.setContentType("application/octer-stream");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\"");
		try {
			OutputStream os = response.getOutputStream();
			FileInputStream fis = new FileInputStream(realFileName);
			
			int ncount = 0;
			byte[] bytes = new byte[512];
			
			while((ncount = fis.read(bytes)) != -1) {
				os.write(bytes, 0, ncount);
			}
			fis.close();
			os.close();
		}catch(Exception e) {
			System.out.println("FileNotFoundException : " + e);
		}
	}
	
	//글 수정 페이지
	@RequestMapping(value = "updateContent.do", method = RequestMethod.GET)
	public String updateContent(Locale locale, Model model, int boardNo) {
		date(locale, model);
		model.addAttribute("content", mainService.viewContent(boardNo));
		return "update";
	}
	
	//글 수정 처리하기
	@RequestMapping(value = "updateProcess.do", method = RequestMethod.POST)
	public String updateProcess(HttpServletRequest req, HttpSession session, int boardNo, MultipartHttpServletRequest multipartRequest) throws Exception{
		BoardVO vo = new BoardVO();
		vo.setBoardTitle(req.getParameter("boardTitle"));
		vo.setBoardContent(req.getParameter("boardContent"));
		vo.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
		
		String fileName1, fileName2 = null;
		
		MultipartFile file1 = multipartRequest.getFile("file1");
		MultipartFile file2 = multipartRequest.getFile("file2");
		
		if(!file1.isEmpty()) {
			String originalFileName = file1.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);
			
			UUID uuid = UUID.randomUUID();
			fileName1 = uuid + "." + ext;
			file1.transferTo(new File("C:\\upload\\" + fileName1));
			vo.setBoardFile1(fileName1);
		}
		
		if(!file2.isEmpty()) {
			String originalFileName = file2.getOriginalFilename();
			String ext = FilenameUtils.getExtension(originalFileName);
			
			UUID uuid = UUID.randomUUID();
			fileName2 = uuid + "." + ext;
			file1.transferTo(new File("C:\\upload\\" + fileName2));
			vo.setBoardFile2(fileName2);
		}
		
		
		mainService.updateProcess(vo);
		return "redirect:/main.do";
	}
	
	//글 삭제 처리하기
	@RequestMapping(value = "deleteProcess.do", method = RequestMethod.GET)
	public String deleteProcess(HttpServletResponse response, Locale locale, Model model, int boardNo) throws IOException {
		date(locale, model);
		mainService.deleteProcess(boardNo);
		return "redirect:/main.do";
	}
	
	
	
	/*
	 * 댓글(reply) 관리 부분
	 */
	
	
	//댓글 입력하기
	@RequestMapping(value = "writeReply.do", method = RequestMethod.POST)
	public String writeReply(RedirectAttributes redirectAttributes, HttpServletRequest req, HttpSession session, HttpServletResponse response, int boardNo) throws Exception{
		ReplyVO vo = new ReplyVO();
		vo.setBoardNo(boardNo);
		vo.setReplyWriter((String)session.getAttribute("userId"));
		vo.setReplyContent(req.getParameter("replyContent"));
		
		mainService.writeReply(vo);
		redirectAttributes.addAttribute("boardNo", boardNo);
		
		return "redirect:/viewContent.do";
	}
	
	//댓글 수정 페이지
	@RequestMapping(value = "updateReply.do", method = RequestMethod.GET)
	public String updateReply(Locale locale, Model model, HttpSession session, HttpServletRequest req, int boardNo) {
		if(!loginCheck(session)) {
			return "login";
		}
		
		int replyNo = Integer.parseInt(req.getParameter("replyNo"));
		
		model.addAttribute("content", mainService.viewContent(boardNo));
		model.addAttribute("reply", mainService.viewReply(boardNo));
		model.addAttribute("update", replyNo);
		
		return "updateReply";
	}
	
	//댓글 수정하기
	@RequestMapping(value = "updateReplyPro.do", method = RequestMethod.POST)
	public String updateReplyPro(RedirectAttributes redirectAttributes, HttpServletRequest req, HttpServletResponse response, Locale locale, Model model, int replyNo) throws IOException {
		ReplyVO vo = new ReplyVO();
		vo.setReplyNo(Integer.parseInt(req.getParameter("replyNo")));
		vo.setReplyContent(req.getParameter("updateReply"));
		int boardNo = Integer.parseInt(req.getParameter("boardNo"));
		
		mainService.updateReply(vo);
		redirectAttributes.addAttribute("boardNo", boardNo);
		
		return "redirect:/viewContent.do";
	}
	
	//댓글 삭제하기
	@RequestMapping(value = "deleteReply.do", method = RequestMethod.GET)
	public String deleteReply(RedirectAttributes redirectAttributes, HttpServletResponse response, HttpServletRequest req, Locale locale, Model model, int boardNo) {
		date(locale, model);

		redirectAttributes.addAttribute("boardNo", boardNo);
		
		int replyNo = Integer.parseInt(req.getParameter("replyNo"));
		
		mainService.deleteReply(replyNo);
		return "redirect:/viewContent.do";
	}
}
