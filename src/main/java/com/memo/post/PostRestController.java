package com.memo.post;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.memo.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {
	
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content,
			@RequestParam("subject") String subject,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) {
		
		// 세션에서 유저 정보 받아옴
		int userId = (int)session.getAttribute("userId");
		String userLoginId = (String)session.getAttribute("userLoginId");
				
		// db insert
		int row = postBO.addPost(userId, userLoginId, subject, content, file);
		
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "메모 저장에 실패하였습니다.");
		}
		
		return result;
		
	}
	
	@PutMapping("/update")
	public Map<String, Object> update(
			@RequestParam("postId") int postId,
			@RequestParam("subject") String subject,
			@RequestParam("content") String content,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) {
		
		// 세션에서 userId, userLoginId
		int userId = (int) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		// BO update
		postBO.updatePost(userId, userLoginId, postId, subject, content, file);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
	}

	

}
