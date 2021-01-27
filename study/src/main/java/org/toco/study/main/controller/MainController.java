package org.toco.study.main.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.toco.study.main.service.MainService;

@Controller
public class MainController {
	
	@Resource
	private MainService mainService;
	
	@RequestMapping(value={"/","home.do"})
	public String home(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate ); 
		return "index";
	}	
	
	@RequestMapping("getBoardTitle.do")
	public String getBoardTitle(Model model) {
		model.addAttribute("board",mainService.getBoardTitle());
		return "index";
	}
	
}
