package com.memo.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
	
	/**
	 * 회원가입 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_up_view")
	public String signUpview(Model model) {
		model.addAttribute("view", "user/signUp");
		return "template/layout";  // layout이라고 되어있는 것이 조각들이 모여져있는 전체 페이지
	}
	
	/**
	 * 로그인 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_in_view")
	public String signInview(Model model) {
		model.addAttribute("view", "user/signIn");
		return "template/layout";
	}

}
