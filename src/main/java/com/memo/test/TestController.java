package com.memo.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.memo.post.dao.PostMapper;

@Controller
public class TestController {
	
	@Autowired
	private PostMapper postMapper;
	
	@ResponseBody
	@RequestMapping("/test1")
	public String test1() {
		return "Hello world";
	}
	
	@ResponseBody
	@RequestMapping("/test2")  // GetMapping으로 해도 같음
	public Map<String, Object> test2() {
		Map<String, Object> myMap = new HashMap<>();		
		myMap.put("aaa", 111);
		myMap.put("bbb", 222);
		return myMap;
	}
	
	@RequestMapping("/test3")
	public String test3() {
		return "test/test3";
	}
	
	@ResponseBody
	@RequestMapping("/test4")
	public List<Map<String, Object>> test4() {
		// 여기서는 bo생략 간단하게 repository만 만들어서 테스트
		return postMapper.selectPostList();
	}
	
	@RequestMapping("/sign_in")
	public String sign_in() {
		return "memo/sign_in";
	}
	
	@RequestMapping("/sign_up")
	public String sign_up() {
		return "memo/sign_up";
	}
	
}
