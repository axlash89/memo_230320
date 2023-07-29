package com.memo.post.bo;

import java.util.Collections;
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
	
	private static final int POST_MAX_SIZE = 3;
	
	@Autowired
	private PostMapper postMapper;  // mybatis
	
	@Autowired
	private FileManagerService fileManager;
	
	// input : userId(글쓴이)
	// output : List<Post>
	public List<Post> getPostListByUserId(int userId, Integer prevId, Integer nextId) {
		
		// 게시글 번호 : 10 9 8 | 7 6 5 | 4 3 2 | 1
		// 만약 4 3 2 페이지에 있을 때 
		// 1) 다음 : 2보다 작은 3개 DESC
		// 2) 이전 : 4보다 큰 3개 ASC (5 6 7) => List reverse (7 6 5)
		// 3) 첫 페이지 일 때 (이전, 다음 없음) DESC 3개
		
		String direction = null;  // 방향
		Integer standardId = null;  // 기준 postId
		
		if (prevId != null) {
			
			// 이전
			direction = "prev";
			standardId = prevId;
			
			// get list
			List<Post> postList = postMapper.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
			
			// reverse
			// 5 6 7
			Collections.reverse(postList);  // 뒤집고 저장까지 해줌 (마우스 올려보면 void)

			// return
			return postList;
			
		} else if (nextId != null) {
			
			// 다음
			direction = "next";
			standardId = nextId;
			
		}
		
		return postMapper.selectPostListByUserId(userId, direction, standardId, POST_MAX_SIZE);
	}
	
	
	// 이전 방향의 끝인지 확인
	// input: prevId, userId
	// output: boolean
	public boolean isPrevLastPage(int prevId, int userId) {
		int postId = postMapper.selectPostIdByUserIdAndSort(userId, "DESC");
		return postId == prevId;  // 같으면 끝, 아니면 끝 아님	
	}
	
	// 다음 방향의 끝인지 확인
	public boolean isNextLastPage(int nextId, int userId) {
		return nextId == postMapper.selectPostIdByUserIdAndSort(userId, "ASC");		
	}
		
	
	// input : int userId, String userLoginId, String subject, String content, MultipartFile file
	// output : 성공된 행의 개수
	public int addPost(int userId, String userLoginId, String subject, String content, MultipartFile file) {
		
		String imagePath = null;
		
		// 이미지가 있으면 업로드 후 imagePath 받아옴
		if (file != null) {
			imagePath = fileManager.saveFile(userLoginId, file);
			if (imagePath == null) {
				return 0;
			}
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
	
	public int deletePostByPostIdAndUserId(int postId, int userId) {
		// 기존 글을 가져온다. (이미지가 있으면 삭제해야 하기 때문에)
		Post post = postMapper.selectPostByPostIdAndUserId(postId, userId);
		
		if (post == null) {
			logger.error("###[글 삭제] post is null. postId:{}, userId:{}", postId, userId);
			return 0;
		}
		
		// 기존에 이미지가 있으면 삭제
		if (post.getImagePath() != null) {
			fileManager.deleteFile(post.getImagePath());
		}		
		
		return postMapper.deletePostByPostIdAndUserId(postId, userId);
	}
		
	
	
}
