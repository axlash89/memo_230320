package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserRepository;
import com.memo.user.entity.UserEntity;

@Service
public class UserBO {

	@Autowired	
	private UserRepository userRepository;
	
	// input : loginId
	// output : UserEntity(null or 채워져있거나)
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}

	// input : user 관련 파라미터들
	// output : id PK
	public Integer addUser(String loginId, String password, String name, String email) {
		// save
		UserEntity userEntity = userRepository.save(
					UserEntity.builder()
					.loginId(loginId)
					.password(password)
					.name(name)
					.email(email)
					.build()
				);
		return userEntity == null ? null : userEntity.getId();  // PK만 리턴
	}
	
}
