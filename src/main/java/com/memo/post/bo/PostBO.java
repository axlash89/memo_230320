package com.memo.post.bo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.dao.PostMapper;
import com.memo.post.domain.Post;

@Service
public class PostBO {
	
	// import 주의 import org.mybatis.LoggerFactory; 이거 아님! slf4j임!
	private Logger logger = LoggerFactory.getLogger(this.getClass());
//	private Logger logger = LoggerFactory.getLogger(PostBO.class);
	
	
	@Autowired
	private PostMapper postMapper;  // mybatis
	
	@Autowired
	private FileManagerService fileManager;
	
	// input : userId(글쓴이)
	// output : List<Post>
	public List<Post> getPostListByUserId(int userId) {
		return postMapper.selectPostListByUserId(userId);
	}
	
	// input : int userId, String userLoginId, String subject, String content, MultipartFile file
	// output : 성공된 행의 개수
	public int addPost(int userId, String userLoginId, String subject, String content, MultipartFile file) {
		
		String imagePath = null;
		
		// 이미지가 있으면 업로드 후 imagePath 받아옴
		if (file != null) {
			imagePath = fileManager.saveFile(userLoginId, file);
		}
		
		return postMapper.insertPost(userId, subject, content, imagePath);
		
	}
	
	public Post getPostByPostIdAndUserId(int postId, int userId) {
		return postMapper.selectPostByPostIdAndUserId(postId, userId);
	}
	
	public void updatePost(int userId, String userLoginId, int postId, String subject, String content, MultipartFile file) {
	
		// 업데이트 대상인 기존 글을 가져와 본다.(validation, 이미지 교체시 기존 이미지 제거를 위해)
		Post post = postMapper.selectPostByPostIdAndUserId(postId, userId);
		if(post == null) {
			logger.warn("###[글 수정] post is null. postId:{}, userId:{}", postId, userId);
		}
		
		// 파일이 비어있지 않다면 업로드 후 imagePath 얻어옴
		// 업로드가 성공하면 기존 이미지 제거
		String imagePath = null;
		if (file != null) {
			// 업로드
			imagePath = fileManager.saveFile(userLoginId, file);
			
			// 기존 이미지 제거
			// - 업로드가 성공했고, 기존 이미지 존재하는 경우
			if (imagePath != null && post.getImagePath() != null) {
				// 이미지 제거
				fileManager.deleteFile(post.getImagePath());
			}
		}
		
		// 글 업데이트
		postMapper.updatePostByPostIdAndUserId(postId, userId, subject, content, imagePath);
		
	}
	
	public int deletePost(int postId, int userId) {
		Post post = getPostByPostIdAndUserId(postId, userId);	
		if (post.getImagePath() != null) {
			fileManager.deleteFile(post.getImagePath());	
		}		
		
		return postMapper.deletePostByPostId(postId);
	}
		
	
	
}
