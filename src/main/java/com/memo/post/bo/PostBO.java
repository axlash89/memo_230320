package com.memo.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.post.dao.PostMapper;
import com.memo.post.domain.Post;

@Service
public class PostBO {
	
	@Autowired
	private PostMapper postMapper;  // mybatis
	
	// input : userId(글쓴이)
	// output : List<Post>
	public List<Post> getPostListByUserId(int userId) {
		return postMapper.selectPostListByUserId(userId);
	}
	
	
	// input : 
	// output : 성공된 행의 개수
	public int addPost(int userId, String subject, String content, MultipartFile file) {
		
		// 이미지가 있으면 업로드 후 imagePath 받아옴
		String imagePath = null;
		return postMapper.insert~~~
		
	}
	
	// sns 회원가입/로그인, 타임라인 postList 뿌리는거까지 하기
//	imagepath는 null 로 들어가는데 나머지 해보기
//	끌쓰기 완료 해보기
}
